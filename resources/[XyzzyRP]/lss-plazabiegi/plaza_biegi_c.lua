--[[
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



addEvent("plaza_timer_stop", true)
addEventHandler("plaza_timer_stop", getRootElement(), function()
	local timer = getTickCount()-STARTTIME --w milisekundach
	local timer = timer/1000 --w sekundach
	setElementData(source, "plaza:time", timer)
end)

addEvent("plaza_timer_start", true)
addEventHandler("plaza_timer_start", getRootElement(), function()
	STARTTIME = getTickCount()
end)


local plaza_bieg = {
	{635.58,-1883.06,4.14,85.5},
	{616.62,-1867.34,4.79,44.7},
	{603.15,-1868.16,4.67,130.9},
	{591.47,-1890.00,3.74,145.9},
	{568.23,-1887.87,3.64,91.7},
	{566.24,-1854.14,4.79,3.7},
	{561.18,-1834.67,5.63,77.0},
	{527.43,-1831.57,5.63,77.6},
	{499.97,-1831.58,5.46,89.9},
	{495.01,-1844.38,4.52,159.7},
	{487.71,-1875.76,3.18,140.0},
	{464.23,-1881.59,2.68,95.2},
	{451.35,-1881.53,2.66,79.8},
	{448.03,-1867.88,3.16,30.3},
	{440.96,-1867.51,3.14,141.9},
	{440.11,-1879.83,2.65,176.7},
	{416.52,-1882.65,2.57,97.7},
	{371.47,-1884.90,2.21,91.4},
	{348.39,-1883.09,2.25,80.8},
	{331.01,-1871.41,2.78,46.0},
	{315.81,-1866.61,2.89,89.2},
}

local plaza_punkty = {}


PLAZA_START = createMarker(666.65,-1880.17,5.46-1,"cylinder",1.5,255,255,0)
PLAZA_TEXT = createElement("text")
setElementPosition(PLAZA_TEXT, 666.65,-1880.17,5.46+0.5)
setElementData(PLAZA_TEXT, "text", "Bieg po plaży")

PLAZA_KONIEC = createMarker(306.85,-1866.98,2.86,"checkpoint",1,255,255,0)
setMarkerSize(PLAZA_KONIEC, 0)

for i,v in ipairs(plaza_bieg) do
		plaza_punkty[i] = createMarker(v[1], v[2], v[3], "checkpoint", 1)
		setMarkerSize(plaza_punkty[i], 0)
		setElementData(plaza_punkty[i], "plaza:nr", i)
		addEventHandler("onClientMarkerHit", plaza_punkty[i], function(el)
			if not el then return end
			if el ~= getLocalPlayer() then return end
			if getElementType(el) ~= "player" then return end
			if getPedOccupiedVehicle(el) then return end
			bieg_po_plazy(el)
		end)
end
	
function bieg_po_plazy(plr)
	
	local ilosc = #plaza_bieg
	cel = cel+1
	for k,v in ipairs(plaza_punkty) do
		if cel == #plaza_bieg+1 then
			setMarkerSize(PLAZA_KONIEC, 1)
			setMarkerSize(plaza_punkty[k], 0)
			playSoundFrontEnd(40)
		elseif k == cel then
			setMarkerSize(plaza_punkty[k], 1)
			setMarkerSize(plaza_punkty[k-1], 0)
			playSoundFrontEnd(40)
			return
		end
	end
end


addEventHandler("onClientMarkerHit", PLAZA_KONIEC, function(el)
	if not el then return end
	if getElementType(el) ~= "player" then return end
	if getPedOccupiedVehicle(el) then return end
	if el ~= getLocalPlayer() then return end
	setMarkerSize(PLAZA_KONIEC, 0)
	setMarkerSize(PLAZA_START, 1)
	cel = 0
	-- triggerEvent(el, "plaza_timer_stop", getRootElement())
	local timer = getTickCount()-STARTTIME --w milisekundach
	local timer = math.ceil(timer/1000) --w sekundach
	outputChatBox("(( Twój czas biegu to "..timer.." sekund. ))")
	
	if timer <= 150 then --dostaje nagrode
		local rand = math.random(1,4)
		outputChatBox("(( Poprzez intensywny trening, twoja stamina wzrasta o "..rand.." ))")
		triggerServerEvent("onPlazaRunCompleted", el, rand)
		
		if getElementData(el, "player:dog") then
			local a,b,c = getElementPosition(el)
			local d,e,f = getElementPosition(getElementData(el, "player:dog"))
			if not getElementData(getElementData(el, "player:dog"),"dog:moveblock") then
				if math.random(1,1)==1 then
					triggerServerEvent("onPlazaRunCompletedDOG", el)
				end
			end
		end
	else
		triggerEvent("broadcastCaptionedEvent", el, getPlayerName(el).." upada ze zmęczenia", 5, 10, true)
	end
end)

addEventHandler("onClientMarkerHit", PLAZA_START, function(el)
	if not el then return end
	if getElementType(el) ~= "player" then return end
	if getPedOccupiedVehicle(el) then return end
	if el ~= getLocalPlayer() then return end
	setMarkerSize(PLAZA_START, 0)
	cel = 0
	bieg_po_plazy(el)
	STARTTIME = getTickCount()
end)