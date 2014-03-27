--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--


local function drugProcess()
	for i,v in ipairs(getElementsByType("player")) do
		local drunkLevel=getElementData(v,"drunkLevel")
		if (drunkLevel) then
			drunkLevel=tonumber(drunkLevel)
			if (drunkLevel<1) then
				removeElementData(v, "drunkLevel")
			else
--				outputDebugString("zmniejszanie " .. getPlayerName(v))
				drunkLevel=drunkLevel-0.15
				setElementData(v, "drunkLevel", drunkLevel)
			end
		end
		local joint=getElementData(v,"joint")
		if (joint) then
			-- regeneracja HP
			local hp=getElementHealth(v)
			hp=hp+math.random(5,10)
			if (hp>100) then hp=100 end
			setElementHealth(v, hp)
		end
	end
end

setTimer(drugProcess, 30000, 0)