--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- triggerServerEvent("requestPBack", resourceRoot)
addEvent("requestPBack", true)
addEventHandler("requestPBack", resourceRoot, function()
  local code=md5(getPlayerSerial(client).."TTT")
  exports.DB2:zapytanie("INSERT INTO lss_pback SET serial=?,code=?", getPlayerSerial(client), code)
  outputConsole(" ", client)
  outputConsole(" ", client)
  outputConsole(" ", client)
  outputConsole("Aby przywrócić swoje konto odwiedź stronę", client)
  outputConsole("http://lss-rp.pl/przywroc/"..code, client)
  outputConsole("Adres został już skopiowany do Twojego schowka", client)
  outputConsole(" ", client)
  outputConsole(" ", client)
  triggerClientEvent(client, "pback2", resourceRoot, "http://lss-rp.pl/przywroc/"..code)
end)

addEvent("requestPBack2", true)
addEventHandler("requestPBack2", resourceRoot, function()
  kickPlayer(client, "Wciśnij ~")
end)
