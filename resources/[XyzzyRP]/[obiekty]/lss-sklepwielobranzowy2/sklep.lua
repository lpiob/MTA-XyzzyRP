local I=2
local D=73

local sprzedawca=createPed(0,2060.59,-1790.41,1635.41,0,false)
addPedClothes(sprzedawca, "sixtyniners", "tshirt", 0)
addPedClothes(sprzedawca, "mohawk","mohawk", 1)
addPedClothes(sprzedawca, "tracktrblue","tracktr", 2)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawca")