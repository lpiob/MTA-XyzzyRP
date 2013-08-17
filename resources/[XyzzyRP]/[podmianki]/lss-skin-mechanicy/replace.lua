addEventHandler("onClientResourceStart",resourceRoot,
    function ()

	SKIN_ID=32
    txd = engineLoadTXD ( "32.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "32.dff", SKIN_ID )
    engineReplaceModel ( dff, SKIN_ID )
	

end)