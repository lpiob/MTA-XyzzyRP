-- stragan na lotnisku
--[[
local sprzedawca_lotnisko=createPed(0,1667.50,-2262.68,13.53,355.5,false)
addPedClothes(sprzedawca_lotnisko, "sixtyniners", "tshirt", 0)
addPedClothes(sprzedawca_lotnisko, "mohawk","mohawk", 1)
addPedClothes(sprzedawca_lotnisko, "tracktrblue","tracktr", 2)
setElementFrozen(sprzedawca_lotnisko,true)
setElementData(sprzedawca_lotnisko,"npc", true)
setElementData(sprzedawca_lotnisko,"name", "Straganiarz")
-- sklep w inteirorze
--]]
I=2
D=76

local sprzedawca=createPed(0,2436.50,-1942.41,2035.41,0,false)
addPedClothes(sprzedawca, "sixtyniners", "tshirt", 0)
addPedClothes(sprzedawca, "mohawk","mohawk", 1)
addPedClothes(sprzedawca, "tracktrblue","tracktr", 2)


setElementDimension(sprzedawca,D)
setElementInterior(sprzedawca,I)
setElementFrozen(sprzedawca,true)
setElementData(sprzedawca,"npc", true)
setElementData(sprzedawca,"name", "Sprzedawca")