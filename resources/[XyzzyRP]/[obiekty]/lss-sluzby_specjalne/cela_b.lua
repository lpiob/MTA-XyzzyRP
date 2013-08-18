local brama={}
brama.l=createObject(2930,1243.4145507813,-1441.8693847656,2296.671875,0,0,90)
brama.r=createObject(2930,1241.6875,-1441.8693847656,2296.671875,0,0,90)

-- dimension
setElementDimension(brama.l, 40) 
setElementDimension(brama.r, 40) 
-- interior
setElementInterior(brama.l, 1) 
setElementInterior(brama.r, 1) 

setElementData(brama.l,"customAction",{label="Otwórz/zamknij",resource="lss-sluzby_specjalne",funkcja="menu_brama3",args={}})
setElementData(brama.r,"customAction",{label="Otwórz/zamknij",resource="lss-sluzby_specjalne",funkcja="menu_brama3",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true
--    local _,_,rz=getElementRotation(brama.l)
    moveObject(brama.l,4000,1243.4145507813+0.8,-1441.8693847656,2296.671875,0,0,0,"OutBounce")
    
--    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,4000,1241.6875-0.8,-1441.8693847656,2296.671875,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true
    local _,_,rz=getElementRotation(brama.l)

    moveObject(brama.l,4000,1243.4145507813,-1441.8693847656,2296.671875,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,4000,1241.6875,-1441.8693847656,2296.671875,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=22 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
-- tak bylo
--    if (wynik and wynik.rank) then return true else return false end
-- tak jest zeby sprawdzac rangi od 2 do 5
    if (wynik and wynik.rank and tonumber(wynik.rank)>=2 and tonumber(wynik.rank)<=6) then return true else return false end
end
--addCommandHandler("bo",brama.otworz)
--addCommandHandler("bz",brama.zamknij)
brama.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
	local fid=getElementData(gracz,"faction:id")
	if not fid or fid~=22 then
		outputChatBox("(( Nie masz klucza do tych drzwi ))", gracz)
		return
	end
	-- sprawdzanie rangi (opcjonalne)
	local lfrid=getElementData(gracz,"faction:rank_id")
	if not lfrid or lfrid<2 then	-- minimalnie ranga 2 i wyzsza
		outputChatBox("(( Nie masz klucza do tych drzwi ))", gracz)
		return
	end
    
    
    local x,y,z=getElementPosition(brama.l)
    local x2,y2,z2=getElementPosition(gracz)
    local dist1=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    x,y,z=getElementPosition(brama.r)
    local dist2=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    
    if ((dist1>2.5 and dist2>2.5) or getPedOccupiedVehicle(gracz)) then
	outputChatBox("Podejdź bliżej do drzwi.", gracz, 255,0,0,true)
	return
    end

    if (brama.animacja) then
	outputChatBox("Odczekaj chwilę.", gracz, 255,0,0,true)
	return
    end
    if (brama.zamknieta) then
	brama.otworz()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " otwiera drzwi.", 5, 15, true)
    else
	brama.zamknij()
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " zamyka drzwi.", 5, 15, true)
    end

end

addEvent("onCelaBramaToggleRequest", true)
addEventHandler("onCelaBramaToggleRequest", resourceRoot, brama.toggle)

