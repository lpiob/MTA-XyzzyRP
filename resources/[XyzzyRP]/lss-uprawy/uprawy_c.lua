--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



function menu_podnies(args)
    snopek=args.snopek
    local x,y,z=getElementPosition(localPlayer)
    local x2,y2,z2=getElementPosition(snopek)
    if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>3) then
	outputChatBox("Musisz podejść bliżej.", 255,0,0)
	return
    end
    triggerServerEvent("onSnopekPickup", resourceRoot, localPlayer, snopek)

end