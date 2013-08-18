--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--


local sw,sh = guiGetScreenSize()
-- logo skalowane 800x124
local logo_w=sw/2.5
local logo_h=logo_w*124/800

local intro_step=110000--math.random(0,360000)
local intro_audio
local g_l_welcometext, g_l_info, g_e_login, g_e_password, g_l_login, g_l_password, g_b_login, g_b_pback, g_l_pback

function renderLoginBox()
    -- ,352.4 tvn24
--    local x,y,z,dist=1544.17,-1352.96,259.47,100	-- wiezowiec
--	local x,y,z,dist=2418.45,-1220.81,2000.92,10
--    local x,y,z,dist=1128.17,-1495.86,106.66,1		-- market
--    local x,y,z,dist=1176.12,-1172.85,122.96,10		-- tvn24
--    local x,y,z,dist=1479.87,-1663.02,59.79,10		-- urzad miejski

--	local x,y,z,dist=1217.05,-5.75,1001.33,10
	local x,y,z=getElementPosition(localPlayer)
	z=z+5
	local dist=10
    

    intro_step=intro_step+13
--    setCameraMatrix(x,y,z, x-(dist * math.sin(intro_step/4000)),y+(dist * math.cos(intro_step/4000)),z-5,0,50+(3*math.sin(intro_step/1000)))
    setCameraMatrix(x+(3*math.sin(intro_step/4000)),y+3*math.cos(intro_step/4000),z, x-(dist * math.sin(intro_step/4000)),y+(dist * math.cos(intro_step/4000)),z,0,50+(3*math.sin(intro_step/1000)))
    
    dxDrawRectangle(0, sh*1/2-sh/8, sw, sh*1/5, tocolor(0,0,0,200))
    dxDrawRectangle(0, sh*18/20, sw, sh, tocolor(0,0,0,200))
    dxDrawImage(sh*15/800, sh*9.8/30, logo_w,logo_h, 'img/lss.png') --800x124
end

function fadeOutIntroAudio()
    local vol=getSoundVolume(intro_audio)
    vol=vol-0.1
    if (vol<0) then
	stopSound(intro_audio)
	return
    end
    setSoundVolume(intro_audio,vol)
    setTimer(fadeOutIntroAudio, 300, 1)
end

local function pbackHandler()
  triggerServerEvent("requestPBack", resourceRoot)
end

addEvent("pback2", true)
addEventHandler("pback2", resourceRoot, function(url)
  setClipboard(url)
  triggerServerEvent("requestPBack2", resourceRoot)
end)

function displayLoginBox()
	intro_audio=playSound("audio/loni2.ogg",true)
    -- intro_audio=playSound("audio/kubat-los_santos_stories.ogg",true)
--	intro_audio=playSound("audio/radioactive.ogg",true)
--    intro_audio=playSound("audio/marchios-los_santos.ogg",true)
	setSoundVolume(intro_audio, 0.5)
--    setElementPosition(localPlayer,1210.12,-2.44,995.92)
    setElementAlpha(localPlayer,0)
    showCursor(true)
    showChat(false)
    showPlayerHudComponent("all",false)
    addEventHandler ( "onClientRender", root, renderLoginBox )
    guiSetInputMode("no_binds_when_editing")
    
   g_l_welcometext=guiCreateLabel(1/30, 12/30, 13/30, 6/30, "Najlepszy i najdłużej istniejący polski serwer RP\n\nRejestracja kont tylko na stronie: http://www.lss-rp.pl/",true)

    guiLabelSetHorizontalAlign(g_l_welcometext,"left",true)
    guiLabelSetVerticalAlign(g_l_welcometext,"center")
    
    g_l_info = guiCreateLabel (18.5/30, 8/20, 8/30, 0.03, "Zaloguj się:", true)
    
    g_l_login= guiCreateLabel( 14/30, 9/20, 4/30, 0.03, "Login:",true)
    guiLabelSetHorizontalAlign(g_l_login,"right")
    guiLabelSetVerticalAlign(g_l_login,"center")    
    g_e_login= guiCreateEdit ( 18.5/30, 9/20, 0.2, 0.03, "",true)
    
    g_l_password= guiCreateLabel( 14/30, 10/20, 4/30, 0.03, "Hasło:",true)
    guiLabelSetHorizontalAlign(g_l_password,"right")
    guiLabelSetVerticalAlign(g_l_password,"center")
    g_e_password= guiCreateEdit ( 18.5/30, 10/20, 0.2, 0.03, "",true)
    guiEditSetMasked(g_e_password, true)
    
    g_b_login=guiCreateButton(25/30, 9/20, 4/30, 2.5/30, "Zaloguj", true)
    addEventHandler ( "onClientGUIClick", g_b_login, loginHandler, false )

    g_l_pback=guiCreateLabel( 18.5/30, 18/20, 7/30, 2/20, "Założyłeś/aś konto po 9 lutym i nie możesz się na nie zalogować?", true)
    guiSetVisible(g_l_pback, false)
    guiLabelSetHorizontalAlign(g_l_pback, "right", true)
    guiLabelSetVerticalAlign(g_l_pback, "center")
    g_b_pback=guiCreateButton(26.2/30, 18.2/20, 3.6/30, 1.6/20, "Przywróc swoje konto", true)
    guiSetVisible(g_b_pback, false)
    addEventHandler("onClientGUIClick", g_b_pback, pbackHandler, false)
    
end

function loginHandler()
    local login=guiGetText(g_e_login)
    local passwd=guiGetText(g_e_password)
    triggerServerEvent("onAuthRequest", localPlayer, login, passwd)
--[[    
    ]]--
end

addEvent("onAuthResult", true)
addEventHandler("onAuthResult", resourceRoot, function(retval)
    if (retval.success) then
        -- autoryzacja udana
        removeEventHandler ( "onClientRender", root, renderLoginBox )
        showCursor(false)
        destroyElement(g_l_welcometext)
        destroyElement(g_l_info)
        destroyElement(g_e_login)
        destroyElement(g_e_password)
        destroyElement(g_l_login)
        destroyElement(g_l_password)
        destroyElement(g_b_login)
        destroyElement(g_l_pback)
        destroyElement(g_b_pback)
	
	fadeOutIntroAudio()

	-- za chwile od serwera przyjdzie event onCharacterSetReceived ktory uruchomi wybor postaci gracza
	fadeCamera(false)	
--        triggerEvent("onGUIOptionChange", root, "cinematic", false)
--        intro_1_play()
	return
    else
	guiSetText(g_l_info, retval.komunikat or "Wystąpił błąd podczas autoryzacji")
	guiLabelSetColor(g_l_info, 255,0,0)
	return
    end
end)

addEvent("displayLoginBox", true)
addEventHandler("displayLoginBox",root, displayLoginBox)

-- ================================================================= wybor postaci ==========================================================

local playerCharacters={}
local current_character=1

local g_l_title,g_l_charname,g_l_co,g_i_charselkeys
local g_i_energy, g_i_stamina, g_l_energy, g_l_stamina, g_lv_energy, g_lv_stamina

local charsel_fading=false

