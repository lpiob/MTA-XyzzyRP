--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local dzwonnice={
--  nazwa={ x,y,z, zasieg, [dzwiek="] }
    -- ls centrum handlowe
    lsch={ 1098.35,-1419.67,45.12, 100, dzwiek="audio/dzwon2.ogg" },
    -- ls urzad miasta
    lsum={ 1481.79,-1781.70,146.90,300, dzwiek="audio/dzwon2.ogg" },
    -- kosciol w Jefferon
    jefferson={ 2253.00,-1311.14,50.46,100 }
}


addEvent("onPelnaGodzina",true)

addEventHandler("onPelnaGodzina", getRootElement(), function()
    for _,d in pairs(dzwonnice) do    
--        setSoundMaxDistance(playSound3D( d.dzwiek or "audio/dzwon.ogg", d[1],d[2],d[3], false), d[4])
	for i=1,9 do
		setTimer(function()
			setSoundMaxDistance(playSound3D( "audio/dzwon-single.mp3", d[1],d[2],d[3], false), d[4])
			local x,y,z=getElementPosition(localPlayer)
			local distance=getDistanceBetweenPoints3D(d[1],d[2],d[3],x,y,z)
			if (distance<(d[4]/5)) then
		    	    triggerEvent("onCaptionedEvent", resourceRoot, "*BOOM*", 1)
			elseif (distance<(d[4]/1.5)) then
			    triggerEvent("onCaptionedEvent", resourceRoot, "*BOM*", 1)
		    	elseif (distance<d[4]) then	    
		    	    triggerEvent("onCaptionedEvent", resourceRoot, "*bom*", 1)
			end
		    end, (2000*(i-1))+50,1)
	end   	
	-- caption dla gracza
	local x,y,z=getElementPosition(localPlayer)
	local distance=getDistanceBetweenPoints3D(d[1],d[2],d[3],x,y,z)
	if (distance<(d[4]/5)) then
	    triggerEvent("onCaptionedEvent", resourceRoot, "Nagle, tuż obok Ciebie rozlega się bicie dzwonu.", 15)
	elseif (distance<(d[4]/1.5)) then
	    triggerEvent("onCaptionedEvent", resourceRoot, "Pobliski dzwon wybija pełną godzinę.", 15)
	elseif (distance<d[4]) then	    
	    triggerEvent("onCaptionedEvent", resourceRoot, "W oddali słychać bicie dzwonu.", 15)
	end

    end
end)
