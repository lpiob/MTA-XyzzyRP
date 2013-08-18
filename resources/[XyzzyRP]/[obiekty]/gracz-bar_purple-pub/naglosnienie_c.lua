local D=60
local I=2


local naglosnienie=playSound3D("http://188.165.22.29:8750",2478.42,-1535.01,2098.40,true)
--local naglosnienie=playSound3D("audiodump.ogg",898.42,2511.23,1055.26,true)
setElementInterior(naglosnienie,I)
setElementDimension(naglosnienie,D)
setSoundMinDistance(naglosnienie,10)
setSoundMaxDistance(naglosnienie,20)