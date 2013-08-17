local SKIN_ID=62

addEventHandler("onClientResourceStart",resourceRoot,
    function ()
    txd = engineLoadTXD ( "wmoprea.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "wmoprea.dff", 0 )
    engineReplaceModel ( dff, SKIN_ID )
--	if (getElementModel(localPlayer)==SKIN_ID)	then
--	    triggerServerEvent ("requestSkinFix", getLocalPlayer(), SKIN_ID)
--	end

end)