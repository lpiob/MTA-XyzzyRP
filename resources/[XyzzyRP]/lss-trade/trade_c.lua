--[[
Handel pomiędzy graczami

@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--




handel_a_visible=false

trade_with=nil

g_HANDEL_a_win = guiCreateWindow(0.7437,0.5687,0.2281,0.2146,"Handel/wymiana",true)
g_HANDEL_a_btn = guiCreateButton(0.1096,0.6893,0.7877,0.2233,"Zgoda",true,g_HANDEL_a_win)
g_HANDEL_a_lbl = guiCreateLabel(0.1096,0.2233,0.7877,0.2689,"Shawn Hanks chce z Tobą handlować",true,g_HANDEL_a_win)
guiLabelSetHorizontalAlign(g_HANDEL_a_lbl,"center",true)

guiSetVisible(g_HANDEL_a_win,false)



function tradeAllow()
    handel_a_visible=false
    guiSetVisible(g_HANDEL_a_win,false)
    triggerServerEvent("onTradeRequestAllowed", localPlayer,trade_with)
end
addEventHandler ( "onClientGUIClick", g_HANDEL_a_btn, tradeAllow, false )

function menu_trade(args)
    local with=args.with
    if (not with or not isElement(with) or getElementType(with)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("menu_trade wywolane z obiektem ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end
    -- todo sprawdzanie odleglosci, dimensionow i interiorow
    local x1,y1,z1=getElementPosition(localPlayer)
    local x2,y2,z2=getElementPosition(with)
    if (getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)>5) then
	outputChatBox("Musisz podejść bliżej aby dokonać transakcji.", 255,0,0,true)
	return false
    end

    triggerServerEvent("onTradeRequest", localPlayer, with)
    return true
end

local function requestTradeAllowanceTimeout()
	if (handel_a_visible and not handel_t_visible) then
	    handel_a_visible=false
	    trade_with=nil
	    guiSetVisible(g_HANDEL_a_win, false)
	end	
end

function requestTradeAllowance()
    if (not source or not isElement(source) or getElementType(source)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("requestTradeAllowance wywolane z obiektem ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end

    if (handel_a_visible and trade_with~=source) then
	-- gracz ma juz otwarte okienko zaproszenia do handlu
	triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " handluje z kimś.", 5, 5, false)
	return false
    end

    if (isTimer(handel_a_timer)) then killTimer(handel_a_timer) end
    trade_with=source
    guiSetText(g_HANDEL_a_lbl, getPlayerName(source) .. " chce z Tobą handlować.")
    guiSetVisible(g_HANDEL_a_win, true)
    handel_a_visible=true
    handel_a_timer=setTimer(requestTradeAllowanceTimeout, 10000, 1)
end

addEvent("onTradeRequestAllowance",true)
addEventHandler("onTradeRequestAllowance", root, requestTradeAllowance)


-- kod handlu wlasciwego

handel_t_visible=false

local trade_offer_1={}	-- to co oferuje lokalny graczy
local trade_offer_2={}	-- to co oferuje gracz zdalny

g_HANDEL_t_win = guiCreateWindow(0.1156,0.0625,0.8,0.7813,"",true)
g_HANDEL_t_lbl1 = guiCreateLabel(0.0254,0.0827,0.3984,0.0587,"Shawn Hanks",true,g_HANDEL_t_win)
g_HANDEL_t_lbl2 = guiCreateLabel(0.5664,0.0827,0.3984,0.0587,"Shawn Hanks",true,g_HANDEL_t_win)
--g_HANDEL_t_btn_zgoda1 = guiCreateButton(0.1523,0.8693,0.2715,0.0907,"Zgoda",true,g_HANDEL_t_win)
g_HANDEL_t_chk_zgoda1 = guiCreateCheckBox(0.1523,0.8693,0.2715,0.0907,"Zgoda",false,true,g_HANDEL_t_win)
--g_HANDEL_t_btn_zgoda2 = guiCreateButton(0.5664,0.8693,0.2715,0.0907,"",true,g_HANDEL_t_win)
g_HANDEL_t_chk_zgoda2 = guiCreateCheckBox(0.5664,0.8693,0.2715,0.0907,"Zgoda",false,true,g_HANDEL_t_win)
guiSetEnabled(g_HANDEL_t_chk_zgoda2, false)
g_HANDEL_t_btn_anuluj = guiCreateButton(0.0254,0.8693,0.0984,0.0907,"Anuluj",true,g_HANDEL_t_win)


g_HANDEL_t_grid_oferta1 = guiCreateGridList(0.0254,0.1547,0.4102,0.6153,true,g_HANDEL_t_win)
g_HANDEL_t_grid_oferta2 = guiCreateGridList(0.5547,0.1547,0.4102,0.688,true,g_HANDEL_t_win)

guiGridListSetSortingEnabled(g_HANDEL_t_grid_oferta1,false)
guiGridListSetSortingEnabled(g_HANDEL_t_grid_oferta2,false)

guiGridListSetSelectionMode(g_HANDEL_t_grid_oferta1,0)
guiGridListSetSelectionMode(g_HANDEL_t_grid_oferta2,0)

g_HANDEL_t_grid_oferta1_nazwa=guiGridListAddColumn(g_HANDEL_t_grid_oferta1,"Nazwa",0.6)
g_HANDEL_t_grid_oferta1_ilosc=guiGridListAddColumn(g_HANDEL_t_grid_oferta1,"Ilość",0.2)

g_HANDEL_t_grid_oferta2_nazwa=guiGridListAddColumn(g_HANDEL_t_grid_oferta2,"Nazwa",0.6)
g_HANDEL_t_grid_oferta2_ilosc=guiGridListAddColumn(g_HANDEL_t_grid_oferta2,"Ilość",0.2)

g_HANDEL_t_scrollbar = guiCreateScrollBar(0.0371,0.784,0.2695,0.0453,true,true,g_HANDEL_t_win)
g_HANDEL_t_edit_ilosc = guiCreateEdit(0.3242,0.784,0.1113,0.0453,"",true,g_HANDEL_t_win)

guiSetVisible(g_HANDEL_t_win,false)

local function trade_fillEQ()
    guiGridListClear(g_HANDEL_t_grid_oferta1)
    trade_offer_1={}
    table.insert(trade_offer_1,{ itemid=-1, name="Gotówka", available_count=getPlayerMoney(), count=0})
    
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
	v.row=guiGridListAddRow(g_HANDEL_t_grid_oferta1)
	if (v.subtype and tonumber(v.subtype)>0) then
	    guiGridListSetItemText(g_HANDEL_t_grid_oferta1, v.row, g_HANDEL_t_grid_oferta1_nazwa, v.name.." ["..v.subtype.."]",false,false)
	else
	    guiGridListSetItemText(g_HANDEL_t_grid_oferta1, v.row, g_HANDEL_t_grid_oferta1_nazwa, v.name,false,false)
	end
	guiGridListSetItemText(g_HANDEL_t_grid_oferta1, v.row, g_HANDEL_t_grid_oferta1_ilosc, v.count,false,false)
	guiGridListSetItemColor(g_HANDEL_t_grid_oferta1, v.row, g_HANDEL_t_grid_oferta1_nazwa, 100,100,100)
    end

end

--trade_fillEQ() -- todo usunac

local function trade_ofertaFindSelectedRow()
    local selectedRow, selectedCol = guiGridListGetSelectedItem( g_HANDEL_t_grid_oferta1 );
    if (not selectedRow) then return end
    
    for i,v in pairs(trade_offer_1) do
	if (v.row==selectedRow) then
	    return v
	end
    end
    return nil
end



local function trade_ofertagridclick()	-- gry gracz kliknie w dana pozycje po swojej stronie oferty

    local v=trade_ofertaFindSelectedRow()
    if (not v) then return end
    guiScrollBarSetScrollPosition ( g_HANDEL_t_scrollbar, tonumber(v.count)/tonumber(v.available_count)*100 )
    guiSetText(g_HANDEL_t_edit_ilosc, tonumber(v.count))
    
    return
end

addEventHandler( "onClientGUIClick", g_HANDEL_t_grid_oferta1, trade_ofertagridclick, false );

local function trade_transmitOffer()
    triggerServerEvent("onOfferProposal", localPlayer, trade_with, trade_offer_1, guiCheckBoxGetSelected(g_HANDEL_t_chk_zgoda1))
end

addEventHandler("onClientGUIClick", g_HANDEL_t_chk_zgoda1, trade_transmitOffer, false)

-- zmiana ilosc produktu na suwaku
local function trade_ofertaChangeAmount()
    if (guiCheckBoxGetSelected(g_HANDEL_t_chk_zgoda1)) then
        guiCheckBoxSetSelected(g_HANDEL_t_chk_zgoda1,false)	-- nastapila zmiana formularza - wycofujemy zgode

    end

    local count=-1
    local v=trade_ofertaFindSelectedRow()
    if (not v) then return end
    
    if (getElementType(source)=="gui-scrollbar") then
	count=math.floor(guiScrollBarGetScrollPosition(g_HANDEL_t_scrollbar)*v.available_count/100)
        removeEventHandler("onClientGUIChanged", g_HANDEL_t_edit_ilosc, trade_ofertaChangeAmount,false)
        guiSetText(g_HANDEL_t_edit_ilosc, tostring(count))
        addEventHandler("onClientGUIChanged", g_HANDEL_t_edit_ilosc, trade_ofertaChangeAmount,false)

    elseif (getElementType(source)=="gui-edit") then
	count=tonumber(guiGetText(g_HANDEL_t_edit_ilosc))
	if (count<0) then count=0 end
	if (count>v.available_count) then count=v.available_count end
	removeEventHandler("onClientGUIScroll", g_HANDEL_t_scrollbar, trade_ofertaChangeAmount,false)
	guiScrollBarSetScrollPosition ( g_HANDEL_t_scrollbar, tonumber(count)/tonumber(v.available_count)*100 )
	addEventHandler("onClientGUIScroll", g_HANDEL_t_scrollbar, trade_ofertaChangeAmount,false)
    else
	-- nie powinno sie wydarzyc
	return
    end
    
    if (count<0) then return end
    v.count=count
    guiGridListSetItemText(g_HANDEL_t_grid_oferta1, v.row, g_HANDEL_t_grid_oferta1_ilosc, v.count,false,false)
    if (v.count>0) then
        guiGridListSetItemColor(g_HANDEL_t_grid_oferta1, v.row, g_HANDEL_t_grid_oferta1_nazwa, 255,255,255)
    else
        guiGridListSetItemColor(g_HANDEL_t_grid_oferta1, v.row, g_HANDEL_t_grid_oferta1_nazwa, 100,100,100)
    end

    trade_transmitOffer()	-- wysylamy do serwera informacje o stanie transakcji
    
end
addEventHandler("onClientGUIScroll", g_HANDEL_t_scrollbar, trade_ofertaChangeAmount,false)
addEventHandler("onClientGUIChanged", g_HANDEL_t_edit_ilosc, trade_ofertaChangeAmount,false)



-- przyjmowanie oferty od drugiej osoby
function offerProposalReceived(trade_offer, accepted)
    --     triggerClientEvent(trade_with, "onTradeOffer", source, trade_offer, accepted) 

    if (not source or not isElement(source) or getElementType(source)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("offerProposalReceived wywolane z obiektem ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end
    -- todo sprawdzanie czy gracz nie ma otwartego okienka z pytaniem o zgode na handel
    if (trade_with~=source) then
	outputDebugString("offerProposalReceived od osoby z ktora nie handlujemy!")
	return false
    end

    
    -- pokazmy tą ofertę
    trade_offer_old=trade_offer_2
    trade_offer_2=trade_offer
    guiGridListClear(g_HANDEL_t_grid_oferta2)
    
    local zawartosc_zmieniona=false
    if (#trade_offer_old~=#trade_offer_2) then zawartosc_zmieniona=true end

    for i,v in ipairs(trade_offer_2) do
	if (v.row and isElement(v.row)) then destroyElement(v.row) end

	if (not trade_offer_old[i] or (v.count and not trade_offer_old[i].count) or (not v.count and trade_offer_old[i].count) or v.count~=trade_offer_old[i].count
				    or (v.itemid and not trade_offer_old[i].itemid) or (not v.itemid and trade_offer_old[i].itemid) or v.itemid~=trade_offer_old[i].itemid
				    or (v.subtype and not trade_offer_old[i].subtype) or (not v.subtype and trade_offer_old[i].subtype) or v.subtype~=trade_offer_old[i].subtype     ) then zawartosc_zmieniona=true end
	
	if (v.count>0) then
		v.row=guiGridListAddRow(g_HANDEL_t_grid_oferta2)
		if (v.subtype and tonumber(v.subtype)>0) then
		    guiGridListSetItemText(g_HANDEL_t_grid_oferta2, v.row, g_HANDEL_t_grid_oferta2_nazwa, v.name.." ["..v.subtype.."]",false,false)
		else
		    guiGridListSetItemText(g_HANDEL_t_grid_oferta2, v.row, g_HANDEL_t_grid_oferta2_nazwa, v.name,false,false)
		end
		guiGridListSetItemText(g_HANDEL_t_grid_oferta2, v.row, g_HANDEL_t_grid_oferta2_ilosc, v.count,false,false)
		guiGridListSetItemColor(g_HANDEL_t_grid_oferta2, v.row, g_HANDEL_t_grid_oferta2_nazwa, 100,100,100)
	end
    end
    
    guiCheckBoxSetSelected(g_HANDEL_t_chk_zgoda2,accepted)
    -- akceptacja?
    if (zawartosc_zmieniona) then
        -- skoro zmienily sie warunki transakcji to wycofujemy nasza zgode
        guiCheckBoxSetSelected(g_HANDEL_t_chk_zgoda1,false)
        trade_transmitOffer()
    end
    
    
end
addEvent("onTradeOffer", true)
addEventHandler("onTradeOffer", root, offerProposalReceived)


--- anulowanie i inicjowanie transkacji

function tradeCancel()
    handel_t_visible=false
    guiSetVisible(g_HANDEL_t_win,false)
    triggerServerEvent("onTradeCancel", localPlayer, trade_with)
end

addEventHandler ( "onClientGUIClick", g_HANDEL_t_btn_anuluj, tradeCancel, false )

function initTrade()
    if (handel_a_visible) then
	-- todo triggerserverevent denytraderequest gracz handluje z kims innym
	handel_a_visible=false
	guiSetVisible(g_HANDEL_a_win,false)
    end
    trade_with=source
    trade_fillEQ()
    trade_offer_2={}
    guiSetText(g_HANDEL_t_lbl1, getPlayerName(localPlayer))
    guiSetText(g_HANDEL_t_lbl2, getPlayerName(trade_with))
    handel_t_visible=true
    guiSetVisible(g_HANDEL_t_win,true)
    
end

addEvent("startTrade",true)
addEventHandler("startTrade",root, initTrade)

function cancelTrade()
    outputChatBox("* " .. getPlayerName(source) .. " zrezygnował z transakcji.")
    handel_t_visible=false
    guiSetVisible(g_HANDEL_t_win,false)
    -- ponizsze potrzebne?
    handel_a_visible=false
    guiSetVisible(g_HANDEL_a_win,false)
end

addEvent("cancelTrade", true)
addEventHandler("cancelTrade", root, cancelTrade)

function finishTrade()
    handel_t_visible=false
    guiSetVisible(g_HANDEL_t_win,false)
    -- ponizsze potrzebne?
    handel_a_visible=false
    guiSetVisible(g_HANDEL_a_win,false)
end

addEvent("finishTrade", true)
addEventHandler("finishTrade", root, finishTrade)



