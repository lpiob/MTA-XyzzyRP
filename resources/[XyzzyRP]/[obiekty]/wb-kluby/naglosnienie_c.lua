local D=12
local I=1

local nazewnatrz=playSound3D("audiodump.ogg", 1048.65,-1420.76,13.55,true)
setSoundVolume(nazewnatrz,0.2)
setSoundMaxDistance(nazewnatrz,60)


local naglosnienie=playSound3D("http://www.bassdrive.com/v2/streams/BassDrive6.pls",898.42,2511.23,1055.26,true)
--local naglosnienie=playSound3D("audiodump.ogg",898.42,2511.23,1055.26,true)
setElementInterior(naglosnienie,I)
setElementDimension(naglosnienie,D)
setSoundMinDistance(naglosnienie,45)
setSoundMaxDistance(naglosnienie,100)



local tancerka=createPed(246,937.54,2498.62,1054.83,132.3,false)
setElementDimension(tancerka,D)
setElementInterior(tancerka,I)
setElementFrozen(tancerka, true)
setElementData(tancerka, "npc", true)
--setPedAnimation ( tancerka, "STRIP", "strip_G", -1, true, false )
setPedAnimation ( tancerka, "STRIP", "STR_C2", -1, true, false )