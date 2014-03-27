--[[
lss-admin: różne funkcje dla supportu

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub

]]--


function isInvisibleAdmin(plr)
	local accName = getAccountName ( getPlayerAccount ( plr ) )
	if accName and isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) and not isObjectInACLGroup ("user."..accName, aclGetGroup ( "Administrator" ) ) then
	  return true
	end
	return false
end

function cmd_doo ( plr, command, czas, ... )
	if not czas or not tonumber(czas) or tonumber(czas)<2 then
		outputChatBox("Użyj: /doo <czas> <tekst>", plr)
		return
	end
	local txt = table.concat( arg, " " )
	if string.len(txt)<3 then
		outputChatBox("Użyj: /doo <czas> <tekst>", plr)
		return
	end
	triggerClientEvent("onCaptionedEvent", root, txt, tonumber(czas))
end

addCommandHandler( "doo", cmd_doo,true,false )

function cmd_torba(plr,cmd)
	beztorby = {}
	
	for k,v in ipairs(getElementsByType("player")) do
		local eq=getElementData(v,"EQ")
		if eq then
			EQ={}
			for i=1,28 do
				EQ[i]={}
				EQ[i].itemid=tonumber(table.remove(eq,1))
				EQ[i].count=tonumber(table.remove(eq,1))
				EQ[i].subtype=tonumber(table.remove(eq,1))
			end
			
			local ilosc = #EQ
			if ilosc > 14 then
				if not getElementData(v, "plecak") then table.insert(beztorby,v) end
			end
			
		end
	end

	outputChatBox("Nadano warny graczom bez plecaka/torebki: ",plr,0,255,0)
	for i,v in ipairs(beztorby) do
		triggerClientEvent("onPlayerWarningReceived",v,"Przy posiadaniu 14+ itemow, zaloz plecak!")
		local c=getElementData(v,"character")
		outputChatBox(c.imie.." "..c.nazwisko.." ("..getElementData(v,"id")..")",plr,255,0,0)
	end
   
end

-- addCommandHandler("torba", cmd_torba,true,false)

function cmd_toggle(player,command,what)
	if (what=="OOC" or what=="ooc") then
		if (exports["lss-core"]:toggleOOC()) then
			outputChatBox("Chat OOC wlaczony.", player)
		else
			outputChatBox("Chat OOC wylaczony.", player)
		end
	end
end

addCommandHandler("toggle", cmd_toggle, true, false)

addCommandHandler("vehreload", function(plr,cmd,id)
	if (not id) then
		return outputChatBox("Użyj: #FFFF00/vehreload <id>", plr, 255,255,255,true)
	end
	exports["lss-vehicles"]:veh_reload(id)
end,true,false)


function cmd_tt ( player, command, target )
	local plr = findPlayer ( player, target )
	if (not plr) then
		outputChatBox("Nie znaleziono gracza o nicku " .. target,player )
		return
	end
	local x,y,z = getElementPosition( plr )
	if (isPedInVehicle(player)) then
		removePedFromVehicle(player)
	end
	setPedAnimation(player)
	setElementAlpha(player,0)
	setElementDimension(player, getElementDimension(plr))
	setElementInterior(player, getElementInterior(plr))
	setElementPosition ( player, x+math.random(-3,3), y+math.random(-3,3), z+math.random(0,3) )

end

addCommandHandler( "tt", cmd_tt,true,false )


function cmd_stt ( player, command, target )
	local plr = findPlayer ( player, target )
	if (not plr) then
		outputChatBox("Nie znaleziono gracza o nicku " .. target,player )
		return
	end
	local x,y,z = getElementPosition( plr )
	if (isPedInVehicle(player)) then
		removePedFromVehicle(player)
	end
	setPedAnimation(player)
	setElementAlpha(player,0)
	    setElementInterior(player, getElementInterior(v))
	    setElementDimension(player, getElementDimension(v))
	setElementPosition ( player, x+math.random(-50,50), y+math.random(-50,50), z+math.random(0,1) )

end

addCommandHandler( "stt", cmd_stt,true,false )


