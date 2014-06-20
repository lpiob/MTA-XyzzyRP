--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--

addEvent("onPlayerRequestFactionData", true)
addEventHandler("onPlayerRequestFactionData", root, function(fid)
    if (not fid) then return end
    local query=string.format("select c.id character_id,cf.skin,cf.rank rank_id,c.imie,c.nazwisko,fr.name ranga,cf.lastduty,cf.door from lss_character_factions cf JOIN lss_faction_ranks fr ON fr.faction_id=cf.faction_id AND fr.rank_id=cf.rank JOIN lss_characters c ON c.id=cf.character_id WHERE cf.faction_id=%d;", fid)
    local dane=exports.DB:pobierzTabeleWynikow(query)
    triggerClientEvent(source, "doFillFactionData", resourceRoot, dane)
end)



addEvent("onZatrudnienieRequest", true)
addEventHandler("onZatrudnienieRequest", root, function(fid, imie, nazwisko)
    if (not fid or not imie or not nazwisko) then return end
    imie=exports.DB:esc(imie)
    nazwisko=exports.DB:esc(nazwisko)
    local query=string.format("SELECT id FROM lss_characters WHERE imie='%s' AND nazwisko='%s' LIMIT 1", imie, nazwisko)
    local dane=exports.DB:pobierzWyniki(query)
    if (dane and dane.id) then
	-- mamy gracza, sprawdzamy czy nie pracuje on juz w tej frakcji
	query=string.format("SELECT 1 FROM lss_character_factions WHERE faction_id=%d AND character_id=%d", fid, dane.id)
	if (exports.DB:pobierzWyniki(query)) then
	    triggerClientEvent(source, "onZatrudnienieReply", resourceRoot, false, "Ta osoba jest już zatrudniona.")
	    return
	end
	-- dopisujemy gracza do frakcji z najniższą rangą
	query=string.format("INSERT INTO lss_character_factions SET character_id=%d,faction_id=%d,rank=1", dane.id, fid)
	exports.DB:zapytanie(query)
        triggerClientEvent(source, "onZatrudnienieReply", resourceRoot, true)
    else
        triggerClientEvent(source, "onZatrudnienieReply", resourceRoot, false, "Nie odnaleziono podanej osoby.")
    end

end)

addEvent("onZwolnienieRequest", true)
addEventHandler("onZwolnienieRequest", root, function(fid,cid)
    -- todo weryfikacje
    if (not fid or not cid) then return end
    local query=string.format("DELETE FROM lss_character_factions WHERE character_id=%d AND faction_id=%d LIMIT 1", cid, fid)
--    outputChatBox(query)
    exports.DB:zapytanie(query)
    triggerClientEvent(source,"onZwolnienieComplete",resourceRoot)
end)




addEvent("onFactionCharacterDetailsRequest", true)
addEventHandler("onFactionCharacterDetailsRequest", root, function(coid,cid)
--    outputDebugString("ofcdr")
    if (not coid or not cid) then return end
--    outputDebugString("ofcdr2")
    local query
    -- rangi
    query=string.format("SELECT rank_id,name FROM lss_faction_ranks WHERE faction_id=%d ORDER BY rank_id ASC;", coid)
    local rangi=exports.DB:pobierzTabeleWynikow(query)
    -- skiny
    query=string.format("SELECT skin from lss_faction_skins WHERE faction_id=%d ORDER BY skin ASC", coid)
    local skiny=exports.DB:pobierzTabeleWynikow(query);
    -- dane postaci
    query=string.format("SELECT c.id,c.imie,c.nazwisko,cf.rank,cf.skin from lss_character_factions cf JOIN lss_characters c ON cf.character_id=c.id WHERE cf.character_id=%d AND cf.faction_id=%d LIMIT 1", cid, coid)
    local postac=exports.DB:pobierzWyniki(query)
    -- todo
    local dane={
	rangi=rangi,
	skiny=skiny,
	postac=postac	
    }
    triggerClientEvent(source, "doFillFactionCharacterData", resourceRoot, dane)
end)

addEvent("onFactionEdycjaPostaci", true)
addEventHandler("onFactionEdycjaPostaci", root, function(cid,ranga,skin,fid)
    if (not cid or not ranga) then return end
--    outputDebugString(" cid " .. cid .. " r " .. ranga .. " skin " .. skin or domyslny)
    skin=skin and tostring(skin) or "NULL"
    local query=string.format("UPDATE lss_character_factions SET skin=%s,rank=%d WHERE character_id=%d AND faction_id=%d LIMIT 1", skin, ranga, cid, fid)
    outputDebugString(query)
    exports.DB:zapytanie(query)
    triggerClientEvent(source, "onFactionEdycjaComplete", resourceRoot, true)
    
--    updatePlayerFactionData(cid)
    
end)
