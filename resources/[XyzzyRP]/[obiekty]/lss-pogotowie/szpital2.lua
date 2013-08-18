local szlaban2={}
szlaban2.obiekt=createObject(968,2005.9985351563,-1450.8907470703,13.256170272827,0,270,0)
setElementData(szlaban2.obiekt,"customAction",{label="Otwórz/zamknij",resource="lss-medycy",funkcja="menu_szlaban2",args={}})

szlaban2.animacja=false
szlaban2.zamknieta=true

szlaban2.otworz=function()
    if (szlaban2.animacja or not szlaban2.zamknieta) then return false end
    szlaban2.animacja=true
    moveObject(szlaban2.obiekt,5000,2005.9985351563,-1450.8907470703,13.256170272827,0,90,0,"OutBounce")
    setTimer(function() szlaban2.animacja=false szlaban2.zamknieta=false end, 6000, 1)
end

szlaban2.zamknij=function()
    if (szlaban2.animacja or szlaban2.zamknieta) then return false end
    szlaban2.animacja=true	
    moveObject(szlaban2.obiekt,5000,2005.9985351563,-1450.8907470703,13.256170272827,0,-90,0,"OutBounce")
    setTimer(function() szlaban2.animacja=false szlaban2.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=6 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank) then return true else return false end
end

szlaban2.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
    if (not pracownik(tonumber(c.id))) then
	outputChatBox("(( nie masz pilota do tego szlabanu ))", gracz)
	return
    end
    
    local x,y,z=getElementPosition(szlaban2.obiekt)
    local x2,y2,z2=getElementPosition(gracz)
    local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist>3) or getPedOccupiedVehicle(gracz)) then
	outputChatBox("Podejdź bliżej szlabanu.", gracz, 255,0,0,true)
	return
    end

    if (szlaban2.animacja) then
	outputChatBox("Odczekaj chwilę.", gracz, 255,0,0,true)
	return
    end
    if (szlaban2.zamknieta) then
	szlaban2.otworz()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " otwiera szlaban.", 5, 15, true)
    else
	szlaban2.zamknij()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " zamyka szlaban.", 5, 15, true)
    end

end

addEvent("onSzpitalSzlaban2ToggleRequest", true)
addEventHandler("onSzpitalSzlaban2ToggleRequest", resourceRoot, szlaban2.toggle)
