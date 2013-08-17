local SKIN_ID=52

addEventHandler("onClientResourceStart",resourceRoot,
    function ()
    txd = engineLoadTXD ( "bmymib.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "bmymib.dff", 0 )
    engineReplaceModel ( dff, SKIN_ID )
--	if (getElementModel(localPlayer)==SKIN_ID)	then
--	    triggerServerEvent ("requestSkinFix", getLocalPlayer(), SKIN_ID)
--	end

end)