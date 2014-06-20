--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


local licence=[[

==============================================================================
LSS-RP (c) Wielebny <wielebny@bestplay.pl> & karer <karer@gg.pl>
Wszelkie prawa zastrzezone. Nie masz praw uzywac tego kodu bez naszej zgody.

2013-

]]

local bw={}
bw.win = guiCreateWindow(0.6953,0.3375,0.2922,0.4875,"",true)
bw.btn_opcje = guiCreateButton(0.0481,0.7906,0.8984,0.1709,"Ustawienia",true,bw.win)
bw.btn_wejdz = guiCreateButton(0.0481,0.5769,0.8984,0.1709,"Wejdź",true,bw.win)
bw.memo = guiCreateMemo(0.0642,0.1282,0.8824,0.406,"(( biznesy w trakcie przygotowywania ))",true,bw.win)
guiMemoSetReadOnly(bw.memo,true)
guiSetVisible(bw.win,false)

local bo={}


local budynek=nil


local function wlascicielBudynku(b)
  local c=getElementData(localPlayer, "character")
  if (not c) then return false end
  if (not b.wlasciciele or type(b.wlasciciele)~="table") then return false end
  for i,v in ipairs(b.wlasciciele) do
	if (tonumber(v)==tonumber(c.id)) then return true end
  end
  return false
end

addEventHandler("onClientColShapeHit", resourceRoot, function(el,md)
    if (el==localPlayer and md and not getPedOccupiedVehicle(localPlayer)) then
--	if (getPlayerName(el)~="Elena_Ramirez") then return end
    local dane_budynku=getElementData(source,"budynek")
    if (dane_budynku) then
	    budynek=dane_budynku
	    if (budynek.entryCost and tonumber(budynek.entryCost)>0) then
		guiSetText(bw.btn_wejdz, "Wejdź (".. tonumber(budynek.entryCost) .."$)")
	    else
		guiSetText(bw.btn_wejdz, "Wejdź")
	    end
	    guiSetText(bw.win,budynek.descr)
	    guiSetText(bw.memo,budynek.descr2 or "")
		if (wlascicielBudynku(budynek)) then
		  guiSetVisible(bw.btn_opcje, true)
		else
		  guiSetVisible(bw.btn_opcje, false)
		end


	    guiSetVisible(bw.win,true)
    end
    --[[ przeniesione do zakupy_c.lua 
    local elpar=getElementParent(source)
    if (elpar and getElementType(elpar)=="ped") then
	outputChatBox("(( biznesy w trakcie przygotowywania ))")
    end
    ]]--
  end
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(el,md)
  if (el==localPlayer) then
    guiSetVisible(bw.win,false)
	budynek=nil
  end
end)

addEventHandler("onClientGUIClick", bw.btn_wejdz, function()
  if (not budynek) then return end
	if (wlascicielBudynku(budynek)) then
		triggerServerEvent("onPlayerRequestEntrance", resourceRoot, localPlayer, budynek)
		return
	end
  if (tonumber(budynek.zamkniety)>0) then
	outputChatBox("Zamknięte.")
	return
  end
  if (tonumber(budynek.entryCost)>0 and getPlayerMoney(localPlayer)<tonumber(budynek.entryCost)) then
    outputChatBox("Nie stać Cię na wejście.")
    return
  end
  triggerServerEvent("onPlayerRequestEntrance", resourceRoot, localPlayer, budynek)
--  setElementInterior(localPlayer, biznes.i_i)
--  setElementDimension(localPlayer, biznes.i_d)
end, false)


addEventHandler("onClientGUIClick", bw.btn_opcje, function()
--  outputChatBox("(( biznesy w trakcie przygotowywania ))")
  wbz.pokaz(budynek)
  guiSetVisible(bw.win,false)
  budynek=nil

end, false)







addEvent("startBiznesSound", true)
addEventHandler("startBiznesSound", getRootElement(), function(plr,id)
	if not (plr==getLocalPlayer()) then return end
	muzykasklepu = playSound(id)
	setSoundVolume(muzykasklepu, 0.3)
end)

