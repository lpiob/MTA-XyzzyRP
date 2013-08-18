--[[
Kasyno - blackjack

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


local I=1
local D=65
local ITEMID_zeton=3


GUI_barek = guiCreateWindow(0.0562,0.6017,0.9,0.1767,"Barek w kasynie",true)
guiSetVisible(GUI_barek,false)
GUI_img={}
GUI_btn={}
GUI_lbl={}
GUI_img.zetony=guiCreateStaticImage(0.02,0.3, 0.05, 0.4, "img/EQ_zeton.png", true, GUI_barek)
GUI_lbl.zetony=guiCreateLabel(0.08,0.3,0.19,0.4,"Żetony do gry w kasynie\n100 żetonow = 100$", true, GUI_barek)
guiLabelSetHorizontalAlign(GUI_lbl.zetony,"center",true)
GUI_btn.zetony_kup=guiCreateButton(0.02, 0.75, 0.08, 0.20, "Kup", true, GUI_barek)
GUI_btn.zetony_sprzedaj=guiCreateButton(0.12, 0.75, 0.08, 0.20, "Sprzedaj", true, GUI_barek)



local barek=createColCuboid(1837.34,-1677.87,1392.00, 1, 5, 1)
setElementDimension(barek,D)
setElementInterior(barek,I)

addEventHandler("onClientColShapeHit", barek, function(hitElement, matchindDimension)
    if (hitElement~=localPlayer or not matchindDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    guiSetVisible(GUI_barek,true)
end,false)

addEventHandler("onClientColShapeLeave", barek, function(hitElement, matchindDimension)
    if (hitElement~=localPlayer or not matchindDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    guiSetVisible(GUI_barek,false)
end,false)

local bclu=getTickCount()

addEventHandler("onClientGUIClick", GUI_btn.zetony_sprzedaj, function()
	if (getTickCount()-bclu<1000) then return end
	bclu=getTickCount()

    local zetony_gracza=exports["lss-gui"]:eq_getItemByID(3)
    if (not zetony_gracza) then    
        triggerEvent("onCaptionedEvent", root, "Nie masz już zadnych żetonów", 2)
	return
    end
    local zetony_na_sprzedaz = zetony_gracza.count > 100 and 100 or zetony_gracza.count
    local cena=zetony_na_sprzedaz	-- /100*100	- 100 zetonow za 100 dolarow
    exports["lss-gui"]:eq_takeItem(ITEMID_zeton, zetony_na_sprzedaz)
    triggerEvent("onCaptionedEvent", root, "Wymieniłeś " .. zetony_na_sprzedaz .. " żetonów na " .. cena .. "$", 2)
    triggerServerEvent("givePlayerMoney", localPlayer, cena)
end, false)



addEventHandler("onClientGUIClick", GUI_btn.zetony_kup, function()
	if (getTickCount()-bclu<1000) then return end
	bclu=getTickCount()

    if (getPlayerMoney()<100) then
	outputChatBox("Nie stać Cię na to.", 255,0,0,true)
	return
    end
    if (exports["lss-gui"]:eq_giveItem(ITEMID_zeton, 100)) then
        triggerEvent("onCaptionedEvent", root, "Kupiłeś 100 żetonów za 100$", 2)
    end
	takePlayerMoney(100)
    triggerServerEvent("takePlayerMoney", localPlayer, 100)

end, false)