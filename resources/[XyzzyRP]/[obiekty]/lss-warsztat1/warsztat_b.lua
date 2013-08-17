-- strefa naprawiajaca auta

-- 1847.89,-1784.65,17.66,182.5
-- 1850.89,-1764.17,17.90,358.3



-- sterowanie podnosnikami przez panel

addEvent("onWarsztatPodnosnikSterowanie", true)
function podnosnikSterowanie(podnosnik, stan)
	outputDebugString("podnosnik 1")
	setPedAnimation(client, "CRIB", "CRIB_Use_Switch", -1, false, false, true, false)
--    outputChatBox("STerowanie " .. podnosnik .. " stan " .. stan)
    if (podnosnik==1) then
        ruchObiektow({"podnosnik1", "podnosnik2", "podnosnik3", "podnosnik4", "podnosnik5", "podnosnik6"}, tonumber(stan)+1, 4000)
    elseif (podnosnik==2) then
        ruchObiektow({"podnosnik7", "podnosnik8", "podnosnik9", "podnosnik10", "podnosnik11", "podnosnik12"}, tonumber(stan)+1, 4000)
    end
end

addEventHandler("onWarsztatPodnosnikSterowanie", resourceRoot, podnosnikSterowanie)

function ruchObiektow(obiekty, krok, czas)
	local postfix="_"..krok
	for _,nazwa_obiektu in ipairs(obiekty) do
		local obiekt=getElementByID(nazwa_obiektu)
		if (obiekt) then
			local cx,cy,cz=getElementPosition(obiekt)

			local posX=getElementData(obiekt,"posX"..postfix)
			if (not posX) then posX=cx end
			local posY=getElementData(obiekt,"posY"..postfix)
			if (not posY) then posY=cy end
			local posZ=getElementData(obiekt,"posZ"..postfix)
			if (not posZ) then posZ=cz end
			moveObject(obiekt, czas, posX, posY, posZ)
		end
	end
    
end


local brama={}
brama.l=createObject(985,1926.7243652344,-1797.2065429688,14.25835609436,0,0,0)
brama.r=createObject(986,1918.7353515625,-1797.2060546875,14.25835609436,0,0,0)


setElementData(brama.l,"customAction",{label="Otwórz/zamknij",resource="lss-warsztat1",funkcja="menu_brama",args={}})
setElementData(brama.r,"customAction",{label="Otwórz/zamknij",resource="lss-warsztat1",funkcja="menu_brama",args={}})

brama.animacja=false
brama.zamknieta=true

brama.otworz=function()
    if (brama.animacja or not brama.zamknieta) then return false end
    brama.animacja=true
--    local _,_,rz=getElementRotation(brama.l)
    moveObject(brama.l,5000,1926.7243652344+7,-1797.2065429688,14.25835609436,0,0,0,"OutBounce")
    
--    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,5000,1918.7353515625-7,-1797.2060546875,14.25835609436,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=false end, 6000, 1)
end

brama.zamknij=function()
    if (brama.animacja or brama.zamknieta) then return false end
    brama.animacja=true
    local _,_,rz=getElementRotation(brama.l)

    moveObject(brama.l,5000,1926.7243652344,-1797.2065429688,14.25835609436,0,0,0,"OutBounce")

    local _,_,rz=getElementRotation(brama.r)
    moveObject(brama.r,5000,1918.7353515625,-1797.2060546875,14.25835609436,0,0,0,"OutBounce")
    setTimer(function() brama.animacja=false brama.zamknieta=true end, 6000, 1)
end


local function pracownik(id)
    local query=string.format("SELECT rank FROM lss_character_factions WHERE faction_id=3 AND character_id=%d", id)
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

addEvent("onWarsztat1BramaToggleRequest", true)
addEventHandler("onWarsztat1BramaToggleRequest", resourceRoot, brama.toggle)
