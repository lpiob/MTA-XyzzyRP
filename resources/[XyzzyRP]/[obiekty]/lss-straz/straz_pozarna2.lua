local brama2={}
brama2.obiekt=createObject(2885,885.81146240234,-1283.177734375,20.849021911621,0,0,270)
setElementData(brama2.obiekt,"customAction",{label="Otwórz/zamknij",resource="lss-straz",funkcja="menu_brama2",args={}})

brama2.animacja=false
brama2.zamknieta=true

brama2.otworz=function()
    if (brama2.animacja or not brama2.zamknieta) then return false end
    brama2.animacja=true
    moveObject(brama2.obiekt,5000,885.81146240234,-1283.177734375,20.849021911621,-90,0,0,"OutBounce")
    setTimer(function() brama2.animacja=false brama2.zamknieta=false end, 6000, 1)
end

brama2.zamknij=function()
    if (brama2.animacja or brama2.zamknieta) then return false end
    brama2.animacja=true	
    moveObject(brama2.obiekt,5000,885.81146240234,-1283.177734375,20.849021911621,90,0,0,"OutBounce")
    setTimer(function() brama2.animacja=false brama2.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=11 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank and tonumber(wynik.rank)>=2 and tonumber(wynik.rank)<=8) then return true else return false end
end

brama2.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
	local fid=getElementData(gracz,"faction:id")
	if not fid or fid~=11 then
		outputChatBox("(( Nie masz klucza do tej bramy ))", gracz)
		return
	end
    
    local x,y,z=getElementPosition(brama2.obiekt)
    local x2,y2,z2=getElementPosition(gracz)
    local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist>25)) then
	outputChatBox("Podejdź bliżej do bramy.", gracz, 255,0,0,true)
	return
    end

    if (brama2.animacja) then
	outputChatBox("Odczekaj chwilę.", gracz, 255,0,0,true)
	return
    end
    if (brama2.zamknieta) then
	brama2.otworz()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " otwiera bramę.", 5, 15, true)
    else
	brama2.zamknij()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " zamyka bramę.", 5, 15, true)
    end

end

addEvent("onStraz_pozarnaBrama2ToggleRequest", true)
addEventHandler("onStraz_pozarnaBrama2ToggleRequest", resourceRoot, brama2.toggle)
