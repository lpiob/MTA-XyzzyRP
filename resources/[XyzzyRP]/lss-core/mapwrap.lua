--[[

Nie pozwalamy graczom opuścić Los Santos, zawijamy mapę. Jeśli ktoś wypłynie/wyleci odpowiednio daleko, pojawi
się z przeciwnej strony, w miarę niezauważalnie.

@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



local cx,cy,radius=1500,-1000,3250
local ml=createColTube(cx,cy,-1000,radius,2000)

addEventHandler ( "onColShapeLeave", ml, function(hitElement, matchingDimension)
    if (not matchingDimension) then return end
    if (getElementDimension(hitElement)~=0 or getElementInterior(hitElement)~=0) then return end
    if (getElementType(hitElement)=="player") then
	if (getPedOccupiedVehicle(hitElement)) then return end
    elseif (getElementType(hitElement)~="vehicle") then
	return
    end
    
    local x,y,z=getElementPosition(hitElement)
    x=cx+0.95*(cx-x)
    y=cy+0.95*(cy-y)
    local vx,vy,vz=getElementVelocity(hitElement)
    setElementPosition(hitElement, x,y,z)
    setElementVelocity(hitElement, vx,vy,vz)
end)


