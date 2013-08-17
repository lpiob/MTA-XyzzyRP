-- strefa naprawiajaca auta





-- brama na zewnatrz

--[[
<map edf:definitions="editor_main">
	<object id="object (gate_autoR) (14)" doublesided="false" model="985" interior="0" dimension="0" posX="647.662109375" posY="-136.8486328125" posZ="26.121578216553" rotX="0" rotY="0" rotZ="179.99450683594"></object>
	<object id="object (gate_autoL) (4)" doublesided="false" model="986" interior="0" dimension="0" posX="655.63671875" posY="-136.8486328125" posZ="26.121578216553" rotX="0" rotY="0" rotZ="179.99450683594"></object>	
</map>
    <object id="object (gate_autoR) (4)" doublesided="false" model="985" interior="0" dimension="0" posX="2319.2177734375" posY="-109.505859375" posZ="27.199689865112" rotX="0" rotY="0" rotZ="0"></object>
    <object id="object (gate_autoL) (3)" doublesided="false" model="986" interior="0" dimension="0" posX="2311.25" posY="-109.505859375" posZ="27.199689865112" rotX="0" rotY="0" rotZ="0"></object>

]]--

local brama={}
brama.l=createObject(985,2319.217,-109.505859,27.19968,0,0,0)
brama.r=createObject(986,2311.250,-109.505859,27.19968,0,0,0)


setElementData(brama.l,"customAction",{label="Otwórz/zamknij",resource="lss-warsztat3",funkcja="menu_brama",args={}})
setElementData(brama.r,"customAction",{label="Otwórz/zamknij",resource="lss-warsztat3",funkcja="menu_brama",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true
--    local _,_,rz=getElementRotation(brama.l)
    moveObject(brama.l,5000,2319.217+1,-109.505859,27.19968,0,0,0,"OutBounce")
    
--    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,5000,2311.250-1,-109.505859,27.19968,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true
    local _,_,rz=getElementRotation(brama.l)

    moveObject(brama.l,5000,2319.217,-109.505859,27.19968,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,5000,2311.250,-109.505859,27.19968,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=13 AND character_id=%d", id)
    local wynik=exports.DB:pobierzWyniki(query)
    if (wynik and wynik.rank) then return true else return false end
end
--addCommandHandler("bo",brama.otworz)
--addCommandHandler("bz",brama.zamknij)
brama.toggle=function(gracz)
    -- automagiczne spawdzanie czy gracz jest pracownikiem frakcji
    local c=getElementData(gracz,"character")
    if (not c or not c.id) then return end
    if (not pracownik(tonumber(c.id))) then
	outputChatBox("(( nie masz klucza do tej bramy ))", gracz)
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

addEvent("onWarsztat3BramaToggleRequest", true)
addEventHandler("onWarsztat3BramaToggleRequest", resourceRoot, brama.toggle)

