local I=2
local D=35

local sprzedawca=createPed(209,667.48,-1862.39,2000.73,270,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawca")