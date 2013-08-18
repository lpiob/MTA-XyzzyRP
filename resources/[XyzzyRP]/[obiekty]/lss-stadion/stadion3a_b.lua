
local drzwi={}
drzwi.obiekt=createObject(976,2690.580078125,-1671.509765625,1439.1633300781,0,358.49487304688,124.37072753906)
setElementData(drzwi.obiekt,"customAction",{label="Otwórz/zamknij",resource="lss-stadion",funkcja="menu_drzwi3",args={}})

-- dimension
setElementDimension(drzwi.obiekt, 24)  -- bylo drzwi, ma byc drzwi.obiekt (tak jak wyzej)
-- interior
setElementInterior(drzwi.obiekt, 1)  -- j.w.

drzwi.animacja=false
drzwi.zamknieta=true

drzwi.otworz=function()
    if (drzwi.animacja or not drzwi.zamknieta) then return false end
    drzwi.animacja=true
    moveObject(drzwi.obiekt,6000,2690.580078125,-1671.509765625,1439.1633300781+3,0,0,0,"OutBounce")
    setTimer(function() drzwi.animacja=false drzwi.zamknieta=false end, 6000, 1)
end

drzwi.zamknij=function()
    if (drzwi.animacja or drzwi.zamknieta) then return false end
    drzwi.animacja=true	
    moveObject(drzwi.obiekt,6000,2690.580078125,-1671.509765625,1439.1633300781,0,0,0,"OutBounce")
    setTimer(function() drzwi.animacja=false drzwi.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=35 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank and tonumber(wynik.rank)>=2 and tonumber(wynik.rank)<=8) then return true else return false end
end

drzwi.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
    if (not pracownik(tonumber(c.id))) then
	outputChatBox("(( nie masz klucza do tych drzwi ))", gracz)
	return
    end
    
    local x,y,z=getElementPosition(drzwi.obiekt)
    local x2,y2,z2=getElementPosition(gracz)
    local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist>4) or getPedOccupiedVehicle(gracz)) then
	outputChatBox("Podejdź bliżej do drzwi.", gracz, 255,0,0,true)
	return
    end

    if (drzwi.animacja) then
	outputChatBox("Odczekaj chwilę.", gracz, 255,0,0,true)
	return
    end
    if (drzwi.zamknieta) then
	drzwi.otworz()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " otwiera drzwi.", 5, 15, true)
    else
	drzwi.zamknij()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " zamyka drzwi.", 5, 15, true)
    end

end

addEvent("onStadion3aBramaToggleRequest", true)
addEventHandler("onStadion3aBramaToggleRequest", resourceRoot, drzwi.toggle)
