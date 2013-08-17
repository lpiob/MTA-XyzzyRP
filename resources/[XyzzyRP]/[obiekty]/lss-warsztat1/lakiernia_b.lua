local brama={}
brama.obiekt=createObject(5422,2071.494140625,-1831.4227294922,14.559337615967,0,0,0)
setElementData(brama.obiekt,"customAction",{label="Otwórz/zamknij",resource="lss-warsztat1",funkcja="menu_brama2",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true
    moveObject(brama.obiekt,10000,2071.494140625,-1831.4227294922,14.559337615967+3.65,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true	
    moveObject(brama.obiekt,10000,2071.494140625,-1831.4227294922,14.559337615967,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=3 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank) then return true else return false end
end

brama.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
	local fid=getElementData(gracz,"faction:id")
	if not fid or fid~=3 then
		outputChatBox("(( Nie masz klucza do tej bramy ))", gracz)
		return
	end
	-- sprawdzanie rangi (opcjonalne)
	local lfrid=getElementData(gracz,"faction:rank_id")
	if not lfrid or lfrid<1 then	-- minimalnie ranga 2 i wyzsza
		outputChatBox("(( Nie masz klucza do tej bramy ))", gracz)
		return
	end
    
    local x,y,z=getElementPosition(brama.obiekt)
    local x2,y2,z2=getElementPosition(gracz)
    local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist>5.7)) then
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

addEvent("onWarsztatBrama2ToggleRequest", true)
addEventHandler("onWarsztatBrama2ToggleRequest", resourceRoot, brama.toggle)
