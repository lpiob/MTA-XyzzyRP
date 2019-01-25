--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local items={}
do
  local dane=exports.DB:pobierzTabeleWynikow("SELECT id,name FROM lss_items")
  for i,v in ipairs(dane) do
	items[tonumber(v.id)]=v.name
  end
end


function findPlayerBankContainer(plr)
    local c=getElementData(plr,"character")
    if (not c or not c.id) then
	return nil
    end
    local query=string.format("SELECT id FROM lss_containers WHERE owning_player=%d AND typ='skrytka' LIMIT 1", c.id)
    local id=exports.DB:pobierzWyniki(query)
    if (not id) then
	outputDebugString("Tworzenie skrytki dla gracza " .. c.id)
	local imie=exports.DB:esc(c.imie .. " " .. c.nazwisko)
	query=string.format("INSERT INTO lss_containers SET owning_player=%d,created=NOW(),last_access=NOW(),typ='skrytka',nazwa='Skrytka bankowa %s'", c.id, imie)
	exports.DB:zapytanie(query)
	id=exports.DB:insertID()
	return id
    else
	return tonumber(id.id)
    end
end

function fetchContainer(id,szyfr)
    if (not id) then return nil end
    local pojemnik
    local query=string.format("SELECT id,nazwa,szyfr FROM lss_containers WHERE id=%d LIMIT 1", id)

    pojemnik=exports.DB:pobierzWyniki(query)
--	outputDebugString(pojemnik.szyfr)
	if (pojemnik) then
	  if (pojemnik.szyfr and tonumber(pojemnik.szyfr) and (not szyfr or tonumber(szyfr)~=tonumber(pojemnik.szyfr))) then
--		outputDebugString("ZS" .. szyfr .. " vs " .. pojemnik.szyfr)
		return nil
	  end
	  query=string.format("SELECT cc.itemid,cc.count,cc.subtype,i.name from lss_container_contents cc JOIN lss_items i ON i.id=cc.itemid WHERE cc.container_id=%d", id)
	  pojemnik.zawartosc=exports.DB:pobierzTabeleWynikow(query)
	else
	  return nil
	end
    return pojemnik
end

addEvent("onPojemnikOpenRequest", true)
addEventHandler("onPojemnikOpenRequest", root, function(id,szyfr)
    local plr=source

    if (id==-1) then
	id=findPlayerBankContainer(plr)
    end
    
    if (not id) then
	outputChatBox("(( nie udało się otworzyć pojemnika ))", plr)
	return
    end
    outputDebugString("Dostęp do pojemnika " .. getPlayerName(plr) .. "-"..id)
    local pojemnik=fetchContainer(id,szyfr)
	if (pojemnik) then
  	    triggerClientEvent(plr, "doOpenPojemnik", resourceRoot, pojemnik)
	else
		outputChatBox("(( nie udało się otworzyć pojemnika. ))", plr)
	end


end)

local function verifyPlayerEQ(plr,offer)	-- moze byc powolne, ale co zrobić
  for i,v in ipairs(offer) do
		if (v.itemid==-1 and v.count>0) then		-- gotowka
		  if (v.count>getPlayerMoney(plr)) then return false end
		elseif (v.itemid>0 and v.count>0) then
		  local item=exports["lss-core"]:eq_getItem(plr,v.itemid,v.subtype)
		  if (not item or (item and item.count and tonumber(item.count)<tonumber(v.count))) then 
--			outputDebugString("vpe nie ma "..v.itemid)
--			if (item) then outputDebugString("item jest") end
			return false 
		  end
		end
  end
  return true
end

function insertItemToContainer(cid, itemid, count, subtype, name)
-- kurwa nie mozna tworzyc indeksow z polami null, trzeba to rozbic na kilka zapytan
    -- sprawdzamy czy w bazie danych mamy nazwe tego przedmiotu
  local query
    if (name and itemid>0 and not items[itemid]) then
	items[itemid]=name
	query=string.format("INSERT INTO lss_items SET id=%d,name='%s'", itemid, exports.DB:esc(name))
	exports.DB:zapytanie(query)
    end

--  outputDebugString("iitc " .. cid .. " itemid " .. itemid .. " count" .. count)

  local q_subtype
--  if (subtype) then
  q_subtype=string.format("IFNULL(subtype,0)=%d", tonumber(subtype) or 0)
