--[[
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--



-- wyłączamy to przeklęte radio w rowerach ;D

isBike = {
	[509]=true, --Bike
	[481]=true, --BMX
	[510]=true, --Mountain bike
}

-- addEventHandler("onClientPlayerVehicleEnter", getLocalPlayer(), function(vehicle, seat)
	-- outputChatBox(getElementModel(vehicle))
	-- if isBike[getElementModel(vehicle)] then setRadioChannel(0) cancelEvent() end
-- end)
 
-- addEventHandler("onClientPlayerRadioSwitch", getLocalPlayer(), function ()
	-- if isBike[getElementModel(getPedOccupiedVehicle(getLocalPlayer()))] then cancelEvent () return end
-- end)

function radioOff(player)
	setRadioChannel(0)
end

addEventHandler ( "onClientVehicleStartEnter", getRootElement(),
	function ( player, seat )
		if (player~=getLocalPlayer()) then return end
		if isBike[getElementModel(source)] then
			setRadioChannel(0)
		end
	end
)

addEventHandler ( "onClientPlayerRadioSwitch", getLocalPlayer (),
	function ( station )
		if isBike[getElementModel(getPedOccupiedVehicle(getLocalPlayer()))] then
			cancelEvent ()
		end
	end
)
