--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--


local walkingAnims={
 ["WOMAN_walksexy"]=true,
 ["WALK_drunk"]=true,
 ["WALK_fat"]=true,
 ["WALK_fatold"]=true,
 ["WALK_gang1"]=true,
 ["WALK_gang2"]=true,
 ["WALK_old"]=true,
 ["WALK_player"]=true,
 ["WALK_shuffle"]=true,
 ["WALK_Wuzi"]=true,
 ["WOMAN_run"]=true,
 ["WOMAN_runbusy"]=true, -- bez
 ["WOMAN_runfatold"]=true,
 ["WOMAN_walkbusy"]=true,
 ["RUN_gang1"]=true,
 ["RUN_1armed"]=true,
 ["RUN_civi"]=true,
 ["PLAYER_sneak"]=true,
}

local function walkingAnim()
	local c1,c2=getPedAnimation(localPlayer)
	if not c1 then return false end
	if c1 and c1=="ped" then
		if walkingAnims[c2] then return true end
	end
end



setTimer(function()
	if not walkingAnim() then 
		if not getPedOccupiedVehicle(localPlayer) and getCameraTarget()==localPlayer then
		end
		return
	end
	if getControlState("right") then
		local _,_,rz=getElementRotation(localPlayer)
		local m=getControlState("backwards") and 3 or 1
		setPedRotation(localPlayer, rz-4*m)
	elseif getControlState("left") then
		local _,_,rz=getElementRotation(localPlayer)
		local m=getControlState("backwards") and 3 or 1
		setPedRotation(localPlayer, rz+4*m)
	end
end, 50, 0)

bindKey("space", "down", function()
	if getCameraTarget()~=localPlayer or getPedOccupiedVehicle(localPlayer) or isCursorShowing() then return end
	if getControlState("forwards") or getControlState("backwards") or getControlState("left") or getControlState("right") then return end
	if walkingAnim() then
		triggerServerEvent("setPedAnimation", localPlayer)
		return
	end
	if getPedAnimation(localPlayer) then return end 
	local walkingStyle=getElementData(localPlayer, "walkingStyle")
	if not walkingStyle then return end
	triggerServerEvent("setPedAnimation", localPlayer, "ped", walkingStyle)
end)

