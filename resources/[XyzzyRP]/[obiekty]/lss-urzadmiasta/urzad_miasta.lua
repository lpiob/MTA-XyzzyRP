local szlaban={}
szlaban.obiekt=createObject(968,1396.5875244141,-1781.6037597656,13.302556037903,0,90,90)
setElementData(szlaban.obiekt,"customAction",{label="Otwórz/zamknij",resource="lss-urzadmiasta",funkcja="menu_szlaban",args={}})

szlaban.animacja=false
szlaban.zamknieta=true

szlaban.otworz=function()
    if (szlaban.animacja or not szlaban.zamknieta) then return false end
    szlaban.animacja=true
    moveObject(szlaban.obiekt,5000,1396.5875244141,-1781.6037597656,13.302556037903,0,-90,0,"OutBounce")
    setTimer(function() szlaban.animacja=false szlaban.zamknieta=false end, 6000, 1)
end

szlaban.zamknij=function()
    if (szlaban.animacja or szlaban.zamknieta) then return false end
    szlaban.animacja=true	
    moveObject(szlaban.obiekt,5000,1396.5875244141,-1781.6037597656,13.302556037903,0,90,0,"OutBounce")
    setTimer(function() szlaban.animacja=false szlaban.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=1 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank) then return true else return false end
end

szlaban.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
    if (not pracownik(tonumber(c.id))) then
	outputChatBox("(( nie masz pilota do tego szlabanu ))", gracz)
	return
    end
    
    local x,y,z=getElementPosition(szlaban.obiekt)
    local x2,y2,z2=getElementPosition(gracz)
    local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist>12)) then
	outputChatBox("Podejdź bliżej szlabanu.", gracz, 255,0,0,true)
	return
    end

    if (szlaban.animacja) then
	outputChatBox("Odczekaj chwilę.", gracz, 255,0,0,true)
	return
    end
    if (szlaban.zamknieta) then
	szlaban.otworz()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " otwiera szlaban.", 5, 15, true)
    else
	szlaban.zamknij()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " zamyka szlaban.", 5, 15, true)
    end

end

addEvent("onUrzad_miastaSzlabanToggleRequest", true)
addEventHandler("onUrzad_miastaSzlabanToggleRequest", resourceRoot, szlaban.toggle)
