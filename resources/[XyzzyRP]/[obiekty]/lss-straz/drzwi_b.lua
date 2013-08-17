local brama={}
brama.l=createObject(1495,924.197265625,-1287.1627197266,1439.9249267578,0,0,90)
brama.r=createObject(1495,924.1669921875,-1284.1558837891,1439.9249267578,0,0,270)

-- dimension
setElementDimension(brama.l, 26) 
setElementDimension(brama.r, 26) 
-- interior
setElementInterior(brama.l, 1) 
setElementInterior(brama.r, 1) 

setElementData(brama.l,"customAction",{label="Otwórz/zamknij",resource="lss-straz",funkcja="menu_drzwi2",args={}})
setElementData(brama.r,"customAction",{label="Otwórz/zamknij",resource="lss-straz",funkcja="menu_drzwi2",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true
--    local _,_,rz=getElementRotation(brama.l)
    moveObject(brama.l,3000,924.197265625,-1287.1627197266-1.3,1439.9249267578,0,0,0,"OutBounce")
    
--    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,3000,924.1669921875,-1284.1558837891+1.3,1439.9249267578,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true
    local _,_,rz=getElementRotation(brama.l)

    moveObject(brama.l,3000,924.197265625,-1287.1627197266,1439.9249267578,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,3000,924.1669921875,-1284.1558837891,1439.9249267578,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=11 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank and tonumber(wynik.rank)>=1 and tonumber(wynik.rank)<=8) then return true else return false end
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
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " otwiera bramę.", 5, 15, true)
    else
	brama.zamknij()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " zamyka bramę.", 5, 15, true)
    end

end

addEvent("onFD_Drzwi2ToggleRequest", true)
addEventHandler("onFD_Drzwi2ToggleRequest", resourceRoot, brama.toggle)

