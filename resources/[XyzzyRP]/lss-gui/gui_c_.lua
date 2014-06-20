--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--




toggleControl("radar",false)
--toggleControl("sprint",true)
toggleControl("next_weapon", false)
toggleControl("previous_weapon", false)

local screenw,screenh= guiGetScreenSize()

local przecinekx,przecineky=screenw*725/800,109/600*screenh
local przecinekfs=screenh/600

local playerWarning=nil

local ss_image

-- 410x111
local logo_w = math.floor(screenw/7)
local logo_h = logo_w*111/410

local spd_w = math.floor(screenw / 5)
if (spd_w>400) then
	spd_w=400
end
local spd_h = math.floor(spd_w * 0.81592)
local spd_X = screenw - spd_w - 25
local spd_Y = screenh - spd_h - 25
local spdw_X = math.floor(spd_X + (spd_w/2))
local spdw_Y = math.floor(spd_Y + (spd_h*3/5))

local fuel_W = math.floor(screenw/14)
if (fuel_W>116) then
	fuel_W=116
end
local fuel_H = math.floor(fuel_W * 0.60344)

local fuel_X = spd_X + (spd_w/2) - (fuel_W/2)
local fuel_Y = screenh - 25- fuel_H
-- wskazowka
local fuelw_X = math.floor(fuel_X + (fuel_W/2))
local fuelw_Y = math.floor(fuel_Y+(fuel_H*9/10))
local fuelw_W = math.floor(fuel_H*1/2)
local lastFuelLevel=0

local guiopts={cinematic=false,bg_charsel=false}
local biglogo={}

announcement = {}
announcement.text = ""
announcement.visible = false
announcement.step = 0


local captions={}

biglogo.fadein = function()
	if (biglogo.alpha<100) then
		biglogo.alpha=biglogo.alpha+10
		guiSetAlpha(biglogo.img, biglogo.alpha/100)
		setTimer(biglogo.fadein, 50, 1)
	end
end

biglogo.fadeout = function()
	if (biglogo.alpha>0) then
		biglogo.alpha=biglogo.alpha-5
		guiSetAlpha(biglogo.img, biglogo.alpha/100)
		setTimer(biglogo.fadeout, 50, 1)
		return
	end
	destroyElement(biglogo.img)
end

biglogo.show = function()
	biglogo.img=guiCreateStaticImage( 0.1, 0.4,  0.8,  0.2, 'img/lss.png', true)
	biglogo.alpha=0
	guiSetAlpha(biglogo.img,0)
	biglogo.fadein()
	setTimer( biglogo.fadeout, 5000, 1)
end

function GetSPDXY(X, Y, alpha, dist)
	 if (alpha>1.45) then alpha=1.45+math.random(0.0,0.5) end
	 alpha=(alpha*3.0)+0.88
	 return X - (dist * math.sin(alpha)), Y + (dist * math.cos(alpha));
end

function GetFuelXY(X,Y,alpha,dist)
	 alpha=(alpha/43.5)+2.08	-- 0 - po lewej, 100 - po prawej
	 return X - (dist * math.sin(alpha)), Y + (dist * math.cos(alpha));
end


addEvent("showServerLogo", true)
addEventHandler("showServerLogo", getRootElement(), biglogo.show)

function receiveCaptionedEvent(descr,lifetime,color)
	for i,v in ipairs(captions) do
		if (v.descr==descr) then
			v.lifetime=getTickCount()+((lifetime or 10)*1000)
			return
		end
	end
    table.insert(captions,{ descr=descr, lifetime=getTickCount()+((lifetime or 10)*1000), alpha=255, color=color })
end

addEvent("onCaptionedEvent", true)
addEventHandler("onCaptionedEvent", resourceRoot, receiveCaptionedEvent)

local fontHeight_clear=dxGetFontHeight(1.0,"clear")

lastPedLookAtUpdate=getTickCount()-3000

function clientRender()
    local x,y,z
    local character=getElementData(localPlayer, "character")
	dxDrawImage(16, screenh-logo_h, logo_w, logo_h, "img/lssrppl.png")
	

    if (isCursorShowing()) then
	_,_,x,y,z=getCursorPosition()
    else
        x,y,z=getWorldFromScreenPosition ( screenw/2, screenh/2, 100 )
    end
	local a=getPedAnimation(localPlayer)
	if (not a or a~="benchpress") then
      setPedLookAt(localPlayer,x,y,z)
	  if (getTickCount()-lastPedLookAtUpdate>1000) then
		lastPedLookAtUpdate=getTickCount()
--		setElementData(localPlayer, "lookAt", { x,y,z })
	  end
	end
    if (guiopts.cinematic) then
        dxDrawRectangle(0,0,screenw,screenh/6,tocolor(0,0,0),true)
        dxDrawRectangle(0,screenh*5/6,screenw,screenh/6,tocolor(0,0,0), true)
    end
    
    if (guiopts.bg_charsel) then
	dxDrawRectangle(screenw*9/20, screenh*8/30, screenw*11/20, screenh*1/3, tocolor(100,100,100,100), false)
	dxDrawRectangle(screenw*9/20, screenh*8/30-10, screenw*11/20, 10, tocolor(255,255,255,200), false)
    end

	if (playerWarning) then
		dxDrawRectangle( 100,100,screenw-200, screenh-200, tocolor(255,0,0,100), true)
		dxDrawText( "Otrzymales/-as ostrzezenie:", 100, 100, screenw-100, screenh/2-20, tocolor(255,255,255), 3.0, "default-bold", "center", "bottom", true, true,true)
		dxDrawText( playerWarning, 100,screenh/2+20, screenw-100, screenh-100, tocolor(0,0,0), 2.0, "default-bold", "center", "top", true, true,true )
		return	-- reszty nie pokazujemy bo po co
	end


    
    local caption_count=0
--    for k,v in ipairs(captions) do
	for k=#captions,1,-1 do
	  local v=captions[k]
    
	if (v.lifetime<getTickCount()) then
	    v.alpha=(v.alpha or 255)-10
	end
	if (v.alpha<1) then
	    table.remove(captions,k)
	    break
	end
    
	local tw=dxGetTextWidth(v.descr, 1, "clear")
	if (tw>screenw*760/1280) then tw=screenw*760/1280 end
	local color=v.color or {0,0,0}
	dxDrawRectangle(screenw*1/2-(tw/2)-20, screenh*640/800-(caption_count*(2*fontHeight_clear+5)), tw+40, fontHeight_clear*2, tocolor(color[1],color[2],color[3],v.alpha/3), true)
	dxDrawText(v.descr, screenw*260/1280, screenh*640/800-(caption_count*(2*fontHeight_clear+5)), screenw*1020/1280,screenh*640/800-(caption_count*(2*fontHeight_clear+5))+fontHeight_clear*2, tocolor(255,255,255,v.alpha), 1, "clear", "center", "center", true, true, true)
	
	caption_count=caption_count+1

    end
--    eq_item_nav_refresh()

--	licznik predkosci
	local veh=getPedOccupiedVehicle(localPlayer)

	if isPlayerHudComponentVisible("money") and (getCameraTarget()==localPlayer or getCameraTarget()==veh) then
		-- dxDrawText(",", przecinekx-2,przecineky+2,przecinekx,przecineky,tocolor(0,0,0),przecinekfs,"pricedown")
		-- dxDrawText(",", przecinekx-2,przecineky-2,przecinekx,przecineky,tocolor(0,0,0),przecinekfs,"pricedown")
		-- dxDrawText(",", przecinekx+2,przecineky+2,przecinekx,przecineky,tocolor(0,0,0),przecinekfs,"pricedown")
		-- dxDrawText(",", przecinekx+2,przecineky-2,przecinekx,przecineky,tocolor(0,0,0),przecinekfs,"pricedown")
		-- dxDrawText(",", przecinekx,przecineky,przecinekx,przecineky,tocolor(47, 90, 38),przecinekfs,"pricedown")
		-- glod/nasycenie
			if not isElementInWater(localPlayer) then
				-- 681/800
				-- tlo
				dxDrawRectangle(683/800*screenw, 75/600*screenh, 76/800*screenw, 11/600*screenh, tocolor(0,0,0,255))
				dxDrawRectangle(685/800*screenw, 77/600*screenh, 72/800*screenw, 7/600*screenh, tocolor(255,255,0,64))
				-- pasek
				local hl=math.max(math.min(character.satiation or 75,100),0)
				dxDrawRectangle(685/800*screenw, 77/600*screenh, 72/800*screenw*(hl/100), 7/600*screenh, tocolor(255,255,0,255))
			end

	end


	if (veh) then
	local vm=getElementModel(veh)
	if not getElementData(localPlayer,"hud:removeclouds") then
	  if (vm~=481 and vm~=509 and vm~=510) then -- rowery
		vx,vy,vz=getElementVelocity(veh)
		spd=(vx^2 + vy^2 + vz^2)^(0.5)*0.6

		dxDrawImage ( spd_X, spd_Y,  spd_w, spd_h, 'img/licznik.png' )
		local gx,gy=GetSPDXY(spdw_X,spdw_Y,spd, spd_w/3)

		dxDrawLine(spdw_X-2,spdw_Y-2, gx,gy, tocolor(155,0,0,100), 3)
		dxDrawLine(spdw_X-2,spdw_Y+2, gx,gy, tocolor(155,0,0,100), 3)
		dxDrawLine(spdw_X+2,spdw_Y-2, gx,gy, tocolor(155,0,0,100), 3)
		dxDrawLine(spdw_X+2,spdw_Y+2, gx,gy, tocolor(155,0,0,100), 3)
		dxDrawLine(spdw_X,spdw_Y, gx,gy, tocolor(255,0,0), 1)

		-- paliwo
		local pp=getElementData(veh,"paliwo")
		if (pp and pp[2] and pp[2]>0) then
			local paliwo,bak=unpack(pp)
			dxDrawImage ( fuel_X, fuel_Y, fuel_W, fuel_H, 'img/paliwo.png' )

			--[[		if (paliwo<1) then	-- spowalniamy pojazd!
				setElementVelocity(v,vx/2,vy/2,vz/2)
			end]]--
			

--			if (lastFuelLevel-paliwo>1) then
--				lastFuelLevel=lastFuelLevel-1
--			elseif (lastFuelLevel-paliwo<1) then
--				lastFuelLevel=lastFuelLevel+1
--			end

			local px,py=GetFuelXY(fuelw_X,fuelw_Y, paliwo/bak*100, fuelw_W)
			dxDrawLine(fuelw_X,fuelw_Y, px,py, tocolor(155,0,0), 3)
		end
		-- przebieg
		local przebieg=getElementData(veh,"przebieg")
		if przebieg then
		    dxDrawText(string.format("%08.1f",przebieg), 1+fuel_X+fuel_W/2, 1+fuel_Y+fuel_H, 1+fuel_X+fuel_W/2, 1+fuel_Y+fuel_H+10, tocolor(255,255,255,155), 1, "default", "center","top")
		    dxDrawText(string.format("%08.1f",przebieg), fuel_X+fuel_W/2, fuel_Y+fuel_H, fuel_X+fuel_W/2, fuel_Y+fuel_H+10, tocolor(0,0,0,255), 1, "default", "center","top")
		end
	  end
	end
	end

--    outputDebugString(tostring(caption_count))    

	if ss_image then
		dxDrawImage( screenw/2-320, screenh/2-240, 640, 480, ss_image )
	end

-- ann
	if (announcement.visible or announcement.step>0) then
		if (not announcement.visible and announcement.step>0) then
			announcement.step=announcement.step-1
		elseif (announcement.visible and announcement.step<15) then
			announcement.step=announcement.step+1
		end
	-- step = x
	-- 100  = screenHeight*20/768
		-- x= step*scr
--		dxDrawRectangle(0,0, screenw, announcement.step*screenh*(18/768)/15, tocolor(0,0,0,100))
--		if announcement.step>7 then
			dxDrawText ( announcement.text, screenw*60/1024+1, 1 , screenw*220/1024+1, screenh*560/768+1, tocolor(0,0,0,(announcement.step)*16), 1.0, "default-bold", "left", "bottom", true,true )
			dxDrawText ( announcement.text, screenw*60/1024, 0 , screenw*220/1024, screenh*560/768, tocolor(255,5,5,(announcement.step)*16), 1.0, "default-bold", "left", "bottom", true,true )
--		end
	end

    
end

function clientHUDRender_grayscale()
    if (guiopts.grayscale) then
	dxSetRenderTarget( );
	dxUpdateScreenSource( grayscale_screenSrc );
	dxDrawImage( 0, 0, screenw, screenh, grayscale_shader );
    end
