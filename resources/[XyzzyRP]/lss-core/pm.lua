--[[

Obsługa pmów, z wychwytaniem framgentów nicków itd. Używać wraz z id_graczy.lua
Oryginalnie napisany dla serwera BestPlay.

@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2010-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


function privateMessage(plr,cmd, cel, ...)
	if (isPlayerMuted(plr)) then
		outputChatBox("Jesteś wyciszony/a i nie możesz pisać prywatnych wiadomości.", plr, 255,0,0)
		return
	end
    if not getElementData(plr,"character") then
      outputChatBox("Najpierw wejdź do gry.", plr)
      return
    end
	if (getElementData(plr,"kary:blokada_pm")) then
	    outputChatBox("Posiadasz nałożoną blokadę prywatnych wiadomości. Blokada wygasa: ".. getElementData(plr, "kary:blokada_pm"),plr, 255,0,0)
	    return
	end

	if (#arg<=0 or (not cel)) then
		outputChatBox("Uzyj: /pm <nick/ID> <tresc>", plr)
		return
	end
	
	local target=findPlayer(plr,cel)

	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end

	if (isPlayerMuted(target)) then
		outputChatBox(getPlayerName(target).." jest wyciszony - nie odpisze Ci.", plr)
	end
	local pmoff=getElementData(target,"pmoff")
	if (pmoff) then
	  outputChatBox(getPlayerName(target).." nie akceptuje wiadomości PM.", plr)
	  if (type(pmoff)=="string") then
		outputChatBox("Powód: " .. pmoff, plr)
	  end
	  return
	end

    if getElementData(plr,"pmoff") then
      outputChatBox("Posiadasz wyłączone wiadomości PM. Ta osoba nie będzie mogła Ci odpisać.", plr)
    end

	local tresc = table.concat( arg, " " )
	if ninjaban(tresc) then
		outputChatBox(">> " .. getPlayerName(target) .. "(" .. getPlayerID(target) .. "): " .. tresc, plr, 245, 219, 0)
		exports["lss-admin"]:gameView_add("PM NINJABAN " .. getPlayerName(plr).."/"..getPlayerID(plr).." >> "..getPlayerName(target).."/"..getPlayerID(target)..": " .. tresc)
		return
	end
	outputChatBox("<< " .. getPlayerName(plr) .. "(" .. getPlayerID(plr) .. "): " .. tresc, target, 225, 199, 0)

	outputChatBox(">> " .. getPlayerName(target) .. "(" .. getPlayerID(target) .. "): " .. tresc, plr, 245, 219, 0)
	local afk=getElementData(target,"afk") or 0
	if afk>1 then
		outputChatBox("(( Gracz do którego piszesz jest obecnie AFK ))", plr, 245,219,0)
	end
--	log("pm", getPlayerName(plr) .. " >> " .. getPlayerName(target) .. ": " .. tresc)
	playSoundFrontEnd(target,12)
--	outputDebugString(getPlayerName(plr).." >> "..getPlayerName(target)..": " .. tresc)
	exports["lss-admin"]:gameView_add("PM " .. getPlayerName(plr).."/"..getPlayerID(plr).." >> "..getPlayerName(target).."/"..getPlayerID(target)..": " .. tresc)
end

addCommandHandler("pm", privateMessage, false, false)
--addCommandHandler("msg", privateMessage)
addCommandHandler("pw", privateMessage, false, false)
--addCommandHandler("msg", privateMessage)
addCommandHandler("w", privateMessage, false, false)



addCommandHandler("pmon", function(plr,cmd)
  removeElementData(plr,"pmoff")
  outputChatBox("(( Akceptujesz wszystkie wiadomości PM. ))", plr)
  return
end)

addCommandHandler("pmoff", function(plr,cmd,...)
  local powod=table.concat(arg," ")
  if (not powod or string.len(powod)<2) then powod=true end
  setElementData(plr, "pmoff", powod)
  outputChatBox("(( Nie akceptujesz wiadomości PM. ))", plr)
  return
end)