addEvent("stopBiznesSound", true)
addEventHandler("stopBiznesSound", getRootElement(), function(plr)
	if not (plr==getLocalPlayer()) then return end
	if muzykasklepu then destroyElement(muzykasklepu) end
end)

function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end





-- -type 1 gui

local type1_skinlistMAN = {
	-- id,nazwa,cena
	{0, "Reserved Style 1", 112},
	{2, "NewYorker Design 1", 103},
	{7, "D&G 1", 108},
	{14, "ZIP Collection 1", 58},
	{15, "H&M Pretty 1", 96},
	{17, "Adidas Sports 1", 48},
	{19, "Versace 1", 85},
	{20, "Adidas Sports 2", 79},
	{21, "G.Armani 1", 107},
	{22, "NewYorker Design 2", 113},
	{24, "Versace 2", 103},
	{25, "Reserved Style 2", 71},
	{28, "KappAhl Fashion 2", 107},
	{29, "NewYorker Design 3", 41},
	{30, "Adidas Sports 3", 94},
	{33, "Guess Company 1", 97},
	{34, "ZIP Collection 2", 119},
	{35, "Adidas Sports 4", 83},
	{36, "Timberland 1", 112},
	{37, "H&M Pretty 2", 114},
	{43, "D&G 2", 84},
	{44, "Guess Company 2", 65},
	{47, "Reserved Style 3", 94},
	{48, "Guess Company 3", 45},
	{49, "Versace 3", 109},
	{51, "NewYorker Design 4", 101},
	{52, "Adidas Sports 5", 89},
	{57, "G.Armani 2", 43},
	{59, "Adidas Sports 6", 102},
	{60, "NewYorker Design 5", 78},
	{66, "NewYorker Design 6", 72},
	{67, "Gucci 1", 95},
	{73, "Adidas Sports 7", 62},
	{82, "G.Armani 3", 113},
	{98, "G.Armani 4", 76},
	{101, "Guess Company 4", 43},
	{112, "Adidas Sports 8", 100},
	{118, "ZIP Collection 3", 58},
	{120, "KappAhl Fashion 3", 116},
	{121, "G.Armani 5", 51},
	{122, "Reserved Style 4", 95},
	{123, "Versace 5", 81},
	{124, "Guess Company 5", 113},
	{128, "Versace 6", 66},
	{133, "Gucci 2", 112},
	{144, "ZIP Collection 4", 111},
	{147, "NewYorker Design 7", 105},
	{176, "Reserved Style 5", 45},
	{179, "D&G 3", 81},
	{180, "Timberland 3", 61},
	{181, "G.Armani 6", 69},
	{185, "ZIP Collection 5", 67},
	{186, "Guess Company 6", 110},
	{187, "Guess Company 7", 99},
	{188, "H&M Pretty 3", 90},
	{206, "Gucci 3", 63},
	{210, "Reserved Style 6", 70},
	{217, "Guess Company 8", 80},
	{222, "G.Armani 7", 56},
	{228, "KappAhl Fashion 4", 103},
	{229, "D&G 4", 52},
	{234, "Guess Company 9", 49},
	{237, "Adidas Sports 9", 46},
	{241, "NewYorker Design 8", 96},
	{248, "Adidas Sports 10", 77},
	{249, "Gucci 4", 49},
	{250, "KappAhl Fashion 5", 108},
	{258, "D&G 5", 71},
	{261, "Guess Company 10", 49},
	{290, "NewYorker Design 9", 103},
	{294, "KappAhl Fashion 6", 77},
	{295, "Guess Company 11", 88},
	{296, "D&G 6", 101},
	{297, "Guess Company 12", 120},
	{299, "Timberland 4", 96},
	{303, "ZIP Collection 7", 63},
}

