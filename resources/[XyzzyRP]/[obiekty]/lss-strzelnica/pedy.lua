local I=4
local D=18
local sprzedawca=createPed(1,298.46,-82.53,1001.52,358.0,false)
setElementDimension(sprzedawca, D)
setElementInterior(sprzedawca, I)
setElementData(sprzedawca,"npc",true)
setElementData(sprzedawca,"name","Sprzedawca")
setElementFrozen(sprzedawca, true)

local bouncer=createPed(164, 293.88,-77.99,1001.52,179.7,false)
setElementInterior(bouncer, I)
setElementDimension(bouncer, D)
setElementData(bouncer,"npc",true)
setElementData(bouncer,"name","Ochroniarz")
setElementFrozen(bouncer, true)

bouncer=createPed(164, 288.15,-85.45,1001.52,95.5,false)
setElementInterior(bouncer, I)
setElementDimension(bouncer, D)
setElementData(bouncer,"npc",true)
setElementData(bouncer,"name","Ochroniarz")
setElementFrozen(bouncer, true)


local t_zwrot=createElement("text")
setElementPosition(t_zwrot,295.29,-78.98,1004.52)
setElementDimension(t_zwrot,D)
setElementInterior(t_zwrot,I)
setElementData(t_zwrot,"text","Broń\ndo zwrotu!")