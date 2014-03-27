--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--

frakcje_win = guiCreateWindow(0.7672,0.2937,0.2016,0.4354,"Frakcja",true)
frakcje_lbl = guiCreateLabel(0.0775,0.134,0.8372,0.4019,"Warsztat\n\nStanowisko: pracownik",true,frakcje_win)
guiLabelSetHorizontalAlign(frakcje_lbl, "center", true)
guiLabelSetVerticalAlign(frakcje_lbl, "center")
frakcje_btn = guiCreateButton(0.0775,0.5837,0.8295,0.3541,"Rozpocznij pracę",true,frakcje_win)

guiSetVisible(frakcje_win, false)

local selected_faction_id=nil

local miejsca_rozpoczecia_pracy={
    -- x,y,z,interior,dimension, nazwa="Warsztat", fid=

--	archiwum w UM
	{ 1466.81,-1783.73,1348.01,1,1,nazwa="Służby miejskie", fid=4 },
    { 1453.73,-1783.62,1348.01,1,1,nazwa="Policja", fid=2 },
    { 1454.76,-1783.62,1348.01,1,1,nazwa="Pogotowie", fid=6 },
	{ 1459.56,-1786.13,1348.01,1,1,nazwa="Straż Pożarna", fid=11 },	
	{ 1453.94,-1785.08,1348.01,1,1,nazwa="Służby Specjalne", fid=22},
    { 1467.90,-1783.65,1348.01,1,1,nazwa="Urząd Miasta", fid=1 },
	{ 1466.81,-1783.73,1348.01,1,1,nazwa="Służby miejskie", fid=4 },
	{ 1466.80,-1786.15,1348.01,1,1,nazwa="CNN News", fid=5 },
	{ 1455.79,-1783.62,1348.01,1,1,nazwa="Sad", fid=17 },
	{ 1456.90,-1783.62,1348.01,1,1,nazwa="Służba więzienna", fid=20 },
	{ 1458.18,-1783.61,1348.01,1,1,nazwa="Służby kościelne", fid=21},
	{ 1465.27,-1783.71,1348.01,1,1,nazwa="Departament Turystyki", fid=35},


	
	
    { 1919.77,-1768.43,1418.86,1,6,nazwa="Warsztat I", fid=3 },
    { 1553.80,-1689.50,1462.47,1,5,nazwa="Policja", fid=2 },
	{ 1562.42,-1690.49,1462.47,1,5,nazwa="Policja", fid=2 }, -- komisariat, za kratami
	{ 1018.67,-1303.78,1234.87,1,27,nazwa="Ośrodek Szkolenia Kierowców I", fid=8 },
	{ 690.42,-665.44,15.41,0,0,nazwa="Służby miejskie", fid=4 }, -- wysypisko
	{ 861.87,-552.34,18.07,0,0,nazwa="Służby miejskie", fid=4 }, -- wysypisko
	{ 797.87,-508.59,1205.88,1,10,nazwa="Służby miejskie", fid=4 }, -- wysypisko
	{ 2611.31,-2198.91,12.90,0,0,nazwa="Służby miejskie", fid=4 }, -- port
	{ 1477.46,-1705.26,1131.83,1,1,nazwa="Służby miejskie", fid=4 }, -- urzad miasta

--	{ 1146.38,-1813.63,1439.49,1,13,nazwa="Taxi", fid=7 },
    { 2056.29,-1384.82,1279.87,1,8,nazwa="Pogotowie", fid=6 },
    { 1478.28,-1797.08,1285.00,1,1,nazwa="Urząd Miasta", fid=1 },
    { 1486.90,-1776.02,1251.97,1,1,nazwa="Urząd Miasta", fid=1 },
    { 1487.06,-1777.33,1191.97,1,1,nazwa="Urząd Miasta", fid=1 },
    { 1402.03,-1804.07,12.58,0,0,nazwa="Urząd Miasta", fid=1 },
	{ 440.06,-1286.35,1195.32,1,7,nazwa="CNN News", fid=5 },
	{ 700.76,-1322.08,1758.03,1,48,nazwa="Kurier", fid=9 },
	{ 907.10,-1267.32,1446.20,1,26,nazwa="Straż Pożarna", fid=11 },
	{ 688.50,-115.72,24.43,0,0,nazwa="Warsztat II", fid=12 },
	{ 2287.56,-114.77,2025.53,2,7,nazwa="Warsztat III", fid=13 },
	{ 1056.40,-364.24,1494.02,1,20,nazwa="Kopalnia", fid=14 },
	{ 2143.14,-1763.27,1421.51,1,31,nazwa="Ochrona", fid=15 },	
	{ 1041.60,-927.07,1470.64,1,32,nazwa="Ośrodek Szkolenia Kierowców II", fid=16 },
	{ 1498.22,-1093.26,1440.77,1,21,nazwa="Sad", fid=17 },
	{ 1405.69,-1078.12,1441.41,1,21,nazwa="Sad", fid=17 },
	{ 1286.91,-931.21,1440.78,1,21,nazwa="Sad", fid=17 },
	{ 1217.49,246.05,2082.52,2,8,nazwa="Warsztat IV", fid=18 },
	{ 97.16,-147.50,2040.15,2,9,nazwa="Warsztat V", fid=19 },
	{ 2437.86,-2675.08,2034.17,2,3,nazwa="Importer", fid=10 },	
	{ 1168.27,-1178.83,19.08,0,0,nazwa="Importer", fid=10 },			
	{ -2058.15,551.50,1172.05,2,3140,nazwa="Służba więzienna", fid=20 },
	{ 913.23,2368.46,245.46,1,3140,nazwa="Służby kościelne", fid=21},
	{ 836.92,-1094.63,2251.20,2,37,nazwa="Służby kościelne", fid=21},
	{ 1172.93,-1425.91,2177.17,1,40,nazwa="Służby Specjalne", fid=22},
	{ 2251.69,120.07,2081.95,2,39,nazwa="Przychodnia lekarska", fid=23},
	{ -459.35,-33.28,2086.47,2,49,nazwa="Tartak", fid=24},
	{ 1490.42,-2223.39,2191.88,2,45,nazwa="Ośrodek Szkolenia Pilotów", fid=25},
	{ 2809.03,-1077.83,1592.72,1,51,nazwa="Departament Turystyki", fid=35},
	{ 3542.94,-1333.39,14.68,0,0,nazwa="Departament Turystyki", fid=35},	--wyspa
	{ 2704.94,-1823.28,1435.49,1,24,nazwa="Departament Turystyki", fid=35},	-- stadion
	{ 2683.96,-1820.06,1435.58,1,24,nazwa="Klub Miasta Los Santos", fid=40},	--stadion
	{ 2814.60,-1081.40,1592.71,1,51,nazwa="Klub Miasta Los Santos", fid=40},	--DT

	
--restauracje, knajpy, sklepy
	{ 1365.35,-1758.81,2034.63,2,12,nazwa="Usługi gastonomiczne - Sklep 'na rogu'", fid=26},
	{ 1365.35,-1758.81,2034.63,2,13,nazwa="Usługi gastonomiczne - Sklep Spożywczy 'Strug'", fid=27},
	{ 366.54,-2048.70,2006.56,2,14,nazwa="Usługi gastonomiczne - Knajpka 'na molo'", fid=28},
	{ 2114.14,-1789.35,2000.49,2,1,nazwa="Usługi gastonomiczne - Restauracja 'The Well Stacked Pizza'", fid=29},
	{ 2394.18,-1906.96,1999.64,2,5,nazwa="Usługi gastonomiczne - Restauracja 'Hot-Food'", fid=30},
	{ 2263.18,86.80,2180.54,2,19,nazwa="Usługi gastonomiczne - Market 'Prima'", fid=31},
	{ 235.19,-167.18,2180.54,2,20,nazwa="Usługi gastonomiczne - Market 'Super Sam'", fid=32},
	{ 668.98,-1858.41,1999.73,2,35,nazwa="Usługi gastonomiczne - Kawiarnia 'pod sceną'", fid=33},
	{ 1369.60,258.73,2066.36,2,41,nazwa="Usługi gastonomiczne - Knajpa 'Paszcza Wieloryba'", fid=34},
	{ 506.60,-1471.27,2066.36,2,53,nazwa="Usługi gastonomiczne - Knajpa 'Isaura'", fid=36},
	{ 1819.22,-1060.34,2180.54,2,52,nazwa="Usługi gastonomiczne - Market 'Łubin'", fid=37},
	{ 1560.51,-1879.96,2006.57,2,63,nazwa="Usługi gastonomiczne - Restauracja 'Przy skarpie'", fid=38},
	{ 1652.62,-1643.27,2566.36,2,68,nazwa="Usługi gastonomiczne - Restauracja 'Diabelski młyn'", fid=39},
	
}

