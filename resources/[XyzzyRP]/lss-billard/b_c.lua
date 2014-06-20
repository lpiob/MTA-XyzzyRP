--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


local przyStole=false

local animState=0
local animStateLU=getTickCount()

stol_center={}
local Z
local W
local H
-- stol_center[1], stol_center[2], Z, W, H

local s_w, s_h = guiGetScreenSize ()


local function doPoolShot(x,y,x2,y2)
	local hit, hx,hy,hz, hitElement=processLineOfSight(x,y, Z, x2,y2,Z, false, false, false,true, false)
	if not hit or not hitElement then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " nie trafia w żadną bilę.", 5, 5, true)
	end
	local model=getElementModel(hitElement)
	if (rodzajeBil[model]) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " trafią w "..rodzajeBil[model].biernik..".", 5, 5, true)
	end
	triggerServerEvent("doPoolShot", resourceRoot, localPlayer, x,y,x2,y2, hitElement)
end

local function znajdzBile(x,y,x2,y2)
	local hit, hx,hy,hz, hitElement=processLineOfSight(x,y, Z, x2,y2,Z, false, false, false,true, false)
	if not hit then return x2,y2 end
	return hx,hy
end

function billard_render()
	if not przyStole then
		removeEventHandler("onClientRender", root, billard_render)
		return
	end
	if getControlState("aim_weapon") then

--		local x,y=getElementPosition(localPlayer)
		local x,y=getPedWeaponMuzzlePosition(localPlayer)
		local x2, y2 = getWorldFromScreenPosition ( s_w/2, s_h/2, 10 )
		if (x2<stol_center[1]-W/2) then x2=stol_center[1]-W/2 end
		if (x2>stol_center[1]+W/2) then x2=stol_center[1]+W/2 end

		if (y2<stol_center[2]-H/2) then y2=stol_center[2]-H/2 end
		if (y2>stol_center[2]+H/2) then y2=stol_center[2]+H/2 end

--		dxDrawLine3D ( x,y,Z,x2,y2,Z, tocolor(255,0,0,100),2 )
		local x3,y3=znajdzBile(x,y,x2,y2)
		dxDrawLine3D ( x,y,Z,x3,y3,Z, tocolor(255,0,0,100),2 )

		if animState==0 then
			triggerServerEvent("setPedAnimation", localPlayer, "POOL", "POOL_Med_Start", -1, false, false)
			animState=1
			animStateLU=getTickCount()
		elseif animState==1 then
			setPedRotation(localPlayer, findRotation(x,y,x2,y2))
			if getControlState("fire") then
				animState=2
				animStateLU=getTickCount()
				triggerServerEvent("setPedAnimation", localPlayer,"POOL", "POOL_Med_Shot", -1, false, false)
				doPoolShot(x,y,x2,y2)

			end
		end
	elseif animState==1 then
			triggerServerEvent("setPedAnimation", localPlayer)
			animState=0
			animStateLU=getTickCount()
	elseif animState==2 and getTickCount()-animStateLU>1500 then
--			setPedAnimation(localPlayer)
			triggerServerEvent("setPedAnimation", localPlayer)
			animState=0
			animStateLU=getTickCount()
	end
end

addEvent("onBillardNamierzanie",true)
addEventHandler("onBillardNamierzanie", resourceRoot, function(...)
	stol_center[1], stol_center[2], Z, W, H = ...
	if (not stol_center[1]) then
		przyStole=false
		return
	else
		przyStole=true
		addEventHandler("onClientRender", root, billard_render)
	end
--	
end)



function menu_resetStolu(argumenty)
	triggerServerEvent("doResetTable", resourceRoot, localPlayer, argumenty.stol)
--	triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " układa ponownie bile na stole.", 5, 5, true)
end


local ballSounds={
	"audio/108615__juskiddink__billiard-balls-single-hit-dry.ogg",
--	"audio/108616__juskiddink__hard-pop.ogg"
}

addEvent("playBallSound", true)
addEventHandler("playBallSound", resourceRoot, function()
--	outputDebugString("BS")
	if not przyStole then return end
	local x,y,z=getElementPosition(localPlayer)
	local x2,y2,z2=getElementPosition(source)
	if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>10 then return end
	playSound3D(ballSounds[math.random(1,#ballSounds)], x2,y2,z2)
end)