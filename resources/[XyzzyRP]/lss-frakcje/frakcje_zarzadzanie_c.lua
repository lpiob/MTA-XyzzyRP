--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--

local aktualny_punkt=nil
local punkty={
    -- x,y,z,interior,dimension, nazwa="Warsztat", fid=
	
--	archiwum w UM
    { 1453.73,-1783.62,1348.01,1,1, fid=2, minrank=6, nazwa="Policja" },
    { 1454.76,-1783.62,1348.01,1,1,fid=6, minrank=7, nazwa="Pogotowie" },
	{ 1459.56,-1786.13,1348.01,1,1,fid=11, minrank=7, nazwa="Straż Pożarna"},
	{ 1453.94,-1785.08,1348.01,1,1,nazwa="Służby Specjalne", fid=22,minrank=4 },
	{ 1467.90,-1783.65,1348.01,1,1, nazwa="Urząd Miasta", fid=1, minrank=3 },
    { 1466.81,-1783.73,1348.01,1,1, fid=4, minrank=4,nazwa="Służby Miejskie" },	
	{ 1466.80,-1786.15,1348.01,1,1,fid=5, minrank=5, nazwa="CNN News" },
    { 1455.79,-1783.62,1348.01,1,1,nazwa="Sad", fid=17, minrank=5 },
	{ 1456.90,-1783.62,1348.01,1,1,nazwa="Służba więzienna", fid=20, minrank=3 },
	{ 1458.18,-1783.61,1348.01,1,1,nazwa="Służby kościelne", fid=21,minrank=6 },
	{ 1465.27,-1783.71,1348.01,1,1,nazwa="Departament Turystyki", fid=35,minrank=6},


	

    { 1469.32,-1700.54,1131.83,1,1, fid=4, minrank=4,nazwa="Służby Miejskie" },		-- sluzby miejskie
    { 1924.39,-1786.66,1418.86,1,6, fid=3, minrank=3, nazwa="Warsztat I" },
    { 1566.48,-1650.58,1463.87,1,5, fid=2, minrank=6, nazwa="Policja" },
    { 1020.71,-1299.63,1234.87,1,27,fid=8, minrank=3, nazwa="Ośrodek Szkolenia Kierowców I" },
    { 2025.62,-1396.22,1279.87,1,8,fid=6, minrank=7, nazwa="Pogotowie" },
--    { 1144.28,-1813.55,1439.49,1,13,fid=7,minrank=7, nazwa="Taksówkarz" },
	{ 451.09,-1295.84,1195.32,1,7,fid=5, minrank=5, nazwa="CNN News" },
    { 708.37,-1399.46,1758.03,1,48,fid=9, minrank=4, nazwa="Kurier" },
	{ 925.44,-1290.30,1439.93,1,26,fid=11, minrank=7, nazwa="Straż Pożarna"},
    { 680.93,-117.53,24.43,0,0,nazwa="Warsztat II", fid=12, minrank=3 },
    { 2284.97,-110.35,2025.51,2,7,nazwa="Warsztat III", fid=13, minrank=5 },
    { 1077.05,-370.36,1494.02,1,20,nazwa="Kopalnia", fid=14, minrank=3 },
    { 2141.63,-1785.82,1421.51,1,31,nazwa="Ochrona", fid=15, minrank=5 },
    { 1044.07,-938.81,1470.86,1,32,nazwa="Ośrodek Szkolenia Kierowców II", fid=16, minrank=3 },
    { 1306.58,-928.28,1440.78,1,21,nazwa="Sad", fid=17, minrank=6 },
    { 1208.54,246.03,2082.51,2,8,nazwa="Warsztat IV", fid=18, minrank=4 },
    { 102.61,-147.05,2040.15,2,9,nazwa="Warsztat V", fid=19, minrank=6 },
    { 2437.92,-2680.06,2034.17,2,3,nazwa="Importer", fid=10, minrank=1 },	
	{ -2068.05,572.67,1172.05,2,3140,nazwa="Służba więzienna", fid=20, minrank=3 },
	{ 917.70,2366.39,245.46,1,3140,nazwa="Służby kościelne", fid=21,minrank=6 },
	{ 1224.73,-1436.51,2196.98,1,40,nazwa="Służby Specjalne", fid=22,minrank=4 },
	{ 2263.21,125.29,2081.83,2,39,nazwa="Przychodnia lekarska", fid=23,minrank=3 },
	{ -464.40,-35.73,2086.47,2,49,nazwa="Tartak", fid=24,minrank=4},
	{ 1500.69,-2215.06,2191.83,2,45,nazwa="Ośrodek Szkolenia Pilotów", fid=25,minrank=3},
	{ 2821.75,-1112.91,1592.71,1,51,nazwa="Departament Turystyki", fid=35,minrank=6},
	{ 2816.86,-1112.90,1592.71,1,51,nazwa="Klub Miasta Los Santos", fid=40,minrank=2},

	
--restauracje, knajpy, sklepy
	{ 1367.95,-1758.98,2034.63,2,12,nazwa="Usługi gastonomiczne - Sklep 'na rogu'", fid=26,minrank=3},
	{ 1368.17,-1758.98,2034.63,2,13,nazwa="Usługi gastonomiczne - Sklep Spożywczy 'Strug'", fid=27,minrank=3},
	{ 364.15,-2047.95,2006.56,2,14,nazwa="Usługi gastonomiczne - Knajpka 'na molo'", fid=28,minrank=3},
	{ 2103.99,-1789.57,2000.50,2,1,nazwa="Usługi gastonomiczne - Restauracja 'The Well Stacked Pizza'", fid=29,minrank=3},
	{ 2389.15,-1901.60,1999.64,2,5,nazwa="Usługi gastonomiczne - Restauracja 'Hot-Food'", fid=30,minrank=3},
	{ 2265.17,91.99,2180.54,2,19,nazwa="Usługi gastonomiczne - Market 'Prima'", fid=31,minrank=3},
	{ 237.13,-162.01,2180.54,2,20,nazwa="Usługi gastonomiczne - Market 'Super Sam'", fid=32,minrank=3},
	{ 681.25,-1876.61,1998.73,2,35,nazwa="Usługi gastonomiczne - Kawiarnia 'pod sceną'", fid=33,minrank=3},
	{ 1365.64,239.18,2066.36,2,41,nazwa="Usługi gastonomiczne - Knajpa 'Paszcza Wieloryba'", fid=34,minrank=3},
	{ 502.68,-1490.82,2066.36,2,53,nazwa="Usługi gastonomiczne - Knajpa 'Isaura'", fid=36,minrank=3},
	{ 1819.18,-1056.61,2180.54,2,52,nazwa="Usługi gastonomiczne - Market 'Łubin'", fid=37,minrank=3},
	{ 1566.05,-1877.96,2006.56,2,63,nazwa="Usługi gastonomiczne - Restauracja 'Przy skarpie'", fid=38,minrank=3},
	{ 1648.66,-1662.83,2566.36,2,68,nazwa="Usługi gastonomiczne - Knajpa 'Diabelski młyn'", fid=39,minrank=3},
	
}