local type1_skinlistWOMAN = {
	-- id,nazwa,cena
	{9, "ZIP Collection 1", 110},
	{11, "Versace 1", 75},
	{12, "H&M Pretty 1", 90},
	{13, "Gucci 1", 110},
	{31, "Guess Company 1", 78},
	{40, "G.Armani 1", 62},
	{63, "Gucci 2", 68},
	{69, "G.Armani 2", 80},
	{86, "KappAhl Fashion 1", 60},
	{90, "Versace 2", 54},
	{91, "Versace 3", 89},
	{92, "H&M Pretty 2", 40},
	{93, "Gucci 3", 104},
	{131, "Reserved Style 1", 81},
	{141, "KappAhl Fashion 2", 107},
	{150, "NewYorker Design 1", 69},
	{151, "Versace 4", 116},
	{152, "ZIP Collection 2", 93},
	{169, "Reserved Style 2", 97},
	{190, "Gucci 4", 111},
	{191, "Gucci 5", 99},
	{192, "Versace 5", 92},
	{193, "Versace 6", 73},
	{211, "Adidas Sports 1", 115},
	{214, "NewYorker Design 2", 63},
	{216, "Adidas Sports 2", 51},
	{224, "G.Armani 3", 97},
	{226, "NewYorker Design 3", 58},
	{234, "D&G 1", 83},
	{263, "Adidas Sports 3", 102},
	{298, "Reserved Style 3", 106},
}

local type1_skinlistPREMIUM = {
	{137,"PREMIUM 1", 70},
	{145,"PREMIUM 2", 70},
	{203,"PREMIUM 4", 70},
	{204,"PREMIUM 5", 70},
	{205,"PREMIUM 6", 70},
	{256,"PREMIUM 7", 70},
	{257,"PREMIUM 8", 70},
	{26,"PREMIUM 9", 70},
	{264,"PREMIUM 10", 70},
	{38,"PREMIUM 11", 70},
	{39,"PREMIUM 12", 70},
	{45,"PREMIUM 13", 70},
	{81,"PREMIUM 14", 70},
	{83,"PREMIUM 15", 70},
	{84,"PREMIUM 16", 70},
	{87,"PREMIUM 18", 70},
	{167,"PREMIUM 19", 70},
	{18,"PREMIUM 20", 70},
}

