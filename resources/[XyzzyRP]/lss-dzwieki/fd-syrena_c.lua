local I=0
local D=0

local marker=createMarker(913.47,-1256.46,14.61,"cylinder",1,0,0,0,100)
setElementInterior(marker,I)
setElementDimension(marker,D)

syrena_win = guiCreateWindow(0.7766,0.3042,0.1766,0.5167,"Syrena",true)
guiSetVisible(syrena_win, false)
syrena_lbl = guiCreateLabel(0.0885,0.1169,0.7965,0.1935,"Tylko dla straży pożarnej!",true,syrena_win)
guiLabelSetHorizontalAlign(syrena_lbl, "center", true)
syrena_btnon = guiCreateButton(0.1062,0.3508,0.7788,0.4702,"Uruchom",true,syrena_win)

addEventHandler("onClientMarkerHit", marker, function(el,md)
	if not md or el~=localPlayer then return end
	guiSetVisible(syrena_win,true)
end)
addEventHandler("onClientMarkerLeave", marker, function(el,md)
	if el~=localPlayer then return end
	guiSetVisible(syrena_win,false)
end)

addEventHandler("onClientGUIClick", syrena_btnon, function()
	local fid=getElementData(localPlayer, "faction:id")
	if not fid or tonumber(fid)~=11 then
		outputChatBox("Nie masz kluczy do tego alarmu.", 255,0,0)
		return
	end
	local lfrankid=getElementData(localPlayer, "faction:rank_id")
	if not lfrankid or tonumber(lfrankid)<1 then
		outputChatBox("Nie masz kluczy do tego alarmu.", 255,0,0)
		return
	end
	triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " uruchamia syrenę alarmową.", 15, 9, true)
	triggerServerEvent("broadcastSound3D", localPlayer, "fd-syrena.ogg", 2000,500,10*1000, "Niedaleko Ciebie rozlega się dźwięk syreny alarmowej straży pożarnej.", "W oddali słychać dźwięk syreny alarmowej straży pożarnej.")

end, false)