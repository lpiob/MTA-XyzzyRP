local D=10
local I=2

local naglosnienie=playSound3D("http://91.121.164.186:9350",1710.47,-1757.26,2000.68,true)
--local naglosnienie=playSound3D("audiodump.ogg",898.42,2511.23,1055.26,true)
setElementInterior(naglosnienie,I)
setElementDimension(naglosnienie,D)
setSoundMinDistance(naglosnienie,10)
setSoundMaxDistance(naglosnienie,20)
