--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


-- 1618.25,-1661.13,13.55,189.5
-- 1856.33,-1494.52,12.89,80.0
--local woda=createWater(1350,-2120,7,2630,-2126,5,1350,-1303,7,2630,-1303,7)
-- 1264.00,-1452.02,13.55,150.8
--local woda=createWater(1350,-2120,7,2630,-2126,5,1264,-1652,7,2630,-1303,7)


-- kanal kolo gs
--local woda2=createWater(2542,-1653,7,2621,-1654,7,2626,-1517,7)--,2577,-1517,7)





function spawn(plr)
    --    setElementData(localPlayer,"character", playerCharacters[current_character]
    local character=getElementData(plr,"character")
    if (not character or not character.skin) then
	kickPlayer(plr,"Nie udalo sie odnalezc Twojej postaci.")
	return
    end
    -- todo to powinno byc robione wczesniej
	local nnick=string.gsub(character.imie .. "_" .. character.nazwisko," ", "_")
    setPlayerName(plr, nnick)
--	kickPlayer(plr,"Nie udalo sie zalogowac na wybrana postac.")
--	return
--    end
    if (tonumber(character.newplayer)>0) then	-- usuwamy oznaczenie 'nowy gracz'
		local query=string.format("UPDATE lss_characters SET newplayer=0 WHERE id=%d LIMIT 1", character.id)
		exports.DB:zapytanie(query)
		character.newplayer=0
		setElementData(plr,"character",character)
		outputChatBox("(( Witaj nowy mieszkańcu Los Santos. Wciśnij klawisz F1 aby zobaczyć krótki przewodnik po serwerze. ))", plr)
		outputChatBox("(( Prawie wszystkie interakcje wykonuje się za pomocą myszki. Aby aktywować kursor, wciśnij TAB. ))", plr)
		outputChatBox("(( Jako nowy mieszkaniec, powinieneś udać się do urzędu aby wyrobić dokumenty i poszukać pracy. ))", plr)

    end
    
    triggerEvent("onPlayerRequestEQSync", plr)
    
    -- lastpos=x,y,z,kąt,interior,dimension
--    setElementDimension(plr, character.lastpos[6])
--    setElementInterior(plr, character.lastpos[5])


    local blokada_aj=getElementData(plr,"kary:blokada_aj")
    if (blokada_aj and tonumber(blokada_aj)>0) then
	-- 317.96,316.98,999.15,267.3
	outputChatBox("Posiadasz nałożony AJ, ilośc minut: " .. blokada_aj, plr, 255,0,0,true)
	repeat until spawnPlayer ( plr, 215.53,109.52,999.02,0.1, tonumber(character.skin), 10, 2000+tonumber(character.id))
    else
        repeat until spawnPlayer ( plr, character.lastpos[1],character.lastpos[2],character.lastpos[3],character.lastpos[4], character.co_skin and tonumber(character.co_skin) or tonumber(character.skin), character.lastpos[5], character.lastpos[6])
    end
    setPedArmor(plr, tonumber(character.ar))
    local hp = tonumber(character.hp)
    if  hp < 1 then hp=1 end
    setElementHealth(plr, hp)
    -- bool spawnPlayer ( player thePlayer, float x, float y, float z, [ int rotation = 0, int skinID = 0, int interior = 0, int dimension = 0, team theTeam = nil ] )
    setPlayerMoney(plr, tonumber(character.money))
    
    setPedStat(plr, 22, tonumber(character.stamina))
    setPedStat(plr, 225, tonumber(character.stamina))

    setPedStat(plr, 23, tonumber(character.energy))
    setPedStat(plr, 164, tonumber(character.energy))
    setPedStat(plr, 165, tonumber(character.energy))
    
    fadeCamera(plr, true)
    setCameraTarget(plr, plr)
    showChat(plr, true)
    showPlayerHudComponent(plr, "all", true)
	if (eq_getItem(plr,16) or eq_getItem(plr,4)) then
	  showPlayerHudComponent(plr, "radar", true)
	else
	  showPlayerHudComponent(plr, "radar", false)
	end
    showPlayerHudComponent(plr, "radio", false)
	showPlayerHudComponent(plr, "weapon", false)
    showPlayerHudComponent(plr, "vehicle_name", false)
    toggleAllControls(plr,true)
    toggleControl(plr,"next_weapon", false)
    toggleControl(plr,"previous_weapon", false)
    toggleControl(plr,"radar", false)
    toggleControl(plr, "action", false)
    if (tonumber(character.stamina)<250) then
	toggleControl(plr,"sprint", false)
    else
    	toggleControl(plr,"sprint", true)
    end
    local blokada_bicia=getElementData(plr, "kary:blokada_bicia")
    if (blokada_bicia) then
	    outputChatBox("Posiadasz blokadę bicia i atakowania, aktywną do #FFFFFF" .. blokada_bicia, plr, 255,0,0,true)
	    toggleControl(plr,"fire", false)
	    toggleControl(plr,"aim_weapon", false)
    end
	setTimer(usunBronieGracza, 5000, 1, plr)
end

--addEventHandler ( "onPlayerJoin", getRootElement(), function()
--    spawn(source)
--    triggerClientEvent(source, "playIntro", getRootElement())
--end)

function onPlayerDownloadFinished(plr)
--    triggerClientEvent(plr, "playIntro", getRootElement())
--    triggerClientEvent(plr, "onGUIOptionChange", getRootElement(), "cinematic", true)
--[[
	outputChatBox("** Na serwerze została wgrana reforma gospodarcza, dokonana zostałą denominacja i obniżone zostały ceny wszystkich rzeczy **", plr, 255,0,0)
	outputChatBox("** Wartość waszych portfeli jest taka sama, możecie kupić tyle samo dóbr co przed reformą **", plr, 255,0,0)
	outputChatBox("** Szczegółowe informacje o reformie można poznać na forum w dziale aktualności **", plr, 255,0,0)
]]--

--	outputChatBox("** UWAGA! Los Santos jest aktualnie pod wplywem tropikalnego sztormu. Sluzby pogodowe zapowiadaja", plr, 255,0,0)
--	outputChatBox("** ulewne deszcze, wichurę i możliwe podtopienia. (( Pamiętaj o konieczności odgrywania warunków", plr, 255,0,0)
--	outputChatBox("** pogodowych, łącznie z powodzią! ))", plr, 255, 0,0)

	setElementFrozen(plr, true)
	local hr=getTime()
--	if hr<=6 or hr>=20 then	 -- choinka kolo gs
--		setElementInterior(plr, 0)
--		setElementDimension(plr, 0)
--		setElementPosition(plr, 2520.02-10,-1526.69-10,50.48-20)
 
--	if hr<=6 or hr>=20 then	 -- klub nocny
--		setElementInterior(plr, 2)
--		setElementDimension(plr, 7)
--		setElementPosition(plr, 1217.05,-5.75,1001.33-5)
--	else	-- ulice ls
		setElementInterior(plr, 0)
		setElementDimension(plr, 7)
		setElementPosition(plr, 2134.67,-81.79,2.98-4)

--	end

	-- Set local ooc chat state to true (TODO: Store it into database?)
	setElementData(plr,"chatb:state", true)

    triggerClientEvent(plr,"displayLoginBox", getRootElement())
end

addEvent("introCompleted", true)
addEventHandler("introCompleted", root, function()
    triggerClientEvent(source, "onGUIOptionChange", getRootElement(), "cinematic", false)
    spawn(source)
end)


addEventHandler("onPlayerConnect", root,
    function(playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber)
	if (string.find(playerNick, "#")~=nil) then
	    cancelEvent(true,"Twoj nick zawiera niedozwolony znak (#). Na tym serwerze nie mozna miec nickow z kolorami. Zmien go w ustawieniach i polacz sie znowu.")
	end              
end)


addEventHandler("onResourceStart", resourceRoot,function()
    setJetpackMaxHeight(101.82230377197)
    setWaveHeight(0)
    setFPSLimit(75)
    setMapName("LSS RP PL")
    setGameType("LSS-RP 2.0.1")
    setRuleValue("Gamemode", "Los Santos Stories RP")
    setRuleValue("WWW", "http://lss-rp.pl/")
    local realtime = getRealTime()
    setTime(realtime.hour, realtime.minute)
    setMinuteDuration(60000)	-- 60000
    setTimer ( every1min, 60000, 0)

--	exports["lss-scoreboard"]:resetScoreboardColumns()
--	exports["lss-scoreboard"]:addScoreboardColumn("id", 3)

end)

--[[
addEventHandler ( "onResourceStart", getRootElement(), function(theResource)
	local sResource = getResourceFromName ( "lss-scoreboard" )
	if ( sResource and theResource == sResource ) then
		exports["lss-scoreboard"]:resetScoreboardColumns()
		exports["lss-scoreboard"]:addScoreboardColumn("id", 3)
	end
end)
]]--


function every1min()
    setJetpackMaxHeight(101.82230377197)
    local time = getRealTime()
    -- synchronizacja czasu
    setTime(time.hour, time.minute)
    -- bicie dzwonu co godzine

    if (time.minute==0) then
    	triggerClientEvent ( "onPelnaGodzina", getRootElement())
    end
end

addEventHandler("onPlayerChangeNick", getRootElement(), function() cancelEvent() end)