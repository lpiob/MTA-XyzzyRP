function menu_ochrona(args)
    local src=args.src
    local x,y,z=getElementPosition(localPlayer)
    local x2,y2,z2=getElementPosition(src)
    local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    local fname=getElementData(localPlayer,"faction:name")

    if (not fname or fname~="Ochrona") then
	triggerEvent("onCaptionedEvent", root, "Szlaban nie otwiera siê.", 5)
	return
    end

    triggerServerEvent("onOchronaOtwarcieRequest", resourceRoot)    


    
end