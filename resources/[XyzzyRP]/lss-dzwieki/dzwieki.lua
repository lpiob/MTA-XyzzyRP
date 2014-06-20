--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



local lu={}

-- triggerServerEvent("broadcastSound3D", pojazd, "pd-syrena.ogg", 50)
addEvent("broadcastSound3D", true)
addEventHandler("broadcastSound3D", root, function(dzwiek, range, minrange, delay, bliskiKomunikat, dalekiKomunikat)
	if delay then
		if lu[dzwiek] and getTickCount()-lu[dzwiek]<delay then
			outputChatBox(string.format("(( Musisz odczekać %d sekund. ))", delay/1000), client, 255,0,0)
			return
		end
		lu[dzwiek]=getTickCount()
	end
	triggerClientEvent("broadcastSound3D", source, dzwiek, range, minrange, bliskiKomunikat, dalekiKomunikat)
end)

-- triggerServerEvent("toggleVehicleSound", pojazd, "fd-syrena4.ogg", 125)
addEvent("toggleVehicleSound", true)
addEventHandler("toggleVehicleSound", root, function(dzwiek, range)
	local snd=getElementData(source,"snd:"..dzwiek)
	if snd then
		triggerClientEvent("destroyVehicleSound", source, dzwiek)
		setTimer(removeElementData,500,1,source,"snd:"..dzwiek)
		return
	end
	triggerClientEvent("createVehicleSound", source, dzwiek, range)
	setElementData(source,"snd:"..dzwiek,true)
end)