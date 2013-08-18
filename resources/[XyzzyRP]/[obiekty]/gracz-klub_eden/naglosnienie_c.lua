local D=69
local I=2

local naglosnienie=playSound3D("http://stream.blackbeatslive.de:80/",970.81,-1743.21,2200.68,true)
--local naglosnienie=playSound3D("audiodump.ogg",898.42,2511.23,1055.26,true)
setElementInterior(naglosnienie,I)
setElementDimension(naglosnienie,D)
setSoundMinDistance(naglosnienie,10)
setSoundMaxDistance(naglosnienie,20)
