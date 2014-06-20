--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--


addCommandHandler("yoff", function()
	showPlayerHudComponent ("all",false)
    showChat(false)
	setElementData(localPlayer, "hud:removeclouds", true)
end)

addCommandHandler("yon", function()
	showPlayerHudComponent ("all",true)
	showChat(true)
	setElementData(localPlayer, "hud:removeclouds", false)
end)