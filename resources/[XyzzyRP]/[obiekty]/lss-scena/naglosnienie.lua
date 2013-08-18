local CHANGE_INTERVAL=60000
local scena=createColSphere(531.09,-1916.91,7.96,170)
local scena_lc=getTickCount()-CHANGE_INTERVAL
setElementInterior(scena, 0)
setElementDimension(scena, 0)

setElementData(scena,"audio", { "http://188.165.21.29:3500",531.09,-1916.91,7.96,0, 0, 45, 170} )


addCommandHandler("muza1", function(plr,cmd,strumien)
	setElementData(scena,"audio", { strumien,531.09,-1916.91,7.96,0, 0, 45, 170} )
end)

-- triggerServerEvent("doChangeAudio", resourceRoot, localPlayer, strumien)

addEvent("doChangeAudio", true)
addEventHandler("doChangeAudio", resourceRoot, function(plr, strumien, opis)
	if getTickCount()-scena_lc<CHANGE_INTERVAL then
		outputChatBox("(( Zmiana muzyki na scenie możliwa za 60 sekund ))", plr)
		return
	end
	scena_lc=getTickCount()
    for i,v in ipairs(getElementsByType("player")) do
		triggerClientEvent(plr, "doHideWindows", resourceRoot)
	end
	setElementData(scena,"audio", { strumien,531.09,-1916.91,7.96,0, 0, 45, 170} )
end)