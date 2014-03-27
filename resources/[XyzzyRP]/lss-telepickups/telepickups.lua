--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local tepi={}


function tepi_reload()
    for i,v in ipairs(tepi) do
	if (v.marker) then
	    destroyElement(v.marker)
	end
	if (v.blip) then
	    destroyElement(v.blip)
	end
	if (v.opis_text3d) then
	    destroyElement(v.opis_text3d)
	end
    end
    
    tepi=exports.DB:pobierzTabeleWynikow("SELECT * FROM lss_telepickups")
    if (not tepi) then return end
    for i,v in ipairs(tepi) do
	tepi[i].marker=createMarker(v.px, v.py, v.pz+0.5, "arrow",1)
	setElementInterior(tepi[i].marker, v.pi)
	setElementDimension(tepi[i].marker, v.pd)
	if (tonumber(v.pi)==0 and tonumber(v.pd)==0) then

		tepi[i].blip=createBlip(v.px, v.py, v.pz, 0, 1, 255,105,5,155, -1000, 200)
	end
	v.hrmin=tonumber(v.hrmin)
	v.hrmax=tonumber(v.hrmax)
	if (v.opis) then
	    tepi[i].opis_text3d=createElement("text")
	    setElementPosition(tepi[i].opis_text3d, v.px, v.py, v.pz+1)
	    setElementData(tepi[i].opis_text3d, "text", v.opis)
	    setElementInterior(tepi[i].opis_text3d, v.pi)
	    setElementDimension(tepi[i].opis_text3d, v.pd)
	end
    end    
end

function tepi_teleportPlayer(plr,i)
    fadeCamera(plr, false)
    setTimer(function()
	    setElementDimension(plr, tepi[i].td)
	    setElementInterior(plr, tepi[i].ti)
	    setElementPosition(plr, tepi[i].tx+(math.random(-10,10)/20), tepi[i].ty+(math.random(-10,10)/20), tepi[i].tz)
	    setElementRotation(plr, 0,0,tepi[i].ta)
	    fadeCamera(plr, true)
	end, 1000, 1)
end

function markerHit(hitElement, matchingDimension)
    if (getElementType(hitElement)~="player") then return end
    if (not matchingDimension) then return end
    if (getElementInterior(hitElement)~=getElementInterior(source)) then return end
	if (getPedOccupiedVehicle(hitElement)) then return end
    -- szukamy markerka w ktory wszedl gracz
    for i,v in ipairs(tepi) do
	if (v.marker==source) then

		local hr=getTime()
		
		if (v.hrlimit=="22-6") then
			if (hr>6 and hr<22) then
				outputChatBox("Czynne od 22 do 6 rano", hitElement, 255,0,0,true)
				return
			end
		end
		
		if (v.hrlimit=="10-20") then
			if (hr>=23 or hr<10) then
				outputChatBox("Czynne od 10 do 23", hitElement, 255,0,0,true)
				return
			end
		end

		local waterLevel=getElementData(root,"waterLevel") or -31337
		if waterLevel>-31337 and tonumber(v.tz)<(waterLevel+1) then
			outputChatBox("Przejscie jest zalane wodą", hitElement, 255,0,0,true)
			return
		end

	    tepi_teleportPlayer(hitElement,i)
	    return
	end
    end
    -- nie znaleziono markera
    -- nie powinno sie wydarzyc
    outputDebugString("TEPI: nie znaleziono markera w ktory wszedl gracz " .. getPlayerName(hitElement))
end

addEventHandler ( "onResourceStart", resourceRoot, function()
    tepi_reload()    
end)

addEventHandler( "onMarkerHit", resourceRoot, markerHit )