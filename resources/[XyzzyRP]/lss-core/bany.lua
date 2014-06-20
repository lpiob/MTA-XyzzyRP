--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



function isPlayerBanned(plr)
	local uid=getElementData(plr,"auth:uid") or 0
	local query=string.format("SELECT b.date_to,b.reason,u.login banned_by FROM lss_bany b JOIN lss_users u ON b.banned_by=u.id WHERE (b.id_user=%d OR b.serial='%s') AND b.date_to>NOW() ORDER BY b.date_to DESC LIMIT 1",
		uid, exports.DB:esc(getPlayerSerial(plr)))
	pasujacy_ban=exports.DB:pobierzWyniki(query)
	if (pasujacy_ban) then
				outputDebugString("Gracz " .. getPlayerName(plr) .. " nie dolacza z powodu aktywnego bana " .. pasujacy_ban.reason .. "(do "..pasujacy_ban.date_to..")")
				outputConsole(" ", plr)
				outputConsole(" ", plr)
				outputConsole(" ", plr)
				outputConsole(" ", plr)
				outputConsole(" ", plr)
				outputConsole("=====================================", plr)
				outputConsole("Zostales/as zbanowany/a na tym serwerze ", plr)
				outputConsole(" ", plr)
				outputConsole("Powód: " .. pasujacy_ban.reason, plr)
				outputConsole("Ban jest aktywny do: "..pasujacy_ban.date_to, plr)
				outputConsole("Ban został nałozony przez: " .. pasujacy_ban.banned_by, plr)
				outputConsole("Twoj serial: " .. getPlayerSerial(plr), plr)
				outputConsole(" ", plr)
				outputConsole("Jeśli uważasz, że ban jest niesłuszny, bądź też chcesz starac", plr)
				outputConsole("sie o wczesniejsze zdjecie, napisz podanie o odbanowanie pod", plr)
				outputConsole("adresem: http://lss-rp.pl/unban", plr)
				kickPlayer(plr,"Wcisnij ~ ")
				return true
	end
	return false

end

function cmd_ban(plr,cmd,cel,czas,jednostka,...)
	local reason = table.concat( arg, " " )

	if (not cel or not czas or not jednostka) then
		outputChatBox("Uzyj: /ban <id/nick> <czas> <jednostka:m/h/d> <powod>", plr)
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
		outputChatBox("Uzyj: /ban <id/nick> <czas> <jednostka:m/h/d> <powod>", plr)
		outputChatBox("Jednostki: m - minuta, h - godzina, d - dzien", plr)
		return
	end


	czas=tonumber(czas)
	if (not czas or czas<1) then
		outputChatBox("Nieprawidlowy okres czasu.",plr)
		return
	end

	local userid=getElementData(target, "auth:uid")

	local q = string.format("INSERT INTO lss_bany SET id_user=%s,serial='%s',date_to=NOW()+INTERVAL %d %s,reason='%s',notes='%s',banned_by=%d", 
				userid,exports.DB:esc(getPlayerSerial(target)),czas,jednostka,exports.DB:esc(reason),exports.DB:esc("nick: "..getPlayerName(target)),getElementData(plr,"auth:uid"))
	exports.DB:zapytanie(q)

	if (exports.DB:affectedRows()<1) then
		outputChatBox("Nie udalo sie wprowadzic bana do bazy danych", plr)
		return
	end

--	outputChatBox("Gracz " .. getPlayerName(target) .. " został/a zbanowany/a przez administratora/kę " .. getElementData(plr,"auth:login"), root, 255,0,0)
--	outputChatBox("Powód: " .. reason, root, 255,0,0)
	local slogin=getElementData(plr,"auth:login")
	if isInvisibleAdmin(plr) then slogin="zdalny administrator" end
	triggerClientEvent("showAnnouncement", root, "Gracz " .. getPlayerName(target) .. " został/a zbanowany/a przez członka ekipy " .. slogin .. ", powód: " .. reason, 15)
	kickPlayer(target,"Polacz sie od nowa.")

end

addCommandHandler("ban", cmd_ban, true,false)

function autobanPlayer(target,reason,quiet)
	local userid=getElementData(target, "auth:uid")

	local q = string.format("INSERT INTO lss_bany SET id_user=%s,serial='%s',date_to=NOW()+INTERVAL 24 MONTH,reason='%s',notes='ban automatyczny',banned_by=10", 
				userid,exports.DB:esc(getPlayerSerial(target)),exports.DB:esc(reason))
	exports.DB:zapytanie(q)
	if (exports.DB:affectedRows()<1) then
		outputDebugString("Nie udalo sie wprowadzic bana do bazy danych")
		return
	end
    if not quiet then
    	triggerClientEvent("showAnnouncement", root, "Gracz " .. getPlayerName(target) .. " został/a zbanowany/a, powód: " .. reason, 15)
    end
	kickPlayer(target,"Polacz sie od nowa.")
end


addEvent("banMe", true)
addEventHandler("banMe", root, function(reason)
  autobanPlayer(source, reason)
--  outputDebugString(getPlayerName(source).. "bu")
end)

addEventHandler("onPlayerWasted", root, function(_, killer, weapon)
	if killer and weapon==9 then -- zabicie z uzyciem pily
		autobanPlayer(killer, "Zabijanie z użyciem piły spalinowej")
	end
end)