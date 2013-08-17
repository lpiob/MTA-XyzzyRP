local D=0
local I=0


local robotnik1=createPed(260,1324.76,-1397.97,13.33,309,false)
setElementDimension(robotnik1,D)
setElementInterior(robotnik1,I)
setElementFrozen(robotnik1, true)
setElementData(robotnik1, "npc", true)
setPedAnimation ( robotnik1, "COP_AMBIENT", "Copbrowse_nod", -1, true, false )

local robotnik2=createPed(27,1238.16,-1405.84,13.00,111,false)
setElementDimension(robotnik2,D)
setElementInterior(robotnik2,I)
setElementFrozen(robotnik2, true)
setElementData(robotnik2, "npc", true)
setPedAnimation ( robotnik2, "DEALER", "DEALER_IDLE", -1, true, false )

local robotnik3=createPed(108,1135.80,-1402.41,17.05,202,false)
setElementDimension(robotnik3,D)
setElementInterior(robotnik3,I)
setElementFrozen(robotnik3, true)
setElementData(robotnik3, "npc", true)
setPedAnimation ( robotnik3, "WUZI", "Wuzi_grnd_chk", -1, true, false )

local robotnik4=createPed(27,1060.01,-1409.73,13.42,26,false)
setElementDimension(robotnik4,D)
setElementInterior(robotnik4,I)
setElementFrozen(robotnik4, true)
setElementData(robotnik4, "npc", true)
setPedAnimation ( robotnik4, "FAT", "IDLE_tired", -1, true, false )


local robotnik5=createPed(108,1152.74,-1395.89,14.44,303,false)
setElementDimension(robotnik5,D)
setElementInterior(robotnik5,I)
setElementFrozen(robotnik5, true)
setElementData(robotnik5, "npc", true)
setPedAnimation ( robotnik5, "BEACH", "ParkSit_M_loop", -1, true, false )

local robotnik6=createPed(260,1149.99,-1397.84,13.57,267,false)
setElementDimension(robotnik6,D)
setElementInterior(robotnik6,I)
setElementFrozen(robotnik6, true)
setElementData(robotnik6, "npc", true)
setPedAnimation ( robotnik6, "BEACH", "ParkSit_W_loop", -1, true, false )

local robotnik7=createPed(260,798.89,-986.10,33.84,269,false)
setElementDimension(robotnik7,D)
setElementInterior(robotnik7,I)
setElementFrozen(robotnik7, true)
setElementData(robotnik7, "npc", true)
setPedAnimation ( robotnik7, "GANGS", "leanIDLE", -1, true, false )

local robotnik8=createPed(27,797.80,-1042.33,24.68,30,false)
setElementDimension(robotnik8,D)
setElementInterior(robotnik8,I)
setElementFrozen(robotnik8, true)
setElementData(robotnik8, "npc", true)
setPedAnimation ( robotnik8, "COP_AMBIENT", "Coplook_loop", -1, true, false )
