local I=2
local D=13

local sprzedawca=createPed(1,1346.65,-1761.49,2035.48, 270,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawca")