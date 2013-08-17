local SKIN_ID=51

addEventHandler("onClientResourceStart",resourceRoot,
    function ()
    txd = engineLoadTXD ( "wmomib.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "wmomib.dff", 0 )
    engineReplaceModel ( dff, SKIN_ID )
--	if (getElementModel(localPlayer)==SKIN_ID)	then
--	    triggerServerEvent ("requestSkinFix", getLocalPlayer(), SKIN_ID)
--	end

end)