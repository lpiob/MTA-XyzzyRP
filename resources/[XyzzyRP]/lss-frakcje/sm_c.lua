--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

function menu_blokadaKol(args)
    local vehicle=args.vehicle
    triggerServerEvent("onWheelLockRequest", vehicle, localPlayer)
end

function menu_wyladujPojazdy(args)

    local vehicle=args.vehicle
	if (exports["lss-vehicles"]:graczMaKlucze(vehicle)) then
	    triggerServerEvent("onVehicleUnloadRequest", vehicle, localPlayer)
	else

		outputChatBox("Nie masz klucza do tego pojazdu.", 255,0,0)


	end

end

function menu_magnes(args)
    local vehicle=args.vehicle
    if (exports["lss-vehicles"]:graczMaKlucze(vehicle)) then
        triggerServerEvent("doMagnes", vehicle, localPlayer)
    else
	outputChatBox("Nie masz klucza do tego pojazdu.", 255,0,0)
    end
end