--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

-- animacje SWORD:sword_block -- sciaganie
--			SWORD:sword_IDLE

ITEMID_RYBA=8

wedkowanie_active=false
wedkowanie_power=0
wedkowanie_etap=0	-- 0 bezczynnosc, 1 zarzucona wedka, 2 sciaganie ryby
wedkowanie_cel=0

ryba_rozmiar=1



wedkowanie_win = guiCreateWindow(0.6906,0.4208,0.2937,0.3042,"Wędkowanie",true)
wedkowanie_progress1 = guiCreateProgressBar(0.0798,0.1781,0.8351,0.1507,true,wedkowanie_win)
wedkowanie_progress2 = guiCreateProgressBar(0.0798,0.3562,0.8351,0.1507,true,wedkowanie_win)
wedkowanie_btn = guiCreateButton(0.0851,0.6233,0.8298,0.274,"Zarzuć wędke",true,wedkowanie_win)

guiSetVisible(wedkowanie_win,false)

local punkty={
    { 354.59,-2088.80,7.84 },	-- pomost ls
    {362.20,-2088.80,7.84 },
    { 367.31,-2088.80,7.84 },
    {369.93,-2088.68,7.84 },
    {375.00,-2088.80,7.84 },
    {383.52,-2088.80,7.84 },
    {391.13,-2088.80,7.84 },
    {396.28,-2088.80,7.84 },
    {398.73,-2088.80,7.84 },
    {403.87,-2088.80,7.84 }
}

for i,v in ipairs(punkty) do
    v.cs=createColSphere(v[1],v[2],v[3],1)
	setElementData(v.cs,"wedkowanie",true)
end

function wedkowanie_update()
    guiProgressBarSetProgress(wedkowanie_progress2, wedkowanie_power)    
    guiProgressBarSetProgress(wedkowanie_progress1, wedkowanie_cel)    
end

function wedkowanie_btnhit()

    if (wedkowanie_etap>0) then
		triggerServerEvent("setPedAnimation", localPlayer, "SWORD", "sword_block", -1, false, false, true,true)
--		setPedAnimation(localPlayer, "SWORD", "sword_block", -1, false, false, true,true)
        wedkowanie_power=wedkowanie_power+10
    else
		wedkowanie_etap=1
		wedkowanie_power=50
		guiSetText(wedkowanie_btn,"Ściągnij wędkę")
    end
    wedkowanie_update()
end

addEventHandler("onClientGUIClick", wedkowanie_btn, wedkowanie_btnhit, false)


function wedkowanie_timer()
    if (wedkowanie_etap>0) then
        if (wedkowanie_power>0) then wedkowanie_power=wedkowanie_power-ryba_rozmiar-1 end
        if (wedkowanie_power<0) then wedkowanie_power=0 end
	if (wedkowanie_etap==2) then
	    wedkowanie_cel=wedkowanie_cel-(wedkowanie_power/10)
	    wedkowanie_cel=wedkowanie_cel+ryba_rozmiar
	    if (wedkowanie_cel>100) then
		wedkowanie_cel=0
		wedkowanie_power=0
		wedkowanie_etap=0
		ryba_rozmiar=0
		guiSetText(wedkowanie_btn, "Zarzuć wędke")	    
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " urywa żyłkę.", 5, 15, true)
		triggerServerEvent("setPedAnimation", localPlayer)
	    end
	    if (wedkowanie_cel<1) then
		wedkowanie_cel=0
		wedkowanie_power=0
		wedkowanie_etap=0
		ryba_rozmiar=0
		guiSetText(wedkowanie_btn, "Zarzuć wędke")	    
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " łowi rybę.", 5, 15, true)
		exports["lss-gui"]:eq_giveItem(ITEMID_RYBA,1)
		wedkowanie_active=false
		guiSetVisible(wedkowanie_win, false)
		triggerServerEvent("setPedAnimation", localPlayer)
		return
	    end
	end
	if (wedkowanie_power<1 and wedkowanie_etap==1) then	-- spadlo do zera podczas czekania na rybe
	    wedkowanie_etap=0
	    wedkowanie_cel=0
	    ryba_rozmiar=0
	    guiSetText(wedkowanie_btn, "Zarzuć wędke")	    
	    wedkowanie_active=false
	    guiSetVisible(wedkowanie_win, false)
	    return

	end
	if (wedkowanie_power<1 and wedkowanie_etap==2) then	-- power spadl do zera podczas sciagania ryby
	    wedkowanie_etap=0
	    wedkowanie_cel=0
	    ryba_rozmiar=0
	    guiSetText(wedkowanie_btn, "Zarzuć wędke")	    
	    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " urywa żyłkę.", 5, 15, true)
	    triggerServerEvent("setPedAnimation", localPlayer)
	end
        if (wedkowanie_power>100) then
		guiSetText(wedkowanie_btn, "Zarzuć wędke")
		wedkowanie_etap=0
		ryba_rozmiar=0
		wedkowanie_power=0
		wedkowanie_cel=0
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " urywa żyłkę.", 5, 15, true)
		wedkowanie_active=false
		guiSetVisible(wedkowanie_win, false)
		triggerServerEvent("setPedAnimation", localPlayer)
		return
        end
    end
    if (wedkowanie_etap==1 and math.random(1,250)==1) then
	ryba_rozmiar=math.random(1,10)
	wedkowanie_etap=2
	wedkowanie_power=math.random(25,50)
	wedkowanie_cel=25+math.random(1,100)/150*ryba_rozmiar
	outputChatBox("Coś pociągą Twoją wedką.")
    end
    
    wedkowanie_update()
    if (wedkowanie_active) then
	setTimer(wedkowanie_timer, 200,1)
    end
end

function wedkowanie_init()
    wedkowanie_power=0
    wedkowanie_cel=0
    wedkowanie_etap=0
    wedkowanie_update()
    guiSetVisible(wedkowanie_win,true)
    guiSetText(wedkowanie_btn,"Zarzuć wędke")
    wedkowanie_active=true

    setTimer(wedkowanie_timer, 200, 1)
end

addEventHandler("onClientColShapeHit", resourceRoot, function(hitElement, matchingDimension)
    if (hitElement~=localPlayer or not matchingDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    if (getPedOccupiedVehicle(localPlayer)) then return end
	if getElementData(source,"wedkowanie") then
	    wedkowanie_init()
	end
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(hitElement, matchingDimension)
    if (hitElement~=localPlayer or not matchingDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    guiSetVisible(wedkowanie_win,false)
    wedkowanie_active=false
end)
