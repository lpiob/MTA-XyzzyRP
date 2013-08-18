local D=68
local I=2


local naglosnienie=playSound3D("http://91.121.89.153:7350",1655.23,-1652.14,2571.74,true)
--local naglosnienie=playSound3D("audiodump.ogg",898.42,2511.23,1055.26,true)
setElementInterior(naglosnienie,I)
setElementDimension(naglosnienie,D)
setSoundMinDistance(naglosnienie,5)
setSoundMaxDistance(naglosnienie,30)