for i,v in ipairs(miejsca_rozpoczecia_pracy) do
    v.marker=createMarker(v[1],v[2],v[3], "cylinder", 1, 255,255,255)
    setElementInterior(v.marker, v[4])
    setElementDimension(v.marker, v[5])
    setElementData(v.marker, "faction:duty", true)
end

local function getmrp(el)
    for i,v in ipairs(miejsca_rozpoczecia_pracy) do
	if (v.marker==el) then return v end
    end
    return nil
end

addEventHandler("onClientMarkerHit", resourceRoot, function(el, md)
    if (el~=localPlayer or not md) then return end
    if (getElementInterior(source)~=getElementInterior(localPlayer)) then return end

    if (not getElementData(source, "faction:duty")) then return end
    
    local _,_,z1=getElementPosition(el)
    local _,_,z2=getElementPosition(source)
    if (math.abs(z1-z2)>3)  then return end
    
    
    local mrp=getmrp(source)
    
    
    guiSetText(frakcje_win, mrp.nazwa)
    guiSetText(frakcje_lbl, mrp.nazwa)
    guiSetText(frakcje_btn, "")
    guiSetEnabled(frakcje_btn, false)
    selected_faction_id=mrp.fid
    triggerServerEvent("onPlayerRequestFactionMembershipData", localPlayer, mrp.fid)

    guiSetVisible(frakcje_win, true)
end)

