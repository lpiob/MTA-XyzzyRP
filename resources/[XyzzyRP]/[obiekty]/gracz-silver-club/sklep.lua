local I=2
local D=10

local sprzedawca=createPed(257,1721.80,-1764.37,2000.68, 95,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawczyni")