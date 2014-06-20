--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



local miscBlips={}

local function destroyMiscBlipForPlayer(plr)
	if miscBlips[plr] then
		destroyElement(miscBlips[plr][1])
		miscBlips[plr]=nil
	end
end
-- exports["lss-frakcje"]:addMiscRequest(senderElement)
function addMiscRequest(re)
	if getElementInterior(re)~=0 or getElementDimension(re)~=0 then return end
	destroyMiscBlipForPlayer(re)

	local x,y,z=getElementPosition(re)
	local blip=createBlip(x,y,z,47)
	miscBlips[re]={blip, getTickCount()}
end


local function miscBlipsCleanup()
	for i,v in pairs(miscBlips) do
		if not isElement(i) or getTickCount()-v[2]>1000*60*5 then
			destroyMiscBlipForPlayer(i)
		end
	end
end

setTimer(miscBlipsCleanup, 60000, 0)
