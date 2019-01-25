--[[
@author Karer <karer.programmer@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local lastChange = 0

local laser = {}

local dots = {}

local laserData = {}
laserData.r,laserData.g,laserData.b,laserData.a = 255,3,3,80
laserData.width = 0.4


function laserToggle ()
	local cTick = getTickCount ()
	if cTick - lastChange >= 1500 then
		lastChange = cTick
		if not getElementData (getLocalPlayer(),"laserchange") then return end
		local c = getElementData (getLocalPlayer(),"laser")
		if c then
			setElementData (getLocalPlayer(),"laser",false)
		elseif isPlayerWeaponValidForLaser (getLocalPlayer()) then
			setElementData (getLocalPlayer(),"laser",true)
		end
	end
end

bindKey ("L","down",laserToggle)

addEventHandler( "onClientRender", getRootElement(),
	function()
		local players = getElementsByType("player",getRootElement(),true)
		for k,v in ipairs(players) do
			drawLaser(v)
		end
	end
)

function drawLaser(player)
	if getElementData(player, "laser") then
		local targetself = getPedTarget(player)
		if targetself and targetself == player then
			targetself = true
		else
			targetself = false
		end		
		
		if getPedTask(player, "secondary", 0) == "TASK_SIMPLE_USE_GUN" and getPedControlState (player,"aim_weapon") and getPedAnimation (player) == false and isPlayerWeaponValidForLaser(player) == true and targetself == false then
			local x,y,z = getPedWeaponMuzzlePosition(player)
			if not x then
				outputDebugString("getPedWeaponMuzzlePosition failed")
				x,y,z = getPedTargetStart(player)
			end
			local x2,y2,z2 = getPedTargetEnd(player)
			if not x2 then
				--outputDebugString("getPedTargetEnd failed")
				return
			end			
			local x3,y3,z3 = getPedTargetCollision(player)
			local r,g,b,a = laserData.r,laserData.g,laserData.b,laserData.a--GetLaserColor(player)
			if x3 then -- collision detected, draw til collision and add a dot
				dxDrawLine3D(x,y,z,x3,y3,z3, tocolor(r,g,b,a), laserData.width)
				drawLaserDot(player, x3,y3,z3)
			else -- no collision, draw til end of weapons range
				dxDrawLine3D(x,y,z,x2,y2,z2, tocolor(r,g,b,a), laserData.width)
				destroyLaserDot(player)
			end
		else
			destroyLaserDot(player) -- not aiming, remove dot, no laser
		end
	else
		destroyLaserDot(player)
	end
end

function drawLaserDot (player, x,y,z)
	if not dots[player] then
		dots[player] = createMarker(x,y,z, "corona", .05, laserData.r, laserData.g, laserData.b, laserData.a)
	else
		setElementPosition(dots[player], x,y,z)
	end
end

function destroyLaserDot(player)
	if dots[player] and isElement(dots[player]) then
		destroyElement(dots[player])
		dots[player] = nil
	end
end

function isPlayerWeaponValidForLaser(player) -- returns false for unarmed and awkward weapons
	local weapon = getPedWeapon(player)
	return true
end
