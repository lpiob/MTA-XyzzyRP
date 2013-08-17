function menu_szlaban(args)
    local src=args.src
    local x,y,z=getElementPosition(localPlayer)
    local x2,y2,z2=getElementPosition(src)
    local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    local fname=getElementData(localPlayer,"faction:name")
    
    if (dist>10) then
	triggerEvent("onCaptionedEvent", root, "Strażnik Cię nie słyszy.", 5)
	outputChatBox("* Strażnik Cię nie słyszy.")
	return
    end
    if (not fname or fname~="Policja") then
	triggerEvent("onCaptionedEvent", root, "Strażnik Cię ignoruje.", 5)
	return
    end

    triggerServerEvent("onSzlabanOtwarcieRequest", resourceRoot)    


    
end