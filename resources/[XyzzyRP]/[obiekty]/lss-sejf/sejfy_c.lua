

local w_szyfr={}
w_szyfr.win=guiCreateWindow(0.7, 0.4, 0.2, 0.2, "Sejf", true)
w_szyfr.edt=guiCreateEdit(0.1, 0.25, 0.8, 0.3, "", true, w_szyfr.win)
guiEditSetMasked(w_szyfr.edt,true)
guiEditSetMaxLength(w_szyfr.edt,9)
w_szyfr.btn=guiCreateButton(0.1, 0.6, 0.8, 0.3, "Otwórz", true, w_szyfr.win)

guiSetVisible(w_szyfr.win, false)

local sejfy={
	-- x,y,z,a,d,i
    { 2131.48,-1161.15,1439.67,0, 25,1, pojemnik=92 },	-- komis samochodowy 'titanic'
	{ 1567.59,-1647.33,1465.28,90, 5,1, pojemnik=101},	-- komisariat policji
	{ 1565.46,-1684.56,1493.72,90, 5,1, pojemnik=1006},	-- komisariat policji (hsiu)
	{ 1579.47,-1682.59,1492.42,270, 5,1, pojemnik=3116},	-- komisariat policji (mpu)
	{ 710.19,-1400.56,1759.6,0, 48,1, pojemnik=106},	-- firma kurierska
	{ 2026.76,-1393.0,1280.87,180, 8,1, pojemnik=124},	-- szpital
	{ 924.45,-1287.99,1440.42,270, 26,1, pojemnik=133},	-- straz pozarna
	{ 446.43,-1296.99,1196.82,0, 7,1, pojemnik=160},	-- CNN News
	{ 1017.59,-1299.80,1235.87,270, 27,1, pojemnik=194},	-- nauka jazdy
	{ 1147.39,-1817.27,1440.99,90, 13,1, pojemnik=197},-- taxi
	{ 1481.59,-1775.33,1252.47,180, 1,1, pojemnik=241}, -- biuro w wydziale os. finansów (UM)
	{ 1471.16,-1783.19,1285.600,180, 1,1, pojemnik=1533}, -- biuro burmistrza (UM)
	{ 680.34,-115.53,25.43,270, 0,0, pojemnik=248},	-- sejf w warsztacie II
	{ 797.27,-512.44,1206.28,270, 10,1, pojemnik=274},	-- sluzby miejskie
	{ 1473.48,-1699.45,1132.33,180, 1,1, pojemnik=274},	-- sluzby miejskie - w urzedzie miasta
	{ 1130.94,-1391.20,1438.55,90, 29,1, pojemnik=275},	-- biznes: klub 'cafe'
	{ -67.21,37.29,6.02,240, 0,0,pojemnik=311},	-- sejf w szopie kolo 0,0,0
	{ 1046.12,-940.76,1471.86,0, 32,1,pojemnik=369},	-- osrodek szkolenia kierowcow 2
	{ 1304.85,-931.53,1441.28,0, 21,1,pojemnik=415},	-- biuro prezesa (sad)
	{ 2139.41,-1786.39,1423.21,0, 31,1, pojemnik=478},		-- sejf w biurze ochrony cywilnej
	{ 2431.88,-2674.10,2035.67,180.0, 3,2, pojemnik=525},		-- Sejf w hurtowni i porcie (import)
	{ 2339.79,-1263.11,2041.95,90, 2,2, pojemnik=530},		-- komis samochodowy 'angelo'
	{ 2115.31,-1790.93,2000.99,90, 1,2, pojemnik=581},		-- biznes: Restauracja 'The Well Stacked Pizza'
	{ 1091.76,-69.82,53.15,201, 0,0, pojemnik=589},		-- mafie
	{ 2191.02,-2696.64,17.4,180, 0,0, pojemnik=634},	-- sejf w porcie - do przemytu broni
	{ 2288.56,-112.65,2026.82,90, 7,2, pojemnik=660},	-- sejf w warsztacie III
	{ 1209.75,251.73,2083.91,180, 8,2, pojemnik=696},	-- sejf w warsztacie IV
	{ 103.50,-150.32,2040.65,90, 9,2, pojemnik=701},	-- sejf w warsztacie V	
	{ 474.05,-10.69,1003.10,180, 1026,17, pojemnik=778},	-- klub 'silver club'
	{ 543.46,-1301.53,2034.67,90, 11,2, pojemnik=889},	-- komis samochodowy 'Smiling Central'
	{ 1367.53,-1755.74,2035.10,180, 12,2, pojemnik=893},	-- sklep 'na rogu'
	{ 2424.94,-1233.36,2000.52,90, 6,2, pojemnik=894},	-- klub 'pig pen'
	{ 1367.62,-1756.04,2035.10,180, 13,2, pojemnik=895},	-- spozywczy
	{ 2419.34,-1691.94,1409.28,0, 24,1, pojemnik=896},	-- silownia na gs
	{ 2393.83,-1913.62,2000.14,0, 5,2, pojemnik=897},	-- restauracja 'Hot-Food'
	{ 1696.35,-1754.19,2003.29,180, 10,2, pojemnik=898},	-- klub 'Silver Club'
	{ 2229.43,-1715.34,2000.20,270, 15,2, pojemnik=899},	-- Silownia w Ganton
	{ 2579.70,-1454.56,2053.66,180, 18,2 , pojemnik=1070}, -- sejf w bibliotece u greka interior 168
	{ 366.50,-2051.73,2007.06,0, 14,2 , pojemnik=1146}, -- sejf w knajpce 'na molo'
	{ 769.03,-1025.42,2000.20,270, 21,2 , pojemnik=1169}, -- sejf na silowni w dzielnicy Richman
	{ 1307.69,378.03,2200.26,0, 22,2 , pojemnik=1170}, -- sejf na silowni w Montgomery
	{ 1167.32,-1185.35,20.58,270,0, 0,0, pojemnik=525}, -- sejf w salonie samochodowym (w imporcie)
	{ 1483.11,-1775.38,1193.57,180, 1,1, pojemnik=1182}, -- sejf w um wydziale ds. gospodarki (UM)
	{ 2424.44,111.51,2285.72,270, 33,2, pojemnik=1251}, -- sejf w komisie samochodowym 'sunset beach'
	{ 312.34,-46.03,2022.69,270, 34,2, pojemnik=1252}, -- sejf w komisie samochodowym 'nemo'
	{ 683.56,-1868.98,2001.43,180, 35,2, pojemnik=1428}, -- sejf w kawiarni 'pod scena'
	{ 2655.52,-1775.92,1427.30,0, 24,1, pojemnik=1577}, -- sejf na stadionie
	{ 603.50,-24.50,1000.89,270, 1040,1, pojemnik=1740}, -- sejf w magazynie w blueberry
	{ 2250.44,77.35,2123.33,180, 36,2, pojemnik=1797}, -- sejf w biurze detektywistycznym
	{ 1046.77,-1437.77,13.80, 92, 3137,0, pojemnik=1820}, -- sejf w budynku numer 42 interior 176
	{ 846.20,-1093.70,2251.70,180, 37,2, pojemnik=1824}, -- sejf w domu pogrzebowym
	{ -2073.99,572.84,1173.06,270.0,3140,2, pojemnik=1870}, -- biuro wiezienia
	{ 890.10,2265.97,238.99,180,3140,2, pojemnik=1883}, -- pojemnik w budynku 44 itnerior 180
	{ -1027.65,835.64,2665.66,90,38,2, pojemnik=1946}, -- pojemnik w budynku 47 int 184 hala paintball
	{ 1921.64,-1787.16,1419.32,0,6,1, pojemnik=1950}, -- sejf w warsztacie I
	{ 2263.12,122.08,2082.33,0,39,2, pojemnik=1960}, -- sejf w przychodni lekarskiej
	{ 2747.23,-1462.18,2031.28,270,16,2, pojemnik=2121}, -- lodziarnia
	{ 235.72,-161.41,2181.84,180,20,2, pojemnik=2122}, -- sejf w markecie 'super sam'
	{ 2263.62,92.49,2181.84,180,19,2, pojemnik=2123}, -- sejf w markecie 'prima'
	{ 1222.17,-1435.85,2197.74,180,40,1, pojemnik=2179}, -- sejf w sluzbach specjalnych (biuro szefa)
	{ 1234.47,-1450.20,2295.10,0,40,1, pojemnik=3142}, -- sejf w sluzbach specjalnych (pokoj przesluchan)
	{ 1364.42,238.18,2067.86,0,41,2, pojemnik=2265}, -- sejf w kawiarni 'paszcza wieloryba'
	{ 908.42,2458.23,1055.10,225,12,1, pojemnik=2294}, -- sejf w klubie 'fantasia'
	{ 2340.64,-1505.13,1481.53,270,34,1, pojemnik=2295}, -- sejf w ruderze rozrywki
	{ -462.62,-32.57,2086.98,180,49,2,pojemnik=2463},	-- sejf w tartaku
	{ 1498.01,-2216.29,2192.43,270,45,2,pojemnik=2526},	-- sejf w osrodku szkolenia pilotow
	{ 2091.74,-1207.66,1701.87,270,50,2,pojemnik=3195},	-- sejf w salonie tatuazu
	{ 2823.45,-1122.16,1594.41,0,51,1,pojemnik=3201},	-- sejf w departamencie turystyki
	{ 1821.45,-1054.41,2182.14,180,52,2,pojemnik=3223},	-- sejf w markecie 'łubin'
	{ 499.72,-1490.26,2067.86,270,53,2,pojemnik=3224},	-- sejf w knajpie 'Isaura'
	{ 1565.89,-1196.99,1626.30,270,56,2,pojemnik=3246},	-- sejf w hotelu 'burza'
	{ 599.89,-1457.23,1626.30,270,57,2,pojemnik=3247},	-- sejf w hotelu 'carrington'
	{ 1495.89,-1587.05,1626.30,270,58,2,pojemnik=3248},	-- sejf w hotelu 'forrester'
	{ 2275.89,73.07,1626.30,270,59,2,pojemnik=3249},	-- sejf w hotelu 'martwa cisza'
	{ 2475.71,-1540.74,2098.56,90,60,2,pojemnik=3272},	-- sejf w barze 'Purple-Pub'
	{ 489.34,-1545.59,2101.30,0,61,2,pojemnik=3273},	-- sejf w odziezowym the exclusive clothing
	{ 1952.71,-2041.95,2027.28,180,62,2,pojemnik=3274},	-- sejf w barze corona billard pub
	{ 1568.37,-1881.63,2007.06,0,63,2,pojemnik=3325},	-- sejf w Restauracji 'Przy skarpie'
	{ 468.20,-1126.72,2003.01,90,66,2,pojemnik=3407},	-- sejf w odziezowym 'anastacia'
	{ 1715.35,-1671.10,2000.71,90,67,2,pojemnik=3408},	-- sejf w odziezowym 'mustang jeans'
	{ 1645.82,-1662.06,2567.56,270,68,2,pojemnik=3409},	-- sejf w knajpie 'diabelski mlyn'
	{ 963.03,-1757.89,2203.41,0,69,2,pojemnik=3414},	-- sejf w klubie 'eden'

}
-- 2332
for i,v in ipairs(sejfy) do
  v.obiekt=createObject(2332, v[1], v[2], v[3], 0,0,v[4]+180)
  setElementDoubleSided(v.obiekt, true)
  setElementDimension(v.obiekt, v[5])
  setElementInterior(v.obiekt, v[6])
  
  local rrz=math.rad(v[4])
  local x2= v[1] + (0.7 * math.sin(-rrz))
  local y2= v[2] + (0.7 * math.cos(-rrz))

  v.marker=createMarker(x2,y2,v[3],"corona", 1, 255,0,0, 0)
  setElementDimension(v.marker, v[5])
  setElementInterior(v.marker,v[6])
  setElementData(v.marker, "index", i)
