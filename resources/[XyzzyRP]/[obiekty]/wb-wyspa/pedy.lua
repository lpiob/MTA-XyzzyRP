local D=55
local I=1

local portier=createPed(54,3574.08 -1303.40 1625.80,180,false)
setElementDimension(portier,D)
setElementInterior(portier,I)
setElementFrozen(portier, true)
setElementData(portier, "npc", true)
setPedAnimation (portier, "COP_AMBIENT", "Coplook_loop", -1, true, false )