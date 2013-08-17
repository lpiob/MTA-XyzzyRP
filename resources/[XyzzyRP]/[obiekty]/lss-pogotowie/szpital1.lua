local szlaban1={}
szlaban1.obiekt=createObject(968,2010.912109375,-1451.408203125,13.227602958679,0,270,0)
setElementData(szlaban1.obiekt,"customAction",{label="Otwórz/zamknij",resource="lss-medycy",funkcja="menu_szlaban1",args={}})

szlaban1.animacja=false
szlaban1.zamknieta=true

szlaban1.otworz=function()
    if (szlaban1.animacja or not szlaban1.zamknieta) then return false end
    szlaban1.animacja=true
    moveObject(szlaban1.obiekt,5000,2010.912109375,-1451.408203125,13.227602958679,0,90,0,"OutBounce")
    setTimer(function() szlaban1.animacja=false szlaban1.zamknieta=false end, 6000, 1)
end

szlaban1.zamknij=function()
    if (szlaban1.animacja or szlaban1.zamknieta) then return false end
    szlaban1.animacja=true	
    moveObject(szlaban1.obiekt,5000,2010.912109375,-1451.408203125,13.227602958679,0,-90,0,"OutBounce")
    setTimer(function() szlaban1.animacja=false szlaban1.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=6 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank) then return true else return false end
end

szlaban1.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
    if (not pracownik(tonumber(c.id))) then
	outputChatBox("(( nie masz pilota do tego szlabanu ))", gracz)
	return
    end
    
    local x,y,z=getElementPosition(szlaban1.obiekt)
    local x2,y2,z2=getElementPosition(gracz)
    local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist>7) or getPedOccupiedVehicle(gracz)) then
	outputChatBox("Podejdź bliżej szlabanu.", gracz, 255,0,0,true)
	return
    end

    if (szlaban1.animacja) then
	outputChatBox("Odczekaj chwilę.", gracz, 255,0,0,true)
	return
    end
    if (szlaban1.zamknieta) then
	szlaban1.otworz()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " otwiera szlaban.", 5, 15, true)
    else
	szlaban1.zamknij()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " zamyka szlaban.", 5, 15, true)
    end

end

addEvent("onSzpitalSzlaban1ToggleRequest", true)
addEventHandler("onSzpitalSzlaban1ToggleRequest", resourceRoot, szlaban1.toggle)
