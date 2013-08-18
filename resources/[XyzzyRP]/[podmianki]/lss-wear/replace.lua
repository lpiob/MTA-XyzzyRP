rootElement = getRootElement()
function loadobj()

	--kominiarka
	txd15 = engineLoadTXD('lrp_cagoule.txd')
	engineImportTXD(txd15, 9000)
	dff15 = engineLoadDFF('lrp_cagoule.dff', 9000)
	engineReplaceModel(dff15, 9000)
	
	
	--torba medyczna
	txd15 = engineLoadTXD('rpit_medic_bag.txd')
	engineImportTXD(txd15, 9001)
	dff15 = engineLoadDFF('rpit_medic_bag.dff', 9001)
	engineReplaceModel(dff15, 9001)
	
	--kamizelka
	txd15 = engineLoadTXD('lrp_kevlars.txd')
	engineImportTXD(txd15, 9002)
	dff15 = engineLoadDFF('lrp_kevlar.dff', 9002)
	engineReplaceModel(dff15, 9002)
	
	--kamizelka(pd)
	txd15 = engineLoadTXD('lrp_kevlars.txd')
	engineImportTXD(txd15, 904)
	dff15 = engineLoadDFF('lrp_kevlar_pd.dff', 904)
	engineReplaceModel(dff15, 904)
	
	engineImportTXD(txd15, 2053)
	dff15 = engineLoadDFF('lrp_kevlar.dff', 2053)
	engineReplaceModel(dff15, 2053)
	
	--iphone
	txd15 = engineLoadTXD('lrp_phones.txd')
	engineImportTXD(txd15, 2006)
	dff15 = engineLoadDFF('lrp_phone1.dff', 2006)
	engineReplaceModel(dff15, 2006)
	
	--barierka blokujaca droge
	txd15 = engineLoadTXD('speed_bumps.txd')
	engineImportTXD(txd15, 16102)
	col = engineLoadCOL('vehicle_barrier01.col')
	dff15 = engineLoadDFF('vehicle_barrier01.dff', 16102)
	engineReplaceCOL(col, 16102)
	engineReplaceModel(dff15, 16102)
	
	--mikrofon fapfap
	txd15 = engineLoadTXD('lrp_micro.txd')
	engineImportTXD(txd15, 333)
	col = engineLoadCOL('lrp_micro.col')
	dff15 = engineLoadDFF('lrp_micro.dff', 333)
	engineReplaceCOL(col, 333)
	engineReplaceModel(dff15, 333)
	
	--zwloki
	txd15 = engineLoadTXD('corpse_system.txd')
	engineImportTXD(txd15, 2749)
	col = engineLoadCOL('lrp_morguebag.col')
	dff15 = engineLoadDFF('lrp_morguebag.dff', 2749)
	engineReplaceCOL(col, 2749)
	engineReplaceModel(dff15, 2749)
	
	--plecak
	txd15 = engineLoadTXD('lrp_eastpak.txd')
	engineImportTXD(txd15, 2752)
	dff15 = engineLoadDFF('lrp_eastpak.dff', 2752)
	engineReplaceModel(dff15, 2752)
	
	--torebka
	txd15 = engineLoadTXD('lrp_sacepaule.txd')
	engineImportTXD(txd15, 2437)
	dff15 = engineLoadDFF('lrp_sacepaule.dff', 2437)
	engineReplaceModel(dff15, 2437)
	
	
	--laptop
	txd15 = engineLoadTXD('lrp_laptops.txd')
	engineImportTXD(txd15, 2052)
	dff15 = engineLoadDFF('lrp_laptop1.dff', 2052)
	engineReplaceModel(dff15, 2052)

	--prezent
	txd15 = engineLoadTXD('XmasBox1.txd')
	engineImportTXD(txd15, 2694)
	dff15 = engineLoadDFF('XmasBox1.dff', 2694)
	engineReplaceModel(dff15, 2694)
	
	--bankomat
	txd15 = engineLoadTXD('lrp_atm.txd')
	engineImportTXD(txd15, 2618)
	dff15 = engineLoadDFF('lrp_atm.dff', 2618)
	engineReplaceModel(dff15, 2618)
end
addEventHandler('onClientResourceStart', rootElement, loadobj)