function cmd_ttv(player,command,vid)
    if (not vid or not tonumber(vid)) then return end
    vid=tonumber(vid)
    for i,v in ipairs(getElementsByType("vehicle")) do
	local dbid=getElementData(v,"dbid")
	if (dbid and tonumber(dbid)==vid) then
	    setElementAlpha(player,0)
	    local x,y,z=getElementPosition(v)
	    setElementPosition(player,x,y,z+4)
	    setElementInterior(player, getElementInterior(v))
	    setElementDimension(player, getElementDimension(v))

	    return
	end
    end
    outputChatBox("Nie odnaleziono na mapie pojazdu o podanym ID.", player, 255,0,0)
	-- sprawdzmy czy nie jest w przechowalni
	local query=string.format("SELECT 1 FROM lss_vehicles WHERE id=%d AND przechowalnia>0",vid);
	local wynik=exports.DB:pobierzWyniki(query)
	if (wynik) then
		outputChatBox("Pojazd znajduje sie na parkingu/w przechowalni.", player)
	end
    return
end

addCommandHandler("ttv", cmd_ttv, true, false)

function cmd_th ( player, command, target )
	local plr = findPlayer ( player, target )
	if (not plr) then
		outputChatBox("Nie znaleziono gracza o nicku " .. target,player )
		return
	end
	local x,y,z = getElementPosition( player )
	if (isPedInVehicle(plr)) then
		removePedFromVehicle(plr)
	end
	setElementDimension(plr, getElementDimension(player))
	setElementInterior(plr, getElementInterior(player))
	setElementPosition ( plr, x+(math.random(-1,1)/5), y+(math.random(-1,1)/5), z+(math.random(0,10)/10) )

end

addCommandHandler( "th", cmd_th,true,false )

function cmd_unbw(player,command,target)
	if (not target) then
	    outputChatBox("Uzyj: /unbw <id/nick>", player)
	    return
        end
	local plr = findPlayer ( player, target )
	if (not plr) then
		outputChatBox("Nie znaleziono gracza o nicku " .. target,player )
		return
	end

	setElementData(plr,"bwEndTime", 0)
end
addCommandHandler("unbw", cmd_unbw, true,false)

function cmd_muteooc(plr,cmd,cel,czas,jednostka,...)
	local reason = table.concat( arg, " " )

	if (not cel or not czas or not jednostka) then
		outputChatBox("Uzyj: /muteooc <id/nick> <czas> <jednostka:m/h/d> <powod>", plr)
		return
	end

	local target=findPlayer(plr,cel)

	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end

	jednostka=string.lower(jednostka)
	if (jednostka=="m") then
		jednostka="MINUTE"
	elseif (jednostka=="h" or jednostka=="g") then
		jednostka="HOUR"
	elseif (jednostka=="d") then
		jednostka="DAY"
	else
		outputChatBox("Jednostki: m - minuta, h - godzina, d - dzien", plr)
		return
	end


	czas=tonumber(czas)
	if (not czas or czas<1) then
		outputChatBox("Nieprawidlowy okres czasu.",plr)
		return
	end

	local uid=getElementData(target, "auth:uid")
	if (not uid) then
	    outputChatBox("Gracz nie jest zalogowany do gry", plr, 255,0,0,true)
	    return
	end
	
	local supportLogin=getElementData(plr, "auth:login")
	
	if (not supportLogin) then 
--		outputDebugString(getPlayerName(plr) .. getElementData(plr,"auth:login"))
		outputChatBox("Nie jesteś zalogowany/a", plr, 255,0,0,true)
	return end

--	local q = string.format("INSERT INTO pbp_bany SET id_player=%s,serial='%s',date_to=NOW()+INTERVAL %d %s,reason='%s',notes='%s',banned_by=%d", 
--				id_player,exports.DB:esc(getPlayerSerial(target)),czas,jednostka,exports.DB:esc(reason),exports.DB:esc("nick: "..getPlayerName(target)),playerData[plr].account.id)
	local q=string.format("UPDATE lss_users SET blokada_ooc=NOW()+INTERVAL %d %s WHERE id=%d LIMIT 1", czas, jednostka, uid)
	exports.DB:zapytanie(q)

	if (exports.DB:affectedRows()<1) then
		outputChatBox("Nie udalo sie wprowadzic bana do bazy danych", plr)
		return
	end

	outputChatBox("* " .. supportLogin .. " nałożył blokade OOC na: " .. getPlayerName(target) .. ", powod: " .. reason, target, 255,0,0,true)
	triggerClientEvent("showAnnouncement", root, supportLogin .. " nałożył blokadę OOC na: " .. getPlayerName(target) .. ", powód: " .. reason, 15)
	setElementData(target, "kary:blokada_ooc", tostring(czas) .. " " .. jednostka .. " (połącz się ponownie aby poznać dokładny czas)")
end

