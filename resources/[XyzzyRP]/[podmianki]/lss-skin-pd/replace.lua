addEventHandler("onClientResourceStart",resourceRoot,
    function ()


	SKIN_ID=246
    txd = engineLoadTXD ( "policjantka_biala.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "policjantka_biala.dff", SKIN_ID )
    engineReplaceModel ( dff, SKIN_ID )

	SKIN_ID=265
    txd = engineLoadTXD ( "policjant_czarny_2.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "policjant_czarny_2.dff", SKIN_ID )
    engineReplaceModel ( dff, SKIN_ID )

	SKIN_ID=280
    txd = engineLoadTXD ( "kadet.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "kadet.dff", SKIN_ID )
    engineReplaceModel ( dff, SKIN_ID )

	SKIN_ID=281
    txd = engineLoadTXD ( "policjant_bialy.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "policjant_bialy.dff", SKIN_ID )
    engineReplaceModel ( dff, SKIN_ID )


	SKIN_ID=282
    txd = engineLoadTXD ( "policjant_bialy_2.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "policjant_bialy_2.dff", SKIN_ID )
    engineReplaceModel ( dff, SKIN_ID )

	SKIN_ID=283
    txd = engineLoadTXD ( "policjant_bialy_3.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "policjant_bialy_3.dff", SKIN_ID )
    engineReplaceModel ( dff, SKIN_ID )

	SKIN_ID=284
    txd = engineLoadTXD ( "policjant_czarny.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "policjant_czarny.dff", SKIN_ID )
    engineReplaceModel ( dff, SKIN_ID )	
	
	SKIN_ID=288
    txd = engineLoadTXD ( "policjant_bialy_4.txd" )
    engineImportTXD ( txd, SKIN_ID )
    dff = engineLoadDFF ( "policjant_bialy_4.dff", SKIN_ID )
    engineReplaceModel ( dff, SKIN_ID )





end)