--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- ciezarowka w sciane = 6000

addEventHandler("onClientVehicleCollision", root, function(collider,force, bodyPart, x, y, z, vx, vy, vz)
    if ( source == getPedOccupiedVehicle(localPlayer) ) then
--	if (force>1000) then
	local fDamageMultiplier = getVehicleHandling(source).collisionDamageMultiplier
	force=math.sqrt(force*fDamageMultiplier)
	if (force>40) then
	    local hp=getElementHealth(localPlayer)
	    hp=hp-force/3
	    if (hp<0) then hp=0 end
	    setElementHealth(localPlayer, hp)
	end
	if (getElementHealth(source)<370 and getVehicleController(source)==localPlayer and getVehicleEngineState(source) and getVehicleType(source)=="Automobile") then
		setVehicleEngineState(source, false)
	    triggerServerEvent("setVehicleEngineState", source, false)
	    triggerEvent("onCaptionedEvent", resourceRoot, "Gaśnie Ci silnik", 3)
	end
--	    setElementHealth(localPlayer, getElementHealth(localPlayer)-(force/55))
--	    local hp=getElementHealth
--	end
	
    end
end)
--[[
addCommandHandler("kierunkowskaz_lewy", function()
    local v=getPedOccupiedVehicle(localPlayer)
    if (not v) then return end
    if (getVehicleController(v)~=localPlayer) then return end
    triggerServerEvent("doMigacze", v, 1)
end,false)
]]--

bindKey(",", "down", "kierunkowskaz_lewy")
--[[
addCommandHandler("kierunkowskaz_prawy", function()
    local v=getPedOccupiedVehicle(localPlayer)
    if (not v) then return end
    if (getVehicleController(v)~=localPlayer) then return end
    triggerServerEvent("doMigacze", v, 2)
end,false)
]]--

bindKey(".", "down", "kierunkowskaz_prawy")


bindKey(";", "down", function()
    local v=getPedOccupiedVehicle(localPlayer)
    if (not v) then return end
    if (getVehicleController(v)~=localPlayer) then return end
    local state=getVehicleOverrideLights(v)
    state=state+1
    if (state==3) then state=1 end
    triggerServerEvent("setVehicleOverrideLights", v, state)
end)