end

function clientHUDRender_motionblur()
    if (guiopts.motionblur) then
		local drunkLevel=getElementData(localPlayer, "drunkLevel")
		if (not drunkLevel or tonumber(drunkLevel)<1) then
			triggerEvent("onGUIOptionChange", root, "motionblur", false)
			return
		end
		local colorLevel=getElementData(localPlayer, "colorLevel") or 1
		dxSetShaderValue( motionblur_shader, "drunkLevel", tonumber(drunkLevel)/1.8, colorLevel)
		dxSetRenderTarget( );
		dxUpdateScreenSource( motionblur_screenSrc );
		dxDrawImage( 0, 0, screenw, screenh, motionblur_shader );
		-- wplyw na auto
	    local v=getPedOccupiedVehicle(localPlayer)
	    if (not v) then return end
		if not getVehicleEngineState(v) then
			setVehicleGravity(v, 0,0,-1)
			return
		end
	    local _,_,rz=getElementRotation(v)
	    local vx,vy,vz=getElementVelocity(v)
	    local spd=((vx^2 + vy^2 + vz^2)^(0.5)+(drunkLevel/50))*2

	    local rrz=math.rad(rz+180)
	    local x= (0.15 * math.sin(-rrz))*spd
	    local y= (0.15 * math.cos(-rrz))*spd
	    setVehicleGravity(v, x,y,-1)

    end
end

addEventHandler ( "onClientElementDataChange", localPlayer, function(dataName, oldValue)
	if (dataName~="drunkLevel") then return end
	local curValue=getElementData(localPlayer, "drunkLevel")
	if ((not curValue or tonumber(curValue)==0) and guiopts.motionblur) then
		triggerEvent("onGUIOptionChange", root, "motionblur", false)
		return
	end

	if ((oldValue==nil or tonumber(oldValue)<1) and tonumber(curValue)>0) then
			triggerEvent("onGUIOptionChange", root, "motionblur", true)
			return
	end
end)




addEventHandler ( "onClientRender", root, clientRender )


function guiStart()
    triggerServerEvent("onResourcesDownloaded", localPlayer)
    local character=getElementData(localPlayer, "character")
    if (character and character.id) then	-- dodajemy bind ktory normalnie jest dodawany przy wyborze postaci - a po restarcie zasobu nie bylby aktywny
        bindKey("o","down","chatbox","OOC")
        bindKey("x","down","chatbox","CB")
        bindKey("b","down","chatbox","B")
        bindKey("y","down","chatbox","Krotkofalowka")
        bindKey("u","down","chatbox","Radio")
    end
end
addEventHandler("onClientResourceStart",resourceRoot, guiStart)

addEvent("onGUIOptionChange", true)
addEventHandler("onGUIOptionChange", root, function(optname, value)
--    outputChatBox("changin " .. optname)
    if (guiopts[optname]==value) then return end
    guiopts[optname]=value
    if (optname=="grayscale") then
		if value and value==true then
			grayscale_shader = dxCreateShader( "fx/grayscale.fx" );
			grayscale_screenSrc = dxCreateScreenSource( screenw, screenh );
			if grayscale_shader and grayscale_screenSrc then
				dxSetShaderValue( grayscale_shader, "GrayscaleTexture", grayscale_screenSrc );
				addEventHandler( "onClientHUDRender", getRootElement( ), clientHUDRender_grayscale );
			end
		else
			if graylscale_shader and grayscale_screenSrc then
				destroyElement( grayscale_shader );
				destroyElement( grayscale_screenSrc );
				grayscale_shader, grayscale_screenSrc = nil, nil;
				removeEventHandler( "onClientHUDRender", getRootElement( ), clientHUDRender_grayscale );
			end
		end
		return
    end

    if (optname=="motionblur") then
		if value and value==true then
			motionblur_shader = dxCreateShader( "fx/motion.fx" );
			motionblur_screenSrc = dxCreateScreenSource( screenw, screenh );
			if motionblur_shader and motionblur_screenSrc then
				dxSetShaderValue( motionblur_shader, "ScreenTexture", motionblur_screenSrc );
				addEventHandler( "onClientHUDRender", getRootElement( ), clientHUDRender_motionblur );
			end
		else
			if motionblur_shader and motionblur_screenSrc then
				destroyElement( motionblur_shader );
				destroyElement( motionblur_screenSrc );
				motionblur_shader, motionblur_screenSrc = nil, nil;
				removeEventHandler( "onClientHUDRender", getRootElement( ), clientHUDRender_motionblur);
			end
		end
		return
    end



end)


