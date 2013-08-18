local I=2
local D=12

local sprzedawca=createPed(31,1346.65,-1761.40,2035.48,261.8,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawczyni")