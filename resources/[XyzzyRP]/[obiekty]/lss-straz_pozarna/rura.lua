local D=26
local I=1

local ruracs=createColSphere(906,-1278,1442.5, 2)
setElementDimension(ruracs,D)
setElementInterior(ruracs,I)


addEventHandler("onColShapeHit", ruracs, function(el,md)
  if (getElementType(el)~="player") then return end
  if (not md) then return end
  local vx,vy,vz=getElementVelocity(el)
  local x,y,z=getElementPosition(el)
  setElementPosition(el,x,y,z)
  setElementVelocity(el,vx,vy,0)
end)
