--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



local garaz=createColCuboid(-173,-267,0, 13, 20, 8)
-- 95.61,-295.55,1.58,277.6
-- 83.62,-315.20,1.58,144.8

local pos={ -159.35,-261.22,4.31 }


addCommandHandler("sv", function(plr,cmd,model)
	if (not model) then return end
	model=tonumber(model)
	if (model<400) then return end
	if (not exports["lss-core"]:eq_playerHasFreeSpace(plr)) then
	    outputChatBox("Nie masz miejsca w ekwipunku.", plr, 255,0,0)
	    return
	end

	local dbid=exports["lss-vehicles"]:createVehicleEx(model,pos[1],pos[2],pos[3],0,0,0)
	exports["lss-core"]:eq_giveItem(plr, 6, 2, dbid)

	
	outputChatBox("DBID " .. dbid, plr)
end,true,false)

--for i,v in ipairs(getE`lementsByType("vehicle")) do
--	outputDebugString(getElementModel(v))
--end