local edytowana_postac=nil


local w_m={}
w_m.wnd = guiCreateWindow(0.1469,0.1667,0.7344,0.675,"",true)
w_m.btn_zatrudnij = guiCreateButton(0.0277,0.8395,0.3064,0.1327,"Zatrudnij",true,w_m.wnd)

w_m.btn_zwolnij = guiCreateButton(0.3427,0.8395,0.3064,0.1327,"Wyrzuć",true,w_m.wnd)
w_m.btn_edytuj = guiCreateButton(0.6577,0.8395,0.3064,0.1327,"Edytuj",true,w_m.wnd)

w_m.grid_pracownicy = guiCreateGridList(0.0298,0.0895,0.9383,0.7191,true,w_m.wnd)
guiGridListSetSelectionMode(w_m.grid_pracownicy,1)
w_m.grid_pracownicy_c_nazwisko = guiGridListAddColumn ( w_m.grid_pracownicy, "Imię, nazwisko", 0.3 )
w_m.grid_pracownicy_c_stanowisko = guiGridListAddColumn ( w_m.grid_pracownicy, "Stanowisko", 0.18 )
w_m.grid_pracownicy_c_widziany = guiGridListAddColumn ( w_m.grid_pracownicy, "Widziany", 0.28 )
w_m.grid_pracownicy_c_skin = guiGridListAddColumn ( w_m.grid_pracownicy, "Skin", 0.15 )
w_m.grid_pracownicy_c_drzwi = guiGridListAddColumn ( w_m.grid_pracownicy, "Drzwi", 0.15 )
guiSetVisible(w_m.wnd,false)

w_m.init=function()
    if not aktualny_punkt then return end
    triggerServerEvent("onPlayerRequestFactionData", localPlayer, aktualny_punkt.fid)
    guiSetText(w_m.wnd, aktualny_punkt.nazwa)
    local lfid=getElementData(localPlayer, "faction:id")
    local lfrank=getElementData(localPlayer, "faction:rank_id")
    if (lfid and lfrank and tonumber(lfid)==aktualny_punkt.fid and tonumber(lfrank)>=aktualny_punkt.minrank) then
    	guiSetEnabled(w_m.btn_zatrudnij,true)
    else
	guiSetEnabled(w_m.btn_zatrudnij,false)
    end
    guiSetEnabled(w_m.btn_zwolnij,false)

    guiSetEnabled(w_m.btn_edytuj, false)
    guiSetVisible(w_e.win, false)
    
    edytowana_postac=nil

end


w_m.fill=function(dane)
--[[
+----------+----------+------------+---------------------+
| imie     | nazwisko | ranga      | lastduty            |	character_id,	rank_id
+----------+----------+------------+---------------------+
| Shawn    | Hanks    | kierownik  |                NULL |
| Dozer    | Baltaar  | dyrektor   |                NULL |
| Jonathan | Callahan | praktykant | 2012-04-04 07:28:54 |
+----------+----------+------------+---------------------+
]]--
    guiGridListClear(w_m.grid_pracownicy)
    if (not dane) then return end
    for i,v in ipairs(dane) do
        local row = guiGridListAddRow ( w_m.grid_pracownicy )
	guiGridListSetItemText ( w_m.grid_pracownicy, row, w_m.grid_pracownicy_c_nazwisko, v.imie .. " " .. v.nazwisko, false, false )
	guiGridListSetItemData ( w_m.grid_pracownicy, row, w_m.grid_pracownicy_c_nazwisko, tonumber(v.character_id) )
	guiGridListSetItemText ( w_m.grid_pracownicy, row, w_m.grid_pracownicy_c_stanowisko, v.ranga, false, false )
	guiGridListSetItemData ( w_m.grid_pracownicy, row, w_m.grid_pracownicy_c_stanowisko, tonumber(v.rank_id ))
	guiGridListSetItemText ( w_m.grid_pracownicy, row, w_m.grid_pracownicy_c_widziany, v.lastduty or "-", false, false )
	guiGridListSetItemText ( w_m.grid_pracownicy, row, w_m.grid_pracownicy_c_skin, v.skin or "-", false, false )
	local drzwi = tostring(v.door)
	local drzwi = string.gsub(drzwi, "0", "nie")
	local drzwi = string.gsub(drzwi, "1", "tak")
	guiGridListSetItemText ( w_m.grid_pracownicy, row, w_m.grid_pracownicy_c_drzwi, drzwi, false, false )
    end

end


w_m.gridclick=function()
    if (not guiGetEnabled(w_m.btn_zatrudnij)) then return end
    selectedRow= guiGridListGetSelectedItem ( w_m.grid_pracownicy)
    if (selectedRow<0) then
	guiSetEnabled(w_m.btn_zwolnij,false)
	guiSetEnabled(w_m.btn_edytuj,false)
    else
	local lfrank=getElementData(localPlayer, "faction:rank_id")
	local sfrank=guiGridListGetItemData( w_m.grid_pracownicy, selectedRow, w_m.grid_pracownicy_c_stanowisko)
	if (lfrank and sfrank and tonumber(lfrank)>=tonumber(sfrank) and tonumber(lfrank)>=3) then
		guiSetEnabled(w_m.btn_zwolnij,true)
		guiSetEnabled(w_m.btn_edytuj,true)
	else
		guiSetEnabled(w_m.btn_zwolnij,false)
		guiSetEnabled(w_m.btn_edytuj,false)
	end
    end
end
w_m.zwolnij=function()
    selectedRow= guiGridListGetSelectedItem ( w_m.grid_pracownicy)
    local pid=guiGridListGetItemData( w_m.grid_pracownicy, selectedRow, w_m.grid_pracownicy_c_nazwisko)
    triggerServerEvent("onZwolnienieRequest", localPlayer, aktualny_punkt.fid, pid)
end

------------------ zatrudnianie ----------------------------------------

