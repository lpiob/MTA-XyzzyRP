local brama1={}
brama1.obiekt=createObject(2885,885.81146240234,-1268.4152832031,20.849021911621,0,0,270)
setElementData(brama1.obiekt,"customAction",{label="Otwórz/zamknij",resource="lss-straz",funkcja="menu_brama1",args={}})

brama1.animacja=false
brama1.zamknieta=true

brama1.otworz=function()
    if (brama1.animacja or not brama1.zamknieta) then return false end
    brama1.animacja=true
    moveObject(brama1.obiekt,5000,885.81146240234,-1268.4152832031,20.849021911621,-90,0,0,"OutBounce")
    setTimer(function() brama1.animacja=false brama1.zamknieta=false end, 6000, 1)
end

brama1.zamknij=function()
    if (brama1.animacja or brama1.zamknieta) then return false end
    brama1.animacja=true	
    moveObject(brama1.obiekt,5000,885.81146240234,-1268.4152832031,20.849021911621,90,0,0,"OutBounce")
    setTimer(function() brama1.animacja=false brama1.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=11 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank and tonumber(wynik.rank)>=2 and tonumber(wynik.rank)<=8) then return true else return false end
end

brama1.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
	local fid=getElementData(gracz,"faction:id")
	if not fid or fid~=11 then
		outputChatBox("(( Nie masz klucza do tej bramy ))", gracz)
		return
	end
    
    local x,y,z=getElementPosition(brama1.obiekt)
    local x2,y2,z2=getElementPosition(gracz)
    local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist>25)) then
	outputChatBox("Podejdź bliżej do bramy.", gracz, 255,0,0,true)
	return
    end

    if (brama1.animacja) then
	outputChatBox("Odczekaj chwilę.", gracz, 255,0,0,true)
	return
    end
    if (brama1.zamknieta) then
	brama1.otworz()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " otwiera bramę.", 5, 15, true)
    else
	brama1.zamknij()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " zamyka bramę.", 5, 15, true)
    end

end

addEvent("onStraz_pozarnaBrama1ToggleRequest", true)
addEventHandler("onStraz_pozarnaBrama1ToggleRequest", resourceRoot, brama1.toggle)


-- npc

local strazak=createPed(279,912.18,-1234.39,16.99,0.7,false)
setElementFrozen(strazak,true)
setElementData(strazak,"npc", true)
setElementData(strazak,"name", "Strażak")