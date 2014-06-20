--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


-- wczytujemy biznesy

local budynki={}



function onType1Hit(el)
  if (getElementType(el)~="player") then return end
  local container = getElementData(source, "type:container_id")
  triggerClientEvent("onMarkerType1Enter", getRootElement(), el, container)
end
function onType1Leave(el)
  if (getElementType(el)~="player") then return end
  triggerClientEvent("onMarkerType1Leave", getRootElement(), el)
end



local function zaladujOferte(npc)
    local cid=getElementData(npc,"budynek:container_id")
--    local query=string.format("SELECT cc.itemid,cc.subtype,cc.count,bo.sellprice FROM lss_container_contents cc JOIN lss_budynki_oferta bo ON bo.container_id=cc.container_id AND bo.itemid=cc.itemid AND IFNULL(bo.subtype,0)=IFNULL(cc.subtype,0) WHERE cc.container_id=%d", cid)
    local query=string.format("SELECT cc.itemid,i.name,cc.subtype,cc.count,bo.sellprice FROM lss_container_contents cc JOIN lss_budynki_oferta bo ON bo.container_id=cc.container_id AND bo.itemid=cc.itemid AND IFNULL(bo.subtype,0)=IFNULL(cc.subtype,0) JOIN lss_items i ON cc.itemid=i.id WHERE cc.container_id=%d", cid)
    local oferta=exports.DB:pobierzTabeleWynikow(query)
    setElementData(npc,"budynek:oferta", oferta)
end

local function zaladujNPC(bid)
    local query=string.format("select * from lss_budynki_npc WHERE budynek_id=%d", bid)
    local dane=exports.DB:pobierzTabeleWynikow(query)
    if (not dane) then return nil end
    local npcs={}
    for i,v in ipairs(dane) do
	local npc=createPed(tonumber(v.skin), tonumber(v.x), tonumber(v.y),tonumber(v.z),tonumber(v.a), false)
	setElementInterior(npc, tonumber(v.interior))
	setElementDimension(npc, tonumber(v.dimension))
	setElementData(npc,"npc",true)
	setElementData(npc, "name", "Sprzedawca")
	setElementFrozen(npc, true)
        -- strefa
        local rrz=math.rad(tonumber(v.a)+180)
        local x2= tonumber(v.x) - (2 * math.sin(-rrz))
        local y2= tonumber(v.y) - (2 * math.cos(-rrz))
        local strefa=createColSphere(x2,y2,tonumber(v.z),2)
	setElementDimension(strefa, tonumber(v.dimension))
	setElementInterior(strefa, tonumber(v.interior))
	setElementParent(strefa, npc)
	-- dane oferty
	
	setElementData(npc,"budynek:container_id", tonumber(v.container_id))
	zaladujOferte(npc)
	
	table.insert(npcs,npc)
    end
    return npcs
end

local function wlascicieleBudynku(bid,fid)
  local wlasciciele={}
  local wlasciciele_id={}
  if not tonumber(bid) then return wlasciciele_id,wlasciciele end
  -- w przypadku gdy wlascicielem budynku jest frakcja, odczytujemy jej nazwe i spis czlonkow z uprawnieniem permission_door
  if (fid) then
	-- odczytujemy nazwe frakcji
	local query=string.format("SELECT name FROM lss_faction WHERE id=%d", fid)
	local dane=exports.DB:pobierzWyniki(query)
	table.insert(wlasciciele, dane.name)
	-- odczytujemy liste czlonkow z odpowiednimi uprawnieniami
	query=string.format("select cf.character_id from lss_character_factions cf JOIN lss_faction_ranks fr ON cf.faction_id=fr.faction_id AND cf.rank=fr.rank_id AND fr.perm_doors=1 WHERE cf.faction_id=%d", fid)