function scanNearbyPeds()
    local peds=getElementsByType("ped", root, true)
    if (not peds or #peds<1) then return end
    
    local selected_ped=peds[math.random(1,#peds)]
    local min_dist=nil
    
    if (math.random(1,3)>=2) then
        local x,y,z=getElementPosition(localPlayer)
        for i,v in ipairs(peds) do
	    local px,py,pz=getElementPosition(v)
	    local dist=getDistanceBetweenPoints3D(x,y,z,px,py,pz)
	    if (not min_dist or dist<min_dist) then
		selected_ped=v
		min_dist=dist
	    end
	end
    end
    if (selected_ped) then
	setPedLookAt(selected_ped, 0,0,0,math.random(4000,7000), localPlayer)
    end
end

setTimer(scanNearbyPeds, 5000, 0)

bindKey("forwards","down",function()	-- chodzenie zamiast biegania!
    setControlState("walk",true)	-- fuck yeah
end)

bindKey("enter", "down", function()
	if (not isElementFrozen(localPlayer) and getPedAnimation(localPlayer)) then
		if getElementData(localPlayer, "animStartPos") then
				if getPedAnimation(localPlayer) then
					local x,y,z = unpack(getElementData(localPlayer, "animStartPos"))
					setElementPosition(localPlayer, x,y,z,false)
				end
		end
		triggerServerEvent("setPedAnimation", localPlayer)
		setElementCollisionsEnabled(localPlayer, true)
		setElementData(localPlayer, "animStartPos", false)
	end
end)

addEventHandler ( "onClientPedDamage", root, cancelEvent )

function stopSprayDamage ( attacker, weapon, bodypart )
	if ( weapon == 41 ) then --spraycan
		cancelEvent() --cancel the event
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), stopSprayDamage )

do
	local curValue=getElementData(localPlayer, "drunkLevel")
	if (curValue and tonumber(curValue)>0) then
			triggerEvent("onGUIOptionChange", root, "motionblur", true)
	end
end


addEventHandler("onClientPlayerVehicleEnter",localPlayer,function(vehicle)
  setVehicleGravity(vehicle, 0,0, -1)
end)

addEventHandler("onClientPlayerVehicleExit",localPlayer,function(vehicle)
  setVehicleGravity(vehicle, 0,0, -1)
end)

addEvent("onMyClientScreenShot",true)
addEventHandler( "onMyClientScreenShot", root,
    function( pixels )
        if ss_image then
            destroyElement(ss_image)
        end
        ss_image = dxCreateTexture( pixels )
		setTimer(function()
			destroyElement(ss_image)
			ss_image=nil
		end, 5000, 1)
    end
)

function showAnnouncement(text,timeout)
	announcement.text = text
	announcement.visible = true
	announcement.step=0
	if (announcement.timer) then
		killTimer(announcement.timer)
		announcement.timer=nil
	end
	announcement.timer=setTimer( function()
		announcement.visible = false
		announcement.timer=nil
	end, timeout*1000, 1 )
end

addEvent("showAnnouncement", true)
addEventHandler("showAnnouncement", root, showAnnouncement)


function hidePlayerWarning()
	playerWarning=false
end

function onPlayerWarningReceived(tresc)
	if source==localPlayer then
		setTimer(playSoundFrontEnd, 500, 3, 5)
		outputChatBox("\n\nOtrzymales/as ostrzezenie!\n", 255,0,0)
		outputChatBox(tresc, 255,255,255)
		outputChatBox("\nNie stosowanie sie do ostrzezen moze skutkowac kickiem lub banem!\n\n\n", 255,0,0)

		playerWarning=tresc
		setTimer(hidePlayerWarning, 7000, 1)
	else
		showAnnouncement(getPlayerName(source).." otrzymuje ostrzeżenie: " .. tresc, 15)
	end
end

addEvent("onPlayerWarningReceived",true)
addEventHandler ( "onPlayerWarningReceived", getRootElement(), onPlayerWarningReceived )

