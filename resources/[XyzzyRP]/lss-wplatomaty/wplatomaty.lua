--[[
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

addEvent("onWplatomatDataRequest", true)
addEventHandler("onWplatomatDataRequest", resourceRoot, function(player,faction)
	local c=getElementData(client,"character")
	if not c or not c.id then return end
	local dbid=tonumber(c.id)
	if not dbid then return end
	
	local data = exports.DB2:pobierzTabeleWynikow("SELECT fw.char_id, fw.kwota, fw.tytul, fw.time, c.imie, c.nazwisko FROM lss_faction_wplaty fw JOIN lss_characters c ON c.id=fw.char_id WHERE faction_id=?", tonumber(faction))
	
	--data to tabelka
	triggerClientEvent(client, "onWplatomatDataReceived", resourceRoot, data)
end)