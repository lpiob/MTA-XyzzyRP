v=504
txd = engineLoadTXD("bandito.txd")
engineImportTXD(txd, v)
dff = engineLoadDFF("bandito.dff", v)
engineReplaceModel(dff, v)
