local I=1
local D=12

local sprzedawca=createPed(171,892.25,2472.56,1054.39,315.5,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Barman")