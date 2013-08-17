local D=21
local I=1

local stenograf=createPed(9,1406.53,-1099.03,1442.41,90,false)
setElementDimension(stenograf,D)
setElementInterior(stenograf,I)
setElementFrozen(stenograf, true)
setElementData(stenograf, "npc", true)
setPedAnimation (stenograf, "INT_OFFICE", "OFF_Sit_Type_Loop", -1, true, false )
