local I=1
local D=29

local sprzedawca=createPed(34,1034.24,-1403.98,1438.41, 270,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawca")