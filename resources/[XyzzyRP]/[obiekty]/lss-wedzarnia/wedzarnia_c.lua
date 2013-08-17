function wedzenie()
    if (getPlayerMoney()<1) then
	outputChatBox("Nie stać Cię na to.", 255,0,0,true)
	return
    end
    local ryby_gracza=exports["lss-gui"]:eq_getItemByID(8)	-- 8 surowa ryba
    if (not ryby_gracza) then
	outputChatBox("Nie masz żadnych surowych ryb.", 255,0,0,true)
	return
    end
    local ryby_do_uwedzenia=ryby_gracza.count > 10 and 10 or ryby_gracza.count
    if (exports["lss-gui"]:eq_giveItem(10,ryby_do_uwedzenia)) then
        triggerServerEvent("takePlayerMoney", localPlayer, ryby_do_uwedzenia)
	exports["lss-gui"]:eq_takeItem(8,ryby_do_uwedzenia)
    end

end

GUI_barek = guiCreateWindow(0.3,0.6017,0.4,0.1767,"Wędzarnia",true)
guiSetVisible(GUI_barek,false)
GUI_img={}
GUI_img.ryba1=guiCreateStaticImage(0.1,0.4, 0.4, 0.4, "wedzarnia.png", true, GUI_barek)
GUI_lbl=guiCreateLabel(0.1,0.75,0.4,0.15,"10 ryb = 10$", true, GUI_barek)
GUI_btn=guiCreateButton(0.6, 0.4, 0.3, 0.4, "Uwędź", true, GUI_barek)
guiLabelSetHorizontalAlign(GUI_lbl,"center",true)
addEventHandler("onClientGUIClick", GUI_btn, wedzenie, false)

local barek=createColSphere(1034.93,-1866.50,13.58,1)

addEventHandler("onClientColShapeHit", barek, function(hitElement, matchindDimension)
    if (hitElement~=localPlayer or not matchindDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    guiSetVisible(GUI_barek,true)
end,false)

addEventHandler("onClientColShapeLeave", barek, function(hitElement, matchindDimension)
    if (hitElement~=localPlayer or not matchindDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    guiSetVisible(GUI_barek,false)
end,false)

