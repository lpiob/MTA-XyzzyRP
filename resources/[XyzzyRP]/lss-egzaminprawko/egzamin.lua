--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



D=14

local pojazd

local egzaminy_cp = {
    createMarker(1111.76,-1306.00,14.08,"checkpoint", 3, 255,255,255),
    createMarker(1170.82,-1316.08,14.07,"checkpoint", 3, 255,255,255),
    createMarker(1111.76,-1306.00,14.08,"checkpoint", 3, 255,255,255),    
    createMarker(1080.43,-1296.54,14.08,"checkpoint", 3, 255,255,255)
}

for i,v in ipairs(egzaminy_cp) do
	setElementDimension(v,D)
end

--[[
local terenegzaminu={
    createColCuboid(1075,-1299,13, 99, 5, 4), --prosta
    createColCuboid(1107,-1315,13, 9, 18, 4),-- zatoczka
    createColCuboid(-- luk
}
]]--
local terenEgzaminu = createColPolygon(
    1167,-1303,
    1173.37,-1321.20,1174.18,-1312.06,1172.93,-1306.17,1170.74,-1299.20,1161.61,-1293.87,
    1075.56,-1293.48,1075.44,-1299.10,1107.10,-1299.28,1106.99,-1315.22,1116.66,-1315.33,
    1116.82,-1299.22,1159.46,-1299.53,1166.81,-1307.69,1167.67,-1321.00)

-- 1159.27,-1298.66,14.06,251.8
-- 1173.37,-1321.20,14.07,358.9
setElementDimension(terenEgzaminu,D)

local saved_pos={}

local egzamin_step=0
local egzaminowany=nil

for i,v in ipairs(egzaminy_cp) do
    setElementVisibleTo ( v, getRootElement ( ), false )
end

function egzamin_init(plr)

    if (egzamin_step>0 and isElement(egzaminowany)) then
	return false
    end
    
    if (#getElementsWithinColShape(terenEgzaminu,"player")+#getElementsWithinColShape(terenEgzaminu,"vehicle")>0) then
	-- na terenie egzaminu jest gracz rob pojazd - nie mozemy zaczac
	return false
    end
    if (pojazd and isElement(pojazd)) then destroyElement(pojazd) end
    pojazd=createVehicle(589,1079.97,-1296.55,13.79,0,0,270,"EGZAMIN")
    if (not pojazd) then return false end
	setElementDimension(pojazd,D)

    -- sprawdzamy czy są jakies pojazdy lub gracze na terenie egzaminu

    saved_pos.x, saved_pos.y, saved_pos.z=getElementPosition(plr)
    saved_pos.i=getElementInterior(plr)
    saved_pos.d=getElementDimension(plr)
    fadeCamera(plr,false)
    egzamin_step=1
    egzaminowany=plr
    setTimer(function()
    	setElementInterior(plr,0)
	setElementDimension(plr,D)
	setElementPosition(plr, 1080,-1294,13.79)
	
	warpPedIntoVehicle(plr,pojazd)


	fadeCamera(plr, true)

        triggerClientEvent(egzaminowany, "onCaptionedEvent", root, "Wjedź przodem do zatoczki po prawej stronie.",6)
        outputChatBox("Wjedź przodem do zatoczki po prawej stronie.", egzaminowany, 0,255,0,true)
        for i,v in ipairs(egzaminy_cp) do
		setElementVisibleTo ( v, getRootElement ( ), false )
		if (i==egzamin_step) then
	        	setElementVisibleTo ( v, plr, true )
		else
			setElementVisibleTo ( v, plr, false )
		end
        end
    end, 1000, 1)
    return true
end

function egzamin_finish(zdal)
    egzamin_step=0

    for i,v in ipairs(egzaminy_cp) do
    	setElementVisibleTo ( v, egzaminowany, false )
    end
    fadeCamera(egzaminowany,false)
    if (zdal) then
	local character=getElementData(egzaminowany, "character")
	
	outputChatBox("Gratulacje! Otrzymujesz prawo jazdy, kategorię B!", egzaminowany, 0,255,0,true)
	exports["lss-core"]:eq_giveItem(egzaminowany, 17, 1, tonumber(character.id))
	local query=string.format("UPDATE lss_characters set pjB=1 WHERE id=%d LIMIT 1", character.id)
	exports.DB:zapytanie(query)
	exports["lss-achievements"]:checkAchievementForPlayer(egzaminowany, "drivlicB")
    end
    setTimer(function()
	removePedFromVehicle(egzaminowany)
        destroyElement(pojazd)
        setElementDimension(egzaminowany, saved_pos.d)
        setElementInterior(egzaminowany, saved_pos.i)
        setElementPosition(egzaminowany, saved_pos.x, saved_pos.y, saved_pos.z)

	fadeCamera(egzaminowany,true)
	egzaminowany=nil
	
	end, 1000, 1)
end

addEventHandler("onMarkerHit", resourceRoot, function(el,md)
    if (egzamin_step<1) then return end
    if (not md) then return end
    if (not isElementVisibleTo(source, el)) then return end
    
    
    if (el~=egzaminowany) then return end

    -- weryfikacja wykonania zadania
    if (egzamin_step==1) then
	local _,_,rz=getElementRotation(pojazd)
	if (rz>217 or rz<145) then
	    outputChatBox("Do zatoczki należało wjechać przodem. Oblewasz egzamin!", egzaminowany, 255,0,0,true)
	    egzamin_finish(false)
	    return
	end
    elseif (egzamin_step==2) then
	local _,_,rz=getElementRotation(pojazd)
	if (rz<333 and rz>32) then
	    outputChatBox("Po łuku należało jechać tyłem! Oblewasz egzamin!", egzaminowany, 255,0,0,true)
	    egzamin_finish(false)
	    return
	end
    elseif (egzamin_step==3) then
	local _,_,rz=getElementRotation(pojazd)
	if (rz>32 and rz<326) then
	    outputChatBox("Do zatoczki należało wjechać tyłem. Oblewasz egzamin!", egzaminowany, 255,0,0,true)
	    egzamin_finish(false)
	    return
	end
    elseif (egzamin_step==4) then
	local _,_,rz=getElementRotation(pojazd)
	if (rz<245 or rz>288) then
	    outputChatBox("Na początek należało wjechać tyłem. Oblewasz egzamin!", egzaminowany, 255,0,0,true)
	    egzamin_finish(false)
	    return
	end
    
    end

    egzamin_step=egzamin_step+1
    for i,v in ipairs(egzaminy_cp) do
	setElementVisibleTo ( v, getRootElement ( ), false )

	if (i==egzamin_step) then
        	setElementVisibleTo ( v, egzaminowany, true )
	else
		setElementVisibleTo ( v, egzaminowany, false )
	end
    end
    playSoundFrontEnd(egzaminowany, 3)

    if (egzamin_step==2) then
	triggerClientEvent(egzaminowany, "onCaptionedEvent", root, "Wycofaj w lewo i podjedź na wstecznym do końca łuku.",6)
	outputChatBox("Wycofaj w lewo i podjedź na wstecznym do końca łuku.", egzaminowany, 0,255,0,true)
    elseif (egzamin_step==3) then
	triggerClientEvent(egzaminowany, "onCaptionedEvent", root, "Podjedź do zatoczki i wjedź w nią tyłem.",6)
	outputChatBox("Podjedź do zatoczki i wjedź w nią tyłem.", egzaminowany, 0,255,0,true)
    elseif (egzamin_step==4) then
	triggerClientEvent(egzaminowany, "onCaptionedEvent", root, "Wyjedź w prawo i wycofaj tyłem na początek egzaminu.",6)
	outputChatBox("Wyjedź w prawo i wycofaj tyłem na początek egzaminu.", egzaminowany, 0,255,0,true)
    elseif (egzamin_step==5) then
	egzamin_finish(true)
    end

end)

addEventHandler("onVehicleDamage", resourceRoot, function(loss)
    if (loss>1 and egzamin_step>0) then
        outputChatBox("Pojazd został uszkodzony! Oblewasz egzamin!", egzaminowany, 255,0,0,true)
        egzamin_finish(false)
        return
    end
end)

addEventHandler ( "onVehicleStartExit", resourceRoot, function()
    cancelEvent()
end )

addEventHandler("onColShapeLeave", terenEgzaminu, function(el, md)
    if (egzamin_step<1) then return end
    if (not md) then return end
    if (el~=pojazd) then return end
    outputChatBox("Opuściłeś teren egzaminu! Oblewasz!", egzaminowany, 255,0,0,true)
    egzamin_finish(false)
end)

--[[
addCommandHandler("xegzx", function(plr,cmd)
    if (not egzamin_init(plr)) then
	outputChatBox("Niestety plac manewrowy jest obecnie zajęty, proszę chwilę odczekać.", plr, 255,0,0,true)
    end
end)
]]--

function egzamin_check()
    if (egzamin_step<1) then return end
    if (not isElement(egzaminowany) or not isElement(pojazd)) then	-- gracz wyszedl z gry?
	if (isElement(pojazd)) then destroyElement(pojazd) end
	egzamin_step=0
	egzaminowany=nil
    end
end

setTimer(egzamin_check, 30000, 0)