addCommandHandler("booc", cmd_muteooc, true,false)






function cmd_bbicia(plr,cmd,cel,czas,jednostka,...)
	local reason = table.concat( arg, " " )

	if (not cel or not czas or not jednostka) then
		outputChatBox("Uzyj: /bbicia <id/nick> <czas> <jednostka:m/h/d> <powod>", plr)
		return
	end

	local target=findPlayer(plr,cel)

	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end

	jednostka=string.lower(jednostka)
	if (jednostka=="m") then
		jednostka="MINUTE"
	elseif (jednostka=="h" or jednostka=="g") then
		jednostka="HOUR"
	elseif (jednostka=="d") then
		jednostka="DAY"
	else
		outputChatBox("Jednostki: m - minuta, h - godzina, d - dzien", plr)
		return
	end


	czas=tonumber(czas)
	if (not czas or czas<1) then
		outputChatBox("Nieprawidlowy okres czasu.",plr)
		return
	end

	local uid=getElementData(target, "auth:uid")
	if (not uid) then
	    outputChatBox("Gracz nie jest zalogowany do gry", plr, 255,0,0,true)
	    return
	end
	
	local supportLogin=getElementData(plr, "auth:login")
	
	if (not supportLogin) then 
--		outputDebugString(getPlayerName(plr) .. getElementData(plr,"auth:login"))
		outputChatBox("Nie jesteś zalogowany/a", plr, 255,0,0,true)
	return end

--	local q = string.format("INSERT INTO pbp_bany SET id_player=%s,serial='%s',date_to=NOW()+INTERVAL %d %s,reason='%s',notes='%s',banned_by=%d", 
--				id_player,exports.DB:esc(getPlayerSerial(target)),czas,jednostka,exports.DB:esc(reason),exports.DB:esc("nick: "..getPlayerName(target)),playerData[plr].account.id)
	local q=string.format("UPDATE lss_users SET blokada_bicia=NOW()+INTERVAL %d %s WHERE id=%d LIMIT 1", czas, jednostka, uid)
	exports.DB:zapytanie(q)

	if (exports.DB:affectedRows()<1) then
		outputChatBox("Nie udalo sie wprowadzic bana do bazy danych", plr)
		return
	end

	outputChatBox("* " .. supportLogin .. " nałożył blokade bicia/ataku na: " .. getPlayerName(target) .. ", powod: " .. reason, target, 255,0,0,true)
	triggerClientEvent("showAnnouncement", root, supportLogin .. " nałożył blokadę bicia/ataku na: " .. getPlayerName(target) .. ", powód: " .. reason, 15)
	setElementData(target, "kary:blokada_bicia", tostring(czas) .. " " .. jednostka .. " (połącz się ponownie aby poznać dokładny czas)")
	toggleControl(target, "fire", false)
	toggleControl(target, "aim_weapon", false)
end

addCommandHandler("bbicia", cmd_bbicia, true,false)


function cmd_bpm(plr,cmd,cel,czas,jednostka,...)
	local reason = table.concat( arg, " " )

	if (not cel or not czas or not jednostka) then
		outputChatBox("Uzyj: /bpm <id/nick> <czas> <jednostka:m/h/d> <powod>", plr)
		return
	end

	local target=findPlayer(plr,cel)

	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end

	jednostka=string.lower(jednostka)
	if (jednostka=="m") then
		jednostka="MINUTE"
	elseif (jednostka=="h" or jednostka=="g") then
		jednostka="HOUR"
	elseif (jednostka=="d") then
		jednostka="DAY"
	else
		outputChatBox("Jednostki: m - minuta, h - godzina, d - dzien", plr)
		return
	end


	czas=tonumber(czas)
	if (not czas or czas<1) then
		outputChatBox("Nieprawidlowy okres czasu.",plr)
		return
	end

	local uid=getElementData(target, "auth:uid")
	if (not uid) then
	    outputChatBox("Gracz nie jest zalogowany do gry", plr, 255,0,0,true)
	    return
	end
	
	local supportLogin=getElementData(plr, "auth:login")
	if isInvisibleAdmin(plr) then supportLogin="Zdalny admin" end
	
	if (not supportLogin) then 
--		outputDebugString(getPlayerName(plr) .. getElementData(plr,"auth:login"))
		outputChatBox("Nie jesteś zalogowany/a", plr, 255,0,0,true)
	return end

