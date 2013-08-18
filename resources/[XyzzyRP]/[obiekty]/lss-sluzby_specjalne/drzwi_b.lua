local brama={}
brama.l=createObject(1495,1203.1083984375,-1427.6474609375,2176.171875,0,0,0)
brama.r=createObject(1495,1206.1171875,-1427.6181640625,2176.171875,0,0,180)

-- dimension
setElementDimension(brama.l, 40) 
setElementDimension(brama.r, 40) 
-- interior
setElementInterior(brama.l, 1) 
setElementInterior(brama.r, 1) 

setElementData(brama.l,"customAction",{label="Otwórz/zamknij",resource="lss-sluzby_specjalne",funkcja="menu_brama2",args={}})
setElementData(brama.r,"customAction",{label="Otwórz/zamknij",resource="lss-sluzby_specjalne",funkcja="menu_brama2",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true
--    local _,_,rz=getElementRotation(brama.l)
    moveObject(brama.l,3000,1203.1083984375-0.85,-1427.6474609375,2176.171875,0,0,0,"OutBounce")
    
--    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,3000,1206.1171875+0.85,-1427.6181640625,2176.171875,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true
    local _,_,rz=getElementRotation(brama.l)

    moveObject(brama.l,3000,1203.1083984375,-1427.6474609375,2176.171875,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,3000,1206.1171875,-1427.6181640625,2176.171875,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=22 AND character_id=%d", id)
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

addEvent("onSluzby_specjalneBrama2ToggleRequest", true)
addEventHandler("onSluzby_specjalneBrama2ToggleRequest", resourceRoot, brama.toggle)

