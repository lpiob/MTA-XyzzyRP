-- Compatibility: Lua-5.1
function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
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


-- kupowanie budynkow

local D=1
local I=1

--[[
local ob_marker=createMarker(1472.85,-1790.91,1131.96,"cylinder",1)
setElementInterior(ob_marker, I)
setElementInterior(ob_marker, D)
]]--
-- 1469.24,-1803.20,1192.96,92.0
local kb_text=createElement("text")
setElementPosition(kb_text, 1469.23,-1801.00,1195.96)
setElementData(kb_text, "text", "Kupno\nbudynków")
setElementInterior(kb_text, I)
setElementDimension(kb_text, D)

local kb_npc=createPed(11,1467.02,-1801.00,1192.95,269.5,false)
setElementInterior(kb_npc, I)
setElementDimension(kb_npc, D)
setElementData(kb_npc, "npc", true)
setElementData(kb_npc, "name", "Urzędniczka")

--local kb_marker=createMarker(1469.21,-1803.20,1191.96,"cylinder",1)
--setElementInterior(kb_marker, I)
--setElementDimension(kb_marker, D)


-- triggerServerEvent("onPlayerRequestBuildingDetails", resourceRoot, localPlayer, numer)
addEvent("onPlayerRequestBuildingDetails", true)
addEventHandler("onPlayerRequestBuildingDetails", resourceRoot, function(plr, numer)
  numer=tonumber(numer)
  local query=string.format("select b.id,count(bn.id) npc_count,b.descr,b.drzwi,IF(b.koszt>0,b.koszt,i.koszt) koszt,b.paidTo,IFNULL(b.paidTo>NOW(),0) oplacony, b.linkedContainer,b.owning_faction from lss_budynki b JOIN lss_interiory i ON i.id=b.interiorid LEFT JOIN lss_budynki_npc bn ON bn.budynek_id=b.id  WHERE b.id=%d GROUP BY b.id;", numer)
	  --	select b.id,b.descr,b.drzwi,IF(b.koszt>0,b.koszt,i.koszt) koszt,b.linkedContainer,b.owning_faction from lss_budynki b JOIN lss_interiory i ON i.id=b.interiorid WHERE b.id=%d", numer)
  local dane=exports.DB:pobierzWyniki(query)
  if not dane then
	outputChatBox("Urzędnik mówi: nie mamy w spisie budynku o takim numerze.", plr)
	triggerClientEvent(plr, "doRetryBuildingNumberSelection", resourceRoot)
	return
  end
  if dane.owning_faction and type(dane.owning_faction)~="userdata" then
	outputChatBox("Urzędnik mówi: ten budynek nie jest obecnie na sprzedaż.", plr)
	triggerClientEvent(plr, "doRetryBuildingNumberSelection", resourceRoot)
	return
  end
  if type(dane.owning_faction)=="userdata" then dane.owning_faction=nil end
  if type(dane.linkedContainer)=="userdata" then dane.linkedContainer=nil end
  dane.drzwi=split(dane.drzwi,",")
  dane.dzielnica=getZoneName(tonumber(dane.drzwi[1]), tonumber(dane.drzwi[2]), tonumber(dane.drzwi[3]))

  if type(dane.oplacony)=="userdata" then
		dane.oplacony=false
  else
		dane.oplacony=tonumber(dane.oplacony)>0 and true or false
  end

	if type(dane.paidTo)=="userdata" then
		dane.paidTo="-"
	end

  local _,wlasciciele=wlascicieleBudynku(numer, dane.owning_faction)
  dane.wlasciciele=table.concat(wlasciciele, ", ")

  triggerClientEvent(plr, "doShowBuildingDetails", resourceRoot, dane)

end)

-- triggerServerEvent("doPlayerBuyBuilding", resourceRoot, localPlayer, ogladany_budynek.id)
addEvent("doPlayerBuyBuilding", true)
addEventHandler("doPlayerBuyBuilding", resourceRoot, function(plr, numer,koszt)
  numer=tonumber(numer)
  koszt=tonumber(koszt)
  if (getPlayerMoney(plr)<koszt) then return end
  local c=getElementData(plr,"character")
  if not c then return end
  if (koszt<1) then return end

  local query=string.format("UPDATE lss_budynki SET paidTo=NOW()+INTERVAL 7 DAY WHERE id=%d LIMIT 1", numer)
  exports.DB:zapytanie(query)
  query=string.format("DELETE FROM lss_budynki_owners WHERE budynek_id=%d", numer)
  exports.DB:zapytanie(query)
  query=string.format("INSERT INTO lss_budynki_owners SET budynek_id=%d,character_id=%d", numer, c.id)
  exports.DB:zapytanie(query)

  exports["lss-budynki"]:zaladujBudynek(bid)
  takePlayerMoney(plr, koszt)
  triggerEvent("broadcastCaptionedEvent", plr, "Urzędnik odbiera pieniądze.", 5, 5, true)
  outputChatBox("Urzędnik mówi: gratuluje zakupu.", plr)
end)