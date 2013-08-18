local brama={}
brama[1]=createObject(2909,2491.2053222656,-2719.6162109375,18.366344451904,0,0,90)
brama[2]=createObject(2909,2482.7807617188,-2719.6162109375,18.366344451904,0,0,90)
brama[3]=createObject(2909,2491.205078125,-2719.6162109375,21.037330627441,0,180,90)
brama[4]=createObject(2909,2482.7802734375,-2719.6162109375,21.037330627441,0,180,90)


setElementData(brama[1],"customAction",{label="Otwórz/zamknij",resource="wb-statek_w_porcie",funkcja="menu_brama",args={}})
setElementData(brama[2],"customAction",{label="Otwórz/zamknij",resource="wb-statek_w_porcie",funkcja="menu_brama",args={}})
setElementData(brama[3],"customAction",{label="Otwórz/zamknij",resource="wb-statek_w_porcie",funkcja="menu_brama",args={}})
setElementData(brama[4],"customAction",{label="Otwórz/zamknij",resource="wb-statek_w_porcie",funkcja="menu_brama",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true

    moveObject(brama[1],5000,2491.2053222656,-2719.6162109375,18.366344451904+5,0,0,0,"OutBounce")
    
    moveObject(brama[2],5000,2482.7807617188,-2719.6162109375,18.366344451904+5,0,0,0,"OutBounce")
	
    moveObject(brama[3],5000,2491.205078125,-2719.6162109375,21.037330627441+5,0,0,0,"OutBounce")
	
    moveObject(brama[4],5000,2482.7802734375,-2719.6162109375,21.037330627441+5,0,0,0,"OutBounce")	
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true
    local _,_,rz=getElementRotation(brama[1])
    moveObject(brama[1],5000,2491.2053222656,-2719.6162109375,18.366344451904,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama[2])
    moveObject(brama[2],5000,2482.7807617188,-2719.6162109375,18.366344451904,0,0,0,"OutBounce")
	
    local _,_,rz=getElementRotation(brama[3])
    moveObject(brama[3],5000,2491.205078125,-2719.6162109375,21.037330627441,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama[4])
    moveObject(brama[4],5000,2482.7802734375,-2719.6162109375,21.037330627441,0,0,0,"OutBounce")	
    setTimer(function() brama.animacja=false brama.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=10 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank) then return true else return false end
end
--addCommandHandler("bo",brama.otworz)
--addCommandHandler("bz",brama.zamknij)
brama.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
    if (not pracownik(tonumber(c.id))) then
	outputChatBox("(( nie masz klucza do tej bramy ))", gracz)
	return
    end
    
    
    local x,y,z=getElementPosition(brama[1])
    local x2,y2,z2=getElementPosition(gracz)
    local dist1=getDistanceBetweenPoints2D(x,y,x2,y2)
    x,y,z=getElementPosition(brama[2])
    local dist2=getDistanceBetweenPoints2D(x,y,x2,y2)
    x,y,z=getElementPosition(brama[3])
    local dist3=getDistanceBetweenPoints2D(x,y,x2,y2)
    x,y,z=getElementPosition(brama[4])
    local dist4=getDistanceBetweenPoints2D(x,y,x2,y2)	
    
    if ((dist1>5 and dist2>5) or getPedOccupiedVehicle(gracz)) then
	outputChatBox("Podejdź bliżej do bramy.", gracz, 255,0,0,true)
	return
    end

    if (brama.animacja) then
	outputChatBox("Odczekaj chwilę.", gracz, 255,0,0,true)
	return
    end
    if (brama.zamknieta) then
	brama.otworz()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " otwiera bramę.", 5, 15, true)
    else
	brama.zamknij()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " zamyka bramę.", 5, 15, true)
    end

end

addEvent("onImportBramaToggleRequest", true)
addEventHandler("onImportBramaToggleRequest", resourceRoot, brama.toggle)

