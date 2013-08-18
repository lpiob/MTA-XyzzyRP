--[[
Okazjonalnie uzywany zasob do przeprowadzania demokratycznych wyborów

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local ID_WYBOROW=2
local D=1
local I=1

local cs=createColSphere(1484.64,-1790.74,1253.00,2)
setElementDimension(cs,D)
setElementInterior(cs,I)


local ped=createPed(150,1483.12,-1790.71,1252.96,182.1, false)
setElementInterior(ped, I)
setElementDimension(ped, D)

setElementFrozen(ped, true)
setElementData(ped, "npc", true)

local function oddalGlos(obywatel)
  local query=string.format("SELECT 1 FROM lss_wybory WHERE id_wyborow=%d AND character_id=%d", ID_WYBOROW, obywatel)
  local dane=exports.DB:pobierzWyniki(query)
  if (dane) then return true end
  return false
end

local function maPrawaWyborcze(obywatel)
  local query=string.format("select 1 FROM lss_characters WHERE id=%d AND created<'2012-08-11'", obywatel)
  local dane=exports.DB:pobierzWyniki(query)
  if (dane) then return true end
  return false
end

addEventHandler("onColShapeHit", cs, function(el,md)
  if not md then return end
  if getElementType(el)~="player" then return end
  local dowod=exports["lss-core"]:eq_getItem(el, 46)
  if (not dowod) then
	  outputChatBox("* Urzędniczka prosi o pokazanie swojego dowodu osobistego.", el)
	  return
  end
  local obywatel=tonumber(dowod.subtype)                                                         
  
  triggerEvent("broadcastCaptionedEvent", el, "Urzędniczka sprawdza dane z dowodu osobistego.", 5, 15, true)
  if (oddalGlos(obywatel)) then
	outputChatBox("Urzędniczka mówi: oddał/a pan/i już głos.", el)
	return
  end
  if (not maPrawaWyborcze(obywatel)) then
	outputChatBox("Urzędniczka mówi: prawo głosu przysługuje tylko mieszkańcom przebywającym minimum tydzień czasu na wyspie.", el)
	return
  end
--  if (getPlayerName(el)~="Shawn_Hanks") then
--	outputChatBox("(( Wybory ruszają za kilka minut ))" ,el)
--	return
--  end

  triggerEvent("broadcastCaptionedEvent", el, "Urzędniczka podaje karte do głosowania.", 5, 15, true)
  triggerClientEvent(el, "onKartaDoGlosowania", resourceRoot)

end)

-- triggerServerEvent("onWyboryRegisterVote", resourceRoot, localPlayer, glos)

addEvent("onWyboryRegisterVote", true)
addEventHandler("onWyboryRegisterVote", resourceRoot, function(plr,glos)
  local dowod=exports["lss-core"]:eq_getItem(plr, 46)
  if (not dowod) then
	  outputChatBox("(( oddanie glosu nie udalo sie: nie masz dowodu przy sobie. ))", plr)
	  return
  end
  local obywatel=tonumber(dowod.subtype)

  if (oddalGlos(obywatel)) then
	outputChatBox("Urzędniczka mówi: oddał/a pan/i już dziś głos.", plr)
	return
  end

  local query=string.format("INSERT INTO lss_wybory SET id_wyborow=%d,character_id=%d,wybor=%d", ID_WYBOROW, obywatel, glos)
  exports.DB:zapytanie(query)
  outputChatBox("(( Twój głos został zarejestrowany. ))", plr)

end)