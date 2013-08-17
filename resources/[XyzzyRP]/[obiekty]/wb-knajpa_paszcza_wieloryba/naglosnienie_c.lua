local D=41
local I=2


local naglosnienie=playSound3D("http://188.165.22.29:8750",1372.58,249.48,2071.74,true)
--local naglosnienie=playSound3D("audiodump.ogg",898.42,2511.23,1055.26,true)
setElementInterior(naglosnienie,I)
setElementDimension(naglosnienie,D)
setSoundMinDistance(naglosnienie,5)
setSoundMaxDistance(naglosnienie,30)