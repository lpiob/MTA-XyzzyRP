function replaceTXD() 

txd = engineLoadTXD("textures/Ground.txd")
  engineImportTXD(txd, 13100)

txd2 = engineLoadTXD("textures/Walls.txd")
  engineImportTXD(txd2, 13370)
  engineImportTXD(txd2, 13371)

txd3 = engineLoadTXD("textures/Entrance.txd")
  engineImportTXD(txd3, 13157)

txd4 = engineLoadTXD("textures/House.txd")
  engineImportTXD(txd4, 18267)
  engineImportTXD(txd4, 18259)

txd5 = engineLoadTXD("textures/Rocks.txd")
  engineImportTXD(txd5, 18225)

txd6 = engineLoadTXD("textures/Trees.txd")
  engineImportTXD(txd6, 689)

txd7 = engineLoadTXD("textures/Walls2.txd")
  engineImportTXD(txd7, 18300)

txd8 = engineLoadTXD("textures/Plants.txd")
  engineImportTXD(txd8, 825)

txd9 = engineLoadTXD("textures/Plants2.txd")
  engineImportTXD(txd9, 820)
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceTXD)