-- oplacanie budynkow

local D=1
local I=1

--[[
local ob_marker=createMarker(1472.85,-1790.91,1131.96,"cylinder",1)
setElementInterior(ob_marker, I)
setElementInterior(ob_marker, D)
]]--

local ob_text=createElement("text")
setElementPosition(ob_text, 1469.21,-1799.35,1195.96)
setElementData(ob_text, "text", "Opłaty za\nbudynki")
setElementInterior(ob_text, I)
setElementDimension(ob_text, D)

local ob_npc=createPed(57,1467.03,-1799.35,1192.95,270,false)
setElementInterior(ob_npc, I)
setElementDimension(ob_npc, D)
setElementData(ob_npc, "npc", true)
setElementData(ob_npc, "name", "Urzędnik")

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


--iggerServerEvent("onPlayerRequestBuildingList", resourceRoot, localPlayeR)
addEvent("onPlayerRequestBuildingList", true)
addEventHandler("onPlayerRequestBuildingList", resourceRoot, function(plr)
  local c=getElementData(plr,"character")
  if not c then	-- nie powinno sie wydarzyc
	outputChatBox("Urzędnik mówi: nie figuruje Pan jako właściel jakiegokolwiek budynku.", plr)
	return
  end
  local query=string.format("select bo.budynek_id,b.owning_faction,b.descr,b.descr2,b.paidTo,IF(b.koszt>0,b.koszt,i.koszt) koszt from lss_budynki_owners bo JOIN lss_budynki b ON b.id=bo.budynek_id JOIN lss_interiory i ON i.id=b.interiorid where bo.character_id=%d and b.paidTo>=NOW()", c.id)
  local budynki=exports.DB:pobierzTabeleWynikow(query)
  for i,v in ipairs(budynki) do
	if type(v.owning_faction)=="userdata" then v.owning_faction=nil end
	_,budynki[i].wlasciciele=wlascicieleBudynku(v.budynek_id,v.owning_faction)
  end
  triggerClientEvent(plr, "doPopulateBuildingsList", resourceRoot, budynki)
end)

--triggerServerEvent("onBuildingPayment", resourceRoot, localPlayer, dane.budynek_id)
addEvent("onBuildingPayment", true)
addEventHandler("onBuildingPayment", resourceRoot, function(plr,bid, cena)
  local query=string.format("UPDATE lss_budynki SET paidTo=paidTo+INTERVAL 7 DAY where id=%d", bid)
  exports.DB:zapytanie(query)
  exports["lss-budynki"]:zaladujBudynek(bid)
  takePlayerMoney(plr, cena)
  triggerEvent("broadcastCaptionedEvent", plr, "Urzędnik odbiera pieniądze.", 5, 5, true)
  triggerEvent("onPlayerRequestBuildingList", resourceRoot, plr)
end)