--  else
--	q_subtype="subtype IS NULL"
--  end
  -- szukamy czy przedmiot jest w kontenerze
  subtype=tonumber(subtype) or "NULL"
  query=string.format("SELECT id,count FROM lss_container_contents WHERE container_id=%d AND itemid=%d AND %s LIMIT 1", cid, itemid, q_subtype)
--  outputDebugString(query)
  local dane=exports.DB:pobierzWyniki(query)
--  outputDebugString("aaa")
  if ((not dane or not dane.id) and count<0) then	-- gracz chce zabrac przedmiot ktorego juz nie ma w pojemniku
	return false
  elseif (dane and dane.id and count<0 and tonumber(dane.count)<-count) then	-- gracz chce zabrac przedmiot ktorego jest za malo
	return false
  elseif (not dane and count>0) then   -- A. nie ma takiego itemu i ilosc jest dodatnia
	query=string.format("INSERT INTO lss_container_contents SET container_id=%d,itemid=%d,count=%d,subtype=%s", cid, itemid, count, tonumber(subtype) and tostring(tonumber(subtype)) or "0")
--	query=string.format("container_id=%d,itemid=%d,count=%d,subtype=%s", cid, itemid, count, tonumber(subtype) and tostring(tonumber(subtype)) or "NULL")
--	outputDebugString(query)
	exports.DB:zapytanie(query)
	return true
  elseif (dane and count<0 and count==-dane.count) then -- przedmiot jest ale po dodaniu go nie bedzie
	query=string.format("DELETE FROM lss_container_contents WHERE id=%d LIMIT 1", dane.id)
	exports.DB:zapytanie(query)
	return true
  else
	-- jest taki przedmiot, sumujemy ilosc
	query=string.format("UPDATE lss_container_contents SET count=count+(%d) WHERE id=%d LIMIT 1", count, dane.id)
	exports.DB:zapytanie(query)
  end
  return true
end

addEvent("insertItemToContainerS", true)
addEventHandler("insertItemToContainerS", getRootElement(), insertItemToContainer)

addEvent("onContainerTransmit", true)
addEventHandler("onContainerTransmit", root, function(p1, p2, poj)
  -- p1 to EQ uzytkownika
  -- p2 to pojemnik
  -- poj to dane pojemnika
  
  -- najpierw sprawdzamy czy gracz ma przedmioty
  if (not verifyPlayerEQ(source, p1)) then
  	outputChatBox("Niestety nie posiadasz już wybranych przedmiotów.", source, 255,0,0)
	return
  end
  -- sprawdzanie zawartosci kontenera po stronie serwera narazie sobie darujemy TODO
  -- zabieramy graczowi przedmioty i wrzucamy je do kontenera
  for i,v in ipairs(p1) do
		if (v.itemid==-1 and v.count>0) then		-- gotowka
		  takePlayerMoney(source,v.count)
		  insertItemToContainer(poj.id, v.itemid, v.count, v.subtype, "Gotówka")
		elseif (v.itemid>0 and v.count>0) then
		  exports["lss-core"]:eq_takeItem(source,v.itemid, v.count, v.subtype)
		  insertItemToContainer(poj.id, v.itemid, v.count, v.subtype, v.name)
		end
  end
  -- przenosimy rzeczy z kontenera do eq gracza
  for i,v in ipairs(p2) do
		if (v.itemid==-1 and v.count>0 and v.count%1==0) then		-- gotowka
		  if not insertItemToContainer(poj.id, v.itemid, -v.count, v.subtype, "Gotówka") then
			outputChatBox("Wybrany przedmiot nie jest już dostępny", source, 255,0,0,true)
			return
		  end
		  givePlayerMoney(source,v.count)
		elseif (v.itemid>0 and v.count>0 and v.count%1==0) then
		  if not insertItemToContainer(poj.id, v.itemid, -v.count, v.subtype, v.name) then
			outputChatBox("Wybrany przedmiot nie jest już dostępny", source, 255,0,0,true)
			return
		  end

		  if not exports["lss-core"]:eq_giveItem(source,v.itemid, v.count, v.subtype) then
			outputChatBox("Nie masz wystarczająco dużo miejsca w inwentarzu!", source, 255,0,0,true)
			insertItemToContainer(poj.id, v.itemid, v.count, v.subtype, v.name)
			return
		  end
		end
  end
  

end)
