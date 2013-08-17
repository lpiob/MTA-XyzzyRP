local I=1
local D=33

local sprzedawca=createPed(90,1996.79,-1773.01,1430.48, 0,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawczyni")