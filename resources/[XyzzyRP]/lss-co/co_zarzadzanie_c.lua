--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--

local function getCO()
  local c=getElementData(localPlayer,"character")
  if (not c) then return nil end
  return c.co_id, c.co_name, c.co_rank, c.co_rank_name
end
local edytowana_postac=nil
local w_m={}
w_m.wnd = guiCreateWindow(0.1469,0.1667,0.7344,0.675,"",true)
w_m.btn_zatrudnij = guiCreateButton(0.0277,0.8395,0.3064,0.1327,"Przyjmij",true,w_m.wnd)
w_m.btn_zwolnij = guiCreateButton(0.3427,0.8395,0.3064,0.1327,"Wyrzuć",true,w_m.wnd)
w_m.btn_edytuj = guiCreateButton(0.6577,0.8395,0.3064,0.1327,"Edytuj",true,w_m.wnd)
w_m.grid_pracownicy = guiCreateGridList(0.0298,0.0895,0.9383,0.7191,true,w_m.wnd)
guiGridListSetSelectionMode(w_m.grid_pracownicy,1)
w_m.grid_pracownicy_c_nazwisko = guiGridListAddColumn ( w_m.grid_pracownicy, "Imię, nazwisko", 0.3 )
w_m.grid_pracownicy_c_stanowisko = guiGridListAddColumn ( w_m.grid_pracownicy, "Ranga", 0.18 )
w_m.grid_pracownicy_c_widziany = guiGridListAddColumn ( w_m.grid_pracownicy, "Widziany", 0.28 )
w_m.grid_pracownicy_c_skin = guiGridListAddColumn ( w_m.grid_pracownicy, "Skin", 0.2 )
guiSetVisible(w_m.wnd,false)

w_m.init=function()

    local coid,coname,corank=getCO()
    if (not coid) then return end

    triggerServerEvent("onPlayerRequestCoData", localPlayer, coid)
    guiSetText(w_m.wnd, coname)

    if (tonumber(corank)>1) then
    	guiSetEnabled(w_m.btn_zatrudnij,true)
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
	guiGridListSetItemText ( w_m.grid_pracownicy, row, w_m.grid_pracownicy_c_skin, v.skin or "-",false, false )
    end

end


w_m.gridclick=function()
    local coid,coname,corank=getCO()
	if (not coid) then return end

    if (not guiGetEnabled(w_m.btn_zatrudnij)) then return end
    selectedRow= guiGridListGetSelectedItem ( w_m.grid_pracownicy)
    if (selectedRow<0) then
	guiSetEnabled(w_m.btn_zwolnij,false)
	guiSetEnabled(w_m.btn_edytuj,false)
    else
	local sfrank=guiGridListGetItemData( w_m.grid_pracownicy, selectedRow, w_m.grid_pracownicy_c_stanowisko)
	if (tonumber(corank)>sfrank and tonumber(corank)>=4) then
		guiSetEnabled(w_m.btn_zwolnij,true)	
	else
		guiSetEnabled(w_m.btn_zwolnij,false)
	end
	if (tonumber(corank)>=4) then
		guiSetEnabled(w_m.btn_edytuj,true)
	else
		guiSetEnabled(w_m.btn_edytuj,false)
	end
    end
end
w_m.zwolnij=function()
	local coid=getCO()
	if (not coid) then return end

    selectedRow= guiGridListGetSelectedItem ( w_m.grid_pracownicy)
    local pid=guiGridListGetItemData( w_m.grid_pracownicy, selectedRow, w_m.grid_pracownicy_c_nazwisko)

    triggerServerEvent("onCoZwolnienieRequest", localPlayer, coid, pid)
end

------------------ zatrudnianie ----------------------------------------

w_z={}
w_z.win = guiCreateWindow(0.3609,0.3229,0.3109,0.4542,"Przyjmowanie",true)
w_z.lbl_imie = guiCreateLabel(0.0704,0.1284,0.8442,0.0826,"Imię:",true,w_z.win)
w_z.edit_imie = guiCreateEdit(0.0704,0.2385,0.8442,0.1239,"",true,w_z.win)
w_z.lbl_nazwisko = guiCreateLabel(0.0704,0.4083,0.8442,0.0826,"Nazwisko:",true,w_z.win)
w_z.edit_nazwisko = guiCreateEdit(0.0704,0.5367,0.8442,0.1239,"",true,w_z.win)
w_z.lbl_blad = guiCreateLabel(0.0704,0.7064,0.8442,0.0826,"",true,w_z.win)
guiLabelSetHorizontalAlign(w_z.lbl_blad,"center",false)
w_z.btn_zatrudnij = guiCreateButton(0.0704,0.8073,0.4042,0.1514,"Przyjmij",true,w_z.win)
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
	local coid=getCO()
	if (not coid) then return end

    local imie=guiGetText(w_z.edit_imie)
    local nazwisko=guiGetText(w_z.edit_nazwisko)
    triggerServerEvent("onCoPrzyjecieRequest", localPlayer, coid, imie, nazwisko)
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

------------- edycja --------------------------------
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
    local coid=getCO()
    if (not coid) then return end

    selectedRow= guiGridListGetSelectedItem ( w_m.grid_pracownicy)
    local pid=guiGridListGetItemData( w_m.grid_pracownicy, selectedRow, w_m.grid_pracownicy_c_nazwisko)

    guiSetInputMode("no_binds_when_editing")
    guiSetVisible(w_e.win,true)
    guiBringToFront(w_e.win)
    guiComboBoxClear(w_e.cmb_ranga)
    guiComboBoxClear(w_e.cmb_skin)
    guiComboBoxAddItem( w_e.cmb_skin, "domyślny postaci")
    triggerServerEvent("onCoCharacterDetailsRequest", localPlayer, coid, pid)
--[[
    guiComboBoxAddItem( w_e.cmb_ranga, "1aaa")
    guiComboBoxAddItem( w_e.cmb_ranga, "2bbb")
    guiComboBoxAddItem( w_e.cmb_ranga, "3ccc")
]]--
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
    local ranga=guiComboBoxGetItemText(w_e.cmb_ranga, guiComboBoxGetSelected(w_e.cmb_ranga))
    ranga=tonumber(string.sub(ranga,1,1))
    local skin=tonumber(guiComboBoxGetItemText(w_e.cmb_skin, guiComboBoxGetSelected(w_e.cmb_skin)))
    triggerServerEvent("onCoEdycjaPostaci", localPlayer, edytowana_postac, ranga, skin)
end


-- bindy
addEvent("doFillCoData", true)
addEventHandler("doFillCoData", resourceRoot, w_m.fill)
addEventHandler("onClientGUIClick", w_m.btn_zatrudnij, w_z.pokaz, false)
addEventHandler("onClientGUIClick", w_m.btn_zwolnij, w_m.zwolnij, false)
addEventHandler("onClientGUIClick", w_m.btn_edytuj, w_e.pokaz, false)
addEventHandler("onClientGUIClick", w_z.btn_zatrudnij, w_z.zatrudnij, false)
addEventHandler("onClientGUIClick", w_z.btn_anuluj, w_z.schowaj, false)
addEventHandler("onClientGUIClick", w_e.btn_anuluj, w_e.schowaj, false)
addEventHandler("onClientGUIClick", w_e.btn_zapisz, w_e.zapisz, false)
addEventHandler("onClientGUIClick", w_m.grid_pracownicy, w_m.gridclick, false)
addEvent("onCoEdycjaComplete", true)
addEventHandler("onCoEdycjaComplete", resourceRoot, w_m.init)
addEvent("onCoZatrudnienieReply", true)
addEventHandler("onCoZatrudnienieReply", resourceRoot, w_z.zatrudnienie_reply)
addEvent("onCoZwolnienieComplete", true)
addEventHandler("onCoZwolnienieComplete", resourceRoot, w_m.init)
addEvent("doFillCoCharacterData", true)
addEventHandler("doFillCoCharacterData", resourceRoot, w_e.edycja_reply)
--- kod ---

bindKey("f5","down",function()
	local coid,coname,corank=getCO()
	if (not coid) then 
	  guiSetVisible(w_m.wnd,false)
	  guiSetVisible(w_z.win,false)
	  guiSetVisible(w_e.win,false)
	  return 
	end

  guiSetVisible(w_m.wnd,not guiGetVisible(w_m.wnd))
  if (not guiGetVisible(w_m.wnd)) then
	  guiSetVisible(w_z.win,false)
	  guiSetVisible(w_e.win,false)
  end
  w_m.init()
end)

--[[
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
	w_m.init()
    end)
    addEventHandler("onClientMarkerLeave", v.marker, function(el,md)
	if (el~=localPlayer) then return end
	aktualny_punkt=nil
	guiSetVisible(w_m.wnd,false)
	guiGridListClear(w_m.grid_pracownicy)
    end)
    
end

]]--