w_z={}
w_z.win = guiCreateWindow(0.3609,0.3229,0.3109,0.4542,"Zatrudnianie",true)
w_z.lbl_imie = guiCreateLabel(0.0704,0.1284,0.8442,0.0826,"Imię:",true,w_z.win)
w_z.edit_imie = guiCreateEdit(0.0704,0.2385,0.8442,0.1239,"",true,w_z.win)
w_z.lbl_nazwisko = guiCreateLabel(0.0704,0.4083,0.8442,0.0826,"Nazwisko:",true,w_z.win)
w_z.edit_nazwisko = guiCreateEdit(0.0704,0.5367,0.8442,0.1239,"",true,w_z.win)
w_z.lbl_blad = guiCreateLabel(0.0704,0.7064,0.8442,0.0826,"",true,w_z.win)
guiLabelSetHorizontalAlign(w_z.lbl_blad,"center",false)
w_z.btn_zatrudnij = guiCreateButton(0.0704,0.8073,0.4042,0.1514,"Zatrudnij",true,w_z.win)
w_z.btn_anuluj = guiCreateButton(0.5004,0.8073,0.4042,0.1514,"Anuluj",true,w_z.win)

guiSetVisible(w_z.win,false)

w_z.pokaz=function()
    guiSetInputMode("no_binds_when_editing")
    guiSetVisible(w_z.win,true)
    guiSetText(w_z.lbl_blad,"")
    guiSetText(w_z.edit_imie,"")
    guiSetText(w_z.edit_nazwisko,"")
    guiBringToFront(w_z.win)
end

w_z.schowaj=function()
    guiSetVisible(w_z.win,false)
end

w_z.zatrudnij=function()
    local imie=guiGetText(w_z.edit_imie)
    local nazwisko=guiGetText(w_z.edit_nazwisko)
    triggerServerEvent("onZatrudnienieRequest", localPlayer, aktualny_punkt.fid, imie, nazwisko)
end

w_z.zatrudnienie_reply=function(wynik,komunikat)
    if (not wynik) then
	guiSetText(w_z.lbl_blad, komunikat)
	return
    else
	w_z.schowaj()
	w_m.init()
    end
end

--------------- edycha ------------------------

w_e={}
w_e.win = guiCreateWindow(0.3609,0.3229,0.3109,0.4542,"Edycja",true)
w_e.lbl_imie = guiCreateLabel(0.0704,0.1284,0.8442,0.0826,"",true,w_e.win)
w_e.lbl_ranga = guiCreateLabel(0.0704,0.2183,0.8442,0.0826,"Ranga:",true,w_e.win)
w_e.cmb_ranga = guiCreateComboBox(0.0704,0.3367,0.8442,0.4239,"Ranga:",true,w_e.win)
w_e.lbl_skin = guiCreateLabel(0.0704,0.4564,0.8442,0.0826,"Skin:",true,w_e.win)
w_e.cmb_skin = guiCreateComboBox(0.0704,0.5367,0.8442,0.4239,"Skin:",true,w_e.win)
w_e.btn_zapisz = guiCreateButton(0.0704,0.8073,0.4042,0.1514,"Zapisz",true,w_e.win)
w_e.btn_anuluj = guiCreateButton(0.5004,0.8073,0.4042,0.1514,"Anuluj",true,w_e.win)

guiSetVisible(w_e.win,false)

w_e.pokaz=function()
    local lfid=getElementData(localPlayer, "faction:id")
    if (not lfid) then return end

    selectedRow= guiGridListGetSelectedItem ( w_m.grid_pracownicy)
    local pid=guiGridListGetItemData( w_m.grid_pracownicy, selectedRow, w_m.grid_pracownicy_c_nazwisko)

    guiSetInputMode("no_binds_when_editing")
    guiSetVisible(w_e.win,true)
    guiBringToFront(w_e.win)
    guiComboBoxClear(w_e.cmb_ranga)
    guiComboBoxClear(w_e.cmb_skin)
    guiComboBoxAddItem( w_e.cmb_skin, "domyślny postaci")
    triggerServerEvent("onFactionCharacterDetailsRequest", localPlayer, lfid, pid)
end

w_e.schowaj=function()
    guiSetVisible(w_e.win,false)
end


w_e.edycja_reply=function(dane)
    if (not dane or not dane.postac or not dane.postac.id) then
	w_e.schowaj()
    end
    
    edytowana_postac=dane.postac.id
    guiSetText(w_e.lbl_imie, dane.postac.imie .. " " .. dane.postac.nazwisko)
    guiComboBoxClear(w_e.cmb_ranga)
    guiComboBoxClear(w_e.cmb_skin)
