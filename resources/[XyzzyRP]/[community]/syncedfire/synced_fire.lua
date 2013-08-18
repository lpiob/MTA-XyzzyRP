local fireModel = 8501
local fires = {}
addEvent("onFireExtinguished",true)
addEvent("onFireCreate",true)


local function isFireNearby(x,y,z)	-- todo d,i
  local cs=createColSphere(x,y,z,3)
  local obiekty=getElementsWithinColShape(cs, "object")
  destroyElement(cs)
  for i,v in ipairs(obiekty) do
	  if (getElementModel(v)==fireModel) then return true end
  end
  return false
end

function createFire(x,y,z,d,i)
	if (isFireNearby(x,y,z,d,i)) then return nil end
	outputDebugString("Tworzymy ogien")
	local fireElem = createObject(fireModel,x,y,z)
	setElementCollisionsEnabled(fireElem,false)
	local col = createColSphere(x,y,z+1,2)
	setElementParent(col, fireElem)
	setElementData(fireElem, "ts", getTickCount(), false)
	fires[fireElem] = {fireElem,col}
	addEventHandler("onColShapeHit",col,setFire)
	if (d) then
	  setElementDimension(fireElem, d)
	  setElementDimension(col, d)
	end
	if (i) then
	  setElementInterior(fireElem, i)
	  setElementInterior(col, i)
	end
	return fireElem
end

function setFire(elem,dim)
	if not dim then return end
	if not elem or not isElement(elem) then return end
	if getElementType(elem) == "player" then
		setPedOnFire(elem,true)
	end
end

function setFire(elem,dim)
	if not dim then return end
	if not elem or not isElement(elem) then return end
	if getElementType(elem) == "vehicle" then
		setVehicleOnFire(elem,true)
	end
end

function fireExtinguished(fireElem)	
	if (not fires[fireElem]) then return end
	triggerEvent("onFireExtinguished",source,fireElem)
	destroyElement(fires[fireElem][1])
	destroyElement(fires[fireElem][2])
	fires[fireElem] = nil
end
addEvent("fireExtinguished",true)
addEventHandler("fireExtinguished",root,fireExtinguished)

addEvent("doCreateFire", true)
addEventHandler("doCreateFire", root, createFire)

addEventHandler ( "onVehicleExplode", root, function()
  outputDebugString("Wybuch pojazdu")
  local x,y,z=getElementPosition(source)
  createFire(x+math.random(-2,2),y+math.random(-2,2),z-0.5,getElementDimension(source), getElementInterior(source))
end)

local function extinguishExpiredFires()
  for i,v in ipairs(getElementsByType("object", resourceRoot)) do
	local ts=getElementData(v,"ts")
	if (ts and getTickCount()-ts<1000*3600*6) then
	  destroyElement(getElementChild(v,0))
	  fires[v]=nil
	  destroyElement(v)
	  outputDebugString("Gasimy stary ogien")
	end
  end
end

setTimer(extinguishExpiredFires, 1000*3600, 0)