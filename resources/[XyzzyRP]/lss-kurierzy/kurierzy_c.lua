--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local ITEMID_KWIT=13

function menu_odbiorPaczki(args)
    local ped=args.ped
    if (not exports["lss-gui"]:eq_getItemByID(16)) then
	outputChatBox("Magazynier mówi: musisz się zaopatrzyć w nawigację aby móc roznosić paczki.")
	return
    end
    local x,y,z=getElementPosition(ped)
    local x2,y2,z2=getElementPosition(localPlayer)
    if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>5) then
	outputChatBox("Musisz podejść bliżej aby odebrać paczkę.", 255,0,0,true)
	return
    end

    triggerServerEvent("onPlayerRequestPackage", localPlayer)
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " odbiera paczkę od magazyniera.", 5, 15, true)
end

function menu_dostawaPaczki(args)
    cel=args.cel
    local x,y,z=getElementPosition(args.obiekt)
    local x2,y2,z2=getElementPosition(localPlayer)
    if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>3) then
	outputChatBox("Musisz podejść bliżej.", 255,0,0,true)
	return
    end
    if (exports["lss-gui"]:eq_takeItem(15,1,cel)) then
	triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wrzuca paczkę do skrzynki.", 5, 15, true)	
	exports["lss-gui"]:eq_giveItem(ITEMID_KWIT, math.random(4,8))
	exports["lss-gui"]:eq_item_nav_turnOff()
    else
	outputChatBox("Nie masz żadnej paczki do tej skrzynki.", 255,0,0,true)
    end
end