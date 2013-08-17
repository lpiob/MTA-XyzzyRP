--[[
lss-admin: obsługa raportów

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


function cmd_raport(plr, cmd, id, ...)
  if (not id) then
	outputChatBox("Użyj: /raport <id/nick> <powod>", plr)
	return
  end
--  local target=getElementByID("p"..id)
  local target=exports["lss-core"]:findPlayer(plr,id)
  if (not target) then
	outputChatBox("Nie odnaleziono gracza o podanym ID.", plr)
	return
  end
  local opis=table.concat(arg, " ")
  opis = getPlayerName(target) .. "/"..getElementData(target,"id").. " - " .. opis
  
  opis = opis .. "-- "..getPlayerName(plr).."/"..getElementData(plr,"id")
  
  
  reportView_add(opis,getElementData(target,"id"))
  outputChatBox("Zgłoszenie zostało wysłane." , plr)
end

addCommandHandler("raport", cmd_raport, false,false)
addCommandHandler("report", cmd_raport, false,false)

function cmd_cl(plr,cmd,id,...)
  if (not id) then
	outputChatBox("Użyj: /cl <id/nick> <powod>", plr)
	return
  end


  local powod=table.concat(arg, " ")
  if (string.len(powod)<2) then
	outputChatBox("Użyj: /cl <id/nick> <powod>", plr)
	return
  end

  local target=exports["lss-core"]:findPlayer(plr,id)
  local opis="?"
  if (target) then
	id=getElementData(target,"id")
	opis=getPlayerName(target)
  end

  reportView_remove(tonumber(id))
  local supportLogin=getElementData(plr, "auth:login")
  msgToSupport(supportLogin .. " usunął/ęła raport na " .. opis .. "/".. id .. ": " .. powod)
end
addCommandHandler("cl", cmd_cl, true, false)

