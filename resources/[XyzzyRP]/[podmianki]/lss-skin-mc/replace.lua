local SKIN_ID=244

addEventHandler("onClientResourceStart",resourceRoot,
    function ()


	SKIN_ID=219
    txd = engineLoadTXD ( "lekarka.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "lekarka.dff", SKIN_ID )
    engineReplaceModel ( dff, SKIN_ID )



end)