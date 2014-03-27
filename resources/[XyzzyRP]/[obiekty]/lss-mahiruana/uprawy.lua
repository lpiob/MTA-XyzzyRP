--[[
Tworzenie obiektow mahiruany do zbierania przez graczy.

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--


local uprawy={
--    { 2043.33,-489.95,71.45 },
--    {2048.13,-491.06,71.40 },
--    { 2052.69,-485.45,71.60 },
--	{2048.90,-476.05,73.48 },

-- hodowla slimakow
  { 1938.00,187.00,33.99 },
  { 1942.06,190.39,33.19 },
  { 1945.45,185.92,33.78 },
  { 1950.00,187.16,33.22 },
  -- wzgorze kolo 0,0,0

-- tartak
  { -485.67,-66.40,59.84 },
  { -491.70,-60.11,59.82 },
  { -487.76,-55.34,59.54 },
  { -483.69,-65.24,59.71 },

	--to sa te gites na tartaku
	-- { -724.42,-123.07,67.22 },
	-- { -721.26,-122.23,67.46 },
	-- { -722.80,-125.00,67.31 },
	-- { -726.78,-125.39,67.01 },
	

--[[
	{ 2330.88,-656.33,128.59 },
	{ 2331.64,-651.85,129.16 },
	{ 2327.58,-653.08,129.15 },
	{ 2327.56,-656.92,128.82 },
	{ 2328.80,-661.08,129.23 },
	{ 2328.15,-648.25,129.97 },
]]--
-- komisariat ls!
--	{ 1478.92,-1665.02,13.55 },
}



addEvent("onZbior", true)
addEventHandler("onZbior", resourceRoot, function(gracz, indeks)
	if (not indeks or not uprawy[indeks]) then return end
	if (not isElement(uprawy[indeks].object)) then return end

	if (not exports["lss-core"]:eq_giveItem(gracz, 27,1)) then
		outputChatBox("Nie masz miejsca w inwentarzu.", gracz, 255,0,0,true)
		return
	end

	destroyElement(uprawy[indeks].object)
	destroyElement(uprawy[indeks].fobject)
	uprawy[indeks].object=nil
	uprawy[indeks].fobject=nil
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " zrywa rośliny.", 5, 15, true)
end)
--triggerServerEvent("onZbior", args.obiekt, localPlayer, args.indeks)

local function respawnUpraw()
	for i,v in ipairs(uprawy) do
		if (math.random(1,3)==1 and (not v.object or not isElement(v.object))) then
			-- 823
			v.object=createObject(3409, v[1], v[2], v[3], 0,0,math.random(0,360))
		--	928, 924, 926
			v.fobject=createObject(928, v[1], v[2], v[3], 0,0,math.random(0,360))
			setObjectScale(v.fobject,0.1)
			setElementData(v.fobject,"customAction",{label="Zbierz",resource="lss-mahiruana",funkcja="menu_zbierz",args={obiekt=v.object,indeks=i}})
			return
		end
	end
end
setTimer(respawnUpraw, 12000, 0)