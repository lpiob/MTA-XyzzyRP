local D=6
local I=2


local naglosnienie=playSound3D("http://91.121.157.138:7750",2415.74,-1220.88,2000.92,true)
--local naglosnienie=playSound3D("audiodump.ogg",898.42,2511.23,1055.26,true)
setElementInterior(naglosnienie,I)
setElementDimension(naglosnienie,D)
setSoundMinDistance(naglosnienie,10)
setSoundMaxDistance(naglosnienie,50)



local tancerka1=createPed(90,2420.06,-1222.16,2001.33,55,false)
setElementDimension(tancerka1,D)
setElementInterior(tancerka1,I)
setElementFrozen(tancerka1, true)
setElementData(tancerka1, "npc", true)
setPedAnimation ( tancerka1, "STRIP", "strip_D", -1, true, false )

local tancerka2=createPed(63,2429.07,-1229.00,2001.33,135,false)
setElementDimension(tancerka2,D)
setElementInterior(tancerka2,I)
setElementFrozen(tancerka2, true)
setElementData(tancerka2, "npc", true)
setPedAnimation ( tancerka2, "STRIP", "STR_Loop_A", -1, true, false )

local tancerka3=createPed(64,2414.39,-1224.12,2001.33,90,false)
setElementDimension(tancerka3,D)
setElementInterior(tancerka3,I)
setElementFrozen(tancerka3, true)
setElementData(tancerka3, "npc", true)
setPedAnimation ( tancerka3, "STRIP", "STR_Loop_A", -1, true, false )

local tancerka4=createPed(243,2429.57,-1220.35,2001.33,11,false)
setElementDimension(tancerka4,D)
setElementInterior(tancerka4,I)
setElementFrozen(tancerka4, true)
setElementData(tancerka4, "npc", true)
setPedAnimation ( tancerka4, "STRIP", "STR_Loop_A", -1, true, false )


local tancerz1=createPed(18,2424.95,-1223.82,2001.33,348,false)
setElementDimension(tancerz1,D)
setElementInterior(tancerz1,I)
setElementFrozen(tancerz1, true)
setElementData(tancerz1, "npc", true)
setPedAnimation ( tancerz1, "STRIP", "STR_Loop_A", -1, true, false )

local tancerz2=createPed(97,2427.57,-1209.30,2001.34,135,false)
setElementDimension(tancerz2,D)
setElementInterior(tancerz2,I)
setElementFrozen(tancerz2, true)
setElementData(tancerz2, "npc", true)
setPedAnimation ( tancerz2, "STRIP", "STR_Loop_A", -1, true, false )
