--[[
Obsluga oswietlenia drogowego

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--



setTrafficLightsLocked(true)

-- 3 1 0 4

local stany={3,4,0,1}

local stan=1

local stany_nocne={6,9,6,9}

function zmianaSwiatel()
    stan=stan+1
    if (stan>#stany) then stan=1 end

	local t=getRealTime()
	if (t.hour>=23 or t.hour<=6) then
	    setTrafficLightState(stany_nocne[stan])
	    setTimer(zmianaSwiatel, 500, 1)
	else
	    setTrafficLightState(stany[stan])
	    setTimer(zmianaSwiatel, stan%2==1 and 15000 or 2000, 1)

	end

end


zmianaSwiatel()
