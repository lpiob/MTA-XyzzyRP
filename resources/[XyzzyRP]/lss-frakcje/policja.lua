--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@author MrDadosz <mrdadosz@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local function changeBinds(player, shouldWork)
  if not isElement(player) then
    return
  end
  if shouldWork then
    toggleControl(player, "fire", true)
    toggleControl(player, "aim_weapon", true)
    toggleControl(player, "action", true)
    toggleControl(player, "enter_exit", true)
  else
    toggleControl(player, "fire", false)
    toggleControl(player, "aim_weapon", false)
    toggleControl(player, "action", false)
    toggleControl(player, "enter_exit", false)  
  end
end

addEvent("onKajdankiZakuj", true)
addEventHandler("onKajdankiZakuj", resourceRoot, function(kto,kogo)
  local obecnie=getElementData(kogo, "kajdanki")
  if not isElement(kto) or (obecnie and isElement(obecnie) and obecnie==kto) then
  setElementData(kogo,"kajdanki", nil)
  triggerClientEvent(kogo, "onKajdankiRozkuj", resourceRoot)
  changeBinds(kogo, true)
  if isElement(kto) then
    outputChatBox(getPlayerName(kto) .. " zdejmuje z Ciebie kajdanki.")
  end
  return
  end
  setElementData(kogo, "kajdanki", kto)
  triggerClientEvent(kogo, "onKajdankiZakuj", resourceRoot)
  changeBinds(kogo, false)
  outputChatBox(getPlayerName(kto) .. " zakuwa Cię w kajdanki.")
end)

addEvent("onKajdankiZmiana", true)
addEventHandler("onKajdankiZmiana", resourceRoot, function()
  local obecnie=getElementData(client, "kajdanki")
  if obecnie and isElement(obecnie) then
    local interior = getElementInterior(obecnie)
    local dimension = getElementDimension(obecnie)
    setElementInterior(client, interior)
    setElementDimension(client, dimension)
  end
end)

addEvent("onKajdankiWejsciePojazd", true)
addEventHandler("onKajdankiWejsciePojazd", resourceRoot, function()
  local obecnie=getElementData(client, "kajdanki")
  if obecnie and isElement(obecnie) then
    local vehicle = getPedOccupiedVehicle(obecnie)
    if not vehicle then
      return
    end
    local maxPassengers = getVehicleMaxPassengers(vehicle) + 1 -- nie uwzględnia kierowcy
    for seat = 1, maxPassengers do 
      local isOccupied = getVehicleOccupant(vehicle, seat)
      if not isOccupied then
        warpPedIntoVehicle(client, vehicle, seat)
      end
    end
  end
end)

addEvent("onKajdankiWyjsciePojazd", true)
addEventHandler("onKajdankiWyjsciePojazd", resourceRoot, function()
  local obecnie=getElementData(client, "kajdanki")
  if obecnie and isElement(obecnie) and not getPedOccupiedVehicle(obecnie) then
    removePedFromVehicle(client)
  end
end)

addEvent("spac",true)
addEventHandler("spac", root, function()
  setPedAnimation(source, "CHAINSAW" ,"csaw_part",  0, false, true, true )
end)