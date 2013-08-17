local ITEMID_SMIEC=9

function menu_wysypSmieci(args)
    local waga=args.obiekt
    local x,y,z=getElementPosition(waga)
    local x2,y2,z2=getElementPosition(localPlayer)
    if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>5) then
	outputChatBox("Podejdź bliżej do wagi.", 255,0,0,true)
	return
    end
    local smieci_gracza=exports["lss-gui"]:eq_getItemByID(ITEMID_SMIEC)
    if (not smieci_gracza) then
	outputChatBox("Nie masz żadnych śmieci.", 255,0,0,true)
	return
    end
    triggerServerEvent("onWymianaSmieci", localPlayer, smieci_gracza.count)
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wysypuje śmieci na wagę.", 5, 15, true)
    
end