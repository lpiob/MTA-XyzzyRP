--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



chainsawMarker = createMarker(-503.60,-77.34,60.5, "cylinder", 1.5)

createBlip(-510.68,-100.19,62.98,42,2,255,0,0,255,0,600)

for i,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
  setElementFrozen(v, true)
end



addEventHandler("onVehicleEnter", resourceRoot, function(plr, seat)
  if seat~=0 then return end
  setElementFrozen(source, false)
end)

addEventHandler("onMarkerHit", chainsawMarker, function(element,dim)
	if not (getElementType(element) == "player") then return end
	giveWeapon(element, 9, 1)
	setPedWeaponSlot(element, 1)
end)

function isVehicleEmpty(v)
  local pasazerowie=getVehicleOccupants(v)
  if not pasazerowie or (#pasazerowie==0 and not pasazerowie[0]) then
    return true
  end
  return false
end


local function respawnPojazdow()
  for i,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
    lu=getElementData(v,"lu") or -1
    if lu>0 and getTickCount()-lu>3*60*1000 and isVehicleEmpty(v) then

      respawnVehicle(v)
      removeElementData(v,"lu")
      setElementFrozen(v, true)
    end
  end
end

setTimer(respawnPojazdow, 60000*1.5, 0)


