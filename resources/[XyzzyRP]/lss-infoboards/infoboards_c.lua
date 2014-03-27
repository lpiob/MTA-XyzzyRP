--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--


local function cnReloadNews()
    local f=getResourceFromName("lss-frakcje")
    if (f) then
        triggerServerEvent("doRefreshNews", getResourceRootElement(f))
    end
end


local tablice={
-- x,y,z,r,d,i
	{1032.67,-1302.19,1235.87,1,27,1, tablica=1},	-- harmonogram (osrodek szkolenia kierowcow I)
	{1547.44,-1688.89,1463.47,1,5,1, tablica=2}, 	-- harmonogram (komisarial policji)
	{1928.59,-1780.15,13.25,1,0,0, tablica=3},	-- tablica informacyjna (warsztat I)
	{2044.11,-1402.45,1275.77,1,8,1, tablica=4},	-- harmonogram (szpital)
	{1466.45,-1749.90,15.45,1,0,0,	tablica=5},	-- informacje dla graczy (um)
	{303.03,-80.23,1001.52,1,18,4, tablica=6},	-- strzelnica
	{1489.90,-1786.91,1132.96,1,1,1, tablica=7},	-- um ogloszenia sm
	{2733.22,-2621.11,13.66,1,23,0, tablica=8},	-- aj
	{453.99,-1124.15,92.57,1,0,0, tablica=9, nazwa="Ogłoszenia", onUpdate=cnReloadNews },	-- CNN News     -- ta tablica jest magiczna, nie przesuwaj jej!
	{2026.54,-1397.59,1279.99,1.5,8,1, tablica=11, nazwa="((zeszyt))"}, -- szpital
	{1479.15,-1799.64,1132.96,1,1,1,tablica=12},	-- wydzial architektoniczny (UM)
	{903.51,-1259.13,14.70,1,0,0,tablica=13},		-- Tablica informacyjna (straz pozarna)
	{928.55,-1206.80,17.20,1,0,0,tablica=161},		-- Tablica informacyjna (2) (straz pozarna)
	{898.61,-1270.30,1447.21,1,26,1,tablica=14},	-- Harmonogram (straz pozarna)
	{1135.90,-1825.10,1440.49,1,13,1,tablica=15},		-- harmonogram (taxi)
	{1494.44,-1766.51,18.50,1,0,0,tablica=16, nazwa="(( tablica informacyjna))\nPrace dorywcze" },
	{1471.58,-1789.58,1285.00,1,1,1,tablica=17, nazwa="(( skoroszyt ))"},
	{1483.98,-1801.55,1132.97,1,1,1,tablica=93},	-- lista pieter (UM)
	{1483.98,-1801.55,1162.97,1,1,1,tablica=93},	-- lista pieter (UM)
	{1483.98,-1801.55,1192.97,1,1,1,tablica=93},	-- lista pieter (UM)
	{1483.98,-1801.55,1222.97,1,1,1,tablica=93},	-- lista pieter (UM)
	{1483.98,-1801.55,1252.97,1,1,1,tablica=93},	-- lista pieter (UM)
	{1484.69,-1805.35,1286.00,1,1,1,tablica=93},	-- lista pieter (UM)
	{1480.49,-1803.57,1285.77,1,1,1,tablica=94},	-- wyzyty (UM)
	{680.93,-113.46,25.43,1,0,0,tablica=95},	-- tablica ze zleceniami (warsztat II)
	{662.13,-137.36,25.60,1,0,0,tablica=96},	-- tablica informacyjna (warsztat II)
	{800.01,-514.29,16.13,1,0,0,tablica=97},	-- tablica informacyjna (służby miejskie)
	{807.23,-490.50,1206.68,1,10,1,tablica=7},	-- sm - zduplikowana tablica z tą z urzędu
	{1926.85,-1786.66,1419.86,1,6,1,tablica=99},	-- harmonogram (warsztat I)
	{2292.66,-108.22,26.88,1,0,0,tablica=100},	-- tablica informacyjna (warsztat III)	
	{2277.53,-115.91,2026.53,1,7,2,tablica=101},	-- harmonogram (warsztat III)
	{2022.75,-1403.81,13.53,1,0,0,tablica=102},	-- tablica informacyjna (szpital)		
	{648.34,-1364.88,13.21,1,0,0,tablica=103},	-- tablica informacyjna (firma kurierska)
	{702.76,-1330.44,1758.72,1,48,1,tablica=104},	-- harmonogram (firma kurierska)
	{1111.92,-1804.72,16.49,1,0,0,tablica=105},	-- tablica informacyjna (taxi)	
	{1058.05,-354.50,73.79,1,0,0,tablica=106},	-- tablica informacyjna (kopalnia)		
	{1062.97,-371.75,1494.92,1,20,1,tablica=107},	-- harmonogram (kopalnia)
	{1043.86,-1294.70,13.55,1,0,0,tablica=108},	-- tablica informacyjna (osrodek szkolenia kierowcow I)
	{2177.92,-1774.00,13.54,1,0,0,tablica=109},	-- tablica informacyjna (ochrona)
	{2177.83,-1776.86,1422.71,1,31,1,tablica=110},	-- harmonogram (ochrona)	
	{1032.12,-945.34,42.64,1,0,0,tablica=111},	-- tablica informacyjna (ośrodek szkolenia kierowców II)
	{1027.73,-928.23,1472.44,1,32,1,tablica=112},	-- harmonogram (ośrodek szkolenia kierowców II)
	{1310.77,-1098.46,1441.53,1,21,1,tablica=113},	-- tablica informacyjna (sąd)
	{1299.22,-928.33,1441.79,1,21,1,tablica=114},	-- harmonogram (sąd)
	{1377.13,-1093.93,1441.67,1,21,1,tablica=115},	-- tablica informacyjna 2 (sąd)
	{2880.61,-1822.76,11.07,1,0,0,tablica=116},	-- tablica informacyjna 2 (służby miejskie)
	{439.53,-1124.22,1196.34,1,7,1,tablica=117},	-- harmonogram (CNN News)
	{1498.31,-1716.93,13.20,1,0,0,tablica=118, nazwa="(( tablica informacyjna))\nZasady dla użytkowników\n parkingu" },	-- na parkingu przy urzedzie miasta
	{1514.39,-1634.13,13.20,1,0,0,tablica=118, nazwa="(( tablica informacyjna))\nZasady dla użytkowników\n parkingu" },	-- na parkingu przy urzedzie miasta
	{1444.67,-1636.79,13.22,1,0,0,tablica=118, nazwa="(( tablica informacyjna))\nZasady dla użytkowników\n parkingu" },	-- na parkingu przy urzedzie miasta
	{1207.94,239.01,19.62,1,0,0,tablica=119},	-- Tablica informacyjna (warsztat IV)		
	{1210.19,237.32,2083.51,1,8,2,tablica=120},	-- harmonogram (warsztat IV)
	{123.74,-152.69,1.58,1,0,0,tablica=121},	-- Tablica informacyjna (warsztat V)		
	{98.63,-147.05,2041.15,1,9,2,tablica=122},	-- harmonogram (warsztat V)		
	{1487.76,-1790.73,1252.96,1,1,1,tablica=124, nazwa="(( Ogłoszenia wyborcze ))"},	-- um
	{1470.36,-1805.91,1162.96,1,1,1,tablica=125, nazwa="(( Przeszklona tablica\nz ogłoszeniami ))"},
	{1487.77,-1793.56,1192.96,1,1,1,tablica=126},	-- um Wydział ds. gospodarki
	{1158.71,-1229.98,17.33,1,0,0,tablica=127},	-- import salon
	{2421.50,-2674.77,13.57,1,0,0,tablica=127},	-- import statek
	{1573.33,-1691.20,1462.08,1,5,1,tablica=128},	-- komisariat policji (cele)
	{1547.17,-1679.11,1493.02,1,5,1,tablica=129},	-- komisariat policji (HSIU)
	{1592.79,-1689.57,1491.52,1,5,1,tablica=157},	-- komisariat policji (MPU)
	{-2059.93,564.15,1173.08,1,3140,2,tablica=130},	-- harmonogram (sluzba wiezienna)
	{2814.23,-2686.49,7.09,1,35,0,tablica=131},	-- kodeks wieznia (sluzba wiezienna)
	{2770.60,-2506.37,13.54,1,0,0,tablica=132},	-- tablica informacyjna (sluzba wiezienna)
	{2764.98,-2656.78,7.09,1,35,0,tablica=133},	-- lista skazancow (sluzba wiezienna)
	{1409.75,-1777.76,13.55,1,0,0,tablica=134},	-- Przydzielanie / Pobieranie pojazdów (Urząd Miasta)
	{1565.99,-1689.97,6.22,1,0,0,tablica=135},	-- Przydzielanie / Pobieranie pojazdów (Policja)
	{807.87,-537.63,16.34,1,0,0,tablica=136},	-- Przydzielanie / Pobieranie pojazdów (Służby Miejskie)
	{420.61,-1118.44,85.21,1,0,0,tablica=137},	-- Przydzielanie / Pobieranie pojazdów (CNN News)
	{2031.43,-1350.66,6.63,1,0,0,tablica=138},	-- Przydzielanie / Pobieranie pojazdów (Pogotowie)
--	{1095.92,-1779.32,13.57,1,0,0,tablica=139},	-- Przydzielanie / Pobieranie pojazdów (Taxi)
	{1043.86,-1298.14,13.55,1,0,0,tablica=140},	-- Przydzielanie / Pobieranie pojazdów (Ośrodek Szkolenia Kierowców I)
	{786.61,-1335.88,13.54,1,0,0,tablica=141},	-- Przydzielanie / Pobieranie pojazdów (Kurierzy)
	{898.37,-1285.80,15.15,1,0,0,tablica=142},	-- Przydzielanie / Pobieranie pojazdów (Straż pożarna)
	{1067.16,-349.95,73.99,1,0,0,tablica=143},	-- Przydzielanie / Pobieranie pojazdów (Kopalnia)
	{1025.76,-930.14,42.18,1,0,0,tablica=144},	-- Przydzielanie / Pobieranie pojazdów (Ośrodek Szkolenia Kierowców II)
	{1380.31,-1117.12,25.75,1,0,0,tablica=145},	-- Przydzielanie / Pobieranie pojazdów (Sąd)
	{2771.77,-2483.57,13.65,1,0,0,tablica=146},	-- Przydzielanie / Pobieranie pojazdów (Służby więzienne)
	{1234.03,-1444.39,13.56,1,0,0,tablica=147},	-- Przydzielanie / Pobieranie pojazdów (Służby Specjalne)
	{1173.72,-1423.93,2178.17,1,40,1,tablica=148},	-- Harmonogram (Służby Specjalne)
	{1229.80,-1470.36,13.55,1,0,0,tablica=149},	-- Przydzielanie / Pobieranie pojazdów (Służby Specjalne)
	{2247.99,115.01,26.48,1,0,0,tablica=150},	-- Tablica informacyjna (Prywatna Przychodnia Lekarska)
	{2258.68,126.50,2082.95,1,39,2,tablica=151},	-- Harmonogram (Prywatna Przychodnia Lekarska)
	{2273.95,130.00,26.76,1,0,0,tablica=152},	-- Przydzielanie / Pobieranie pojazdów (Prywatna Przychodnia Lekarska)
	{1450.60,-2281.76,13.55,1,0,0,tablica=153},	-- Tablica informacyjna (Ośrodek Szkolenia Pilotów)
	{1498.14,-2224.14,2192.83,1,45,2,tablica=154},	-- Harmonogram (Ośrodek Szkolenia Pilotów)
	{1450.69,-2292.35,13.55,1,0,0,tablica=155},	-- Przydzielanie / Pobieranie pojazdów (Ośrodek Szkolenia Pilotów)
	{2597.03,-2237.06,13.54,1,0,0,tablica=7},	-- sm - zduplikowana tablica z tą z urzędu
	{2817.94,-1083.21,1593.71,1,51,1,tablica=158},	-- Tablica informacyjna (Departament Turystyki)
	{2818.64,-1121.86,1593.71,1,51,1,tablica=159},	-- Harmonogram (Departament Turystyki)
	{2853.59,-1060.93,24.93,1,0,0,tablica=160},	-- Przydzielanie / Pobieranie pojazdów (Departament Turystyki)
	{1682.77,-2283.78,13.51,1,0,0,tablica=162},	-- Tablica informacyjna (Import)
	{1405.49,-1091.36,1441.51,1,21,1,tablica=163, nazwa="(( skoroszyt ))"},	--sad (biurko sedziego)
	{1552.20,-1684.75,1462.67,1,5,1,tablica=164, nazwa="(( skoroszyt ))"},	--policja (biurko na korzytarzu)
	{2065.41,-1398.15,1274.37,1,8,1,tablica=165, nazwa="(( zeszyt ))"},	--szpital (recepcja)
	{2065.41,-1398.15,1274.37,1,8,1,tablica=165, nazwa="(( zeszyt ))"},	--cnn (biuro glowne)
	{1380.01,-1756.72,13.55,1,0,0,tablica=166}, --kafejka 1
	{447.68,-1294.57,1195.82,1,7,1,tablica=167, nazwa="(( zeszyt ))"},	--cnn (biuro glowne)
	{926.31,-1288.50,1440.13,1,26,1,tablica=168, nazwa="(( zeszyt ))"},	--straz pozarna (biuro glowne)
	{1471.83,-1700.41,1131.93,1,1,1,tablica=169, nazwa="(( zeszyt ))"},	--sm (biuro glowne)
	{1305.73,-929.97,1440.88,1,21,1,tablica=170, nazwa="(( zeszyt ))"},	--sad (biuro glowne)

}