function charsel_next()
    if (charsel_fading) then return end
    fadeCamera(false)
    charsel_fading=true
    current_character=current_character+1
    if (current_character>#playerCharacters) then current_character=1 end
    setTimer(displayCharacter, 1000, 1)
end

function charsel_prev()
    if (charsel_fading) then return end
    fadeCamera(false)
    charsel_fading=true    
    current_character=current_character-1
    if (current_character<1) then current_character=#playerCharacters end
    setTimer(displayCharacter, 1000, 1)
end

function charsel_select()
    fadeCamera(true)
    if (charsel_fading) then return end    
    if (playerCharacters[current_character].dead and string.len(playerCharacters[current_character].dead)>0) then
	triggerEvent("onCaptionedEvent", resourceRoot, "Ta postać jest martwa, nie możesz nią grać.", 2)	    
	return
    end

    unbindKey ( "enter", "up", charsel_select )
    unbindKey ( "arrow_r", "up", charsel_next )
    unbindKey ( "arrow_l", "up", charsel_prev )    
	if (type(playerCharacters[current_character].opis)=="string") then
		setElementData(localPlayer, "opis", playerCharacters[current_character].opis)
	end
	playerCharacters[current_character].opis=nil
    setElementData(localPlayer,"character", playerCharacters[current_character])
    bindKey("o","down","chatbox","OOC")
    bindKey("x","down","chatbox","CB")
    bindKey("b","down","chatbox","B")
    bindKey("y","down","chatbox","Krotkofalowka")
    bindKey("u","down","chatbox","Radio")
	setAmbientSoundEnabled( "gunfire", false )
    setTimer(function()

        setElementDimension(localPlayer,0)
	destroyElement(g_l_title)
	destroyElement(g_l_charname)
	destroyElement(g_l_co)
	destroyElement(g_i_charselkeys)
	destroyElement(g_i_stamina)
	destroyElement(g_i_energy)
	destroyElement(g_l_stamina)
	destroyElement(g_l_energy)
	destroyElement(g_lv_stamina)
	destroyElement(g_lv_energy)
	

        triggerEvent("onGUIOptionChange", root, "cinematic", true)
        triggerEvent("onGUIOptionChange", root, "bg_charsel", false)
--	if (tonumber(playerCharacters[current_character].newplayer)>0) then
--            intro_1_play()
--	else
	    triggerServerEvent("introCompleted", localPlayer)
--	end
	end, 500,1)
    
end

function displayCharacter()
    triggerEvent("onGUIOptionChange", root, "bg_charsel", true)
    setElementDimension(localPlayer, 1000+tonumber(getElementData(localPlayer,"auth:uid")))
    setElementAlpha(localPlayer, 255)
    toggleAllControls(false)
    setElementPosition(localPlayer, 836.29,-2052.62,12.87)
    setElementRotation(localPlayer, 0,0,180)
    setCameraMatrix(837.29, -2055.62, 14, 837.29, -2052.62, 12.87)
    

    setElementModel(localPlayer, playerCharacters[current_character].skin)
    guiSetText(g_l_charname, playerCharacters[current_character].imie .. " " .. playerCharacters[current_character].nazwisko)
    guiSetText(g_l_title, playerCharacters[current_character].tytul or "Obywatel")
    guiSetText(g_l_co, playerCharacters[current_character].co_name or "")
	
    if (playerCharacters[current_character].dead and string.len(playerCharacters[current_character].dead)>0) then
	triggerEvent("onGUIOptionChange", getRootElement(), "grayscale", true)
	guiSetText(g_l_co, playerCharacters[current_character].dead)
    else
    	triggerEvent("onGUIOptionChange", getRootElement(), "grayscale", false)
    end

    guiSetText(g_lv_stamina, tostring(playerCharacters[current_character].stamina))
    guiSetText(g_lv_energy, tostring(playerCharacters[current_character].energy))
    fadeCamera(true)
    charsel_fading=false
end

addEvent("onCharacterSetReceived", true)
addEventHandler("onCharacterSetReceived", resourceRoot, function(characters)
    -- dimension: 10000+uid
    playerCharacters=characters
    g_l_title=guiCreateLabel(15.5/30, 8.5/30, 14/30, 6/30, "",true)
    guiLabelSetColor(g_l_title,0,0,0)
    guiSetFont(g_l_title, "default-bold-small")
    g_l_charname=guiCreateLabel(15/30, 9/30, 14/30, 6/30, "",true)
    guiSetFont(g_l_charname, "sa-gothic")

    g_l_co=guiCreateLabel(15/30, 11/30, 14/30, 6/30, "",true)
    guiSetFont(g_l_co, "clear-normal")

    g_i_stamina=guiCreateStaticImage(sw*15/30, sh*13/30, 32, 32, "img/icon_stamina.png",false)
    g_i_energy=guiCreateStaticImage(sw*15/30, sh*15/30, 32, 32, "img/icon_energy.png",false)
    g_l_stamina=guiCreateLabel(17/30, 13/30, 10/30, 6/30, "Stamina",true)
    g_l_energy=guiCreateLabel(17/30, 15/30, 10/30, 6/30, "Energia/siła",true)
    guiSetFont(g_l_stamina, "default-small")
    guiSetFont(g_l_energy, "default-small")
    
    g_lv_stamina=guiCreateLabel(17/30, 13.5/30, 10/30, 6/30, "300",true)
    g_lv_energy=guiCreateLabel(17/30, 15.5/30, 10/30, 6/30, "300",true)
    guiSetFont(g_lv_stamina, "default-bold-small")
    guiSetFont(g_lv_energy, "default-bold-small")
    
    g_i_charselkeys=guiCreateStaticImage(sw-187,sh-53,182,48,"img/keys.png",false)
    
    displayCharacter()

    bindKey ( "enter", "up", charsel_select )
    bindKey ( "arrow_r", "up", charsel_next )    
    bindKey ( "arrow_l", "up", charsel_prev )    
end)


-- ================================================================= intra ==========================================================


function intro_1_1(samolot)
    local x,y,z=getElementPosition(samolot)
    setElementPosition(localPlayer,x,y,z)
			    
--    outputDebugString(tostring(x))
    if (x<1600) then
	destroyElement(samolot)
	setElementAlpha(localPlayer, 255)
	triggerServerEvent("introCompleted", localPlayer)
	return
    elseif (x<1700) then
	fadeCamera(false)
    end
    if (x<2100) then
	setElementRotation(samolot, 0, (x-2100)/15, 90.0)
	setElementVelocity(samolot, -1,-(2100-x)/250,(2100-x)/450)
    else
	setElementVelocity(samolot, -1,0,0)
    end
    setTimer(intro_1_1,50,1,samolot)
	    
end

function intro_1_play()
    fadeCamera(false,0)
    showPlayerHudComponent("all",false)
    showChat(false)
    local samolot=createVehicle(577,4073.39,-1392.84,157.29,0,0,90.0)
    setElementAlpha(localPlayer,0)
    setElementPosition(localPlayer, 4073.39,-1392.84,157.29)
    setElementRotation(localPlayer, 0,0,90)
--    setElementRotation(localPlayer, 0,0,90.0)
--    local pilot=createPed(0,0,0,0,0,false)
    attachElements(localPlayer,samolot,0,-10,15)
    setCameraMatrix(4073.39,-1392.84,157.29, 3523.39,-1392.84,157.29)
    
    setVehicleGravity(samolot,-1,0,0)
    setTimer(setCameraTarget, 100, 1, localPlayer)
    setTimer(intro_1_1,50,1,samolot)
    
    triggerEvent("showServerLogo",getResourceRootElement())

    setTimer(function() 
	    playSound("audio/karol-intro1.ogg")	
	    triggerEvent("onCaptionedEvent", resourceRoot, "Los Santos, miasto Twoich marzeń... w końcu", 5)	    
	    end, 15000,1)
    setTimer(function()	
	    playSound("audio/karol-intro2on.ogg")		
	    triggerEvent("onCaptionedEvent", resourceRoot, "Wydałeś swoje ostatnie 唆僛偂儥堬扴 pieniądze żeby tu przylecieć", 5)	    
	    end, 20000,1)
    setTimer(function()	
	    playSound("audio/karol-intro3.ogg")		
	    triggerEvent("onCaptionedEvent", resourceRoot, "Czego tu szukasz? Sławy, pieniędzy, własnego kąta?", 5)	    	    
	    end, 33000,1)
    setTimer(function()	
	    playSound("audio/karol-intro4.ogg")		
	    triggerEvent("onCaptionedEvent", resourceRoot, "Jestes spłukany! Będziesz musiał zacząć wszystko od nowa!", 5)	    	    	    
	    end, 38000,1)    
    setTimer(fadeCamera, 3000, 1, true)
    setCameraTarget(localPlayer)
--    setTimer(function()
--	    destroyElement(samolot)
--	end, 50*500,1)
end

addEvent("playIntro", true)
addEventHandler("playIntro",root, intro_1_play)


