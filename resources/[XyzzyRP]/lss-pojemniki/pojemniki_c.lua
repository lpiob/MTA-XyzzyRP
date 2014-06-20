--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- ten kod jest k****ko brzydka kopią/modyfikacją lss-trade

local otwarty_pojemnik=nil

-- okienko

local trade_offer_1={}	-- eq gracza
local trade_offer_2={}	-- pojemnik

g_POJ_t_win = guiCreateWindow(0.1156,0.0625,0.8,0.7813,"",true)
guiSetAlpha(g_POJ_t_win, 0.75)
g_POJ_t_lbl1 = guiCreateLabel(0.0254,0.0827,0.3984,0.0587,"Shawn Hanks",true,g_POJ_t_win)
g_POJ_t_lbl2 = guiCreateLabel(0.5664,0.0827,0.3984,0.0587,"Shawn Hanks",true,g_POJ_t_win)

g_POJ_t_btn_przenies = guiCreateButton(0.0254,0.8693,0.7984,0.0907,"Przenieś",true,g_POJ_t_win)
g_POJ_t_btn_anuluj = guiCreateButton(0.8654,0.8693,0.0984,0.0907,"Anuluj",true,g_POJ_t_win)

g_POJ_t_grid_oferta1 = guiCreateGridList(0.0254,0.1547,0.4102,0.6153,true,g_POJ_t_win)
g_POJ_t_grid_oferta2 = guiCreateGridList(0.5547,0.1547,0.4102,0.6153,true,g_POJ_t_win)

guiGridListSetSortingEnabled(g_POJ_t_grid_oferta1,false)
guiGridListSetSortingEnabled(g_POJ_t_grid_oferta2,false)

guiGridListSetSelectionMode(g_POJ_t_grid_oferta1,0)
guiGridListSetSelectionMode(g_POJ_t_grid_oferta2,0)

g_POJ_t_grid_oferta1_nazwa=guiGridListAddColumn(g_POJ_t_grid_oferta1,"Nazwa",0.6)
g_POJ_t_grid_oferta1_ilosc=guiGridListAddColumn(g_POJ_t_grid_oferta1,"Ilość",0.2)

g_POJ_t_grid_oferta2_nazwa=guiGridListAddColumn(g_POJ_t_grid_oferta2,"Nazwa",0.6)
g_POJ_t_grid_oferta2_ilosc=guiGridListAddColumn(g_POJ_t_grid_oferta2,"Ilość",0.2)

g_POJ_t_scrollbar1 = guiCreateScrollBar(0.0371,0.784,0.2695,0.0453,true,true,g_POJ_t_win)
g_POJ_t_edit_ilosc1 = guiCreateEdit(0.3242,0.784,0.1113,0.0453,"",true,g_POJ_t_win)

g_POJ_t_scrollbar2 = guiCreateScrollBar(0.5547,0.784,0.2695,0.0453,true,true,g_POJ_t_win)
g_POJ_t_edit_ilosc2 = guiCreateEdit(0.8510,0.784,0.1113,0.0453,"",true,g_POJ_t_win)




guiSetVisible(g_POJ_t_win,false)

local function fillEQ()
    guiGridListClear(g_POJ_t_grid_oferta1)
    trade_offer_1={}
--    table.insert(trade_offer_1,{ itemid=-1, name="Gotówka", available_count=getPlayerMoney(), count=0})
    
    -- przetwarzamy EQ gracza
    local EQ=exports["lss-gui"].eq_get()
    for i,v in ipairs(EQ) do
--	    { itemid=5, name="Aspiryna", count=10, img="img/EQ_aspiryna.png"},
	if (v.itemid and v.itemid>0 and v.count and v.count>0) then
        	table.insert(trade_offer_1,{ itemid=v.itemid, name=v.name, subtype=v.subtype or nil, available_count=v.count, count=0 })
	end
    end

    for i,v in ipairs(trade_offer_1) do
	if (v.row and isElement(v.row)) then destroyElement(v.row) end
	v.row=guiGridListAddRow(g_POJ_t_grid_oferta1)
	if (v.subtype and tonumber(v.subtype)>0) then
	    guiGridListSetItemText(g_POJ_t_grid_oferta1, v.row, g_POJ_t_grid_oferta1_nazwa, v.name.." ["..v.subtype.."]",false,false)
	else
	    guiGridListSetItemText(g_POJ_t_grid_oferta1, v.row, g_POJ_t_grid_oferta1_nazwa, v.name,false,false)
	end
	guiGridListSetItemText(g_POJ_t_grid_oferta1, v.row, g_POJ_t_grid_oferta1_ilosc, v.count,false,false)
	guiGridListSetItemColor(g_POJ_t_grid_oferta1, v.row, g_POJ_t_grid_oferta1_nazwa, 100,100,100)
    end

end

local function pojemnik_ofertaFindSelectedRow1()
    local selectedRow, selectedCol = guiGridListGetSelectedItem( g_POJ_t_grid_oferta1 );
    if (not selectedRow) then return end
    
    for i,v in pairs(trade_offer_1) do
	if (v.row==selectedRow) then
	    return v
	end
    end
    return nil
end

local function pojemnik_oferta1gridclick()	-- gry gracz kliknie w dana pozycje po swojej stronie oferty
    local v=pojemnik_ofertaFindSelectedRow1()
    if (not v) then return end
    guiScrollBarSetScrollPosition ( g_POJ_t_scrollbar1, tonumber(v.count)/tonumber(v.available_count)*100 )
    guiSetText(g_POJ_t_edit_ilosc1, tonumber(v.count))

    return
end

addEventHandler( "onClientGUIClick", g_POJ_t_grid_oferta1, pojemnik_oferta1gridclick, false );


local function pojemnik_ofertaFindSelectedRow2()
    local selectedRow, selectedCol = guiGridListGetSelectedItem( g_POJ_t_grid_oferta2 );
    if (not selectedRow) then return end
    
    for i,v in pairs(trade_offer_2) do
	if (v.row==selectedRow) then
	    return v
	end
    end
    return nil
end

local function pojemnik_oferta2gridclick()	-- gry gracz kliknie w dana pozycje po swojej stronie oferty

    local v=pojemnik_ofertaFindSelectedRow2()
    if (not v) then return end
    guiScrollBarSetScrollPosition ( g_POJ_t_scrollbar2, tonumber(v.count)/tonumber(v.available_count)*100 )
    guiSetText(g_POJ_t_edit_ilosc2, tonumber(v.count))

    return
end

addEventHandler( "onClientGUIClick", g_POJ_t_grid_oferta2, pojemnik_oferta2gridclick, false );



-- zmiana ilosc produktu na suwaku
local function pojemnik_oferta1ChangeAmount()
    local count=-1
    local v=pojemnik_ofertaFindSelectedRow1()
    if (not v) then return end
    
    if (getElementType(source)=="gui-scrollbar") then
	count=math.floor(guiScrollBarGetScrollPosition(g_POJ_t_scrollbar1)*v.available_count/100)
        removeEventHandler("onClientGUIChanged", g_POJ_t_edit_ilosc1, pojemnik_oferta1ChangeAmount,false)
        guiSetText(g_POJ_t_edit_ilosc1, tostring(count))
        addEventHandler("onClientGUIChanged", g_POJ_t_edit_ilosc1, pojemnik_oferta1ChangeAmount,false)

    elseif (getElementType(source)=="gui-edit") then
	count=tonumber(guiGetText(g_POJ_t_edit_ilosc1))
	if (count<0) then count=0 end
	if (count>v.available_count) then count=v.available_count end
	removeEventHandler("onClientGUIScroll", g_POJ_t_scrollbar1, pojemnik_oferta1ChangeAmount,false)
	guiScrollBarSetScrollPosition ( g_POJ_t_scrollbar1, tonumber(count)/tonumber(v.available_count)*100 )
	addEventHandler("onClientGUIScroll", g_POJ_t_scrollbar1, pojemnik_oferta1ChangeAmount,false)
    else
	-- nie powinno sie wydarzyc
	return
    end
    
    if (count<0) then return end
    v.count=count
    guiGridListSetItemText(g_POJ_t_grid_oferta1, v.row, g_POJ_t_grid_oferta1_ilosc, v.count,false,false)
    if (v.count>0) then
        guiGridListSetItemColor(g_POJ_t_grid_oferta1, v.row, g_POJ_t_grid_oferta1_nazwa, 255,255,255)
    else
        guiGridListSetItemColor(g_POJ_t_grid_oferta1, v.row, g_POJ_t_grid_oferta1_nazwa, 100,100,100)
    end

--    trade_transmitOffer()	-- wysylamy do serwera informacje o stanie transakcji
    
end
addEventHandler("onClientGUIScroll", g_POJ_t_scrollbar1, pojemnik_oferta1ChangeAmount,false)
addEventHandler("onClientGUIChanged", g_POJ_t_edit_ilosc1, pojemnik_oferta1ChangeAmount,false)




-- zmiana ilosc produktu na suwaku
local function pojemnik_oferta2ChangeAmount()
    local count=-1
    local v=pojemnik_ofertaFindSelectedRow2()
    if (not v) then return end
    
    if (getElementType(source)=="gui-scrollbar") then
	count=math.floor(guiScrollBarGetScrollPosition(g_POJ_t_scrollbar2)*v.available_count/100)
        removeEventHandler("onClientGUIChanged", g_POJ_t_edit_ilosc2, pojemnik_oferta2ChangeAmount,false)
        guiSetText(g_POJ_t_edit_ilosc2, tostring(count))
        addEventHandler("onClientGUIChanged", g_POJ_t_edit_ilosc2, pojemnik_oferta2ChangeAmount,false)

    elseif (getElementType(source)=="gui-edit") then
	count=tonumber(guiGetText(g_POJ_t_edit_ilosc2))
	if (count<0) then count=0 end
	if (count>v.available_count) then count=v.available_count end
	removeEventHandler("onClientGUIScroll", g_POJ_t_scrollbar2, pojemnik_oferta2ChangeAmount,false)
	guiScrollBarSetScrollPosition ( g_POJ_t_scrollbar2, tonumber(count)/tonumber(v.available_count)*100 )
	addEventHandler("onClientGUIScroll", g_POJ_t_scrollbar2, pojemnik_oferta2ChangeAmount,false)
    else
	-- nie powinno sie wydarzyc
	return
    end
    
    if (count<0) then return end
    v.count=count
    guiGridListSetItemText(g_POJ_t_grid_oferta2, v.row, g_POJ_t_grid_oferta2_ilosc, v.count,false,false)
    if (v.count>0) then
        guiGridListSetItemColor(g_POJ_t_grid_oferta2, v.row, g_POJ_t_grid_oferta2_nazwa, 255,255,255)
    else
        guiGridListSetItemColor(g_POJ_t_grid_oferta2, v.row, g_POJ_t_grid_oferta2_nazwa, 100,100,100)
    end

--    trade_transmitOffer()	-- wysylamy do serwera informacje o stanie transakcji
    
end
addEventHandler("onClientGUIScroll", g_POJ_t_scrollbar2, pojemnik_oferta2ChangeAmount,false)
addEventHandler("onClientGUIChanged", g_POJ_t_edit_ilosc2, pojemnik_oferta2ChangeAmount,false)


addEventHandler ( "onClientGUIClick", g_POJ_t_btn_anuluj, function()
        guiSetVisible(g_POJ_t_win,false)
		otwarty_pojemnik=nil
end, false )

local function pojemniki_transmitAction()
--  outputChatBox("TA " .. #trade_offer_1 .. " - " .. #trade_offer_2)
  triggerServerEvent("onContainerTransmit", localPlayer, trade_offer_1, trade_offer_2, otwarty_pojemnik)
  zamknijPojemnik(-1)
end

addEventHandler ( "onClientGUIClick", g_POJ_t_btn_przenies, pojemniki_transmitAction, false)
-- exportowane funkcje ----------------

function otworzPojemnik(id,szyfr)
    if (not id) then return end
    triggerServerEvent("onPojemnikOpenRequest", localPlayer, id,szyfr)
end

function zamknijPojemnik(id)
    if (otwarty_pojemnik and (otwarty_pojemnik.id==id or id<0)) then
        guiSetVisible(g_POJ_t_win,false)
		otwarty_pojemnik=nil
    end
end

addEvent("doOpenPojemnik", true)
addEventHandler("doOpenPojemnik", resourceRoot, function(pojemnik)
    local c=getElementData(localPlayer, "character")
    if (not c) then return end
    
    guiSetVisible(g_POJ_t_win,true)
    otwarty_pojemnik=pojemnik
    guiSetText(g_POJ_t_lbl1,c.imie .. " " .. c.nazwisko)
    guiSetText(g_POJ_t_lbl2,pojemnik.nazwa .. " ["..pojemnik.id.."]")
    fillEQ()
	-- wypelniamy teraz prawą stronę

    guiGridListClear(g_POJ_t_grid_oferta2)
    trade_offer_2={}

	if (pojemnik.zawartosc) then
      for i,v in ipairs(pojemnik.zawartosc) do
		if (v.itemid and v.count) then
        	table.insert(trade_offer_2,{ itemid=tonumber(v.itemid), name=v.name, subtype=tonumber(v.subtype) or nil, available_count=tonumber(v.count), count=0 })
		end
	  end

      for i,v in ipairs(trade_offer_2) do
		if (v.row and isElement(v.row)) then destroyElement(v.row) end
		v.row=guiGridListAddRow(g_POJ_t_grid_oferta2)
		if (v.subtype and tonumber(v.subtype)>0) then
		    guiGridListSetItemText(g_POJ_t_grid_oferta2, v.row, g_POJ_t_grid_oferta2_nazwa, v.name.." ["..v.subtype.."]",false,false)
		else
		    guiGridListSetItemText(g_POJ_t_grid_oferta2, v.row, g_POJ_t_grid_oferta2_nazwa, v.name,false,false)
		end
		guiGridListSetItemText(g_POJ_t_grid_oferta2, v.row, g_POJ_t_grid_oferta2_ilosc, v.count,false,false)
		guiGridListSetItemColor(g_POJ_t_grid_oferta2, v.row, g_POJ_t_grid_oferta2_nazwa, 100,100,100)
    end
  end

end)

