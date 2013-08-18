txd = engineLoadTXD("comet.txd")
engineImportTXD(txd, 589)
dff = engineLoadDFF("comet.dff", 480)
engineReplaceModel(dff, 589)
