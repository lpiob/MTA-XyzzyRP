local I=2
local D=52

local sprzedawca=createPed(31,1818.63,-1056.60,2181.54,225,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawczyni")