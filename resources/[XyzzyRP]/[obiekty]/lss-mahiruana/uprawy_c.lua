--[[
Tworzenie obiektow mahiruany do zbierania przez graczy.

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--

function menu_zbierz(args)
--	setElementData(v.fobject,"customAction",{label="Zbierz",resource="lss-mahiruana",funkcja="menu_zbierz",args={obiekt=v.object,indeks=i}})
	if (not args.obiekt or not isElement(args.obiekt)) then return end
	local x,y,z=getElementPosition(localPlayer)
	local x2,y2,z2=getElementPosition(args.obiekt)
	if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>4) then
		outputChatBox("Musisz podejść bliżej.", 255,0,0,true)
		return
	end
	triggerServerEvent("onZbior", args.obiekt, localPlayer, args.indeks)
end