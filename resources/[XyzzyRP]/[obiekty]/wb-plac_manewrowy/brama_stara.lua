-- brama na zewnatrz

local brama={}
--    <object id="pmbrama1" doublesided="false" model="986" interior="0" dimension="0" posX="1072.4556884766" posY="-1328.3017578125" posZ="14.804490089417" rotX="0" rotY="0" rotZ="90"></object>
--    <object id="pmbrama2" doublesided="false" model="985" interior="0" dimension="0" posX="1072.4556884766" posY="-1320.3179931641" posZ="14.804490089417" rotX="0" rotY="0" rotZ="90"></object>	

brama.l=createObject(985,1072.4556884766,-1320.3179931641,14.804490089,0,0,90)
brama.r=createObject(986,1072.4556884766,-1328.3017578125,14.804490089,0,0,90)


setElementData(brama.l,"customAction",{label="Otwórz/zamknij",resource="wb-plac_manewrowy",funkcja="menu_brama",args={}})
setElementData(brama.r,"customAction",{label="Otwórz/zamknij",resource="wb-plac_manewrowy",funkcja="menu_brama",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true
--    local _,_,rz=getElementRotation(brama.l)
    moveObject(brama.l,5000,1072.4556884766,-1321.9179931641+8,14.804490089,0,0,0,"OutBounce")
    
--    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,5000,1072.4556884766,-1327.0017578125-8,14.804490089,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true
    local _,_,rz=getElementRotation(brama.l)

    moveObject(brama.l,5000,1072.4556884766,-1320.3179931641,14.804490089,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,5000,1072.4556884766,-1328.3017578125,14.804490089,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=true end, 6000, 1)
end


--addCommandHandler("bo",brama.otworz)
--addCommandHandler("bz",brama.zamknij)
brama.toggle=function()

    local x,y,z=getElementPosition(brama.l)
    local x2,y2,z2=getElementPosition(source)
    local dist1=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    x,y,z=getElementPosition(brama.r)
    local dist2=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist1>5 and dist2>5) or getPedOccupiedVehicle(source)) then
	outputChatBox("Podejdź bliżej do bramy.", source, 255,0,0,true)
	return
    end

    if (brama.animacja) then
	outputChatBox("Odczekaj chwilę.", source, 255,0,0,true)
	return
    end
    if (brama.zamknieta) then
	brama.otworz()
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source) .. " otwiera bramę.", 5, 15, true)
    else
	brama.zamknij()
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source) .. " zamyka bramę.", 5, 15, true)
    end

end

addEvent("onPlacMBramaToggleRequest", true)
addEventHandler("onPlacMBramaToggleRequest", root, brama.toggle)
