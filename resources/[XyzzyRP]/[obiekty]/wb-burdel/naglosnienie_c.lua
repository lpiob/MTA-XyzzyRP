local D=34
local I=1


local naglosnienie=playSound3D("http://87.230.53.10:9480",2354.70,-1505.08,1481.12,true)
--local naglosnienie=playSound3D("audiodump.ogg",898.42,2511.23,1055.26,true)
setElementInterior(naglosnienie,I)
setElementDimension(naglosnienie,D)
setSoundMinDistance(naglosnienie,10)
setSoundMaxDistance(naglosnienie,50)



local tancerka=createPed(97,2360.16,-1511.26,1481.13,76.9,false)
setElementDimension(tancerka,D)
setElementInterior(tancerka,I)
setElementFrozen(tancerka, true)
setElementData(tancerka, "npc", true)
setPedAnimation ( tancerka, "STRIP", "strip_D", -1, true, false )

local tancerz=createPed(139,2358.96,-1511.00,1481.13,273.4,false)
setElementDimension(tancerz,D)
setElementInterior(tancerz,I)
setElementFrozen(tancerz, true)
setElementData(tancerz, "npc", true)
setPedAnimation ( tancerz, "STRIP", "STR_Loop_A", -1, true, false )

local czlowiek1=createPed(213,2363.38,-1497.49,1481.12,14,false)
setElementDimension(czlowiek1,D)
setElementInterior(czlowiek1,I)
setElementFrozen(czlowiek1, true)
setElementData(czlowiek1, "npc", true)
setPedAnimation ( czlowiek1, "PAULNMAC", "wank_loop", -1, true, false )

local czlowiek2=createPed(237,2360.84,-1497.55,1481.12,0,false)
setElementDimension(czlowiek2,D)
setElementInterior(czlowiek2,I)
setElementFrozen(czlowiek2, true)
setElementData(czlowiek2, "npc", true)
setPedAnimation ( czlowiek2, "MISC", "Scratchballs_01", -1, true, false )

local czlowiek_na_lozku1=createPed(15,2351.55,-1497.87,1481.88,180,false)
setElementDimension(czlowiek_na_lozku1,D)
setElementInterior(czlowiek_na_lozku1,I)
setElementFrozen(czlowiek_na_lozku1, true)
setElementData(czlowiek_na_lozku1, "npc", true)
setPedAnimation ( czlowiek_na_lozku1, "BEACH", "Lay_Bac_Loop", -1, true, false )

local czlowiek_na_lozku2=createPed(77,2351.56,-1498.96,1481.88,0,false)
setElementDimension(czlowiek_na_lozku2,D)
setElementInterior(czlowiek_na_lozku2,I)
setElementFrozen(czlowiek_na_lozku2, true)
setElementData(czlowiek_na_lozku2, "npc", true)
setPedAnimation ( czlowiek_na_lozku2, "BLOWJOBZ", "BJ_COUCH_LOOP_W", -1, true, false )