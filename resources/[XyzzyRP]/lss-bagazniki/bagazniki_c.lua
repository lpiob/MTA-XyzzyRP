--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


function menu_bagaznik(args)
	veh=args.vehicle
	if not veh then return end

--[[
	triggerServerEvent("setVehicleDoorOpenRatio", vehicle, 1, 1, 1000)
	triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " otwiera bagażnik w samochodzie.", 5, 15, true)
]]--
    if (getVehicleDoorOpenRatio(veh,1)>0) then	-- zamykanie maski
        triggerServerEvent("setVehicleDoorOpenRatio", veh, 1, 0, 1000)
        triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zamyka bagażnik w samochodzie.", 5, 15, true)
		return
    end
    
    -- sprawdzamy czy pojazd jest otwarty
    if (isVehicleLocked(veh)) then
		outputChatBox("Pojazd jest zamknięty.", 255,0,0,true)
		return
    end
	-- sprawdzamy czy gracz ma klucze do pojazdu
	if not exports["lss-vehicles"]:graczMaKlucze(veh) then
	    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " bezskutecznie próbuje otworzyć bagażnik w samochodzie.", 5, 15, true)
		outputChatBox("(( Musisz miec klucze do pojazdu aby otworzyć bagażnik. ))")
		return
	end
    -- otwieramy maske
    triggerServerEvent("setVehicleDoorOpenRatio", veh, 1, 1, 1000)
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " otwiera bagażnik w samochodzie.", 5, 15, true)

	-- otwieramy pojemnik
	triggerServerEvent("doOtworzBagaznik", resourceRoot, localPlayer, veh)

end