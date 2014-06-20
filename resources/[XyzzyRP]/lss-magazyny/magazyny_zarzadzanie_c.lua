--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--




local zm={}
local uc={}


zm.win = guiCreateWindow(0.1758,0.138,0.6592,0.612,"Zarządzanie magazynem",true)
guiSetVisible(zm.win,false)

guiWindowSetSizable(zm.win,false)
zm.lbl_opis = guiCreateLabel(0.0104,0.0596,0.9822,0.0787,"Magazyn Blueberry, ilość gotówki w kasie: 1231231$.",true,zm.win)
guiLabelSetVerticalAlign(zm.lbl_opis,"center")
guiLabelSetHorizontalAlign(zm.lbl_opis,"center",true)
zm.tabpanel = guiCreateTabPanel(0.0133,0.1532,0.9689,0.7511,true,zm.win)
zm.tab_stany = guiCreateTab("Stany magazynowe i cennik",zm.tabpanel)
zm.grid_stany = guiCreateGridList(0.0092,0.0274,0.9817,0.9514,true,zm.tab_stany)
guiGridListSetSelectionMode(zm.grid_stany,2)

guiGridListAddColumn(zm.grid_stany,"Produkt",0.2)

guiGridListAddColumn(zm.grid_stany,"Stan magazynowy",0.2)

guiGridListAddColumn(zm.grid_stany,"Cena skupu/100",0.2)

guiGridListAddColumn(zm.grid_stany,"Cena sprzedaży/100",0.2)
zm.tab_historia = guiCreateTab("Historia dostaw",zm.tabpanel)
guiSetEnabled(zm.tab_historia, false)
zm.memo_historia = guiCreateMemo(0.0076,0.0274,0.9801,0.9483,"",true,zm.tab_historia)
guiMemoSetReadOnly(zm.memo_historia,true)
zm.tab_notatki = guiCreateTab("Notatki",zm.tabpanel)
guiSetEnabled(zm.tab_notatki, false)
zm.memo_notatki = guiCreateMemo(0.0076,0.0274,0.9801,0.9483,"",true,zm.tab_notatki)
zm.btn_zapisz = guiCreateButton(0.7126,0.9149,0.2726,0.066,"Zapisz zmiany",true,zm.win)
zm.btn_anuluj = guiCreateButton(0.0148,0.9149,0.2726,0.066,"Anuluj",true,zm.win)

uc.win = guiCreateWindow(0.3789,0.3372,0.2598,0.1771,"Ustal cenę",true)
guiSetVisible(uc.win,false)

guiWindowSetSizable(uc.win,false)
uc.chk_enable = guiCreateCheckBox(0.0451,0.2206,0.891,0.1618,"Magazyn skupuje produkt",false,true,uc.win)
uc.lbl = guiCreateLabel(0.0489,0.4632,0.4023,0.2132,"Cena za 100szt:",true,uc.win)
uc.edt_cena = guiCreateEdit(0.4624,0.4485,0.4774,0.1544,"",true,uc.win)
uc.btn_zapisz = guiCreateButton(0.0414,0.7206,0.9098,0.2132,"Zapisz",true,uc.win)

local amagazyn

local function schowajOkna()
	guiSetVisible(uc.win,false)
	guiSetVisible(zm.win,false)
	amagazyn=nil
end

local function pokazOknoZM()
	guiSetVisible(uc.win,false)
	guiSetVisible(zm.win, true)
	guiBringToFront(zm.win)
end



addEvent("doFillDaneMagazynu", true)
addEventHandler("doFillDaneMagazynu", resourceRoot, function(dane)
--	outputChatBox("Otrzymano dane magazynu.")
	amagazyn=dane
	guiSetText(zm.lbl_opis, string.format("%s, ilość gotówki w kasie: $%d.", dane.nazwa,dane.gotowka))
	-- stany magazynowy
	guiGridListClear(zm.grid_stany)
	for i,v in ipairs(dane.stan_magazynowy) do
		local row=guiGridListAddRow(zm.grid_stany)
		if v.buyprice and v.buyprice==0 then v.buyprice=nil end
		if v.sellprice and v.sellprice==0 then v.sellprice=nil end
		guiGridListSetItemText(zm.grid_stany, row, 1, string.format("%d %s", v.item_id, v.item_name),false,false)
		guiGridListSetItemData(zm.grid_stany, row, 1, v.item_id)
		guiGridListSetItemText(zm.grid_stany, row, 2, v.stan_magazynowy or 0,false,true)
		guiGridListSetItemData(zm.grid_stany, row, 2, v.stan_magazynowy)
		guiGridListSetItemText(zm.grid_stany, row, 3, v.buyprice or "nie skupuje",false,false)
		guiGridListSetItemData(zm.grid_stany, row, 3, v.buyprice)
		guiGridListSetItemText(zm.grid_stany, row, 4, v.sellprice or "nie sprzedaje",false,false)
		guiGridListSetItemData(zm.grid_stany, row, 4, v.sellprice)
	end
	pokazOknoZM()
end)

addEventHandler("onClientMarkerHit", resourceRoot, function(el,md)
	if el~=localPlayer or not md then return end

	if getPlayerName(localPlayer)~="Bob_Euler" then
		outputChatBox("(( Nie znasz hasła do tego terminala. ))")
		return
	end

	local et=getElementData(source,"typ")

	if et and et=="zarzadzanie" then
--		outputChatBox("(( Otwieranie magazynu ))")
		triggerServerEvent("doFetchDaneMagazynu", resourceRoot, getElementData(source, "magazyn")) -- jebac nazewnictwo
	end
end)

addEventHandler("onClientMarkerLeave", resourceRoot, function(el,md)
	if el~=localPlayer then return end
	amagazyn=nil
	schowajOkna()
end)

addEventHandler("onClientGUIClick", zm.btn_anuluj, function()
	schowajOkna()
	amagazyn=nil
end, false)

addEventHandler( "onClientGUIDoubleClick", zm.grid_stany, function()
	local selectedRow, selectedCol = guiGridListGetSelectedItem( zm.grid_stany);
	if selectedCol==3 or selectedCol==4 then
		local data=guiGridListGetItemData(zm.grid_stany, selectedRow, selectedCol)
		if not data then
			guiCheckBoxSetSelected(uc.chk_enable,false)
			guiSetEnabled(uc.edt_cena,false)
		else
			guiCheckBoxSetSelected(uc.chk_enable,true)
			guiSetEnabled(uc.edt_cena,true)
		end
		if selectedCol==3 then
			guiSetText(uc.chk_enable, "Magazyn skupuje produkt")
		else
			guiSetText(uc.chk_enable, "Magazyn sprzedaje produkt")
		end
		guiSetText(uc.edt_cena, data or 0)
		guiSetEnabled(zm.win, false)
		guiSetVisible(uc.win, true)
		guiBringToFront(uc.win, true)
	end
end, false)

addEventHandler("onClientGUIClick", uc.chk_enable, function()
	if guiCheckBoxGetSelected(uc.chk_enable) then
		guiSetEnabled(uc.edt_cena,true)
	else
		guiSetEnabled(uc.edt_cena,false)
	end
end, false)

addEventHandler("onClientGUIClick", uc.btn_zapisz, function()
	
	local cena=nil
	if guiCheckBoxGetSelected(uc.chk_enable) then
		cena=tonumber(guiGetText(uc.edt_cena))
		if cena<=0 then cena=nil end
	end
--	outputChatBox("cena " .. cena)

	local selectedRow, selectedCol = guiGridListGetSelectedItem( zm.grid_stany);
	if selectedCol==3 or selectedCol==4 then
		guiGridListSetItemText(zm.grid_stany, selectedRow, selectedCol, cena or (selectedCol==3 and "nie skupuje" or "nie sprzedaje"),false,false)
		guiGridListSetItemData(zm.grid_stany, selectedRow, selectedCol, cena)
	end

	guiSetEnabled(zm.win, true)
	guiSetVisible(uc.win, false)
	guiBringToFront(zm.win, true)
end, false)

addEventHandler("onClientGUIClick", zm.btn_zapisz, function()
	local stany_magazynowe={}
	for row=1,guiGridListGetRowCount(zm.grid_stany) do
		table.insert(stany_magazynowe, 
			{
				item_id=guiGridListGetItemData(zm.grid_stany, row, 1),
				buyprice=guiGridListGetItemData(zm.grid_stany, row, 3),
				sellprice=guiGridListGetItemData(zm.grid_stany, row, 4),
			})
	end
	local dane={
		magazyn=amagazyn.magazyn,
		stany_magazynowe=stany_magazynowe,
	}
	schowajOkna()
	triggerServerEvent("doSaveDaneMagazynu", resourceRoot, dane)

end,false)
