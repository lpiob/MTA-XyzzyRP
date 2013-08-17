local D=5
local I=1

local straznik1=createPed(282,1577.11,-1695.40,1460.87,180,false)
setElementDimension(straznik1,D)
setElementInterior(straznik1,I)
setElementFrozen(straznik1, true)
setElementData(straznik1, "npc", true)
setPedAnimation ( straznik1, "COP_AMBIENT", "Coplook_loop", -1, true, false )

local straznik2=createPed(282,1574.11,-1695.40,1460.87,220,false)
setElementDimension(straznik2,D)
setElementInterior(straznik2,I)
setElementFrozen(straznik2, true)
setElementData(straznik2, "npc", true)
setPedAnimation ( straznik2, "DEALER", "DEALER_IDLE", -1, true, false )
