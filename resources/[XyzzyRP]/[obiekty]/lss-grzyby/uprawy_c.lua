function menu_zbierz(args)
--	setElementData(v.fobject,"customAction",{label="Zbierz",resource="lss-mahiruana",funkcja="menu_zbierz",args={obiekt=v.object,indeks=i}})
	if (not args.obiekt or not isElement(args.obiekt)) then return end
	local x,y,z=getElementPosition(localPlayer)
	local x2,y2,z2=getElementPosition(args.obiekt)
	if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>4) then
		outputChatBox("Musisz podejść bliżej.", 255,0,0,true)
		return
	end
	triggerServerEvent("onGZbior", args.obiekt, localPlayer, args.indeks)
end