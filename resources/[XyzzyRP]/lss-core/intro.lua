--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--



local T_OPIS="Trwa pobieranie zasobow serwera"
local T_STOPKA="http://github.com/lpiob/MTA-XyzzyRP"

intro_watchers={}

addEventHandler ( "onPlayerJoin", getRootElement(), function()
	showPlayerHudComponent(source, "all", false)
	showChat(source, false)
	intro_watchers[source]={}

	intro_watchers[source].introTextDisplay = textCreateDisplay()
	intro_watchers[source].serverText={}
	intro_watchers[source].serverText[1] = textCreateTextItem ( "XyzzyRP", 0.5, 0.1, 2, 255,255,255, 255, 3.0, "center", "center",127 )    -- create a text item for the display

	textDisplayAddText ( intro_watchers[source].introTextDisplay, intro_watchers[source].serverText[1] )

	intro_watchers[source].serverText[2] = textCreateTextItem (  T_OPIS, 0.5, 0.5, 2, 255,255,255, 255, 1.2, "center", "center",127 )    -- create a text item for the display
	textDisplayAddText ( intro_watchers[source].introTextDisplay, intro_watchers[source].serverText[2] )
	intro_watchers[source].serverText[3] = textCreateTextItem (  T_STOPKA, 0.5, 0.89, 2, 55,55,255, 255, 1.2, "center", "bottom",127 )
	textDisplayAddText ( intro_watchers[source].introTextDisplay, intro_watchers[source].serverText[3] )

	fadeCamera(source, true)
	textDisplayAddObserver ( intro_watchers[source].introTextDisplay, source )
end)

function onResourcesDownloaded()
--	intro_watchers[client]=nil
	if (intro_watchers[source]) then
		textDisplayRemoveObserver ( intro_watchers[source].introTextDisplay, source )
		introRemoveWatcher(source)
		onPlayerDownloadFinished(source)
	end
	
end

addEvent("onResourcesDownloaded", true)
addEventHandler("onResourcesDownloaded", getRootElement(), onResourcesDownloaded)

function introRemoveWatcher(plr)
	textDestroyTextItem(intro_watchers[plr].serverText[1])
	textDestroyTextItem(intro_watchers[plr].serverText[2])
	textDestroyTextItem(intro_watchers[plr].serverText[3])
	textDestroyDisplay(intro_watchers[plr].introTextDisplay)
	intro_watchers[plr]=nil
	showPlayerHudComponent(plr,"all",true)
	fadeCamera(plr,true)
	showChat(plr, true)
end


addEventHandler ( "onPlayerQuit", getRootElement(), function()
	if (intro_watchers[source] and intro_watchers[source].introTextDisplay) then
		textDestroyTextItem(intro_watchers[source].serverText[1])
		textDestroyTextItem(intro_watchers[source].serverText[2])
		textDestroyTextItem(intro_watchers[source].serverText[3])
		textDestroyDisplay(intro_watchers[source].introTextDisplay)
	end
	intro_watchers[source]=nil
end)