rootElement = getRootElement()
function loadobj()


	txd15 = engineLoadTXD('MatColours.txd')
	engineImportTXD(txd15, 3964)
	col15 = engineLoadCOL('PoliceLight1.col')
	dff15 = engineLoadDFF('PoliceLight1.dff', 3964)
	engineReplaceCOL(col15, 3964)
	engineReplaceModel(dff15, 3964)


	txd16 = engineLoadTXD('MatTextures.txd')
	engineImportTXD(txd16, 3962)
	col16 = engineLoadCOL('RedNeonTube1.col')
	dff16 = engineLoadDFF('RedNeonTube1.dff', 3962)
	engineReplaceCOL(col16, 3962)
	engineReplaceModel(dff16, 3962)

	engineImportTXD(txd16, 2113)
	col17 = engineLoadCOL('BlueNeonTube1.col')
	dff17 = engineLoadDFF('BlueNeonTube1.dff', 2113)
	engineReplaceCOL(col17, 2113)
	engineReplaceModel(dff17, 2113)

	engineImportTXD(txd16, 1784)
	col18 = engineLoadCOL('GreenNeonTube1.col')
	dff18 = engineLoadDFF('GreenNeonTube1.dff', 1784)
	engineReplaceCOL(col18, 1784)
	engineReplaceModel(dff18, 1784)

	engineImportTXD(txd16, 2054)
	col19 = engineLoadCOL('YellowNeonTube1.col')
	dff19 = engineLoadDFF('YellowNeonTube1.dff', 2054)
	engineReplaceCOL(col19, 2054)
	engineReplaceModel(dff19, 2054)

	engineImportTXD(txd16, 2428)
	col20 = engineLoadCOL('PinkNeonTube1.col')
	dff20 = engineLoadDFF('PinkNeonTube1.dff', 2428)
	engineReplaceCOL(col20, 2428)
	engineReplaceModel(dff20, 2428)
	engineReplaceCOL(col20, 2428)

	engineImportTXD(txd16, 2352)
	col21 = engineLoadCOL('WhiteNeonTube1.col')
	dff21 = engineLoadDFF('WhiteNeonTube1.dff', 2352)
	engineReplaceCOL(col21, 2352)
	engineReplaceModel(dff21, 2352)
	engineReplaceCOL(col21, 2352)


end
addEventHandler('onClientResourceStart', rootElement, loadobj)