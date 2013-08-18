--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local i=0

local function pojazdPusty(veh)
	local occupants = getVehicleOccupants(veh)
	for i=0,getVehicleMaxPassengers(veh) do
		if occupants[i] and isElement(occupants[i]) then return false end
	end
	-- a co tam, sprawdzmy czy nie ma kogos w okolicy!
	local x,y,z=getElementPosition(veh)
	local cs=createColSphere(x,y,z,10)
	local graczewokolicy=getElementsWithinColShape(cs,"player")
	destroyElement(cs)
	if #graczewokolicy>0 then return false end


	return true
end

local vehResource=getResourceFromName("lss-vehicles")
setTimer(function()
	local vehicles=getElementsByType("vehicle", getResourceRootElement(vehResource))
	
	local i2=0
	for _,veh in ipairs(vehicles) do
		i2=i2+1
		if (i2%2==i) then
				local caudio=getElementData(veh,"audio:cd")
				if caudio and type(caudio)=="table" and caudio[1] then
				-- sprawdzamy czy pojazd ma pasazerow
				if pojazdPusty(veh) then
					setElementData(veh,"audio:cd", false)
				end
			end
		end

	end


	i=i+1
	if i>1 then i=0 end
end, 60000,0)
