local I=2
local D=68

local sprzedawca=createPed(1,1656.22,-1655.79,2571.74, 0,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawca")