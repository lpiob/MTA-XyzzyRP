local D=24
local I=1

local cs1=createColSphere(2672.75,-1823.59,1435.77,3)
setElementDimension(cs1,D)
setElementInterior(cs1,I)

local cs2=createColSphere(2724.60,-1867.07,1441.52,3)
setElementDimension(cs2,D)
setElementInterior(cs2,I)



addEventHandler("onClientColShapeHit", cs1, function(el,md)
  if (not md) then return end
  if (getElementType(el)=="vehicle" and getPedOccupiedVehicle(localPlayer)==el) then
	  setElementPosition(el,2730.77,-1861.48,1441.52)
	  setElementRotation(el,0,0,300)
  end
end)

addEventHandler("onClientColShapeHit", cs2, function(el,md)
  if (not md) then return end
  if (getElementType(el)=="vehicle" and getPedOccupiedVehicle(localPlayer)==el) then
	  setElementPosition(el,2674.82,-1817.38,1436.65)
	  setElementRotation(el,0,0,340)
  end
end)