function string:split(sep)
        local sep, fields = sep or ":", {}
        local pattern = string.format("([^%s]+)", sep)
        self:gsub(pattern, function(c) fields[#fields+1] = c end)
        return fields
end

odz_window = guiCreateWindow(0, 0, 0.39, 0.58, "Sklep odzieżowy", true)
odz_gridlist = guiCreateGridList(0.03, 0.06, 0.50, 0.92, true, odz_window)
odz_column1 = guiGridListAddColumn(odz_gridlist, "Id", 0.2)
odz_column2 = guiGridListAddColumn(odz_gridlist, "Nazwa", 0.4)
odz_column3 = guiGridListAddColumn(odz_gridlist, "Cena", 0.3)
odz_button1 = guiCreateButton(0.56, 0.20, 0.42, 0.16, "Przymierz", true, odz_window)
odz_button2 = guiCreateButton(0.56, 0.4, 0.42, 0.16, "Zakup", true, odz_window)
odz_button3 = guiCreateButton(0.56, 0.8, 0.42, 0.16, "Zamknij", true, odz_window)
guiSetVisible(odz_window, false)

addEvent("onMarkerType1Enter", true)
addEventHandler("onMarkerType1Enter", getRootElement(), function(plr,containerid)
	if not (plr==getLocalPlayer()) then return end
	local c = getElementData(plr,"character")
	guiGridListClear(odz_gridlist)
	if (c.plec=="man") then
		for k,v in ipairs(type1_skinlistMAN) do --wczytujemy skiny
			local row = guiGridListAddRow(odz_gridlist)
			guiGridListSetItemText(odz_gridlist, row, odz_column1, tostring(v[1]), false, true)
			guiGridListSetItemText(odz_gridlist, row, odz_column2, tostring(v[2]), false, false)
			guiGridListSetItemText(odz_gridlist, row, odz_column3, tostring(v[3]), false, false)
			
			guiGridListSetItemData(odz_gridlist, row, odz_column1, "type1:id")
			guiGridListSetItemData(odz_gridlist, row, odz_column2, "type1:nazwa")
			guiGridListSetItemData(odz_gridlist, row, odz_column3, "type1:cena")
		end
	else
		for k,v in ipairs(type1_skinlistWOMAN) do --wczytujemy skiny
			local row = guiGridListAddRow(odz_gridlist)
			guiGridListSetItemText(odz_gridlist, row, odz_column1, tostring(v[1]), false, true)
			guiGridListSetItemText(odz_gridlist, row, odz_column2, tostring(v[2]), false, false)
			guiGridListSetItemText(odz_gridlist, row, odz_column3, tostring(v[3]), false, false)
			
			guiGridListSetItemData(odz_gridlist, row, odz_column1, "type1:id")
			guiGridListSetItemData(odz_gridlist, row, odz_column2, "type1:nazwa")
			guiGridListSetItemData(odz_gridlist, row, odz_column3, "type1:cena")
		end

	end
	centerWindow(odz_window)
	guiSetVisible(odz_window, true)
	setElementData(odz_window, "container:id", containerid)
	local premium = getElementData(plr, "premium") -- 2013-05-11
	if not premium then return end

	
		for k,v in ipairs(type1_skinlistPREMIUM) do --wczytujemy skiny
			local row = guiGridListAddRow(odz_gridlist)
			guiGridListSetItemText(odz_gridlist, row, odz_column1, tostring(v[1]), false, true)
			guiGridListSetItemText(odz_gridlist, row, odz_column2, tostring(v[2]), false, false)
			guiGridListSetItemText(odz_gridlist, row, odz_column3, tostring(v[3]), false, false)
			
			guiGridListSetItemData(odz_gridlist, row, odz_column1, "type1:id")
			guiGridListSetItemData(odz_gridlist, row, odz_column2, "type1:nazwa")
			guiGridListSetItemData(odz_gridlist, row, odz_column3, "type1:cena")
		end
	
end)

addEvent("onMarkerType1Leave", true)
addEventHandler("onMarkerType1Leave", getRootElement(), function(plr)
	if not (plr==getLocalPlayer()) then return end
	guiSetVisible(odz_window, false)
end)

addEventHandler("onClientGUIClick", odz_button1, function()
	local player = localPlayer
	local selected = guiGridListGetSelectedItem(odz_gridlist)
	if (not selected) or (selected=="") then return end
	local model = guiGridListGetItemText(odz_gridlist, selected, 1)
	
	if (guiGridListGetItemData(odz_gridlist, selected, 1) ~= "type1:id") then return end --w gridliscie mozna zmieniac kolejnosc tabelek i oszukiwac ceny, skiny
	if (guiGridListGetItemData(odz_gridlist, selected, 2) ~= "type1:nazwa") then return end --w gridliscie mozna zmieniac kolejnosc tabelek i oszukiwac ceny, skiny
	if (guiGridListGetItemData(odz_gridlist, selected, 3) ~= "type1:cena") then return end --w gridliscie mozna zmieniac kolejnosc tabelek i oszukiwac ceny, skiny
	
	triggerServerEvent("setElementModelShop", getRootElement(), player, tonumber(model),true)
	guiSetVisible(odz_window, false)
end,false)

addEventHandler("onClientGUIClick", odz_button2, function()
	local player = localPlayer
	local selected = guiGridListGetSelectedItem(odz_gridlist)
	if (not selected) or (selected=="") then return end
	local model = guiGridListGetItemText(odz_gridlist, selected, 1)
	
	if (guiGridListGetItemData(odz_gridlist, selected, 1) ~= "type1:id") then return end --w gridliscie mozna zmieniac kolejnosc tabelek i oszukiwac ceny, skiny
	if (guiGridListGetItemData(odz_gridlist, selected, 2) ~= "type1:nazwa") then return end --w gridliscie mozna zmieniac kolejnosc tabelek i oszukiwac ceny, skiny
	if (guiGridListGetItemData(odz_gridlist, selected, 3) ~= "type1:cena") then return end --w gridliscie mozna zmieniac kolejnosc tabelek i oszukiwac ceny, skiny
	
	if string.find(guiGridListGetItemText(odz_gridlist, selected, 2), "PREMIUM") then
		premium = true
	end
	triggerServerEvent("setElementModelShop", getRootElement(), player, tonumber(model), false, tonumber(guiGridListGetItemText(odz_gridlist, selected, 3)), getElementData(odz_window, "container:id"),premium)
	guiSetVisible(odz_window, false)
end,false)

addEventHandler("onClientGUIClick", odz_button3, function()
	guiSetVisible(odz_window, false)
end,false)