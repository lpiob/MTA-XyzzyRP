local fireModel = 8501
function applyFire()
	local fire = engineLoadDFF("fire.dff",8501)
	engineReplaceModel(fire,fireModel)
end

addEventHandler("onClientResourceStart",resourceRoot,applyFire)

function createExtinguisher(wep,_,_,hitX,hitY,hitZ)
	if wep == 42 and math.random(1,10)==1 then
	for k, v in ipairs(getElementsByType("object",resourceRoot)) do
		if getElementModel(v) == fireModel then
			local fX,fY,fZ = getElementPosition(v)
			local dist = getDistanceBetweenPoints2D(hitX,hitY,fX,fY)
			if dist < 1 then
				triggerServerEvent("fireExtinguished",localPlayer,v)
			end
		end
	end
	end
	if wep == 37 and math.random(1,5)==1 then	-- tworzymy ogien!
	  triggerServerEvent("doCreateFire", root, hitX, hitY, hitZ, getElementDimension(localPlayer), getElementInterior(localPlayer))
	end
end


addEventHandler("onClientPlayerWeaponFire",localPlayer,createExtinguisher)
--[[
function enterTruck(veh,seat)
	if getElementModel(veh) ~= 407 or seat > 0 then return end
	if not rendering then		addEventHandler("onClientRender",root,checkTurret)	endendaddEventHandler("onClientPlayerVehicleEnter",localPlayer,enterTruck)function exitTruck()	if rendering then		removeEventHandler("onClientRender",root,checkTurret)	endendaddEventHandler("onClientPlayerVehicleExit",localPlayer,exitTruck)addEventHandler("onClientPlayerWasted",localPlayer,exitTruck)function checkTurret()	if not getKeyState("vehicle_fire") and not getKeyState("vehicle_secondary_fire") then return end	outputDebugString("0")	local veh = getPedOccupiedVehicle(localPlayer)	outputDebugString("1")	if not veh then return end	outputDebugString("2")	local fX,fY,fZ = getElementPosition(veh)	outputDebugString("3")	local turretPosX,turretPosY = getVehicleTurretPosition(veh)	outputDebugString("4")	local turretPosX = math.deg(turretPosX)	outputDebugString("5")	if turretPosX < 0 then turretPosX = turretPosX+360 end	outputDebugString("6")	local rotX,rotY,rotZ = getVehicleRotation(veh)	outputDebugString("7")	local turretPosX = turretPosX+rotZ-360	outputDebugString("8")	if turretPosX < 0 then turretPosX = turretPosX+360 end	outputDebugString("9")	local firetruckShape = createColCircle(fX,fY,20)	outputDebugString("10")	local burningVehicles = getElementsWithinColShape(firetruckShape,"object")	outputDebugString("11")	for k, v in pairs(burningVehicles) do		local bX,bY,bZ = getElementPosition(v)		local neededRot = findRotation(fX,fY,bX,bY)			outputDebugString(tostring(neededRot))		if turretPosX > neededRot-30 and turretPosX < neededRot+30 then			triggerServerEvent("fireExtinguished",localPlayer,v)			break		end	end	destroyElement(firetruckShape)endfunction findRotation(x1,y1,x2,y2)	local t = -math.deg(math.atan2(x2-x1,y2-y1))	if t < 0 then t = t+360 end	return tend
]]--

function enterTruck(veh,seat)
	if getElementModel(veh) ~= 407 or seat > 0 then return end
	if not rendering then		
      addEventHandler("onClientRender",root,checkTurret)	
    end
end

addEventHandler("onClientPlayerVehicleEnter",localPlayer,enterTruck)

function exitTruck()	
if rendering then		
  removeEventHandler("onClientRender",root,checkTurret)	
end
end

addEventHandler("onClientPlayerVehicleExit",localPlayer,exitTruck)
addEventHandler("onClientPlayerWasted",localPlayer,exitTruck)
function checkTurret()	
  if not getControlState("vehicle_fire") and not getControlState("vehicle_secondary_fire") then return end	

  local veh = getPedOccupiedVehicle(localPlayer)
  if not veh then return end
  local fX,fY,fZ = getElementPosition(veh)
  local turretPosX,turretPosY = getVehicleTurretPosition(veh)
  local turretPosX = math.deg(turretPosX)	
  if turretPosX < 0 then turretPosX = turretPosX+360 end
  local rotX,rotY,rotZ = getVehicleRotation(veh)
  local turretPosX = turretPosX+rotZ-360
  if turretPosX < 0 then turretPosX = turretPosX+360 end
--  outputDebugString(fX.."x"..fY)
--  local firetruckShape = createColSphere(fX,fY,fZ,20)

--  local burningVehicles = getElementsWithinColShape(firetruckShape,"object")	
--  outputDebugString("elementow "..#burningVehicles)	
  local burningVehicles=getElementsByType("object", resourceRoot, true)
  for k, v in pairs(burningVehicles) do		
      local bX,bY,bZ = getElementPosition(v)
      if getDistanceBetweenPoints2D(bX,bY,fX, fY)<30 then 
        local neededRot = findRotation(fX,fY,bX,bY)
        if turretPosX > neededRot-10 and turretPosX < neededRot+10 and math.random(1,25)==1 then
          triggerServerEvent("fireExtinguished",localPlayer,v)			
          break		
        end	
      end                                                          
  end	
--  destroyElement(firetruckShape)
end




function findRotation(x1,y1,x2,y2)	local t = -math.deg(math.atan2(x2-x1,y2-y1))	if t < 0 then t = t+360 end	return tend
