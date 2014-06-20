--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local switching=false

addEventHandler("onClientPlayerRadioSwitch", getLocalPlayer(), function(st)
	local veh=getPedOccupiedVehicle(localPlayer)
	if not veh then return end

	if getVehicleController(veh)~=localPlayer then
		if not switching then
			cancelEvent()
		end
		switching=false
		return
	end
	-- kierowca zmienil kanal
	local pasazerowie=getVehicleOccupants(veh)
	local wyslijDo={}
	local seats = getVehicleMaxPassengers(veh)
	for seat = 1, seats do
		if pasazerowie[seat] and isElement(pasazerowie[seat]) then
			table.insert(wyslijDo, pasazerowie[seat])
		end
	end
	if #wyslijDo>0 then
		triggerServerEvent("syncRadiostation", resourceRoot, wyslijDo, st)
	end
end)

-- triggerClientEvent(v,"switchRadiostation", resourceRoot, st)
addEvent("switchRadiostation", true)
addEventHandler("switchRadiostation", resourceRoot, function(st)

	switching=true
	if getPedOccupiedVehicle(localPlayer) then
		setRadioChannel(st)
	else
		setRadioChannel(0)
	end
end)