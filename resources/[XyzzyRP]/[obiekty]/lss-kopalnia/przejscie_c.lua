-- 1092.06,-243.93,28.33,279.1
-- 1091.81,-244.02,1428.42,246.8
local cs0=createColCuboid(1093.02-10,-242.98-10,27.45-4,1,20,10)
local cs1=createColCuboid(1093.02-10,-242.98-10,1427.45-4,1,20,10)
setElementInterior(cs1, 1)
setElementDimension(cs1, 19)
local ltp=getTickCount()

function nadol(el)
  if (el~=localPlayer) then return end
--  outputChatBox("nadol")
  if (getTickCount()-ltp<500) then return end
  local _,_,rz = getElementRotation(el)
  if (rz<207) then return end -- gracz idzie w zla strone

  ltp=getTickCount()
  local vx,vy,vz=getElementVelocity(el)
  setElementDimension(el, 19)
  setElementInterior(el, 1)



  local x,y,z=getElementPosition(el)
  setElementPosition(el, x,y,z+1400)
  setElementVelocity(el, vx,vy,vz)
end
function wgore(el)
  if (el~=localPlayer) then return end
  if (getTickCount()-ltp<500) then return end
  local _,_,rz = getElementRotation(el)
  if (rz>160 or rz<25) then return end -- gracz idzie w zla strone

  ltp=getTickCount()

  local x,y,z=getElementPosition(el)
  local vx,vy,vz=getElementVelocity(el)
  setElementPosition(el, x,y,z-1400)
  setElementInterior(el,0)
  setElementDimension(el,0)
  setElementVelocity(el, vx,vy,vz)

end

addEventHandler("onClientColShapeHit", cs0, nadol,false)
addEventHandler("onClientColShapeHit", cs1, wgore,false)
