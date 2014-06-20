--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



addEvent("onPlayerRequestIBContents", true)
addEventHandler("onPlayerRequestIBContents", root, function(id)
	dane=exports.DB:pobierzWyniki(string.format("SELECT nazwa,tresc,restrict_faction FROM lss_infoboards WHERE id=%d LIMIT 1", id))

	triggerClientEvent(source, "onIBContentsRcvd", resourceRoot, dane)
end)

addEvent("onPlayerUpdateIBContents", true)
addEventHandler("onPlayerUpdateIBContents", root, function(id, tresc)
	if not id or not tresc then return end
	tresc=exports.DB:esc(tresc)
	local query=string.format("UPDATE lss_infoboards SET tresc='%s' WHERE id=%d LIMIT 1", tresc, id)
	exports.DB:zapytanie(query)
end)