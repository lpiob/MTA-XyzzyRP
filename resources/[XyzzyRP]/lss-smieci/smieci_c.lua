--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



function menu_podniesSmiecia(args)
    obiekt=args.obiekt
    local x,y,z=getElementPosition(localPlayer)
    local x2,y2,z2=getElementPosition(obiekt)
    if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>3 or getPedOccupiedVehicle(localPlayer)) then
	outputChatBox("Musisz podejść bliżej.", 255,0,0)
	return
    end
--    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " podnosi coś z ziemii.", 5, 15, true)
    triggerServerEvent("onTrashPickup", localPlayer, obiekt)
--    exports["lss-gui"]:eq_giveItem(9,1)
end