--	outputConsole(query)
	dane=exports.DB:pobierzTabeleWynikow(query)
	for i,v in ipairs(dane) do
	  table.insert(wlasciciele_id,v.character_id)
	end

  else
  -- w przypadku gdy wlascicielem budynku nie jest zadna frakcja, dokonujemy odczytu z tabeli lss_budynki_owners
    local query=string.format("select bo.character_id,concat(c.imie,' ',c.nazwisko) wlasciciel from lss_budynki_owners bo JOIN lss_characters c ON c.id=bo.character_id where bo.budynek_id=%d", bid)
    local wyniki=exports.DB:pobierzTabeleWynikow(query)
    for i,v in ipairs(wyniki) do
		table.insert(wlasciciele_id,v.character_id)
		table.insert(wlasciciele,v.wlasciciel)
    end
  end
  return wlasciciele_id, wlasciciele
end

local function cleanupBudynek(id)
    if (not budynki[id]) then return false end
    destroyElement(budynki[id].text3d)
    destroyElement(budynki[id].marker)
    destroyElement(budynki[id].blip)
    destroyElement(budynki[id].markerwyjsciowy)
    for i,v in ipairs(budynki[id].npcs) do
	for i2,v2 in ipairs(getElementChildren(v)) do
	    destroyElement(v2)
	end
	destroyElement(v) -- usuwamy npc
    end
    budynki[id]=nil
    return true
end

local function utworzBudynek(v)
	local id=tonumber(v.id)
	if (budynki[id]) then
	    cleanupBudynek(id)
	end
	v.id=tonumber(v.id)
	v.paidTo_days=tonumber(v.paidTo_days)
	if (v.paidTo_days<0) then
	  v.zamkniety=1
	  v.descr2="Lokal nieczynny."
	end
	v.entryCost=tonumber(v.entryCost)
	
	if (type(v.linkedContainer)=="userdata") then -- null
	    v.linkedContainer=nil
	    v.entryCost=0	-- nie zbieramy oplat jesli nie ma przypisanego sejfu
	else
	    v.linkedContainer=tonumber(v.linkedContainer)
	end