--	local q = string.format("INSERT INTO pbp_bany SET id_player=%s,serial='%s',date_to=NOW()+INTERVAL %d %s,reason='%s',notes='%s',banned_by=%d", 
--				id_player,exports.DB:esc(getPlayerSerial(target)),czas,jednostka,exports.DB:esc(reason),exports.DB:esc("nick: "..getPlayerName(target)),playerData[plr].account.id)
	local q=string.format("UPDATE lss_users SET blokada_pm=NOW()+INTERVAL %d %s WHERE id=%d LIMIT 1", czas, jednostka, uid)
	exports.DB:zapytanie(q)

	if (exports.DB:affectedRows()<1) then
		outputChatBox("Nie udalo sie wprowadzic bana do bazy danych", plr)
		return
	end

	outputChatBox("* " .. supportLogin .. " nałożył blokade PM na: " .. getPlayerName(target) .. ", powod: " .. reason, target, 255,0,0,true)
	triggerClientEvent("showAnnouncement", root, supportLogin .. " nałożył blokadę PM na: " .. getPlayerName(target) .. ", powód: " .. reason, 15)
	setElementData(target, "kary:blokada_pm", tostring(czas) .. " " .. jednostka .. " (połącz się ponownie aby poznać dokładny czas)")
end

addCommandHandler("bpm", cmd_bpm, true,false)

local function isValidSkin(s)
  local allSkins = getValidPedModels ( )
  for key, skin in ipairs( allSkins ) do -- Check all skins
      if skin == s then return true end
  end
  return false
end

local womanSkins = {
	[9]=true,
	[11]=true,
	[12]=true,
	[13]=true,
	[31]=true,
	[40]=true,
	[63]=true,
	[69]=true,
	[86]=true,
	[90]=true,
	[91]=true,
	[92]=true,
	[93]=true,
	[131]=true,
	[141]=true,
	[150]=true,
	[151]=true,
	[152]=true,
	[169]=true,
	[190]=true,
	[191]=true,
	[192]=true,
	[193]=true,
	[211]=true,
	[214]=true,
	[216]=true,
	[224]=true,
	[226]=true,
	[234]=true,
	[263]=true,
	[298]=true,
}

function isWomanSkin(s)
	return womanSkins[s]
end

local function isSkinPremium(s)
  if s==137 or s==145 or s==167 or s==203 or s==204 or s==205 or s==256 or s==257 or s==26 or s==264 or s==38 or s==39 or s==45 or s==81 or s==83 or s==84 or s==87 or s==80 then return true end
  return false
end
local function isCOSkin(s)
  local query=string.format("select 1 from lss_co_skins where skin=%d AND restricted=1 limit 1", s)
  local d=exports.DB:pobierzWyniki(query)
  if d then return true end
  return false
end

function cmd_skin(plr,cmd,cel,skin)
	if (not skin or not cel) then
		outputChatBox("Uzyj: /skin <id/nick> <id skinu>", plr)
		return
	end
	skin=tonumber(skin)

	if (isCOSkin(skin)) then
		outputChatBox("Wybrany skin nalezy do organizacji przestepczej, zmiany moze dokonac lider tej organizacji.", plr)
		return
	end

	if (isSkinPremium(skin)) then
	  outputChatBox("Wybrany skin to skin premium. Gracz musi go zmienic sam w panelu pod http://lss-rp.pl/postacie", plr)
	  return
	end

	if (not isValidSkin(skin)) then
	  outputChatBox("Podane ID skina jest nieprawidlowe.", plr)
	  return
	end

	

	local target=findPlayer(plr,cel)

	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end

	local uid=getElementData(target, "auth:uid")
	if (not uid) then
	    outputChatBox("Gracz nie jest zalogowany do gry", plr, 255,0,0,true)
	    return
	end
	local c=getElementData(target,"character")
	if (not c) then
		outputChatBox("Gracz jeszcze nie wybral postaci.", plr, 255,0,0,true)
		return
	end
	
	if isWomanSkin(skin) then
		c.plec = "female"
	else
		c.plec = "male"
	end
	
	setElementData(target, "character", c)
	local supportLogin=getElementData(plr, "auth:login")
	
	if (not supportLogin) then 
--		outputDebugString(getPlayerName(plr) .. getElementData(plr,"auth:login"))
		outputChatBox("Nie jesteś zalogowany/a", plr, 255,0,0,true)
	return end

	setElementModel(target, skin)
	local query=string.format("UPDATE lss_characters SET skin=%d WHERE id=%d LIMIT 1", skin, c.id)
	exports.DB:zapytanie(query)
	gameView_add("ZMIANA SKINA "..supportLogin.." zmienil skin " .. getPlayerName(target).." na "..skin)
end

addCommandHandler("skin", cmd_skin, true, false)



function cmd_baj(plr,cmd,cel,czas,...)
	if (not cel or not czas) then
		outputChatBox("Uzyj: /bAJ <id/nick> <czas w minutach> <powod>", plr)
		return
	end

	local target=findPlayer(plr,cel)

	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end

	local reason = table.concat( arg, " " )
	local uid=getElementData(target, "auth:uid")
	if (not uid) then
	    outputChatBox("Gracz nie jest zalogowany do gry", plr, 255,0,0,true)
	    return
	end
	
	local supportLogin=getElementData(plr, "auth:login")
	if isInvisibleAdmin(plr) then supportLogin="Zdalny admin" end
	
	if (not supportLogin) then 
--		outputDebugString(getPlayerName(plr) .. getElementData(plr,"auth:login"))
		outputChatBox("Nie jesteś zalogowany/a", plr, 255,0,0,true)
	return end

--	local q = string.format("INSERT INTO pbp_bany SET id_player=%s,serial='%s',date_to=NOW()+INTERVAL %d %s,reason='%s',notes='%s',banned_by=%d", 
--				id_player,exports.DB:esc(getPlayerSerial(target)),czas,jednostka,exports.DB:esc(reason),exports.DB:esc("nick: "..getPlayerName(target)),playerData[plr].account.id)
	local q=string.format("UPDATE lss_users SET blokada_aj=%d WHERE id=%d LIMIT 1", czas, uid)
	exports.DB:zapytanie(q)
	outputDebugString(q)

--	if (exports.DB:affectedRows()<1) then
--		outputChatBox("Nie udalo sie wprowadzic AJ do bazy danych", plr)
--		return
--	end
	local character=getElementData(target,"character")


	outputChatBox("* " .. supportLogin .. " nałożył AJ (" .. czas .. " min) na: " .. getPlayerName(target) .. ", powod: " .. reason, target, 255,0,0,true)
	triggerClientEvent("showAnnouncement", root, supportLogin .. " nałożył AJ (" .. czas .. " min) na: " .. getPlayerName(target) .. ", powód: " .. reason, 15)
	setElementData(target, "kary:blokada_aj", czas)
	removePedFromVehicle(target)
	setElementInterior(target,10)
	setElementDimension(target,2000+(character and tonumber(character.id) or 0))
	setElementPosition(target, 215.53,109.52,999.02)
--	spawnPlayer ( plr, 317.96,316.98,999.15,267.3, tonumber(character.skin), 5, 0)

end
addCommandHandler("baj", cmd_baj, true,false)

function cmd_heal(plr,cmd, cel)
	if (not cel) then
	  outputChatBox("Uzyj: /heal <id/nick>", plr)
	  return
	end
	local target=findPlayer(plr,cel)

	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end
	setElementHealth(target, 100)
	outputChatBox("Uleczono gracza " .. getPlayerName(target), plr)
	outputChatBox("(( Zostałeś uleczony/a. ))", target)
end

addCommandHandler("heal", cmd_heal, true, false)

function cmd_spec(plr,cmd, cel)
	local target=findPlayer(plr,cel)

	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end
	removePedFromVehicle(plr)
	setElementInterior(plr, getElementInterior(target))
	setElementDimension(plr, getElementDimension(target))
--	setElementDimension(plr, 69)
--	setElementPosition(plr, -827+math.random(-5,5), 502.76+math.random(-5,5), 1358.72)
	setElementPosition(plr, 3521.56,3520.72,12.85)
--	setCameraInterior(plr, getElementInterior(target))
	setCameraTarget(plr, target)
end

addCommandHandler("spec", cmd_spec,true,false)


function cmd_specoff(plr,cmd)
	setElementPosition(plr, 3521.56,3520.72,12.85)
	setCameraTarget(plr,plr)
end

addCommandHandler("specoff", cmd_specoff,true,false)


addCommandHandler("inv", function(plr)
  if (getElementAlpha(plr)>0) then
	setElementAlpha(plr,0)
  else
    setElementAlpha(plr,255)
  end
end, true, false)

addCommandHandler("invveh", function(plr)
	local plr = getPedOccupiedVehicle(plr)
	if not plr then return end
  if (getElementAlpha(plr)>0) then
	setElementAlpha(plr,0)
  else
    setElementAlpha(plr,255)
  end
end, true, false)

