--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local veh=getElementByID("mcb")
if veh then
--	local snd=playSound3D("audio/gto_-_rap.mod", 0,0,-100, true)
	local snd=playSound3D("audio/4852__zajo__loop02.ogg", 0,0,-100, true)
	attachElements(snd, veh)
end

veh=getElementByID("mcb2")
if veh then
	local snd=playSound3D("audio/gto_-_rap.mod", 0,0,-100, true)
--	local snd=playSound3D("audio/4852__zajo__loop02.ogg", 0,0,-100, true)
	attachElements(snd, veh)
end

veh=getElementByID("mcb3")
if veh then         
	local snd=playSound3D("audio/24039__bebeto__loop022.ogg", 0,0,-100, true)
--	local snd=playSound3D("audio/4852__zajo__loop02.ogg", 0,0,-100, true)
	attachElements(snd, veh)
end