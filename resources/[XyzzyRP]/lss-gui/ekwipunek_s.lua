--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



function findRotation(x1,y1,x2,y2)
 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
 
end



addEvent("setPedFightingStyler", true)
addEventHandler("setPedFightingStyler", getRootElement(), function(i)
	setPedFightingStyle(source,i)
end)

addEvent("defibrylatorUse", true)
addEventHandler("defibrylatorUse", getRootElement(), function()
	local player = source
	local fid = getElementData(player, "faction:id")
	if (not fid) or (fid~=6) then 
		outputChatBox("(( Nie umiesz posługiwać się defibrylatorem! ))", player) 
		triggerEvent("broadcastCaptionedEvent", player, getPlayerName(player).." próbuje bezskutecznie użyć defibrylator", 3, 10, true)
		return
	end
	
	
	local x,y,z = getElementPosition(player)
	local sphere = createColSphere(x,y,z,2)
	setElementInterior(sphere, getElementInterior(player))
	setElementDimension(sphere, getElementDimension(player))
	local players = getElementsWithinColShape(sphere,"player")
	for k,v in ipairs(players) do
		if not getElementData(v, "character") then break end
		if isPlayerDead(v) then
			local x2,y2,z2 = getElementPosition(v)
			if (getDistanceBetweenPoints2D(x,y,x2,y2) > 2) then break end
			triggerClientEvent("BONE_SPINE1_pos", getRootElement(), v)
			setTimer(function(x,y,x2,y2,player,v,sphere)
				local x2,y2,z2 = unpack(getElementData(v, "BONE_SPINE1_pos"))
				local nrot = findRotation(x,y,x2,y2)
				setElementRotation(player, 0, 0, nrot)
				setElementFrozen(player, true)
				setPedAnimation(player, "MEDIC", "CPR", -1, false, false, true, false)
				triggerEvent("broadcastCaptionedEvent", player, getPlayerName(player).." używa defibrylatora", 3, 10, true)
				setTimer(function(player,v)
					--robimy unbw
					setElementData(v,"bwEndTime", 0)
					setElementFrozen(player, false)
				end, 7000, 1, player, v)
				destroyElement(sphere)
			end, 100, 1, x,y,x2,y2,player,v,sphere)
			return
		end
	end
	destroyElement(sphere)
end)

boombox = {}


addEvent("onBoomboxStop",true)
addEventHandler("onBoomboxStop", getRootElement(), function()
	-- if (not boombox[source] or not isElement(boombox[source])) then 
		-- return 
	-- end
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).." wyłącza radio", 5, 10, true)
	exports["bone_attach"]:detachElementFromBone(boombox[source])
	destroyElement(boombox[source])
	triggerClientEvent("onBoomboxStopSound", source)
	removeElementData(source,"boombox:object")
end)


addEvent("onBoomboxStart", true)
addEventHandler("onBoomboxStart", getRootElement(), function()
	local player = source
	if (boombox[player] and isElement(boombox[player])) then destroyElement(boombox[player]) end
	if not getElementData(source, "boombox:url") then outputChatBox("(( Aby ustawić kanał radiowy, wpisz /boomradio [link] ))", source) return end
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).." włącza radio", 5, 10, true)
	outputChatBox("(( Aby ustawić nowy kanał, wpisz /boomradio [link] ))", source)
	boombox[player]=createObject(2226,0,0,0)
	setElementDimension(boombox[player], getElementDimension(player))
	setElementInterior(boombox[player], getElementInterior(player))
	setElementCollisionsEnabled(boombox[player], false)
	exports["bone_attach"]:attachElementToBone(boombox[player], player, 12, 0, 0, 0.39, 0, 180, 0)
	setElementData(player, "boombox:object", boombox[player])
	
	triggerClientEvent("onBoomboxStartSound", source)
end)

addEventHandler("onPlayerQuit", root, function()
	if (boombox[source] and isElement(boombox[source])) then 
		destroyElement(boombox[source]) 
		boombox[source]=nil
	end
end)

addCommandHandler("boomradio", function(plr,cmd,url)
	setElementData(plr, "boombox:url", url)
	outputChatBox("(( Ustawiełeś swoje radio na nową stację ))", plr)
end)

addEvent("obroza", true)
addEventHandler("obroza", getRootElement(), function()
	local x,y,z = getElementPosition(source)
	local sphere = createColSphere(x,y,z,2)
	local el = getElementsWithinColShape(sphere)
	outputDebugString(#el)
	for i,v in ipairs(el) do
		if getElementModel(v) == 310 or getElementModel(v) == 311 or getElementModel(v) == 312 then
			if getElementData(v, "dog:wild") then
				call(getResourceFromName("lss-petsystem"),"menu_oswajanie",{player=source, dog=v})
				destroyElement(sphere)
				return
			end
		end
	end
	destroyElement(sphere)
	outputChatBox("(( Aby oswoić psa, podejdź do niego i użyj obrożę ))", source)
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source) .. " spogląda na obrożę dla psa.", 3, 20, true)
end)

addEvent("karma", true)
addEventHandler("karma", getRootElement(), function()
	local x,y,z = getElementPosition(source)
	local sphere = createColSphere(x,y,z,2)
	local el = getElementsWithinColShape(sphere)
	outputDebugString(#el)
	for i,v in ipairs(el) do
		if getElementModel(v) == 310 or getElementModel(v) == 311 or getElementModel(v) == 312 then
			if (not getElementData(v, "dog:wild")) then
				exports["lss-core"]:eq_takeItem(source, 167, 1)
				local heal = math.ceil(getElementHealth(v)+10)
				if heal > 100 then heal = 100 end
				setElementHealth(v, heal)
				exports.DB2:zapytanie("UPDATE lss_petsystem SET nasycenie=? WHERE char_id=?",heal, getElementData(getElementData(v,"dog:owner"), "character").id)
				local dog = getElementData(v, "dog")
				dog.nasycenie = heal
				setElementData(v, "dog", dog)
				destroyElement(sphere)
				triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source) .. " karmi psa.", 3, 20, true)
				return
			end
		end
	end
	destroyElement(sphere)
	outputChatBox("(( Aby nakarmić psa, podejdź do niego i użyj karmę ))", source)
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source) .. " spogląda na karmę dla psa.", 3, 20, true)
end)

weaponidToName = {
	[0]="pięści",
	[1]="kastet",
	[2]="kij golfowy",
	[3]="pałka policyjna",
	[4]="nóż",
	[5]="kij baseballowy",
	[6]="łopata",
	[7]="kij billardowy",
	[8]="katana",
	[9]="piła mechaniczna",
	[22]="glock",
	[23]="paralizator",
	[24]="deagle",
	[25]="shotgun",
	[26]="obrzyn",
	[27]="shotgun bojowy",
	[28]="UZI",
	[29]="MP5",
	[32]="TEC-9",
	[30]="AK-47",
	[31]="M4",
	[33]="strzelba",
	[34]="snajperka",
	[37]="miotacz ognia",
	[16]="granat",
	[17]="gaz łzawiący",
	[18]="molotov",
	[41]="spray",
	[42]="gasnica",
	[14]="kwiaty",
	[15]="laska",
	[54]="upadek",
}

addEvent("onCorpseWantInfo", true)
addEventHandler("onCorpseWantInfo", getRootElement(), function(id)
	local query = exports.DB2:pobierzWyniki("SELECT co.data, co.weaponid, ch.imie, ch.nazwisko FROM lss_corpses co JOIN lss_characters ch ON ch.id=? WHERE char_id=?", id, id)
	if query and query.imie then
		outputChatBox("Dane z karteczki - "..query.imie.." "..query.nazwisko.." ",source)
		outputChatBox("Narzędzie zbrodni - "..weaponidToName[query.weaponid], source)
		outputChatBox("Data zgonu - "..query.data, source)
		triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source) .. " ogląda ciało.", 3, 20, true)
	end
end)