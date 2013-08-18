local I=1
local D=5


local lapaczcs=createColCuboid(1566,-1698,1455, 40, 40, 1)
setElementInterior(lapaczcs,I)
setElementDimension(lapaczcs,D)

local szybcs=createColCuboid(1566,-1698,1460, 5, 8, 180)
setElementInterior(szybcs, I)
setElementDimension(szybcs, D)

addEventHandler("onColShapeHit", lapaczcs, function(el,md)
  if (not md) then return end
  if (getElementType(el)~="player") then return end
  setElementPosition(el,1575.43,-1700.86,1460.87)
end,false)