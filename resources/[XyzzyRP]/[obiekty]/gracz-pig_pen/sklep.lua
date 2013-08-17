local I=2
local D=6

local sprzedawca=createPed(63,2421.09,-1233.26,2000.92, 0,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawczyni")