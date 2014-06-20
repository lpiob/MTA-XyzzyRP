--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



addEvent("startZjazd", true)
addEventHandler("startZjazd", resourceRoot, function()

	local seat = getPedOccupiedVehicleSeat(client)
	if not seat then return end
	local veh=getPedOccupiedVehicle(client)
	local rrx,rry,rrz=getElementRotation(client)
	local x,y,z=getElementPosition(client)
--	setElementCollisionsEnabled(client,false)
	setPedGravity(client,0.001)
	removePedFromVehicle(client)
	setElementPosition(client,x,y,z-1)
	setElementData(client,"zjazd",veh)
	
	

--	setElementRotation(client, rrx,rry,rrz+90)
--	setPedAnimation(client,"SWAT","swt_vent_02",-1,false,false,false)
	setPedAnimation(client,"ped","abseil",-1,false,false,false)
end)

addEvent("finishZjazd", true)
addEventHandler("finishZjazd", resourceRoot, function()
	removeElementData(client,"zjazd")
	setPedGravity(client,0.008)
	setPedAnimation(client)
end)

for i,v in ipairs(getElementsByType("player")) do
	if getElementData(v,"zjazd") then
		setPedGravity(v,0.008)
		setPedAnimation(v)
		removeElementData(v,"zjazd")
	end
end