--[[
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



function dogFollow(thecop, theprisoner)
		if not ( theprisoner and thecop ) then return end
		if not theprisoner then return end
		if not getElementData(theprisoner, "dog:moveblock") then
			local copx, copy, copz = getElementPosition ( thecop )
			local prisonerx, prisonery, prisonerz = getElementPosition ( theprisoner )
			copangle = ( 360 - math.deg ( math.atan2 ( ( copx - prisonerx ), ( copy - prisonery ) ) ) ) % 360
			setPedRotation ( theprisoner, copangle )
			local dist = getDistanceBetweenPoints2D ( copx, copy, prisonerx, prisonery )	
			if getElementInterior(thecop) ~= getElementInterior(theprisoner) then setElementInterior(theprisoner, getElementInterior(thecop)) end
			if getElementDimension(thecop) ~= getElementDimension(theprisoner) then setElementDimension(theprisoner, getElementDimension(thecop)) end
			local dog = getElementData(theprisoner, "dog")
			-- outputDebugString(dog.stamina or "lol")
			if dist >= 200 then
				local x,y,z = getElementPosition(thecop)
				setElementPosition(theprisoner, x, y, z)
			elseif dist >= 8 and dog.stamina>=50 then
				setPedAnimation(theprisoner, "ped", "sprint_civi")
			elseif dist >= 2 then
				setPedAnimation(theprisoner, "ped", "run_player")
			else
				setPedAnimation(theprisoner, false)
			end
		end
		local zombify = setTimer ( dogFollow, 500, 1, thecop, theprisoner )
		-- outputDebugString(dog.stamina)
end

local rasy = {
	[0]=310,
	[1]=311,
	[2]=312,
}

local rasyskiny = {
	[310]=0,
	[311]=1,
	[312]=2,
}

function reloadDog(player,msg)
	if not getElementData(player,"character") then return end
	local check = exports.DB2:pobierzWyniki("SELECT * FROM lss_petsystem WHERE char_id=?",getElementData(player,"character").id)
	if getElementData(player, "player:dog") then
		destroyElement(getElementData(getElementData(player, "player:dog"),"dog:text"))
		destroyElement(getElementData(player, "player:dog"))
	end
	if check and check.id then
		local x,y,z = getElementPosition(player)
		local pies = createPed(rasy[check.rasa], x, y, z)
		setElementData(pies, "dog:owner", player)
		setElementData(pies, "dog", check)
		setElementData(player, "player:dog", pies)
		dogFollow(player, pies)
		local text = createElement("text")
		setElementPosition(text, x, y, z)
		setElementData(text, "attach", pies)
		setElementData(text, "addz", 1)
		setElementData(text, "text", ((check.nazwa)=="BRAK" and "Pies" or "Pies - "..check.nazwa))
		setElementData(pies, "dog:text", text)
		setElementHealth(pies, check.nasycenie)
	else
		return
	end
	
	if msg then outputChatBox("(( Pies został zespawnowany ))", player) end
end


function unspawnDog(player)
	if not getElementData(player,"character") then return end
	if getElementData(player, "player:dog") then
		destroyElement(getElementData(getElementData(player, "player:dog"),"dog:text"))
		destroyElement(getElementData(player, "player:dog"))
		removeElementData(player, "player:dog")
	end
end

-- addCommandHandler("dogreload", function(plr)
	-- if getElementData(plr, "player:dog") then destroyElement(getElementData(plr, "player:dog")) end
	-- reloadDog(plr)
-- end)


--skrypt na tworzenie pieskow do oswojenia
local wildDog = {}

local wildDogsPos = {
	{1191.05,-1736.10,14.07, 10},
	{1329.95,-1235.92,13.55, 280},
	{1691.55,-1492.48,13.55,260.3},
	{2125.92,-1819.92,13.55,225.2},
	{2087.87,-1989.19,13.55,62.6},
	{2238.88,-1762.36,13.73,66.1},
}

local function respawnDogs()
      if #getElementsByType("ped",resourceRoot)>50 then return end
		for k,v in ipairs(wildDogsPos) do
			if math.random(1,5) == 1 then
                local cs=createColSphere(v[1],v[2],v[3],10)
                local ec=#getElementsWithinColShape(cs)
                destroyElement(cs)
                if (ec==0) then
    				wildDog[k] = createPed(math.random(310,312), v[1], v[2], v[3])
				  setElementData(wildDog[k], "dog:wild", true)
				  setElementRotation(wildDog[k], 0, 0, v[4])
				  local text = createElement("text")
				  setElementPosition(text, v[1], v[2], v[3]+1)
				  setElementData(text, "text", "Dziki pies")
				  setElementData(wildDog[k], "dog:text", text)
				  setElementFrozen(wildDog[k], true)
                end
			end
		end
end


function menu_oswajanie(args)
	triggerEvent("onDogOswajanie", args.dog, args.player)
end

addEvent("onDogOswajanie", true)
addEventHandler("onDogOswajanie", getRootElement(), function(player)
	local check = exports.DB2:pobierzWyniki("SELECT * FROM lss_petsystem WHERE char_id=?",getElementData(player,"character").id)
	if check and check.id then outputChatBox("(( Masz już psa! ))", player) return end
	local szansa=math.random(1,10)
	if szansa==1 then --zlapal
		triggerEvent("broadcastCaptionedEvent", player, getPlayerName(player).." zakłada obrożę na dzikiego psa.", 5, 10, true)
		exports.DB2:zapytanie("INSERT INTO lss_petsystem (char_id, nazwa, rasa) VALUES ('?', ?, '?')", tonumber(getElementData(player,"character").id), "BRAK", rasyskiny[getElementModel(source)])
		reloadDog(player)
	else
		triggerEvent("broadcastCaptionedEvent", player, getPlayerName(player).." próbuje bezskutecznie złapać psa, który ucieka.",5, 10, true)
	end
	
	destroyElement(getElementData(source, "dog:text"))
	if source and getElementType(source) then destroyElement(source) end
	exports["lss-core"]:eq_takeItem(player, 165, 1)
end)

respawnDogs()
setTimer(respawnDogs, 1200000, 0)

for k,v in ipairs(getElementsByType("player")) do
	removeElementData(v, "player:dog")
end

addEventHandler("onPlayerQuit", getRootElement(), function()
	unspawnDog(source)
end)

local function getCharacterName(plr)
	local character=getElementData(plr,"character")
	if not character then return "Nieznana osoba" end
	local zamaskowany=getElementData(plr,"zamaskowany")
	if zamaskowany then
		return "Zamaskowana osoba"
	end
	return character.imie.." "..character.nazwisko
end

local function polecenie_say(plr, msg)
	local characterName=getCharacterName(plr)
	local x,y,z=getElementPosition(plr)
    local strefa=createColSphere(x,y,z,50)
    local gracze=getElementsWithinColShape(strefa, "player")
	
    for i,v in ipairs(gracze) do
		if (getElementInterior(v)==getElementInterior(plr) and getElementDimension(v)==getElementDimension(plr)) then
			local x2,y2=getElementPosition(v)
			if (getDistanceBetweenPoints2D(x,y,x2,y2)<=10) then
				outputChatBox( characterName .. " wydaje polecenie psu: " .. msg, v, 255, 255, 255, true)
			end
			
		end
	end
	destroyElement(strefa)    
end

addEvent("onDogCommand", true)
addEventHandler("onDogCommand", getRootElement(), function(cmd,nasycenie,add1)
	local nasycenie = tonumber(nasycenie)
	if cmd == "Spawn" then
		if getElementData(source, "player:dog") then return end
		reloadDog(source,true)
		
	elseif cmd == "Unspawn" then
		if not getElementData(source, "player:dog") then return end
		unspawnDog(source)
		outputChatBox("(( Pies został zunspawnowany ))", source)
	elseif cmd == "P: Daj głos!" then
		local pies = getElementData(source, "player:dog")
		if not pies then return end
		local pies_name = getElementData(pies, "dog").nazwa=="BRAK" and "" or getElementData(pies, "dog").nazwa
		if nasycenie <= 30 then triggerEvent("broadcastCaptionedEvent", pies, "Brzuch psa "..pies_name.." burczy z głodu", 5, 10, true) return end
		polecenie_say(source, "daj głos!")
		triggerClientEvent("dog_polecenie", source, "P: Daj głos!")
	elseif cmd == "P: Zostań!" then
		local pies = getElementData(source, "player:dog")
		if not pies then return end
		local pies_name = getElementData(pies, "dog").nazwa=="BRAK" and "" or getElementData(pies, "dog").nazwa
		if nasycenie <= 20 then triggerEvent("broadcastCaptionedEvent", pies, "Brzuch psa "..pies_name.." burczy z głodu", 5, 10, true) return end
		polecenie_say(source, "zostań!")
		
		setElementData(pies, "dog:moveblock", true)
		setElementFrozen(pies, true)
		setPedAnimation ( pies, "JST_BUISNESS", "girl_02", -1, false, false )
		-- setPedAnimation(pies, "INT_OFFICE", "OFF_Sit_Idle_Loop", -1, true, false)
	elseif cmd == "P: Do nogi!" then
		local pies = getElementData(source, "player:dog")
		if not pies then return end
		local pies_name = getElementData(pies, "dog").nazwa=="BRAK" and "" or getElementData(pies, "dog").nazwa
		if nasycenie <= 20 then triggerEvent("broadcastCaptionedEvent", pies, "Brzuch psa "..pies_name.." burczy z głodu", 5, 10, true) return end
		polecenie_say(source, "do nogi!")
		
		setElementData(pies, "dog:moveblock", false)
		setElementFrozen(pies, false)
		setPedAnimation(pies, false)
	elseif cmd == "Zmiana nazwy" then
		local pies = getElementData(source, "player:dog")
		if not pies then return end
		exports.DB2:zapytanie("UPDATE lss_petsystem SET nazwa=? WHERE char_id=?", add1, getElementData(source, "character").id)
		unspawnDog(source)
		setTimer(reloadDog,50, 1, source,true)
	end
end)


local function dog_glod()
	--glod pieskow ;c
	for k,v in ipairs(getElementsByType("ped")) do
		if getElementModel(v) == 310 or getElementModel(v) == 311 or getElementModel(v) == 312 then
			if getElementData(v, "dog:owner") then
				--glod
				dog = getElementData(v, "dog")
				dog.nasycenie = ((dog.nasycenie)-1)<0 and 0 or ((dog.nasycenie)-1)
				setElementData(v, "dog", dog)
				exports.DB2:zapytanie("UPDATE lss_petsystem SET nasycenie=nasycenie-1 WHERE char_id=?", getElementData(getElementData(v, "dog:owner"),"character").id)
				setElementHealth(v, dog.nasycenie)
				if dog.nasycenie <= 0 then --zabijamy psa :(
					triggerEvent("broadcastCaptionedEvent", v, "Pies "..dog.nazwa.." umiera z głódu.", 5, 10, true)
					exports.DB2:zapytanie("DELETE FROM lss_petsystem WHERE char_id=?", getElementData(getElementData(v, "dog:owner"),"character").id)
					unspawnDog(getElementData(v, "dog:owner"))
				end
				
			end
		end
	end
end
setTimer(dog_glod, 240000, 0)
-- setTimer(dog_glod, 5000, 0)