addEventHandler("onClientResourceStart",resourceRoot,
    function ()


	SKIN_ID=64
    txd = engineLoadTXD ( "64.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "64.dff", SKIN_ID )
    engineReplaceModel ( dff, SKIN_ID )
	
	SKIN_ID=279
    txd = engineLoadTXD ( "279.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "279.dff", SKIN_ID )
    engineReplaceModel ( dff, SKIN_ID )



end)