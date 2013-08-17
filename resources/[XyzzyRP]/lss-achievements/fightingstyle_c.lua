-- kod zwiazany z obsluga stylow walki
local styles={
	{5},			-- 1 Styl boksera  5
	{6},			-- 2 Karate        6
	{7,8,14},		-- 3 Styl ganstera 7+8+14
	{7,5,16},		-- 4 Styl uliczny  7+5+16
	{4,5,6,7,8,16},	-- 5 Styl MMA      4+5+6+7+8+16
}

local lastSwitchTime=getTickCount()
local MIN_SWITCH_INTERVAL=1000

local function diverseFightingStyle()
	outputDebugString("a")
	if (getPedWeaponSlot(localPlayer) or 31337)>1 then return end
	local fstyle=getElementData(localPlayer, "fightingStyle") or 0
	if fstyle>0 and styles[fstyle] and getTickCount()-lastSwitchTime>MIN_SWITCH_INTERVAL then
		triggerServerEvent("setPedFightingStyle", localPlayer, styles[fstyle][math.random(#styles[fstyle])])
		lastSwitchTime=getTickCount()
		outputDebugString("switching")
	end
end

bindKey("fire","down", diverseFightingStyle)
bindKey("aim_weapon","down", diverseFightingStyle)
bindKey("enter_exit","down", diverseFightingStyle)