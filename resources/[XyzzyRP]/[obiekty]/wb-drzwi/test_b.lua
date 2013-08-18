
local brama={}
brama.obiekt=createObject(2885,3502.95,3544.64,207.73,0,0,335.98406982422)
setElementData(brama.obiekt,"customAction",{label="Otwórz/zamknij",resource="wb-drzwi",funkcja="menu_brama",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true
    moveObject(brama.obiekt,5000,3502.95,3544.64,207.73,-90,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true	
    moveObject(brama.obiekt,5000,3502.95,3544.64,207.73,90,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions SET faction:duty WHERE faction_id=20 AND character_id=%d AND rank=4", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank) then return true else return false end
end

brama.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
--[[ sprawdzanie czy gracz jest pracownikiem (niekoniecznie na duty)
	if (not pracownik(tonumber(c.id))) then
		outputChatBox("(( nie masz klucza do tej bramy ))", gracz)
		return
	end ]]--
	-- sprawdzanie czy gracz jest na duty
	local fid=getElementData(gracz,"faction:id")
	if not fid or fid~=20 then
		outputChatBox("(( Nie masz klucza do tej bramy", gracZ)
		return
	end
	-- sprawdzanie rangi (opcjonalne)
	local lfrid=getElementData(gracz,"faction:rank_id")
	if not lfrid or lfrid<2 then	-- minimalnie ranga 2 i wyzsza
		outputChatBox("(( Nie masz klucza do tej bramy", gracZ)
		return
	end
    
    local x,y,z=getElementPosition(brama.obiekt)
    local x2,y2,z2=getElementPosition(gracz)
    local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist>15) or getPedOccupiedVehicle(gracz)) then
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

addEvent("onTestBramaToggleRequest", true)
addEventHandler("onTestBramaToggleRequest", resourceRoot, brama.toggle)
