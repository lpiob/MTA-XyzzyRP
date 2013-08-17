local brama={}
brama.l=createObject(1495,2171.3620605469,-1780.8178710938,1421.5125732422,0,0,90)
brama.r=createObject(1495,2171.3325195313,-1777.8074951172,1421.5125732422,0,0,270)

-- dimension
setElementDimension(brama.l, 31) 
setElementDimension(brama.r, 31) 
-- interior
setElementInterior(brama.l, 1) 
setElementInterior(brama.r, 1) 

setElementData(brama.l,"customAction",{label="Otwórz/zamknij",resource="lss-ochrona",funkcja="menu_brama",args={}})
setElementData(brama.r,"customAction",{label="Otwórz/zamknij",resource="lss-ochrona",funkcja="menu_brama",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true
--    local _,_,rz=getElementRotation(brama.l)
    moveObject(brama.l,3000,2171.3620605469,-1780.8178710938-1.14,1421.5125732422,0,0,0,"OutBounce")
    
--    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,3000,2171.3325195313,-1777.8074951172+1.14,1421.5125732422,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true
    local _,_,rz=getElementRotation(brama.l)

    moveObject(brama.l,3000,2171.3620605469,-1780.8178710938,1421.5125732422,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,3000,2171.3325195313,-1777.8074951172,1421.5125732422,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=15 AND character_id=%d", id)
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
	outputChatBox("(( nie masz klucza do tych drzwi ))", gracz)
	return
    end
    
    
    local x,y,z=getElementPosition(brama.l)
    local x2,y2,z2=getElementPosition(gracz)
    local dist1=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    x,y,z=getElementPosition(brama.r)
    local dist2=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist1>3 and dist2>3) or getPedOccupiedVehicle(gracz)) then
	outputChatBox("Podejdź bliżej drzwi.", gracz, 255,0,0,true)
	return
    end

    if (brama.animacja) then
	outputChatBox("Odczekaj chwilę.", gracz, 255,0,0,true)
	return
    end
    if (brama.zamknieta) then
	brama.otworz()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " otwiera drzwi.", 5, 15, true)
    else
	brama.zamknij()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " zamyka drzwi.", 5, 15, true)
    end

end

addEvent("onOchronaBramaToggleRequest", true)
addEventHandler("onOchronaBramaToggleRequest", resourceRoot, brama.toggle)