addCommandHandler("warn", function(plr,cmd,cel, ...)
	local target = findPlayer ( plr, cel )
	if (not target) then
		outputChatBox("Nie znaleziono gracza " .. cel,plr )
		return
	end
	local tresc = table.concat( arg, " " )
	if (string.len(tresc)<=1) then
		outputChatBox("Wpisz tresc ostrzezenia!", plr)
		return
	end

--	local llogin=getElementData(plr,"auth:login")
--	if isInvisibleAdmin(plr) then llogin="administrator zdalny" end
--	outputChatBox(getPlayerName(target) .. " otrzymal ostrzezenie od " .. llogin .. ": " .. tresc, getRootElement(), 255,0,0)
	triggerClientEvent("onPlayerWarningReceived", target, tresc)
end, true,false)


addCommandHandler("sp", function(plr,cmd)
    local pos={}
    pos[1],pos[2],pos[3]=getElementPosition(plr)
    pos[4]=getElementInterior(plr)
    pos[5]=getElementDimension(plr)
    setElementData(plr,"savedPosition", pos)
    outputChatBox("Pozycja została zapisana.", plr)
end,true,false)

addCommandHandler("lp", function(plr,cmd)
    local pos=getElementData(plr, "savedPosition")
    if (not pos) then
	outputChatBox("Nie masz żadnej zapisanej pozycji.", plr)
	return
    end
    setElementAlpha(plr,0)
    setElementPosition(plr,pos[1],pos[2],pos[3])
    setElementInterior(plr,pos[4])
    setElementDimension(plr,pos[5])
    outputChatBox("Wczytano pozycję.", plr)
end,true,false)



function cmd_ck(plr, cmd, cel, ...)
	if (not cel) then
	  outputChatBox("Użyj: /ck <id/nick> <powod>", plr)
	  return
	end
	local target = findPlayer ( plr, cel )
	if (not target) then
		outputChatBox("Nie znaleziono gracza " .. cel,plr )
		return
	end
	local tresc = table.concat( arg, " " )
	if (string.len(tresc)<=1) then
		outputChatBox("Wpisz powód śmierci.", plr)
		return
	end
	if (string.len(tresc)>90) then
		outputChatBox("Powód jest zbyt długi (max 90 znaków).", plr)
		return
	end

	local character=getElementData(target,"character")
	if (not character) then
		outputChatBox("Wskazany gracz nie jest zalogowany.", plr)
		return
	end

	if not isPedDead(target) then
		outputChatBox("Gracz musi mieć BW, abyś mógł/mogła zatwierdzić śmierć.", plr)
		return
	end

	local slogin=getElementData(plr,"auth:login")
	if (not slogin) then
		outputChatBox("Nie jestes zalogowany!", plr)
		return
	end
	triggerEvent("broadcastCaptionedEvent", target, getPlayerName(target) .. " umiera. "..tresc, 5, 15, true)
	local x,y,z = getElementPosition(target)
	
	local bron = getElementData(target, "ck:bron")
	exports.DB2:zapytanie("INSERT INTO lss_corpses (char_id, weaponid) VALUES (?, ?)",getElementData(target,"character").id, bron)
	
	triggerEvent("onItemDrop", target, 166, getElementData(target, "character").id, "Zwłoki", true) --na stale
	
	gameView_add("CK "..character.imie.." "..character.nazwisko..", powod: '".. tresc .."', przez: ".. slogin)
	local query=string.format("UPDATE lss_characters SET dead='%s' WHERE id=%d LIMIT 1", exports.DB:esc(tresc), character.id)
	exports.DB:zapytanie(query)

	kickPlayer(target,"Smierć postaci: " .. tresc)

end


addCommandHandler("ck", cmd_ck, true, false)

function cmd_kick(plr,cmd,cel,...)
	if (not cel) then
		outputChatBox("Uzyj: /k[ick] <nick/id> [powod]",plr)
		return
	end
	local target=findPlayer(plr,cel)

	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end

	local reason = table.concat( arg, " " )

	local slogin=getElementData(plr,"auth:login")
	if (not slogin) then
		outputChatBox("Nie jestes zalogowany!", plr)
		return
	end

	if isInvisibleAdmin(plr) then
		slogin="Zdalny administrator"
	end

  	gameView_add("KICK "..getPlayerName(target)..", powod: '".. reason .."', przez: ".. slogin)		
	outputChatBox(slogin.." wykopał/a " .. getPlayerName(target)..": ".. reason, target, 255,0,0)
	triggerClientEvent("showAnnouncement", root, slogin.." wykopał/a " .. getPlayerName(target)..": ".. reason, 15)
	kickPlayer ( target, plr, reason)



end

addCommandHandler("kick", cmd_kick, true, false)


function cmd_eq(plr,cmd,cel)
	if (not cel) then
		outputChatBox("Uzyj: /eq <nick/id>",plr)
		return
	end
	local target=findPlayer(plr,cel)

	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end
	triggerClientEvent(target, "onEQDataRequest", root, plr)

end
addCommandHandler("eq", cmd_eq, true, false)

-- triggerServerEvent("onPlayerShowEQ", localPlayer, komu, EQ)
addEvent("onPlayerShowEQ", true)
addEventHandler("onPlayerShowEQ", root, function(komu, EQ, przeszukanie)
  if (not komu or not isElement(komu)) then return end
  outputChatBox("Ekwipunek gracza " .. getPlayerName(source), komu)
  local przedmioty={}
  for i,v in ipairs(EQ) do
	if (v.itemid and tonumber(v.itemid)>0) then
	  outputChatBox(tostring(i)..". " .. tostring(v.count) .. "x "..v.name.. " [" .. (v.subtype or "-").."]", komu)
	  local str=""
	  if (tonumber(v.count)>1) then
		  str=str .. tostring(v.count).."x"
	  end
	  str=str..v.name
	  table.insert(przedmioty, str)
	end
  end
  outputChatBox("Gotówka: " .. getPlayerMoney(source).."$", komu)
  if (getPlayerMoney(source)>0) then
	  table.insert(przedmioty, string.format("%.02f",getPlayerMoney(source)/100).."$")
  end
  if (przeszukanie) then
      local eq_desc=table.concat(przedmioty,", ")
      triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source) .. " ma przy sobie: "..eq_desc, 10, 5, true)
  end

end)



function cmd_cenapojazdu(plr,cmd,nazwa)
	if (not nazwa) then
		outputChatBox("uzyj: /cenapojazdu <id/nazwa>",plr)
	end
	local vid=0
	if (tonumber(nazwa) and tonumber(nazwa)>=400) then
		vid=tonumber(nazwa)
	else
		vid=getVehicleModelFromName(nazwa)
	end
	if (not vid or vid==0) then
		outputChatBox("Nie udalo sie odnalezc pojazdu o podanej nazwie/id.", plr)
	end
	outputChatBox("MODEL: " .. vid,plr)
	outputChatBox("Nazwa: " .. getVehicleNameFromModel(vid), plr)
	outputChatBox("Cena:  " .. getModelHandling(vid).monetary.."$", plr)
end
addCommandHandler("cenapojazdu", cmd_cenapojazdu, true,false)


function cmd_cenypojazdow(plr)
  local vehicleIDS = { 496, 517, 401, 410, 518, 600, 527, 436, 419, 439, 533, 549, 526, 491, 474, 445, 426, 507, 547, 585,
405, 587, 409, 466, 492, 566, 540, 551, 421, 529, 592, 553, 488, 511, 497, 548, 563, 512, 476, 593, 447, 425, 519, 520, 460,
417, 469, 487, 513, 581, 510, 509, 522, 481, 461, 462, 448, 521, 468, 586, 472, 473, 493, 595, 484, 430, 453, 452, 446, 454, 485, 552, 431, 
438, 437, 574, 420, 525, 408, 416, 596, 433, 597, 427, 599, 490, 601, 407, 428, 544, 523, 470, 598, 499, 588, 609, 403, 498, 514, 524, 
423, 414, 578, 443, 486, 515, 406, 531, 573, 456, 455, 543, 482, 478, 554, 418, 582, 413, 440, 536, 575, 
567, 535, 576, 412, 402, 542, 603, 475, 449, 537, 538, 501, 465, 568, 557, 471, 495, 539, 483, 508, 500, 
444, 556, 429, 411, 541, 559, 415, 561, 480, 560, 506, 565, 451, 558, 555, 477, 579, 400, 404, 489, 479, 442,
606, 607, 610, 590, 569, 611, 584, 608, 435, 591} -- , 594 }
  local text="Model\tNazwa\tCena"
  for i,v in ipairs(vehicleIDS) do
  if (getVehicleType(v)=="Automobile") then
	local text2=tostring(v).."\t"..getVehicleNameFromModel(v).."\t"..(getModelHandling(v).monetary*3).."$"
	outputConsole(text2)
	text=text..text2.."\n"
  end
  end
--  setClipboard(text)
end
addCommandHandler("cenypojazdow", cmd_cenypojazdow, false, false)

function cmd_info(plr,cmd,cel)
	if (not cel) then
		outputChatBox("Uzyj: /pinfo <nick/id>",plr)
		return
	end
	local target=findPlayer(plr,cel)

	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end
	local id=getElementData(target,"id")
    outputChatBox("ID: ".. (id or "-") ..", nick: " .. getPlayerName(target), plr)
	local c=getElementData(target,"character")
	if (not c) then
		outputChatBox("Gracz nie dołączył jeszcze do gry, lub nie wybral jeszcze postaci", plr)
		return
	end

	outputChatBox("Imię: " .. c.imie ..", nazwisko: " .. c.nazwisko ..", ID: " .. c.id .. ", skin: " .. getElementModel(target), plr)
  local login=getElementData(target,"auth:login")
  outputChatBox("Login: " .. login, plr)


  
end
addCommandHandler("pinfo", cmd_info, true, false)


function cmd_sluzby(plr,cmd)
  -- sprawdzamy liste frakcji
  local frakcje=exports.DB:pobierzTabeleWynikow("SELECT id,name FROM lss_faction WHERE public=1")
  -- chuj tam ze nieoptymalne, rzadko bedzie uzywane
  for i,v in ipairs(frakcje) do
	outputChatBox(v.id..". ".. v.name, plr, 255,255,0)
	local t=""
	for _,player in ipairs(getElementsByType("player")) do
	  local fid=getElementData(player,"faction:id")
	  if (fid and tonumber(fid)==tonumber(v.id)) then
		  t=t..getPlayerName(player).."("..getElementData(player,"id")..")"..", "
	  end
	  if (string.len(t)>60) then
		outputChatBox("  "..t, plr)
		t=""
	  end
	end
	if (string.len(t)>0) then
	  outputChatBox("  "..t, plr)
	end

  end
end
addCommandHandler("sluzby", cmd_sluzby, true, false)


addCommandHandler("veh.info", function(plr,cmd,pojazd)
	if not pojazd or not tonumber(pojazd) then
		outputChatBox("Użyj: /veh.info <id pojazdu>", plr)
		return
	end
	pojazd=tonumber(pojazd)
	local query=string.format("select v.model,v.last_modified,v.created,v.tablica,v.owning_player,concat(c.imie,' ',c.nazwisko) owning_player_name,v.owning_faction,f.name owning_faction_name,v.opis,v.paliwo,v.bak,v.przebieg from lss_vehicles v LEFT JOIN lss_characters c ON v.owning_player=c.id LEFT JOIN lss_faction f ON v.owning_faction=f.id where v.id=%d limit 1", pojazd)
	local danepojazdu=exports.DB:pobierzWyniki(query)
	if not danepojazdu or not danepojazdu.model then
		outputChatBox("Nie odnaleziono danego pojazdu", plr)
		return
	end
	if type(danepojazdu.owning_player)~="string" then danepojazdu.owning_player="-" end
	if type(danepojazdu.owning_faction)~="string" then danepojazdu.owning_faction="-" end
	if type(danepojazdu.owning_player_name)~="string" then danepojazdu.owning_player_name="-" end
	if type(danepojazdu.owning_faction_name)~="string" then danepojazdu.owning_faction_name="-" end

	outputChatBox("Pojazd ID " .. pojazd .. ", model " .. danepojazdu.model .. " ("..getVehicleNameFromModel(danepojazdu.model)..")", plr)
	outputChatBox("Własność gracza " .. danepojazdu.owning_player_name .. " ("..danepojazdu.owning_player..") / frakcji " .. danepojazdu.owning_faction_name .." ("..danepojazdu.owning_faction..")", plr)
	outputChatBox("Pojazd utworzony " .. danepojazdu.created .. " ostatnio uzywany " .. danepojazdu.last_modified .. " przebieg " .. danepojazdu.przebieg, plr)
	outputChatBox("Tablica " .. danepojazdu.tablica .. " Paliwo " .. danepojazdu.paliwo .. " / " ..danepojazdu.bak, plr)
end, true, false)


addCommandHandler("dp", function(player,cmd)
	local veh = getPedOccupiedVehicle(player)
	if getElementData(veh,"damageproof") then outputChatBox("YES",player) else outputChatBox("NO",player) end
	
end)