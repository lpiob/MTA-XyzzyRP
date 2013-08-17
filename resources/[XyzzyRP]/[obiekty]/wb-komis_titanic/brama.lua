-- brama na zewnatrz
local brama={}

addEventHandler("onResourceStart", resourceRoot, function()

brama.o=getElementByID("kt_brama")
--    <object id="pmbrama1" doublesided="false" model="986" interior="0" dimension="0" posX="1072.4556884766" posY="-1328.3017578125" posZ="14.804490089417" rotX="0" rotY="0" rotZ="90"></object>
--    <object id="pmbrama2" doublesided="false" model="985" interior="0" dimension="0" posX="1072.4556884766" posY="-1320.3179931641" posZ="14.804490089417" rotX="0" rotY="0" rotZ="90"></object>	

setElementData(brama.o,"customAction",{label="Otwórz/zamknij",resource="wb-komis_titanic",funkcja="menu_brama",args={}})
end)

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true
	
    moveObject(brama.o,7000,2165.5908203125, -1138.5423583984-6, 23.360504150391,0,0,0,"OutBounce")
    
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true

    moveObject(brama.o,7000,2165.5908203125, -1138.5423583984, 23.360504150391,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=true end, 6000, 1)
end


--addCommandHandler("bo",brama.otworz)
--addCommandHandler("bz",brama.zamknij)
brama.toggle=function()

    local x,y,z=getElementPosition(brama.o)
    local x2,y2,z2=getElementPosition(client)
    local dist1=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist1>5) or getPedOccupiedVehicle(client)) then
	outputChatBox("Podejdź bliżej do bramy.", client, 255,0,0,true)
	return
    end

    if (brama.animacja) then
	outputChatBox("Odczekaj chwilę.", client, 255,0,0,true)
	return
    end
    if (brama.zamknieta) then
	brama.otworz()
	triggerEvent("broadcastCaptionedEvent", client, getPlayerName(client) .. " otwiera bramę.", 5, 15, true)
    else
	brama.zamknij()
	triggerEvent("broadcastCaptionedEvent", client, getPlayerName(client) .. " zamyka bramę.", 5, 15, true)
    end

end

addEvent("onBramaToggleRequest", true)
addEventHandler("onBramaToggleRequest", resourceRoot, brama.toggle)