--    guiSetProperty(w_e.cmb_ranga, "ReadOnly", "false")
    for i,v in ipairs(dane.rangi) do
        local i2=guiComboBoxAddItem( w_e.cmb_ranga, tostring(v.rank_id)..". "..v.name)
	if (v.rank_id==dane.postac.rank) then
	    guiComboBoxSetSelected(w_e.cmb_ranga, i2)
--	    if (i==#dane.rangi) then	-- gracz ma najwyższą rangę -- blokujemy edycję
--		guiSetProperty(w_e.cmb_ranga, "ReadOnly", "True")	-- nie dziala
--	    end
--	    outputDebugString(guiGetProperty(w_e.cmb_ranga,"ReadOnly"))
	end

    end
    local i2=guiComboBoxAddItem( w_e.cmb_skin, "domyślny postaci")
    guiComboBoxSetSelected(w_e.cmb_skin, i2)
    if (dane.skiny and #dane.skiny>0) then
        for i,v in ipairs(dane.skiny) do
            local i3=guiComboBoxAddItem( w_e.cmb_skin, tostring(v.skin))
	    if (v.skin==dane.postac.skin) then
		guiComboBoxSetSelected(w_e.cmb_skin, i3)
	    end
        end
    end
end

w_e.zapisz=function()
    if (not edytowana_postac) then return end
    local lfid=getElementData(localPlayer, "faction:id")
    local ranga=guiComboBoxGetItemText(w_e.cmb_ranga, guiComboBoxGetSelected(w_e.cmb_ranga))
    ranga=tonumber(string.sub(ranga,1,1))
    local skin=tonumber(guiComboBoxGetItemText(w_e.cmb_skin, guiComboBoxGetSelected(w_e.cmb_skin)))
    triggerServerEvent("onFactionEdycjaPostaci", localPlayer, edytowana_postac, ranga, skin, lfid)
end



-- bindy
addEvent("doFillFactionData", true)
addEventHandler("doFillFactionData", resourceRoot, w_m.fill)
addEventHandler("onClientGUIClick", w_m.btn_zatrudnij, w_z.pokaz, false)
addEventHandler("onClientGUIClick", w_m.btn_zwolnij, w_m.zwolnij, false)
addEventHandler("onClientGUIClick", w_z.btn_zatrudnij, w_z.zatrudnij, false)
addEventHandler("onClientGUIClick", w_z.btn_anuluj, w_z.schowaj, false)
addEventHandler("onClientGUIClick", w_m.grid_pracownicy, w_m.gridclick, false)
addEventHandler("onClientGUIClick", w_m.btn_edytuj, w_e.pokaz, false)
addEventHandler("onClientGUIClick", w_e.btn_anuluj, w_e.schowaj, false)
addEventHandler("onClientGUIClick", w_e.btn_zapisz, w_e.zapisz, false)

addEvent("onZatrudnienieReply", true)
addEventHandler("onZatrudnienieReply", resourceRoot, w_z.zatrudnienie_reply)
addEvent("onZwolnienieComplete", true)
addEventHandler("onZwolnienieComplete", resourceRoot, w_m.init)

addEvent("doFillFactionCharacterData", true)
addEventHandler("doFillFactionCharacterData", resourceRoot, w_e.edycja_reply)
addEvent("onFactionEdycjaComplete", true)
addEventHandler("onFactionEdycjaComplete", resourceRoot, w_m.init)

--- kod ---


local function findPunkt(el)
    for i,v in ipairs(punkty) do
	if (v.marker==el) then return v end
    end
    return nil
end

for i,v in ipairs(punkty) do
    v.marker=createMarker(v[1],v[2],v[3], "cylinder", 1, 255,255,0,50)
    setElementDimension(v.marker,v[5])
    setElementInterior(v.marker,v[4])
    
    addEventHandler("onClientMarkerHit", v.marker, function(el,md)
	if (el~=localPlayer) then return end
	if (not md) then return end
	local _,_,z1=getElementPosition(el)
	local _,_,z2=getElementPosition(source)
	if (math.abs(z1-z2)>3)  then return end
	aktualny_punkt=findPunkt(source)
	if (not aktualny_punkt) then return end
	guiSetVisible(w_m.wnd,true)
	guiSetVisible(w_e.win,false)
	w_m.init()
    end)
    addEventHandler("onClientMarkerLeave", v.marker, function(el,md)
	if (el~=localPlayer) then return end
	aktualny_punkt=nil
	guiSetVisible(w_m.wnd,false)
	guiSetVisible(w_e.win,false)
	guiSetVisible(w_z.win,false)
	guiGridListClear(w_m.grid_pracownicy)
    end)
    
end

