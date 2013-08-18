--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

-- jestem hardkorem

local klawisze={a=1,d=1,s=1,w=1,capslock=1,space=1,arrow_u=1,arrow_d=1,arrow_l=1,arrow_r=1}

function playerPressedKey(button, press)
    if (klawisze[button] and  getKeyState ( "lalt" )) then -- Only output when they press it down
		local pojazd=getPedOccupiedVehicle(localPlayer)
		if (not pojazd) then return end
		local vm=getElementModel(pojazd)
		if (vm==589 and getVehicleOccupant(pojazd,1)==localPlayer) then
			triggerServerEvent("onVehicleSteering", localPlayer, pojazd, button)
		end
    end
end
addEventHandler("onClientKey", root, playerPressedKey)