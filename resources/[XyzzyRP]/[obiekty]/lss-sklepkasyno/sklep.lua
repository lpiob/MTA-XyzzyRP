local I=12
local D=2
local sprzedawca=createPed(169,1141.16,-7.28,1000.67,86.3,false)
addPedClothes(sprzedawca, "sixtyniners", "tshirt", 0)
addPedClothes(sprzedawca, "mohawk","mohawk", 1)
addPedClothes(sprzedawca, "tracktrblue","tracktr", 2)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawca")

