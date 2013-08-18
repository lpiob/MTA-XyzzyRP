--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- triggerServerEvent("createNote", resourceRoot, localPlayer, text)"
addEvent("createNote", true)
addEventHandler("createNote", resourceRoot, function(plr, tresc)
	tresc=exports.DB:esc(tresc)
	-- tworzymy notatke
	local character=getElementData(plr, "character")
	if not character or not character.id then return end
	local query=string.format("INSERT INTO lss_notes SET character_id=%d,contents='%s'", character.id, tresc)
	exports.DB:zapytanie(query)
	local subtype=exports.DB:insertID()
	if not subtype or not tonumber(subtype) then
		return
	end
	exports["lss-core"]:eq_giveItem(plr, 47, 1, tonumber(subtype))
end)

addEvent("readNote", true)
addEventHandler("readNote", resourceRoot, function(plr, nid)
	local rr=exports.DB:pobierzWyniki(string.format("SELECT contents FROM lss_notes WHERE id=%d LIMIT 1", nid))
	local tresc
	if not rr then
		tresc="(( Notatka jest nieczytelna ))"
	else
		tresc=rr.contents
	end
	triggerClientEvent(plr, "fillNote", resourceRoot, tresc)
end)

