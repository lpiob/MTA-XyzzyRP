
function menu_szlaban(argumenty)
--    if (not exports["lss-gui"]:eq_getItemByID(14)) then
--		outputChatBox("Nie masz klucza do bramy.", 255,0,0,true)
--		return
--    end

    triggerServerEvent("onUrzad_miastaSzlabanToggleRequest", resourceRoot, localPlayer)	-- pi
end

