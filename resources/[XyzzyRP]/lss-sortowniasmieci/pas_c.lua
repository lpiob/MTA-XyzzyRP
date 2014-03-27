--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local I=1
local D=42

local start={674.42,-616.28,1596.3}-- punkt skad startuja rzeczy
local koniec={613.49,-616.91,1595.3}-- punkt do ktorego jada rzeczy

local obiekty={ 2672, 924, 926, 2673}
local czasRuchu=25000 -- czas potrzebny na pokonanie trasy

local function pasSpool()
	if getElementInterior(localPlayer)~=I or getElementDimension(localPlayer)~=D then return end
	local ox=math.random(1,10)/10-0.5

	local o=createObject(obiekty[math.random(1,#obiekty)], start[1]-ox,start[2]-ox,start[3])
	setElementInterior(o, I)
	setElementDimension(o, D)
	moveObject(o,czasRuchu, koniec[1]-ox,koniec[2]-ox,koniec[3])
	setTimer(destroyElement, czasRuchu, 1, o)
--utputDebugString("obiektow: " .. #getElementsByType("object", resourceRoot))
end

setTimer(pasSpool, 5000, 0)