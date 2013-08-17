local I=2
local D=5

local sprzedawca=createPed(209,2392.94,-1913.06,2000.64,90,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawca")