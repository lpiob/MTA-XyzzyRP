--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

-- crun playSoundFrontEnd(49),, 34 start

-- only if voice enabled
if isVoiceEnabled() then
    -- adding handler for voice start event
    addEventHandler( 'onPlayerVoiceStart', root,
        function()
--	    outputDebugString("x" .. getPlayerName(source))
--	    outputChatBox("Nadajesz!", source)
	    if (not getElementData(source,"voice")) then cancelEvent() return end
	    local v=getPedOccupiedVehicle(source)
	    if (not v) then
		cancelEvent()
		return
	    end
	    if (not getElementData(v,"cb")) then
		cancelEvent()
		return
	    end
	    setPlayerVoiceBroadcastTo (source, source)
	    -- szukamy innych pojazdow z CB
	    local odbiorcy={}
	    for i,v in ipairs(getElementsByType("vehicle")) do
		if (getElementData(v,"cb")) then
		    local occupants = getVehicleOccupants(v)
		    local seats = getVehicleMaxPassengers(v)
		    for seat = 0, seats do
			local occupant = occupants[seat]
			if (occupant and isElement(occupant) and getElementType(occupant)=="player") then
			    table.insert(odbiorcy, occupant)
--			    outputDebugString("voice " .. getPlayerName(source) .. " > " .. getPlayerName(occupant))
			end
		    end
		end
	    end
	    setPlayerVoiceBroadcastTo (source, odbiorcy)
	    
--		local x,y,z=getElementPosition(source)
--		local cs=createColSphere(x,y,z,10)
--		local wokolicy=getElementsWithinColShape(cs,"player")
--		destroyElement(cs)
--	
        end
    )
end

addCommandHandler("cb", function(plr,cmd,...)
    local msg=table.concat(arg," ")
    local v=getPedOccupiedVehicle(plr)
    if (not v) then
	outputChatBox("Nie jesteś w pojeździe.", plr, 255,0,0)
	return
    end
    if (not getElementData(v,"cb")) then
	outputChatBox("Ten pojazd nie ma CB.", plr, 255,0,0)
	return
    end
    local c=getElementData(plr,"character")
    -- szukamy innych pojazdow z CB
    local odbiorcy={}
    for i,v in ipairs(getElementsByType("vehicle")) do
	if (getElementData(v,"cb")) then
	    local occupants = getVehicleOccupants(v)
	    local seats = getVehicleMaxPassengers(v)
	    for seat = 0, seats do
		local occupant = occupants[seat]
		if (occupant and isElement(occupant) and getElementType(occupant)=="player") then
		    outputChatBox("CB(0)> #FFFFFF" .. msg, occupant, 255,200,0, true)
		end
	    end
	end
    end

end, false,false)