--	outputDebugString("Entry cost: " .. v.entryCost)
	
	v.drzwi=split(v.drzwi,",")
	v.drzwi[1], v.drzwi[2], v.drzwi[3] = tonumber(v.drzwi[1]), tonumber(v.drzwi[2]), tonumber(v.drzwi[3])
	v.punkt_wyjscia=split(v.punkt_wyjscia,",")
	v.punkt_wyjscia[1], v.punkt_wyjscia[2], v.punkt_wyjscia[3], v.punkt_wyjscia[4] = tonumber(v.punkt_wyjscia[1]), tonumber(v.punkt_wyjscia[2]), tonumber(v.punkt_wyjscia[3]), tonumber(v.punkt_wyjscia[4])
	v.i_entrance=split(v.i_entrance,",")
	v.i_exit=split(v.i_exit,",")
	v.i_entrance[1], v.i_entrance[2], v.i_entrance[3], v.i_entrance[4] = tonumber(v.i_entrance[1]), tonumber(v.i_entrance[2]), tonumber(v.i_entrance[3]), tonumber(v.i_entrance[4])
	v.i_i,v.i_d=tonumber(v.i_i), tonumber(v.i_d) or (1000+v.id)
	v.type = tonumber(v.type)
	v.owning_faction=tonumber(v.owning_faction)

	budynki[id]=v

	if not v.descr2 or type(v.descr2)~="string" then v.descr2="" end
	v.descr2_orig=v.descr2
	v.wlasciciele,wlasciciele=wlascicieleBudynku(v.id,v.owning_faction)
	if (#wlasciciele==1) then
	  v.descr2=v.descr2 .. "\n\nWłaściciel: " .. wlasciciele[1]
	elseif (#wlasciciele>1) then
	  v.descr2=v.descr2 .. "\n\nWłaściciele: " .. table.concat(wlasciciele,", ")
	end
	v.descr2=v.descr2.."\n\nID budynku: " .. id
--	outputDebugString(type(v.wlasciciele))

	budynki[id].text3d=createElement("text")


	
	setElementPosition(budynki[id].text3d, v.drzwi[1], v.drzwi[2], v.drzwi[3]+0.5)

	setElementData(budynki[id].text3d, "text", v.descr)

	budynki[id].marker=createMarker(v.drzwi[1], v.drzwi[2], v.drzwi[3]+0.51, "arrow", 1, 255,0,0,100)
	budynki[id].blip=createBlip(v.drzwi[1], v.drzwi[2], v.drzwi[3], 0, 1, 5,105,255,155, -1000, 200)
	budynki[id].cs=createColSphere(v.drzwi[1], v.drzwi[2], v.drzwi[3], 1)
--	outputDebugString(string.format("%d %f %f %f", v.id, v.drzwi[1], v.drzwi[2], v.drzwi[3]))
	setElementData(budynki[id].cs,"budynek",v)
	setElementData(budynki[id].cs,"type",tonumber(v.type))

	-- marker wyjsciowy
	budynki[id].markerwyjsciowy=createMarker(tonumber(v.i_exit[1]), tonumber(v.i_exit[2]), tonumber(v.i_exit[3])+0.51, "arrow", 1, 255,0,0,100)
	setElementInterior(budynki[id].markerwyjsciowy, v.i_i)
	setElementDimension(budynki[id].markerwyjsciowy, v.i_d)
	setElementData(budynki[id].markerwyjsciowy, "budynek:tpto", v.punkt_wyjscia)
	setElementData(budynki[id].markerwyjsciowy,"type",tonumber(v.type))

	
	

	
	-- funkcje dodatkowe
	if v.type == 1 then --sklep odziezowy
		local int = v.i_i
		
		if int == 3 then
			xyz = {207.16,-129.73,1002.51} --int 79
		elseif int == 1 then
			xyz = {203.81,-44.16,1000.80} --int 84
		elseif int == 18 then
			xyz = {161.35,-84.21,1000.80}  --int 86
		elseif int == 14 then
			xyz = {204.42,-160.22,999.52}  --int 87
		elseif int == 2 then
			if v.i_entrance[1] == 466.77 then
				xyz = {467.05,-1128.92,2002.51}
			elseif v.i_entrance[1]== 489.42 then
				xyz = {489.43,-1547.55,2100.80}  --int 
			elseif v.i_entrance[1]== 1734.05 then
				xyz = {1716.63,-1669.58,2000.21}
			end
		end
		local x,y,z = unpack(xyz)
		
		budynki[id].type1marker = createMarker(x,y,z,"cylinder",1.2,255,255,0,100)
		setElementInterior(budynki[id].type1marker, v.i_i)
		setElementDimension(budynki[id].type1marker, v.i_d)
		setElementData(budynki[id].type1marker,"type:container_id", tonumber(v.linkedContainer))
		addEventHandler("onMarkerHit", budynki[id].type1marker, onType1Hit)
		addEventHandler("onMarkerLeave", budynki[id].type1marker, onType1Leave)
	end
	
	budynki[id].npcs=zaladujNPC(id)
end

function zaladujBudynek(id)
    local query=string.format("SELECT b.id,b.descr,b.descr2,b.drzwi,b.linkedContainer,b.owning_faction,b.entryCost,b.punkt_wyjscia,i.interior i_i,i.dimension i_d,i.entrance i_entrance,i.exit i_exit,b.zamkniety,b.koszt,b.updated,b.paidTo,IFNULL(datediff(b.paidTo, NOW()),-1) paidTo_days,b.type,b.linkedContainer FROM lss_budynki b JOIN lss_interiory i ON i.id=b.interiorid WhERE b.id=%d LIMIT 1", id)
    local wyniki=exports.DB:pobierzWyniki(query)
    utworzBudynek(wyniki)
end

do
  local query="SELECT b.id,b.descr,b.descr2,b.drzwi,b.entryCost,b.owning_faction,b.linkedContainer,b.punkt_wyjscia,i.interior i_i,i.dimension i_d,i.entrance i_entrance,i.exit i_exit,b.zamkniety,b.koszt,b.updated,b.paidTo,IFNULL(datediff(b.paidTo, NOW()),-1) paidTo_days,b.type,b.linkedContainer FROM lss_budynki b JOIN lss_interiory i ON i.id=b.interiorid"
  local wyniki=exports.DB:pobierzTabeleWynikow(query)
  for i,v in ipairs(wyniki) do
	utworzBudynek(v)
  end
end

--[[
addEventHandler("onMarkerHit", resourceRoot, function(el,md)
  if (getElementType(el)~="player") then return end
  if (not md) then return end
  triggerEvent("broadcastCaptionedEvent", el, getPlayerName(el) .. " łapie za klamkę i próbuje otworzyć drzwi.", 5, 15,true)
  outputChatBox("(( biznesy do kupienia - w przygotowaniu. ))", el)
end)
]]--

-- triggerServerEvent("onPlayerRequestEntrance", resourceRoot, localPlayer, biznes)
addEvent("onPlayerRequestEntrance", true)
addEventHandler("onPlayerRequestEntrance", resourceRoot, function(plr, budynek)
  if (budynek.entryCost>0) then
    if (getPlayerMoney(plr)<budynek.entryCost) then
	return	-- nie powinno sie wydarzyc bo sprawdzanie jest zduplikowane po stronie klienta
    end
    if (exports["lss-pojemniki"]:insertItemToContainer(budynek.linkedContainer, -1, budynek.entryCost)) then
        takePlayerMoney(plr, budynek.entryCost)
    else
	outputDebugString("Nie udalo sie pobrac oplaty za wstep do biznesu " .. budynek.id)
    end
    
  end
  setElementPosition(plr, budynek.i_entrance[1]+math.random(-5,5)/10, budynek.i_entrance[2]+math.random(-5,5)/10, budynek.i_entrance[3])
  setElementInterior(plr, budynek.i_i)
  setElementDimension(plr, budynek.i_d or 1000+budynek.id)
  setPedRotation(plr, budynek.i_entrance[4])
  if (budynek.radio) and (budynek.radio~="") then triggerClientEvent("startBiznesSound", getRootElement(), plr, budynek.radio) end
  
  if tonumber(budynek.type) == 1 then
	setElementData(plr, "type1oldskin", false)
  end
  
end)


addEventHandler("onMarkerHit", resourceRoot, function(el,md)
  if (getElementType(el)~="player") then return end

  if (not md) then return end

  local tpto=getElementData(source,"budynek:tpto")
  if (tpto) then
    setElementPosition(el, tpto[1]+math.random(-5,5)/10, tpto[2]+math.random(-5,5)/10, tpto[3])
	setPedRotation(el, tpto[4])
    setElementInterior(el, 0)
    setElementDimension(el, 0)
	if getElementData(source,"type") == 1 then
		triggerClientEvent("stopBiznesSound", getRootElement(), el, getElementData(source,"type"))
		if getElementData(el, "type1oldskin") then
			setElementModel(el, getElementData(el, "type1oldskin"))
		end
	end
  
  end
end)



local function odswiezOferte()
  local sprzedawcy=getElementsByType("ped",resourceRoot)
  outputDebugString("Sprzedawcow: " .. #sprzedawcy)
  for i,v in ipairs(sprzedawcy) do
	zaladujOferte(v)
  end
  
end

setTimer(odswiezOferte, 60000*2, 0)




addEvent("setElementModelShop", true)
addEventHandler("setElementModelShop", getRootElement(), function(plr,model,przym,pay,pojemnik,premium)
	if przym then
		triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr).." przymierza ubranie", 3, 10, true)
		if not getElementData(plr, "type1oldskin") then
			setElementData(plr, "type1oldskin", getElementModel(plr)) 
		end
	end
	if pay then
		if getPlayerMoney(plr)-pay < 0 then outputChatBox("Sprzedawca mówi: niestety, nie stać Pana na to ubranie!", plr) return end
		takePlayerMoney(plr,pay)
		triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr).." zakupuje ubranie", 3, 10, true)
		setElementData(plr, "type1oldskin", false) 
		local c = getElementData(plr, "character")
		if not premium then
			local query=string.format("UPDATE lss_characters SET skin=%d, premiumskin = NULL WHERE id=%d LIMIT 1", model, c.id)
			exports.DB2:zapytanie(query)
		else
			local query=string.format("UPDATE lss_characters SET premiumskin=%d WHERE id=%d LIMIT 1", model, c.id)
			exports.DB2:zapytanie(query)
		end
		exports["lss-pojemniki"]:insertItemToContainer(pojemnik, -1, math.ceil(tonumber(pay)/2),0,"Gotówka")
	end
	
	setElementModel(plr,model)
end)