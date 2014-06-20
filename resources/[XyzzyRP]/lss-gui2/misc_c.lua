--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



addEvent("doQuake", true)
addEventHandler("doQuake", root, function(s)
	local x,y,z=getElementPosition(localPlayer)
	createExplosion(x,y,z+10,12, false, s, false)
end)