addEventHandler("onClientMarkerLeave", resourceRoot, function(el, md)

    if (el~=localPlayer or getElementDimension(el)~=getElementDimension(source)) then return end

    if (not getElementData(source, "faction:duty")) then return end
    selected_faction_id=nil
    guiSetVisible(frakcje_win, false)
end)

addEvent("onServerReturnsFactionMembershipData", true)
addEventHandler("onServerReturnsFactionMembershipData", resourceRoot, function(dane)
    if (not dane) then
	guiSetText(frakcje_lbl,"Nie jesteś członkiem tej frakcji.")
	guiSetEnabled(frakcje_btn, false)
	guiSetText(frakcje_btn, "")
	return
    end
    guiSetText(frakcje_lbl, dane.faction_name.."\n\nStanowisko: "..dane.rank_name)
    -- jesli gracz juz jest w tej frakcji to dajemy mu opcje opuszczenia jej
    local cf=getElementData(localPlayer, "faction:id")
    if (cf and tonumber(cf)==selected_faction_id) then
        guiSetText(frakcje_btn, "Zakończ pracę")
    else
        guiSetText(frakcje_btn, "Rozpocznij pracę")
    end


    guiSetEnabled(frakcje_btn, true)
end)

addEventHandler("onClientGUIClick", frakcje_btn, function()
    if (not selected_faction_id) then return end	 -- nie powinno sie zdarzyc
    local cf=getElementData(localPlayer, "faction:id")
    if (cf and tonumber(cf)==selected_faction_id) then
	-- zakonczenie pracy
	triggerServerEvent("onPlayerFinishFactionDuty", localPlayer, selected_faction_id)
    else
	-- rozpoczecie pracy
	triggerServerEvent("onPlayerStartFactionDuty", localPlayer, selected_faction_id)
    end
    guiSetVisible(frakcje_win, false)
    selected_faction_id=nil
end, false)