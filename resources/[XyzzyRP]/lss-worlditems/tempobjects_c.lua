--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

-- setElementData(o,"customAction",{label="Podnieś",resource="lss-worlditems",funkcja="menu_podniesObiektTymczasowy",args={obiekt=o}})

function menu_podniesObiektTymczasowy(args)
	local o=args.obiekt
	local x,y,z=getElementPosition(localPlayer)
	local x2,y2,z2=getElementPosition(o)
	if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>3 then
		outputChatBox("(( Musisz podejść bliżej ))", 255,0,0)
		return
	end
	triggerServerEvent("doPickupTemporaryObject", o)
end



function menu_itemPickup(args)
	local player = args.player
	local item = args.item
	local x,y,z=getElementPosition(localPlayer)
	local x2,y2,z2=getElementPosition(item)
	if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>1.2 then
		outputChatBox("(( Musisz podejść bliżej ))", 255,0,0)
		return
	end
	triggerServerEvent("onItemPickup", player, item)
end