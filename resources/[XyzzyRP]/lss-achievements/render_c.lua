--[[
lss-achievements: osiągniecia

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--


local ACHIEVEMENT_FADEOUT=45000
local sw,sh=guiGetScreenSize()

local top=sh*470/600
local left=sw*180/800

local achievement_lines={}

local types={ "orange", "gold", "purple","red","black" }
--[[
local lines={
	{ name="Bez paniki!", descr="To tylko testy nowego kodu!"},
	{ name="Pierwsza krew", descr="ktoś po raz pierwszy wbił Tobie stan BW (nieprzytomności), udaj się do szpitala (skate park) i odegraj akcję doznanych przez Ciebie obrażeń. +25GP"},
	{ name="Biznesmen", descr="Założyłeś swój pierwszy biznes! +5GP"},
	{ name="Biznesmen", descr="Założyłeś swój pierwszy biznes! +5GP"},

}
]]--

local adisplay_active=false

local function render()
	adisplay_active=false
	for i=#achievement_lines,1,-1 do
		local v=achievement_lines[i]

		local alpha=math.floor((getTickCount()-v.ts)/2)
		if alpha>255 then alpha=255 end

		local ltop=top-16 + (i-1)*36
		dxDrawRectangle( left+16+255-alpha, ltop-8, sw/2, 32+16, tocolor(0,0,0,alpha/5)) 

		dxDrawImage(left,ltop, 32, 32,"i/star_".. types[v.typ] ..".png")
		
		dxDrawText(v.name, left+36, ltop, sw, ltop+16, tocolor(255,255,255,alpha), 1, "default-bold", "left", "bottom")
		dxDrawText(v.descr, left+36, ltop+16, left+36+sw/2,ltop+32, tocolor(255,255,255,alpha), 1, "default", "left", "top",false,true)

		if getTickCount()-v.ts>ACHIEVEMENT_FADEOUT then
			table.remove(achievement_lines,i)
		else
			adisplay_active=true
		end

	end
	if not adisplay_active then
		removeEventHandler("onClientRender", root, render)
	end
end
--[[
if getPlayerName(localPlayer)=="Bob_Euler" then
	addEventHandler("onClientRender", root, render)
	setTimer(function()
		local line=lines[math.random(1,#lines)]
		line.typ=math.random(1,5)
		line.ts=getTickCount()
		table.insert(achievement_lines, line)
		playSound("a/tada"..math.random(1,2)..".ogg")
	end, 6000, 0)
end
]]--




addEvent("showAchievement", true)
addEventHandler("showAchievement", root, function(typ, nazwa, opis)
	table.insert(achievement_lines, { name=nazwa, descr=opis, typ=typ, ts=getTickCount() })
	playSound("a/tada"..math.random(1,2)..".ogg")
	if not adisplay_active then
		addEventHandler("onClientRender", root, render)
	end
end)