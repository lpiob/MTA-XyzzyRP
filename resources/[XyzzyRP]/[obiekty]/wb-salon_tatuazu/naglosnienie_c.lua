local D=50
local I=2

local nazewnatrz=playSound3D("audio/maszynka.ogg", 2095.02,-1207.76,1702.27,true)	--parking kolo urzedu
setSoundVolume(nazewnatrz,0.5)
setSoundMaxDistance(nazewnatrz,3)
setElementDimension(nazewnatrz,D)
setElementInterior(nazewnatrz,I)