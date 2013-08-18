function menu_brama()
	if (not exports["lss-gui"]:eq_getItemByID(20) and not exports["lss-gui"]:eq_getItemByID(56)) then
		outputChatBox("Nie masz klucza do bramy.", 255,0,0,true)
		return
	end
	triggerServerEvent("onPlacMBramaToggleRequest", localPlayer)
end