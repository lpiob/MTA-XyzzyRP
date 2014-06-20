--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- kosz - 1343, 1329　　worek - 1264,　　 śmieci - 2672, 924
-- 926, 2673
local smieci={ 2672, 924, 926, 2673}
local pos={2598.55,-2430.63,13.46,181.4}

local t=""

for i=1,100 do
    local radius=math.random(5,100)
    local kat=math.random(0,360)
    local x=pos[1]+(radius*math.sin(kat))
    local y=pos[2]+(radius*math.cos(kat))
    local z=getGroundPosition(x,y,pos[3])

    if (z and z>0) then
	local oid=smieci[math.random(1,#smieci)]
        local obiekt=createObject(oid, x, y,z)
        setElementDoubleSided(obiekt,true)
	t=t .. string.format("{%.1f, %.1f, %.2f},\n", x,y,z)
    end
end

setClipboard(t)