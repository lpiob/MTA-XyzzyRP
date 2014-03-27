--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



function menu_spedycjaInfo(args)
  local veh=args.vehicle
  triggerServerEvent("onPlayerRequestSpedycjaInfo", localPlayer, veh)
end

addEventHandler("onClientVehicleExit", root, function(plr,seat)
	if (plr~=localPlayer) then return end
	if (seat~=0) then return end
    local s=getElementData(source,"spedycja")
	if (not s) then  return	end
    exports["lss-gui"]:eq_item_nav_turnOff()
end)

addEventHandler("onClientVehicleEnter", root, function(plr,seat)
	if (plr~=localPlayer) then return end
	if (seat~=0) then return end
    local s=getElementData(source,"spedycja")
	if (not s) then  return	end
	triggerServerEvent("onPlayerRequestSpedycjaInfo", localPlayer, source)
end)

addEvent("hideGPS", true)
addEventHandler("hideGPS", resourceRoot, function()
    exports["lss-gui"]:eq_item_nav_turnOff()
end)