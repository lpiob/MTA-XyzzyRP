
function menu_drzwi1(argumenty)
--    if (not exports["lss-gui"]:eq_getItemByID(14)) then
--		outputChatBox("Nie masz klucza do bramy.", 255,0,0,true)
--		return
--    end

    triggerServerEvent("onUM_Drzwi1ToggleRequest", resourceRoot, localPlayer)	-- pi
end

