--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local blips={}
local REFRESH_INTERVAL=10000

local function odswiez()
	local pojazdy={}
	for i,v in ipairs(getElementsByType("vehicle")) do
		local dbid=tonumber(getElementData(v,"dbid"))
		if dbid then
			pojazdy[dbid]=v
		end
	end

	local EQ=exports["lss-gui"]:eq_get()
	for i,v in ipairs(EQ) do
		if (v.itemid and tonumber(v.itemid)==6 and v.subtype and tonumber(v.subtype)) then
			if pojazdy[tonumber(v.subtype)] and not blips[tonumber(v.subtype)] then
				blips[tonumber(v.subtype)]=createBlipAttachedTo(pojazdy[tonumber(v.subtype)], 0, 1, 100,100,255, 100, 0)
				setElementData(blips[tonumber(v.subtype)], "upd", getTickCount())
			end
		end
	end

	for i,v in ipairs(blips) do
		if (getTickCount()-getElementData(v,"upd")>(REFRESH_INTERVAL*2)) then
			destroyElement(v)
			blips[i]=nil
		end
	end

end


setTimer(odswiez, REFRESH_INTERVAL, 0)