end


local aktualny_sejf=nil

addEventHandler("onClientMarkerHit", resourceRoot, function(el,md)
    if (not md) then return end
    if (el~=localPlayer) then return end
	local sejf=getElementData(source, "index")
	if (not sejf or not sejfy[sejf]) then return end
	aktualny_sejf=sejf
--	outputChatBox("in")
--    outputChatBox("(( skrytki bankowe w przygotowaniu ))")
--    if (getPlayerName(el)=="Shawn_Hanks" or getPlayerName(el)=="Peter_O'Connor" or getPlayerName(el)=="Dozer_Baltaar" or getPlayerName(el)=="Matthew_Trance") then
	guiSetText(w_szyfr.edt,"")
	guiSetVisible(w_szyfr.win, true)
--	exports["lss-pojemniki"]:otworzPojemnik(sejfy[sejf].pojemnik)
--    end
end)

addEventHandler("onClientGUIClick", w_szyfr.btn, function()
  if (not aktualny_sejf) then return end
  local szyfr=guiGetText(w_szyfr.edt)

  if (not szyfr or not tonumber(szyfr) or tonumber(szyfr)<=0) then return end
  triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wprowadza kod na klawiaturze sejfu.", 5, 15, true)
  guiSetVisible(w_szyfr.win, false)
  exports["lss-pojemniki"]:otworzPojemnik(sejfy[aktualny_sejf].pojemnik, szyfr)
end, false)

addEventHandler("onClientMarkerLeave", resourceRoot, function(el,md)
--    outputDebugString("a")
--    outputDebugString("b")
    if (el~=localPlayer) then return end
	guiSetVisible(w_szyfr.win, false)
    exports["lss-pojemniki"]:zamknijPojemnik(-1)
	aktualny_sejf=nil
end)
