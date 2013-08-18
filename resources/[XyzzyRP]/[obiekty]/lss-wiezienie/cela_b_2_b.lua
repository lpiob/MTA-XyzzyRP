local brama={}
brama.l=createObject(2930,2690.99609375,-2670.7478027344,8.8243560791016,0,0,0)
brama.r=createObject(2930,2690.99609375,-2672.3908691406,8.8243560791016,0,0,0)

-- dimension
setElementDimension(brama.l, 35) 
setElementDimension(brama.r, 35) 
-- interior
setElementInterior(brama.l, 0) 
setElementInterior(brama.r, 0) 

setElementData(brama.l,"customAction",{label="Otwórz/zamknij",resource="lss-wiezienie",funkcja="menu_brama12",args={}})
setElementData(brama.r,"customAction",{label="Otwórz/zamknij",resource="lss-wiezienie",funkcja="menu_brama12",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true
--    local _,_,rz=getElementRotation(brama.l)
    moveObject(brama.l,5000,2690.99609375,-2670.7478027344-2.5,8.8243560791016,0,0,0,"OutBounce")
    
--    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,5000,2690.99609375,-2672.3908691406-2.5,8.8243560791016,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true
    local _,_,rz=getElementRotation(brama.l)

    moveObject(brama.l,5000,2690.99609375,-2670.7478027344,8.8243560791016,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,5000,2690.99609375,-2672.3908691406,8.8243560791016,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=20 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
-- tak bylo
--    if (wynik and wynik.rank) then return true else return false end
-- tak jest zeby sprawdzac rangi od 2 do 5
    if (wynik and wynik.rank and tonumber(wynik.rank)>=3 and tonumber(wynik.rank)<=4) then return true else return false end
end
--addCommandHandler("bo",brama.otworz)
--addCommandHandler("bz",brama.zamknij)
brama.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
	local fid=getElementData(gracz,"faction:id")
	if not fid or fid~=20 then
		outputChatBox("(( Nie masz klucza do tej bramy ))", gracz)
		return
	end
	-- sprawdzanie rangi (opcjonalne)
	local lfrid=getElementData(gracz,"faction:rank_id")
	if not lfrid or lfrid<3 then	-- minimalnie ranga 2 i wyzsza
		outputChatBox("(( Nie masz klucza do tej bramy ))", gracz)
		return
	end
    
    
    local x,y,z=getElementPosition(brama.l)
    local x2,y2,z2=getElementPosition(gracz)
    local dist1=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    x,y,z=getElementPosition(brama.r)
    local dist2=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist1>5 and dist2>5) or getPedOccupiedVehicle(gracz)) then
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

addEvent("onCela_b_2BramaToggleRequest", true)
addEventHandler("onCela_b_2BramaToggleRequest", resourceRoot, brama.toggle)

