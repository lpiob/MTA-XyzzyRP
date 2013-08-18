-- 1700.01,248.84,1420.32,38.7
local D=15
local I=1
local o1=createPed(math.random(163,164),1700.01,248.84,1420.32,38.7,false)
setElementInterior(o1,I)
setElementDimension(o1,D)
setElementData(o1,"npc", true)
setElementData(o1,"name","Ochroniarz")
setPedAnimation ( o1, "COP_AMBIENT", "Coplook_loop", -1, true, false )
setElementFrozen(o1,true)



local o2=createPed(math.random(163,164),1665.01,259.55,1420.31,160.9,false)
setElementInterior(o2,I)
setElementDimension(o2,D)
setElementData(o2,"npc", true)
setElementData(o2,"name","Ochroniarz")
setPedAnimation ( o2, "COP_AMBIENT", "Coplook_loop", -1, true, false )
setElementFrozen(o2,true)


