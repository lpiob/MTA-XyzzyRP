local brama={}
brama[1]=createObject(16775,2426.876953125,-2623.83984375,16.652284622192,0,0,0)
brama[2]=createObject(16775,2441.552734375,-2623.83984375,16.652284622192,0,0,0)
brama[3]=createObject(16775,2426.8642578125,-2623.7585449219,16.652284622192,0,0,180)
brama[4]=createObject(16775,2441.5395507813,-2623.7585449219,16.652284622192,0,0,180)


setElementData(brama[1],"customAction",{label="Otwórz/zamknij",resource="wb-statek_w_porcie",funkcja="menu_brama2",args={}})
setElementData(brama[2],"customAction",{label="Otwórz/zamknij",resource="wb-statek_w_porcie",funkcja="menu_brama2",args={}})
setElementData(brama[3],"customAction",{label="Otwórz/zamknij",resource="wb-statek_w_porcie",funkcja="menu_brama2",args={}})
setElementData(brama[4],"customAction",{label="Otwórz/zamknij",resource="wb-statek_w_porcie",funkcja="menu_brama2",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true

    moveObject(brama[1],10000,2426.876953125-6.7,-2623.83984375,16.652284622192,0,0,0,"OutBounce")
    
    moveObject(brama[2],10000,2441.552734375+6.7,-2623.83984375,16.652284622192,0,0,0,"OutBounce")
	
    moveObject(brama[3],10000,2426.8642578125-6.7,-2623.7585449219,16.652284622192,0,0,0,"OutBounce")
	
    moveObject(brama[4],10000,2441.5395507813+6.7,-2623.7585449219,16.652284622192,0,0,0,"OutBounce")	
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true
    local _,_,rz=getElementRotation(brama[1])
    moveObject(brama[1],10000,2426.876953125,-2623.83984375,16.652284622192,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama[2])
    moveObject(brama[2],10000,2441.552734375,-2623.83984375,16.652284622192,0,0,0,"OutBounce")
	
    local _,_,rz=getElementRotation(brama[3])
    moveObject(brama[3],10000,2426.8642578125,-2623.7585449219,16.652284622192,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama[4])
    moveObject(brama[4],10000,2441.5395507813,-2623.7585449219,16.652284622192,0,0,0,"OutBounce")	
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
    
    if ((dist1>7 and dist2>7) or getPedOccupiedVehicle(gracz)) then
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

addEvent("onImport2BramaToggleRequest", true)
addEventHandler("onImport2BramaToggleRequest", resourceRoot, brama.toggle)

