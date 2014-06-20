--[[
@author RootKiller <rootkiller.programmer@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--


local sx,sy = guiGetScreenSize()
local death = {}

function dli(x,a,b,c)
	if (x==1) then	return a end
	if (x%10>1) and (x%10<5) and (not ((x%100>=10) and (x%100<=21))) then 	return b end
	return c
end

function bwUpdate()
	local toBwEnd = (getElementData(getLocalPlayer(), "bwEndTime")-getTickCount())

	local x, y, z = getElementPosition ( getLocalPlayer () )
--	setCameraMatrix ( x + 10, y + 10, z + 15, x, y, z )
	setCameraMatrix(x-(10 * math.sin(toBwEnd/40000)),y+(10 * math.cos(toBwEnd/40000)),z+15,x,y,z)

	if(toBwEnd <= 1) then
		outputChatBox("Żyjesz! Lecz masz tylko 1hp udaj się do szpitala po leki.")		
		triggerEvent("onBwFinish", getRootElement())		
		removeEventHandler("onClientRender", getRootElement(), bwUpdate)
		return
	end
	
	local timeInt = math.floor(toBwEnd/1000)
	local timeStr = (timeInt >= 60 and dli(timeInt/60+1, "minuta", "minuty", "minut") or dli(timeInt, "sekunda", "sekund", "sekund"))
	
	local text = "Do końca BW pozostało " .. tostring(math.floor((timeInt >= 60 and timeInt/60+1 or timeInt))) .. " " .. timeStr
	
	local fX = (sx/2)-(dxGetTextWidth(text, 2)/2)
	local fY = (sx/2)-200
	
	dxDrawText(text, fX + 1, fY, fX + 1, fY, tocolor(0,   0,   0, 255),   2)
	dxDrawText(text, fX - 1, fY, fX - 1, fY, tocolor(0,   0,   0, 255),   2)
	dxDrawText(text, fX, fY + 1, fX, fY + 1, tocolor(0,   0,   0, 255),   2)
	dxDrawText(text, fX, fY - 1, fX, fY - 1, tocolor(0,   0,   0, 255),   2)
	dxDrawText(text, fX, fY, fX, fY, tocolor(255, 255, 255, 255), 2)
end

addEventHandler("onClientPlayerWasted", getRootElement(), 
	function(killer, weapon, bodypart)
		if(source == getLocalPlayer()) then
			local abs=getElementData(source,"abseiling")
			if abs and abs~="" then
				return
			end
			local bwSeconds = 10			
			if bodypart == 9 then -- głowa
				bwSeconds = (10 * 60)
			elseif bodypart == 9 then -- tyłek
				bwSeconds = (2 * 60)
			elseif tonumber(bodypart) and (tonumber(bodypart) >= 5 and tonumber(bodypart) <= 8) then -- kończyny
				bwSeconds = (5 * 60)
			elseif bodypart == 3 then -- klatka piersiowa
				bwSeconds = (5 * 60)
			else
				bwSeconds = (5 * 60)
			end
			
			setElementData(getLocalPlayer(), "bwEndTime", getTickCount()+(bwSeconds * 1000))
			
			triggerEvent("onGUIOptionChange", getRootElement(), "grayscale", true)
			addEventHandler("onClientRender", getRootElement(), bwUpdate)
			fadeCamera ( false, 1.0, 0, 0, 0 ) 
			setTimer ( fadeCamera, 2000, 1, true, 0.5 )
			
			death.heartBeat = playSound("audio/heartbeat.mp3", true)
		end
	end
)

addEvent("onBwFinish", true)
addEventHandler("onBwFinish", getRootElement(),
	function()
		setCameraTarget(getLocalPlayer())		
		destroyElement(death.heartBeat)
			
		triggerServerEvent("onPlayerFinshBW", getLocalPlayer())
		
		triggerEvent("onGUIOptionChange", getRootElement(), "grayscale", false)		
		removeEventHandler("onClientRender", getRootElement(), bwUpdate)
	end
)

addEventHandler ( "onClientPlayerDamage", getRootElement(),
	function()
		if(source == getLocalPlayer()) then
			fadeCamera ( false, 1.0, 255, 0, 0 ) 
			setTimer ( fadeCamera, 500, 1, true, 0.5 )
		end
	end
)
