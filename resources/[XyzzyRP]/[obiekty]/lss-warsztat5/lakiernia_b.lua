local brama={}
brama[1]=createObject(11416,120.0216293335,-183.76448059082,2.6227464675903,0,0,90)
brama[2]=createObject(11416,115.6703338623,-183.74078369141,2.6227464675903,0,0,90)
brama[3]=createObject(11416,111.26872253418,-183.76448059082,2.6227464675903,0,0,90)
setElementData(brama[1],"customAction",{label="Otwórz/zamknij",resource="lss-warsztat5",funkcja="menu_brama2",args={}})
setElementData(brama[2],"customAction",{label="Otwórz/zamknij",resource="lss-warsztat5",funkcja="menu_brama2",args={}})
setElementData(brama[3],"customAction",{label="Otwórz/zamknij",resource="lss-warsztat5",funkcja="menu_brama2",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true

    moveObject(brama[1],10000,120.0216293335,-183.76448059082,2.6227464675903-4.05,0,0,0,"OutBounce")
    
    moveObject(brama[2],10000,115.6703338623,-183.74078369141,2.6227464675903-4.02,0,0,0,"OutBounce")
	
    moveObject(brama[3],10000,111.26872253418,-183.76448059082,2.6227464675903-4.05,0,0,0,"OutBounce")

    setTimer(function() brama.animacja=false brama.zamknieta=false end, 3000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true
    local _,_,rz=getElementRotation(brama[1])
    moveObject(brama[1],10000,120.0216293335,-183.76448059082,2.6227464675903,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama[2])
    moveObject(brama[2],10000,115.6703338623,-183.74078369141,2.6227464675903,0,0,0,"OutBounce")
	
    local _,_,rz=getElementRotation(brama[3])
    moveObject(brama[3],10000,111.26872253418,-183.76448059082,2.6227464675903,0,0,0,"OutBounce")

    setTimer(function() brama.animacja=false brama.zamknieta=true end, 3000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=19 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank) then return true else return false end
end

brama.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
	local fid=getElementData(gracz,"faction:id")
	if not fid or fid~=19 then
		outputChatBox("(( Nie masz klucza do tej bramy ))", gracz)
		return
	end
	-- sprawdzanie rangi (opcjonalne)
	local lfrid=getElementData(gracz,"faction:rank_id")
	if not lfrid or lfrid<1 then	-- minimalnie ranga 2 i wyzsza
		outputChatBox("(( Nie masz klucza do tej bramy ))", gracz)
		return
	end
    
    
    local x,y,z=getElementPosition(brama[1])
    local x2,y2,z2=getElementPosition(gracz)
    local dist1=getDistanceBetweenPoints2D(x,y,x2,y2)
    x,y,z=getElementPosition(brama[2])
    local dist2=getDistanceBetweenPoints2D(x,y,x2,y2)
    x,y,z=getElementPosition(brama[3])
    local dist3=getDistanceBetweenPoints2D(x,y,x2,y2)

    
    if ((dist1>5.7 and dist2>5.7 and dist3>5.7 and dist4>5.7) or getPedOccupiedVehicle(gracz)) then
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

addEvent("onWarsztat5Brama2ToggleRequest", true)
addEventHandler("onWarsztat5Brama2ToggleRequest", resourceRoot, brama.toggle)