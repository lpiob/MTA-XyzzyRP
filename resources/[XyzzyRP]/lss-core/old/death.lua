local licence=[[

==============================================================================
LSS-RP (c) Wielebny <wielebny@bestplay.pl>
Wszelkie prawa zastrzezone. Nie masz praw uzywac tego kodu bez mojej zgody.

2012-

]]


local punkty_wskrzeszen={
    szpital1={1173.17,-1323.63,15.40}
}


-- inicjalizacja punktow wskrzeszen
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), function()
    for i,p in pairs(punkty_wskrzeszen) do
	punkty_wskrzeszen[i].marker=createMarker(p[1],p[2],p[3],"corona", 1, 255,255,255,255)
	addEventHandler( "onMarkerHit", punkty_wskrzeszen[i].marker, death_resurection)
    end
end)

function death_ghostMode(plr)
    fadeCamera(plr,false,0)
    local x,y,z=getElementPosition(plr)
    -- todo vw,i
    spawnPlayer(plr, 0,0,-1000)	-- poza zasiegiem jakiegokolwiek obiektu
    setTimer(function()
        setElementPosition(plr,x,y,z)
        fadeCamera(plr,true)
	end, 500, 1)
    takeAllWeapons(plr)
    toggleControl(plr,"fire", false)
    toggleControl(plr,"next_weapon", false)
    toggleControl(plr,"prev_weapon", false)
    toggleControl(plr,"enter_exit", false)    
    toggleControl(plr,"aim_weapon", false)    
    showPlayerHudComponent(plr, "all", false)
    setElementAlpha(plr, 15)
    setElementData(plr, "duch", true, true)
    triggerClientEvent(plr, "onGUIOptionChange", getRootElement(), "grayscale", true)
    outputChatBox("Nie żyjesz... udaj się do szpitala lub kościoła aby zostać wskrzeszonym...", plr)
end

function death_resurection(plr)
    if (not plr and source) then plr=source end
    if (getElementType(plr)~="player") then return end
    
    if (not getElementData(plr,"duch") or getElementData(plr,"duch")~=true) then
--	outputChatBox("Nie potrzebujesz wskrzeszenia...", plr)
	return
    end
    
    local x,y,z=getElementPosition(plr)
    fadeCamera(plr,false,0)
    setElementAlpha(plr, 255)
    spawnPlayer(plr, 0,0,-1000)	-- poza zasiegiem jakiegokolwiek obiektu
    setTimer(function()
        setElementPosition(plr,x,y,z)
        fadeCamera(plr,true)
	end, 500, 1)
    setElementData(plr, "duch", false, true)
    toggleAllControls(plr,true)
    showPlayerHudComponent(plr, "all", true)
    showPlayerHudComponent(plr, "radar", false)
    showPlayerHudComponent(plr, "radio", false)

    
    triggerClientEvent(plr, "onGUIOptionChange", getRootElement(), "grayscale", false)
    
end

addCommandHandler("gho", death_ghostMode)
addCommandHandler("res", death_resurection)

addEventHandler("onPlayerWasted", root, function(ammo, attacker, weapon, bodypart)
    setTimer(death_ghostMode, 18000, 1, source)
end)
