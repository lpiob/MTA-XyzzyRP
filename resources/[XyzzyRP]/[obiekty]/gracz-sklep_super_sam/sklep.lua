local I=2
local D=20

local sprzedawca=createPed(31,234.62,-163.61,2181.54,212.6,225,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawczyni")