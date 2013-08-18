--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



function findRotation(startX, startY, targetX, targetY)	-- Doomed-Space-Marine
	local t = -math.deg(math.atan2(targetX - startX, targetY - startY))
	
	if t < 0 then
		t = t + 360
	end
	
	return t
end

local sw,sh = guiGetScreenSize()  -- Get screen resolution.
-- 500x352
local gw=sw/3
local gh=gw/1.42045

local tx=10
local ty=sh-gh-gh/2

local nw={}
nw.img=guiCreateStaticImage(tx,ty,gw,gh, "i/gps.png",false)
nw.edt=guiCreateEdit(0.1,0.15,0.8, 0.15, "Numer...", true, nw.img)
nw.lbl=guiCreateLabel(0.1,0.32,0.8,0.6, "", true, nw.img)
guiLabelSetHorizontalAlign(nw.lbl,"center",true)
guiSetVisible(nw.img,false)


local namierzanieAktywne=false
local pojazd=nil

function rysujGPS()
    local p=getPedOccupiedVehicle(localPlayer)
    if (not p) then
	schowajNamierzacz()
	return
    end
    -- , float rotation = 0, float rotationCenterOffsetX = 0, 
    --    float rotationCenterOffsetY = 0, int color = white, bool postGUI = false ] )
    
    if (getTickCount()%1000<=100) then
	dxDrawImage(tx+gw/30,ty+gh*19/30,gw/20, gw/20, "i/kropka.png", 0,0,0,tocolor(255,255,255),true)
    end
    local nn=getElementData(pojazd,"namierzanyNumer")
    if (nn and tonumber(nn) and getVehicleController(getPedOccupiedVehicle(localPlayer))==localPlayer) then
	    guiSetText(nw.edt, nn)
    end

    local dane=getElementData(pojazd,"namierzanie")
    if (not dane) then
	guiSetText(nw.lbl,"Brak danych...")
    elseif (dane[5] and tonumber(dane[5])>0) then
	guiSetText(nw.lbl,"Obiekt poza zasiegiem (w budynku)")
    else
	local x,y,z=getElementPosition(pojazd)
	local odleglosc=getDistanceBetweenPoints3D(x,y,z,dane[1],dane[2],dane[3])
	guiSetText(nw.lbl,dane[4] .. " " .. string.format("%.1fm", odleglosc))
	local ttx, tty = getWorldFromScreenPosition(sw * 0.5, sh * 0.5, 100)
	local cx, cy = getCameraMatrix()
	local cameraAngle = findRotation(ttx, tty, cx,cy)
	local kat=cameraAngle-findRotation(dane[1],dane[2],x,y)+270
	dxDrawImage(tx+gw/2-16,ty+gh/2, 32,32, "i/arrow.png", kat,0,0,tocolor(255,255,255),true)
	
	
    end
--    dxDrawImage(tx,ty,gw,gh, "i/gps.png")
end


function namierzaczSpool()
    if (not namierzanieAktywne) then return end
    local namierzanyNumer=guiGetText(nw.edt)
    if (tonumber(namierzanyNumer) and getVehicleController(getPedOccupiedVehicle(localPlayer))~=localPlayer) then
	setElementData(pojazd,"namierzanyNumer", namierzanyNumer)
	triggerServerEvent("doNamierzanie",resourceRoot, pojazd, namierzanyNumer)
    end
    setTimer(namierzaczSpool, 2500, 1)    
    
end

function pokazNamierzacz(obsluga,ppojazd)
	pojazd=ppojazd
	addEventHandler("onClientRender", root, rysujGPS)
	guiSetVisible(nw.img,true)
	if (obsluga) then
	    guiEditSetReadOnly(nw.edt,false)
	else
	    guiEditSetReadOnly(nw.edt,true)
	end
	local namierzanyNumer=getElementData(pojazd,"namierzanyNumer")
	guiSetText(nw.edt,namierzanyNumer or "Numer...")	
	namierzanieAktywne=true
	if (obsluga) then
	    setTimer(namierzaczSpool, 2500, 1)
	end
end

function schowajNamierzacz()
	removeEventHandler("onClientRender", root, rysujGPS)
	guiSetVisible(nw.img,false)
	namierzanieAktywne=false
	pojazd=nil
end

addEventHandler("onClientPlayerVehicleEnter",localPlayer,function(vehicle,seat)
    local special=getElementData(vehicle, "special")
    if (special and (special=="namierzacz" or special=="namierzaczt")) then
	    pokazNamierzacz(seat>1 and true or false,vehicle)
    end
end)

local p=getPedOccupiedVehicle(localPlayer)
if (p) then
    local special=getElementData(p, "special")
    if (special and (special=="namierzacz" or special=="namierzaczt")) then
	    pokazNamierzacz(false,p)
    end	
end