ib_win = guiCreateWindow(0.5703,0.2729,0.4016,0.5958,"",true)
ib_memo = guiCreateMemo(0.0506,0.1049,0.8911,0.8462,"",true,ib_win)
guiSetVisible(ib_win,false)

for i,v in ipairs(tablice) do
	v.cs=createColSphere(v[1],v[2],v[3],v[4])
	setElementInterior(v.cs,v[6])
	setElementDimension(v.cs,v[5])
	v.t3d=createElement("text")
	setElementPosition(v.t3d,v[1],v[2],v[3]+1)
	setElementData(v.t3d, "text", v.nazwa or "(( tablica\ninformacyjna ))")
	setElementInterior(v.t3d,v[6])
	setElementDimension(v.t3d,v[5])

end

local aktualna_tablica=nil

local function znajdzTablice(el)
	for i,v in ipairs(tablice) do
		if v.cs==el then return i end
	end
	return nil
end

addEventHandler("onClientColShapeHit", resourceRoot, function(el,md)
--	outputChatBox("dupa")
	if (not md) then return end
	if (el~=localPlayer) then return end

	aktualna_tablica=znajdzTablice(source)
	if (not aktualna_tablica) then return end

	guiSetVisible(ib_win,true)
	guiSetInputMode("no_binds_when_editing")
	tablice[aktualna_tablica].changed=nil
	triggerServerEvent("onPlayerRequestIBContents", localPlayer, tablice[aktualna_tablica].tablica)
end)
addEventHandler("onClientColShapeLeave", resourceRoot, function(el,md)
	if (el~=localPlayer) then return end
	guiSetVisible(ib_win,false)
	-- sprawdzamy czy tablica sie zmienila
	if (not aktualna_tablica) then return end
	local fid=getElementData(localPlayer,"faction:id")
	if (not fid or tonumber(fid)~=tonumber(tablice[aktualna_tablica].restrict_faction)) then
		aktualna_tablica=nil
		return
	end

	if (aktualna_tablica and tablice[aktualna_tablica].changed) then
		triggerServerEvent("onPlayerUpdateIBContents", localPlayer, tablice[aktualna_tablica].tablica, guiGetText(ib_memo))
		if (tablice[aktualna_tablica].onUpdate) then
		    setTimer(tablice[aktualna_tablica].onUpdate, 5000, 1)
		end
	end
	aktualna_tablica=nil
end)

addEventHandler("onClientGUIChanged", ib_memo, function()

	if (aktualna_tablica) then
		tablice[aktualna_tablica].changed=true
	end
end)

addEvent("onIBContentsRcvd", true)
addEventHandler("onIBContentsRcvd", root, function(dane)
	if (not aktualna_tablica) then return end
	if (dane) then
		guiSetText(ib_win, dane.nazwa)
		guiSetText(ib_memo, dane.tresc)
		tablice[aktualna_tablica].changed=nil
		tablice[aktualna_tablica].restrict_faction=tonumber(dane.restrict_faction)
		local fid=getElementData(localPlayer,"faction:id")
		if (not fid or tonumber(fid)~=tonumber(dane.restrict_faction)) then
			guiMemoSetReadOnly(ib_memo,true)
		else
			guiMemoSetReadOnly(ib_memo,false)
		end
	else
		
		guiSetText(ib_win, "Tablica")
		guiSetText(ib_memo, "")
	end
end)