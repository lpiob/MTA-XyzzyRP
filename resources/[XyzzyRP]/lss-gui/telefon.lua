--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



signalTimer = {}

local function phone_sync(who,number)
--[[
local kontakty={
--    { 300001, "Shawn Hanks", true },
--    { 300016, "Dozer Baltaar", true },
--    { 300008, "Tom Rosales", false },
}
]]--
	local kontakty1=exports.DB:pobierzTabeleWynikow(string.format("select number,descr FROM lss_phone_contacts WHERE owner=%d;", number))
	local kontakty2={
--	  { 999, "Pogotowie", false },
--	  { 998, "Straż pożarna", false },
--	  { 911, "Policja", false },
--	  { 606, "Federalne Biuro Śledcze", false },
	  { 911, "Alarmowy", false },
	  { 990, "Pomoc drogowa", false },
	  { 9696, "Taxi", false },
	  { 313, "Departament Turystyki", false },
	  { 9292, "CNN News", false },
	}
	for i,v in ipairs(kontakty1) do
		table.insert(kontakty2, { v.number, v.descr, true })
	end
	

--[[
local wiadomosci={
    [ 300001 ]={
	    { incoming=true, tresc="Testowa wiadomość przychodząca", ts="2012.03.04 12:57" },
	    { incoming=false, tresc="Testowa odpowiedź", ts="2012.03.04 13:57" },
	    },
    [ 300016 ]={
	    { incoming=true, tresc="Testowa wiadomość przychodząca", ts="2012.03.04 12:57" },
	    { incoming=false, tresc="Testowa odpowiedź", ts="2012.03.04 13:57" },
	    },
	    

}
--]]
	local wiadomosci1=exports.DB:pobierzTabeleWynikow(string.format("select sender,receiver,content,ts from lss_phone_sms WHERE (receiver=%d OR sender=%d);", number, number))
	wiadomosci2={}
	local cnt=0
	for i,v in ipairs(wiadomosci1) do
		local grupa=tonumber(v.sender)==number and tonumber(v.receiver) or tonumber(v.sender)
		if (not wiadomosci2[grupa]) then wiadomosci2[grupa]={} end
		table.insert(wiadomosci2[grupa], { incoming=(tonumber(v.receiver)==number), tresc=v.content, ts=ts })
		cnt=cnt+1
	end

	local dane={
		numer=number,
		kontakty=kontakty2,
		wiadomosci=wiadomosci2,
		wiadomosc_count=cnt
	}
	triggerClientEvent(who, "onPhoneSync", resourceRoot, dane)


end

local function taksowkarzeOnline()
	for i,v in ipairs(getElementsByType("player")) do
		local fid=getElementData(v,"faction:id")
		if fid and tonumber(fid)==7 then
			return true
		end
	end
	return false
end

addEvent("onSMSSent", true)
addEventHandler("onSMSSent", resourceRoot, function(from, to, content)
	outputDebugString("SMS " .. from .. "->"..to .. ": " .. content)
	content=exports.DB:esc(content)
	local query=string.format("INSERT INTO lss_phone_sms SET sender=%d,receiver=%d,content='%s'", from, to, content)
	exports.DB:zapytanie(query)
	-- 9696
	if tonumber(to)==9696 and not taksowkarzeOnline() then
		setTimer(function(f,c)
			outputChatBox("** SMS ** Przykro nam, nie ma obecnie żadnych wolnych taksówek.", c)
--			triggerClientEvent(c, "onIncomingSMS", resourceRoot, f, "Przykro nam, nie ma obecnie żadnych wolnych taksówek.", 9696)
		end, 1500, 1, from,client)
		return
	end
	triggerClientEvent(root, "onIncomingSMS", resourceRoot, to, content, from, client)
end)

addEvent("onPhoneCall", true)
addEventHandler("onPhoneCall", getRootElement(), function(player, from, to, budka)
	outputDebugString("TELEFON START " .. from .. "->"..to)
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v, "character") then
			if exports["lss-core"]:eq_getItem(v, 21, tonumber(to)) then
				-- if getElementData(v, "phone:number") == tostring(to) then
					if getElementData(player, "dzwoniDo") or getElementData(player, "zadzwonilDo") or getElementData(player, "odebralOd") then outputChatBox("Połączenie nieudane, Twój telefon nawiązuje już połączenie z innym numerem.", player) return end
					if getElementData(v, "odebralOd") or getElementData(v, "dzwoniDoNiego") or getElementData(v, "zadzwonilDo") then outputChatBox("Numer jest tymczasowo zajęty, proszę zadzwonić później.", player) return end
					setElementData(player, "dzwoniDo", v)
					setElementData(v, "dzwoniDoNiego", player)
					outputChatBox("#E7D9B0Trwa łączenie z numerem #FFFCA8"..to.." #E7D9B0...", player, 1, 1, 1, true)
					triggerClientEvent("onIncomingCall", v, from, budka)
					triggerClientEvent("onIncomingCallSong", getRootElement(), v)
					triggerEvent("broadcastCaptionedEvent", v, "W pobliżu słychać dźwięk telefonu.", 3, 15, true)
					setElementData(player, "dzwoniDoNumeru", to)
					setElementData(v, "dzwoniDoNiegoNumer", from)
					
					signalTimer[player] = setTimer(function(player,v,numer)
						if (not getElementData(v, "odebralOd")) then 
							setElementData(player, "dzwoniDo", false)
							setElementData(v, "dzwoniDoNiego", false) 
							setElementData(player, "dzwoniDoNumeru", false)
							setElementData(v, "dzwoniDoNiegoNumer", false)
							outputChatBox("Brak odpowiedzi od numeru "..numer..", połączenie przerwane", player)
							triggerClientEvent("killPhoneSong", getRootElement(), v)
						end
					end, 30000, 1, player, v, to)
					return
				-- end
			end
		end
	end
	outputChatBox("(( Numer niedostępny ))", player)
end)

addEvent("onPhoneZerwane", true)
addEventHandler("onPhoneZerwane", getRootElement(), function(player, v)
					destroyElement(signalTimer[player])
					if (not getElementData(v, "odebralOd")) then 
						setElementData(player, "dzwoniDo", false)
						setElementData(v, "dzwoniDoNiego", false) 
						setElementData(player, "dzwoniDoNumeru", false)
						setElementData(v, "dzwoniDoNiegoNumer", false)
						outputChatBox("Połączenie się zerwało", player)
						triggerClientEvent("killPhoneSong", getRootElement(), v)
					end
end)

addEvent("onPhoneAccept", true)
addEventHandler("onPhoneAccept", getRootElement(), function(player,budka)
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(player, "dzwoniDoNiego") == v then
			local from = getElementData(player, "dzwoniDoNiegoNumer")
			local to = getElementData(v, "dzwoniDoNumeru")
			if not (from and to) then return end
			setElementData(v, "dzwoniDo", false)
			setElementData(player, "dzwoniDoNiego", false)
			
			setElementData(v, "zadzwonilDo", player)
			setElementData(player, "odebralOd", v)
			
			setPedAnimation(player, "ped", "phone_in", 1000, false, true, false)
			
			setPedAnimation(v, "ped", "phone_in", 1000, false, true, false)
			
			triggerEvent("onIPhone", getRootElement(), player)
			if not budka then
				triggerEvent("onIPhone", getRootElement(), v)
			end
			
			outputChatBox("#E7D9B0Połączyłeś sie z numerem #FFFCA8"..to.." #FF3639[ALT+3 - rozłącz się]", v, 1, 1, 1, true)
			outputChatBox("#E7D9B0Połączyłeś sie z numerem #FFFCA8"..from.." #FF3639[ALT+3 - rozłącz się]", player, 1, 1, 1, true)
			triggerClientEvent("killPhoneSong", getRootElement(), player)
			killTimer(signalTimer[v])
			return
		end
	end
	
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
	
	for k,v in ipairs(getElementsByType("player")) do
		if (getElementData(source, "dzwoniDo") == v) or (getElementData(source, "dzwoniDoNiego") == v) then
			setElementData(v, "dzwoniDoNumeru", false)
			setElementData(v, "dzwoniDo", false)
			
			setElementData(v, "dzwoniDoNiego", false)
			setElementData(v, "dzwoniDoNiegoNumer", false)
			triggerClientEvent("killPhoneSong", getRootElement(), v)
			outputChatBox("Rozmówca rozłączył się", v)
			if signalTimer[source]  and (isTimer(signalTimer[source])) then killTimer(signalTimer[source]) end
			if signalTimer[v] and (isTimer(signalTimer[v])) then killTimer(signalTimer[v]) end
		end
	end
	
	for k,v in ipairs(getElementsByType("player")) do
		if (getElementData(source, "zadzwonilDo") == v) or (getElementData(source, "odebralOd") == v) then
			outputChatBox("Rozmówca rozłączył się", v)
			setElementData(v, "odebralOd", false)
			setElementData(v, "zadzwonilDo", false)
			triggerClientEvent("killPhoneSong", getRootElement(), v)
			setPedAnimation(v, "ped", "phone_out", 1000, false, true, false)
			triggerEvent("iPhoneOff", getRootElement(), v)
			if signalTimer[source] and (isTimer(signalTimer[source])) then killTimer(signalTimer[source]) end
			if signalTimer[v] and (isTimer(signalTimer[v])) then killTimer(signalTimer[v]) end
		end
	end
end)

addEvent("onPhoneDecline", true)
addEventHandler("onPhoneDecline", getRootElement(), function(player,budka)
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(player, "dzwoniDoNiego") == v then
			setElementData(v, "dzwoniDo", false)
			outputChatBox("Numer odrzucił twoje połączenie", v)
			setElementData(v, "dzwoniDoNumeru", false)
			-- setPedAnimation(v, "ped", "phone_out", 1000, false, true, false)
			if signalTimer[player] and (isTimer(signalTimer[player])) then killTimer(signalTimer[player]) end
			if signalTimer[v] and (isTimer(signalTimer[v])) then killTimer(signalTimer[v]) end
		end
	end
	setElementData(player, "dzwoniDoNiego", false)
	triggerClientEvent("killPhoneSong", getRootElement(), player)
	setElementData(player, "dzwoniDoNumeru", false)
end)


addEvent("onPhoneEnd", true)
addEventHandler("onPhoneEnd", getRootElement(), function(player,budka)

	local source = player
	for k,v in ipairs(getElementsByType("player")) do
		if (getElementData(source, "zadzwonilDo") == v) or (getElementData(source, "odebralOd") == v) then
			outputChatBox("Rozmówca rozłączył się", v)
			outputChatBox("Rozłączyłeś się", source)
			setElementData(v, "odebralOd", false)
			setElementData(v, "zadzwonilDo", false)
			if signalTimer[source] and (isTimer(signalTimer[v])) then killTimer(signalTimer[source]) end
			if signalTimer[v] and (isTimer(signalTimer[v])) then killTimer(signalTimer[v]) end
			setElementData(source, "odebralOd", false)
			setElementData(source, "zadzwonilDo", false)
			triggerClientEvent("killPhoneSong", getRootElement(), v)
			triggerClientEvent("killPhoneSong", getRootElement(), source)
			setPedAnimation(v, "ped", "phone_out", 1000, false, true, false)
			setPedAnimation(player, "ped", "phone_out", 1000, false, true, false)
			setTimer(function(player,v)
				triggerEvent("iPhoneOff", getRootElement(), v)
				triggerEvent("iPhoneOff", getRootElement(), player)
			end, 1000, 1, player, v)
			return
		end
	end
end)



addEvent("setPhoneNumber", true)
addEventHandler("setPhoneNumber", getRootElement(), function(player, number)
	setElementData(player, "phone:number", tostring(number))
end)

addEvent("onPhoneRequestSync", true)
addEventHandler("onPhoneRequestSync", root, function(owner,number)
	phone_sync(owner,number)
end)

addEvent("onPhoneContactAdd", true)
addEventHandler("onPhoneContactAdd", root, function(owner,number,descr)
--utputDebugString("O " .. owner .. " n " .. number .. " d " .. descr)
	if (not owner or not number or not descr) then return end
	descr=exports.DB:esc(descr)
	local query=string.format("INSERT INTO lss_phone_contacts SET owner=%d, number=%d, descr='%s' ON DUPLICATE KEY UPDATE descr='%s'",
		owner, number, descr, descr)
	exports.DB:zapytanie(query)

	phone_sync(source,owner)
end)

addEvent("onPhoneContactRemove", true)
addEventHandler("onPhoneContactRemove", root, function(owner,number)
	if (not owner or not number) then return end
	local query=string.format("DELETE FROM lss_phone_contacts WHERE owner=%d AND number=%d LIMIT 1",	owner, number)
	exports.DB:zapytanie(query)

	phone_sync(source,owner)
end)

addEventHandler("onResourceStart", resourceRoot, function()
	for k,v in ipairs(getElementsByType("player")) do
		setElementData(v, "zadzwonilDo", false)
		setElementData(v, "odebralOd", false)
		setElementData(v, "dzwoniDo", false)
		setElementData(v, "dzwoniDoNiego", false)
	end
end)