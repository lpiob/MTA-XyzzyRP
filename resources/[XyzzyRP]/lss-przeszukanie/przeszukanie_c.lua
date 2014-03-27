--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--


przeszukanie_a_visible=false

trade_with=nil

g_PRZESZUKANIE_a_win = guiCreateWindow(0.7437,0.6687,0.2281,0.2146,"Przeszukanie",true)
g_PRZESZUKANIE_a_btn = guiCreateButton(0.1096,0.6893,0.7877,0.2233,"Zgoda",true,g_PRZESZUKANIE_a_win)
g_PRZESZUKANIE_a_lbl = guiCreateLabel(0.1096,0.2233,0.7877,0.3689,"Shawn Hanks chce Cię przeszukać",true,g_PRZESZUKANIE_a_win)
guiLabelSetHorizontalAlign(g_PRZESZUKANIE_a_lbl,"center",true)

guiSetVisible(g_PRZESZUKANIE_a_win,false)



function tradeAllow()
    przeszukanie_a_visible=false
    guiSetVisible(g_PRZESZUKANIE_a_win,false)
    triggerServerEvent("onPrzeszukanieRequestAllowed", localPlayer,trade_with)
end
addEventHandler ( "onClientGUIClick", g_PRZESZUKANIE_a_btn, tradeAllow, false )

function menu_przeszukaj(args)
    local with=args.with
    if (not with or not isElement(with) or getElementType(with)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("menu_trade wywolane z obiektem ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end
    -- todo sprawdzanie odleglosci, dimensionow i interiorow
    local x1,y1,z1=getElementPosition(localPlayer)
    local x2,y2,z2=getElementPosition(with)
    if (getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)>5) then
	outputChatBox("Musisz podejść bliżej aby dokonać przeszukania.", 255,0,0,true)
	return false
    end

    triggerServerEvent("onPrzeszukanieRequest", localPlayer, with)
--	outputChatBox("(( Przeszukiwanie jest w trakcie wprowadzania, bedzie dostepne wkrotce ))")
    return true
end

local function requestPrzeszukanieAllowanceTimeout()
	if (przeszukanie_a_visible and not handel_t_visible) then
	    przeszukanie_a_visible=false
	    trade_with=nil
	    guiSetVisible(g_PRZESZUKANIE_a_win, false)
	end	
end

function requestPrzeszukanieAllowance()
    if (not source or not isElement(source) or getElementType(source)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("requestPrzeszukanieAllowance wywolane z obiektem ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end

    if (przeszukanie_a_visible and trade_with~=source) then
	-- gracz ma juz otwarte okienko zaproszenia do handlu
	return false
    end

    if (isTimer(przeszukanie_a_timer)) then killTimer(przeszukanie_a_timer) end
    trade_with=source
    guiSetText(g_PRZESZUKANIE_a_lbl, getPlayerName(source) .. " chce Cię przeszukać.")
    guiSetVisible(g_PRZESZUKANIE_a_win, true)
    przeszukanie_a_visible=true
    przeszukanie_a_timer=setTimer(requestPrzeszukanieAllowanceTimeout, 10000, 1)
end

addEvent("onPrzeszukanieRequestAllowance",true)
addEventHandler("onPrzeszukanieRequestAllowance", root, requestPrzeszukanieAllowance)

