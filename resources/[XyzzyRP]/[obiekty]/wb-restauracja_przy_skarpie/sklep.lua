local I=2
local D=63

local sprzedawca=createPed(209,1566.99,-1881.23,2007.56,180,false)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawca")