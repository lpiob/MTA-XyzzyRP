--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



--triggerServerEvent("requestDLDetails", localPlayer, EQ[btnidx].subtype)
addEvent("requestDLDetails", true)
addEventHandler("requestDLDetails", root, function (id)
  if (not id) then
	triggerEvent("broadcastCaptionedEvent", source, "Prawo jazdy jest kompletnie zniszczone, nie da się z niego nic odczytać.", 5, 5, true)
	return
  end
  local user=exports.DB:pobierzWyniki(string.format("SELECT pjA,pjB,pjL,imie,nazwisko FROM lss_characters where id=%d LIMIT 1", id))
  if (not user) then
	triggerEvent("broadcastCaptionedEvent", source, "Prawo jazdy jest kompletnie zniszczone, nie da się z niego nic odczytać.", 5, 5, true)
	return
  end
  local komunikat="Prawo jazdy na nazwisko: " .. user.imie .. " " .. user.nazwisko .. ", kat."
  if (user.pjA and tonumber(user.pjA)>0) then
	komunikat=komunikat .. " A "
  end
  if (user.pjB and tonumber(user.pjB)>0) then
	komunikat=komunikat .. " B "
  end
  if (user.pjL and tonumber(user.pjL)>0) then
	komunikat=komunikat .. " L "
  end


  triggerEvent("broadcastCaptionedEvent", source, komunikat, 5, 5, true)


end)

addEvent("requestPCDetails", true)
addEventHandler("requestPCDetails", root, function (id)
  if (not id) then
	triggerEvent("broadcastCaptionedEvent", source, "Dokument jest kompletnie zniszczone, nie da się z niego nic odczytać.", 5, 5, true)
	return
  end
  local user=exports.DB:pobierzWyniki(string.format("SELECT imie,nazwisko,data_urodzenia,rasa FROM lss_characters where id=%d LIMIT 1", id))
  if (not user) then
	triggerEvent("broadcastCaptionedEvent", source, "Dowód osobisty jest kompletnie zniszczone, nie da się z niego nic odczytać.", 5, 5, true)
	return
  end
  if (type(user.data_urodzenia)=="userdata") then user.data_urodzenia="n/n" end
  if (type(user.rasa)=="userdata") then user.rasa="n/n" end
  local komunikat="Dane z dowodu: " .. user.imie .. " " .. user.nazwisko .. ", data urodzenia " .. user.data_urodzenia .. ", rasa: " .. user.rasa


  triggerEvent("broadcastCaptionedEvent", source, komunikat, 5, 5, true)


end)