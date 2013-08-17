local schody={}
schody.a=createObject(3361,511.24807739258,-1895.9498291016,4.7975449562073-5,0,0,90)
schody.b=createObject(3361,511.24523925781,-1889.9271240234,0.7805455327034-5,0,0,90)

-- dimension
setElementDimension(schody.a, 0) 
setElementDimension(schody.b, 0) 
-- interior
setElementInterior(schody.a, 0) 
setElementInterior(schody.b, 0) 

setElementData(schody.a,"customAction",{label="Na_góre/na_dół",resource="lss-scena",funkcja="menu_schody",args={}})
setElementData(schody.b,"customAction",{label="Góra/dół",resource="lss-scena",funkcja="menu_schody",args={}})

schody.animacja=false
schody.dol=true

schody.na_gore=function()
    if (schody.animacja or not schody.dol) then return false end
    schody.animacja=true
--    local _,_,rz=getElementRotation(schody.l)
    moveObject(schody.a,7000,511.24807739258,-1895.9498291016,4.7975449562073,0,0,0,"OutBounce")
    
--    local _,_,rz=getElementRotation(schody.r)
    moveObject(schody.b,7000,511.24523925781,-1889.9271240234,0.7805455327034,0,0,0,"OutBounce")
    setTimer(function() schody.animacja=false schody.dol=false end, 6000, 1)
end

schody.na_dol=function()
    if (schody.animacja or schody.dol) then return false end
    schody.animacja=true
    local _,_,rz=getElementRotation(schody.a)

    moveObject(schody.a,7000,511.24807739258,-1895.9498291016,4.7975449562073-5,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(schody.b)
    moveObject(schody.b,7000,511.24523925781,-1889.9271240234,0.7805455327034-5,0,0,0,"OutBounce")
    setTimer(function() schody.animacja=false schody.dol=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=35 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank) then return true else return false end
end
--addCommandHandler("bo",schody.otworz)
--addCommandHandler("bz",schody.zamknij)
schody.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
    if (not pracownik(tonumber(c.id))) then
	outputChatBox("(( nie znasz hasła do konsoli ))", gracz)
	return
    end
    
    
    local x,y,z=getElementPosition(schody.a)
    local x2,y2,z2=getElementPosition(gracz)
    local dist1=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    x,y,z=getElementPosition(schody.b)
    local dist2=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist1>10 and dist2>10) or getPedOccupiedVehicle(gracz)) then
	outputChatBox("Podejdź bliżej do panelu.", gracz, 255,0,0,true)
	return
    end

    if (schody.animacja) then
	outputChatBox("Odczekaj chwilę.", gracz, 255,0,0,true)
	return
    end
    if (schody.dol) then
	schody.na_gore()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " uruchamia schody.", 5, 15, true)
    else
	schody.na_dol()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " chowa schody.", 5, 15, true)
    end

end

addEvent("onSchodySchodyToggleRequest", true)
addEventHandler("onSchodySchodyToggleRequest", resourceRoot, schody.toggle)

