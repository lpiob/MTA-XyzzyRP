local D=10
local I=1

local slusarz=createPed(50,809.64,-492.99,1206.88,90,false)
setElementDimension(slusarz,D)
setElementInterior(slusarz,I)
setElementFrozen(slusarz, true)
setElementData(slusarz,"npc", true)
setElementData(slusarz,"name", "Œlusarz")
setPedAnimation (slusarz, "COP_AMBIENT", "Coplook_loop", -1, true, false )

