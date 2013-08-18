local D=53
local I=2


local naglosnienie=playSound3D("http://files.kusmierz.be/rmf/70s-1.wma",510.23,-1481.02,2071.39,true)
--local naglosnienie=playSound3D("audiodump.ogg",898.42,2511.23,1055.26,true)
setElementInterior(naglosnienie,I)
setElementDimension(naglosnienie,D)
setSoundMinDistance(naglosnienie,5)
setSoundMaxDistance(naglosnienie,30)