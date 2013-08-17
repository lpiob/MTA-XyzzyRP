local I=2
local D=60

local sprzedawca=createPed(1,2477.65,-1537.46,2098.77, 0,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawca")