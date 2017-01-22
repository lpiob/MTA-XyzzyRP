--[[
Kasyno - blackjack

@author Lukasz Biegaj <wielebny@bestplay.pl>
@author R3fr3Sh <https://github.com/R3fr3Sh>
@license Dual GPLv2/MIT
]]--


local ITEMID_zeton=3

local legal="Cards images are (c) CC-BY-SA by David Bellot http://www.eludication.org/playingcards.html"

local talia_cala={
--  {	nazwa pliku, wartosc karty (1 dla asa - ale mozliwa wartosc to rowniez 11), blue }
    {"karty/clubs-10-75.png", 10, true},
    {"karty/clubs-2-75.png", 2, true},
    {"karty/clubs-3-75.png", 3, true},
    {"karty/clubs-4-75.png", 4, true},
    {"karty/clubs-5-75.png", 5, true},
    {"karty/clubs-6-75.png", 6, true},
    {"karty/clubs-7-75.png", 7, true},
    {"karty/clubs-8-75.png", 8, true},
    {"karty/clubs-9-75.png", 9, true},
    {"karty/clubs-a-75.png", 1, true},	-- as
    {"karty/clubs-j-75.png", 10, true},
    {"karty/clubs-q-75.png", 10, true},    
    {"karty/clubs-k-75.png", 10, true},
    {"karty/diamonds-10-75.png", 10 },
    {"karty/diamonds-2-75.png", 2},
    {"karty/diamonds-3-75.png", 3},
    {"karty/diamonds-4-75.png", 4},
    {"karty/diamonds-5-75.png", 5},
    {"karty/diamonds-6-75.png", 6},
    {"karty/diamonds-7-75.png", 7},
    {"karty/diamonds-8-75.png", 8},
    {"karty/diamonds-9-75.png", 9},
    {"karty/diamonds-a-75.png", 1},	-- as
    {"karty/diamonds-j-75.png", 10},
    {"karty/diamonds-q-75.png", 10},    
    {"karty/diamonds-k-75.png", 10},
    {"karty/hearts-10-75.png", 10},
    {"karty/hearts-2-75.png", 2},
    {"karty/hearts-3-75.png", 3},
    {"karty/hearts-4-75.png", 4},
    {"karty/hearts-5-75.png", 5},
    {"karty/hearts-6-75.png", 6},
    {"karty/hearts-7-75.png", 7},
    {"karty/hearts-8-75.png", 8},
    {"karty/hearts-9-75.png", 9},
    {"karty/hearts-a-75.png", 1}, --as
    {"karty/hearts-j-75.png", 10},
    {"karty/hearts-q-75.png", 10},
    {"karty/hearts-k-75.png", 10},    
    {"karty/spades-10-75.png", 10,true},
    {"karty/spades-2-75.png", 2,true},
    {"karty/spades-3-75.png", 3,true},
    {"karty/spades-4-75.png", 4,true},
    {"karty/spades-5-75.png", 5,true},
    {"karty/spades-6-75.png", 6,true},
    {"karty/spades-7-75.png", 7,true},
    {"karty/spades-8-75.png", 8,true},
    {"karty/spades-9-75.png", 9,true},
    {"karty/spades-a-75.png", 1,true},	--as
    {"karty/spades-j-75.png", 10,true},
    {"karty/spades-q-75.png", 10,true},
    {"karty/spades-k-75.png", 10,true}
}

local talia_gry={}
local karty_gracza={}
local karty_krupiera={}
local karty_widoczne=false	-- czy wszystkie karty krupiera sa widoczne?

local sw,sh=guiGetScreenSize()

function shuffle(t)
    local n = #t
    while n >= 2 do
    local k = math.random(n) -- 1 <= k <= n
        t[n], t[k] = t[k], t[n]
	n = n - 1
    end
    return t
end

local gui_karta=guiCreateButton(1/3, 17.5/30, 1/10,1/20, "Karta", true)
local gui_pass=guiCreateButton(1.5/3, 17.5/30, 1/10,1/20, "Pass", true)
guiSetVisible(gui_karta, false)
guiSetVisible(gui_pass, false)

function blackjack_init()
	for k,v in ipairs(talia_cala) do
    	table.insert(talia_gry, v)
	end
    shuffle(talia_gry)
    karty_widoczne=false

    karty_gracza={}
    karty_krupiera={}
    
    setElementFrozen(localPlayer,true)
    setCameraMatrix(1130.78,-1.7,1003.2,1130.04,-1.69,1002.52)    
    addEventHandler("onClientRender", root, blackjack_render)
    
    -- wyciagamy 2 karty dla krupiera
    local karta
    karta=table.remove(talia_gry,1)
    table.insert(karty_krupiera,karta)
    karta=table.remove(talia_gry,1)
    table.insert(karty_krupiera,karta)

    -- i jedną karte dla gracza
    karta=table.remove(talia_gry,1)
    table.insert(karty_gracza,karta)
    
    guiSetVisible(gui_karta, true)
    guiSetVisible(gui_pass, true)
    setTimer(function()
        exports["lss-gui"]:panel_show()
	end, 500,1)
end


function blackjack_render()
    -- rozmiar karty 75x107
    -- odstep pomiedzy kartami: 55
    local left=(sw/2)-3.5*55
    if (#karty_krupiera>0) then
	for i,v in ipairs(karty_krupiera) do
		if (not v.alpha) then
		    v.alpha=0
		elseif (v.alpha<255) then
		    v.alpha=v.alpha+16
		end
		if (v.alpha>255) then v.alpha=255 end
		if (i==1 and not karty_widoczne) then -- pierwsza karta zakryta
	        	dxDrawImage(left+((i-1)*55)+(255-v.alpha)/3, 2/3*sh+(i*7%5)-180, 75,107, v[3] and "karty/back-blue-75-2.png" or "karty/back-red-75-2.png", math.sin(i*v[2])*4,0,0,tocolor(255,255,255,v.alpha))
		else
	        	dxDrawImage(left+((i-1)*55)+(255-v.alpha)/3, 2/3*sh+(i*7%5)-180, 75,107, v[1], math.sin(i*v[2])*4+(255-v.alpha)/7,0,0,tocolor(255,255,255,v.alpha))
		end
	end
    end
    if (#karty_gracza>0) then	-- rysujemy karty gracza
	for i,v in ipairs(karty_gracza) do
		if (not v.alpha) then
		    v.alpha=0
		elseif (v.alpha<255) then
		    v.alpha=v.alpha+16
		end
		if (v.alpha>255) then v.alpha=255 end

        	dxDrawImage(left+((i-1)*55)+(255-v.alpha)/3, 2/3*sh+(i*7%5), 75,107, v[1], math.sin(i*v[2])*4+(255-v.alpha)/7,0,0,tocolor(255,255,255,v.alpha))
	end
    end
end

function blackjack_finish()
    setCameraTarget(localPlayer)
    setElementFrozen(localPlayer,false)
    removeEventHandler("onClientRender", root, blackjack_render)
    guiSetVisible(gui_karta, false)
    guiSetVisible(gui_pass, false)
end

function blackjack_calculateValue(talia)	-- zwraca wartosc kart w talii
    local suma=0
    local asy=0
    for i,v in ipairs(talia) do
	suma=suma+v[2]
	if (v[2]==1) then
	    suma=suma+10
	    asy=asy+1
	end
    end
    
    while (suma>21 and asy>0) do
	asy=asy-1
	suma=suma-10
    end
    
    return suma
end

function blackjack_verify()	-- sprawdzamy czy ktos nie wygral!
	outputDebugString("bj1")
    local suma_gracz=blackjack_calculateValue(karty_gracza)
	outputDebugString("bj2")
    local suma_krupier=blackjack_calculateValue(karty_krupiera)
  	outputDebugString("bj3")

    if (suma_gracz==21) then	-- blackjack
	karty_widoczne=true
        guiSetVisible(gui_karta, false)
        guiSetVisible(gui_pass, false)
	triggerEvent("onCaptionedEvent", root, "BLACKJACK! Wygrałeś/aś!", 6)
	exports["lss-gui"]:eq_giveItem(ITEMID_zeton, 150)
	setTimer(blackjack_finish, 4000, 1)
	return
    end
    
    if (suma_krupier==21) then
	karty_widoczne=true
        guiSetVisible(gui_karta, false)
        guiSetVisible(gui_pass, false)
	triggerEvent("onCaptionedEvent", root, "Przegrałeś/aś!", 6)
	setTimer(blackjack_finish, 4000, 1)
	return
    end
    
    
    if (suma_gracz>21) then	-- gracz przekroczyl 21 => przegrywa
	karty_widoczne=true
        guiSetVisible(gui_karta, false)
        guiSetVisible(gui_pass, false)
	triggerEvent("onCaptionedEvent", root, "Przegrałeś/aś!", 6)
	setTimer(blackjack_finish, 4000, 1)
	return
    end
    
    if (suma_krupier>21) then	-- krupier przekroczyl 21 => przegrywa, gracz wygrywa
	karty_widoczne=true
        guiSetVisible(gui_karta, false)
        guiSetVisible(gui_pass, false)
	triggerEvent("onCaptionedEvent", root, "Wygrałeś/aś!", 6)
	exports["lss-gui"]:eq_giveItem(ITEMID_zeton, 150)
	setTimer(blackjack_finish, 4000, 1)
	return
    end
end

function blackjack_pass()
    karty_widoczne=true	-- odkrywamy karty przy pierwszym passie

    guiSetVisible(gui_karta, false)
    guiSetVisible(gui_pass, false)
    
    -- prosty algorytm decydujacy o dzialaniach krupiera
    local suma_gracz=blackjack_calculateValue(karty_gracza)
    local suma_krupier=blackjack_calculateValue(karty_krupiera)
    if (suma_krupier>suma_gracz) then
	-- krupier pasuje i wygrywa
	karty_widoczne=true
        guiSetVisible(gui_karta, false)
        guiSetVisible(gui_pass, false)
		triggerEvent("onCaptionedEvent", root, "Przegrałeś/aś!", 6)
		setTimer(blackjack_finish, 4000, 1)
		return
    else
		while (suma_krupier<21 and #karty_krupiera<7) do
		-- krupier dobiera karte
			local karta
	        karta=table.remove(talia_gry,1)
	        table.insert(karty_krupiera,karta)
			suma_krupier=blackjack_calculateValue(karty_krupiera)
		end
		blackjack_verify()
		return
    end
end

function blackjack_karta()
    if (#karty_gracza>=7) then return end	-- maksymalnie 7 kart
    -- wyciagamy karte z talii
    local karta=table.remove(talia_gry,1)
    table.insert(karty_gracza,karta)
    blackjack_verify()
end

addEventHandler("onClientGUIClick", gui_karta, blackjack_karta)
addEventHandler("onClientGUIClick", gui_pass, blackjack_pass)


function menu_blackjack(argumenty)
	if (guiGetVisible(gui_karta) or guiGetVisible(gui_pass) or isElementFrozen(localPlayer)) then return end
    -- todo kojarzenie krupiera, sprawdzanie odleglosci, sprawdzanie czy stol nie jest zajety
    if (not exports["lss-gui"]:eq_takeItem(ITEMID_zeton, 100)) then
		triggerEvent("onCaptionedEvent", root, "Potrzebujesz 100 żetonów, żeby zagrać w Black Jacka.",3)
		return
    end
    blackjack_init()
end
