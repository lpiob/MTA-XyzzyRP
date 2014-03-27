--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--


function updatePlayerCoData(cid)

    if (type(cid)=="number" or type(cid)=="string") then
	cid=tonumber(cid)
	for i,v in ipairs(getElementsByType("player")) do
	    local c=getElementData(v,"character")
--	    outputDebugString("przetwarzamy " .. getPlayerName(v))
	    if (c and c.id and tonumber(c.id)==tonumber(cid)) then
--		outputDebugString("aktualizacja danych " .. cid)
		--  return c.co_id, c.co_name, c.co_rank, c.co_rank_name
		local query=string.format("select cc.skin,c.id co_id,c.name co_name,cc.rank co_rank,cr.name co_rank_name from lss_character_co cc JOIN lss_co_ranks cr ON cr.co_id=cc.co_id AND cr.rank_id=cc.rank JOIN lss_co c ON c.id=cc.co_id WHERE cc.character_id=%d LIMIT 1", cid)
		local dane=exports.DB:pobierzWyniki(query)
	
		if (dane) then
		    c.co_id=dane.co_id
		    c.co_name=dane.co_name
		    c.co_rank=dane.co_rank
		    c.co_rank_name=dane.co_rank_name
		    if (dane.skin and type(dane.skin)~="userdata") then
			setElementModel(v, dane.skin)
		    else
			setElementModel(v, c.skin)
		    end
		    outputChatBox("(( Twoja przynależność do organizacji przestępczej została zaktualizowana. ))", v)
		else
		    c.co_id=nil
		    c.co_name=nil
		    c.co_rank=nil
		    c.co_rank_name=nil
		    setElementModel(v, c.skin)
		    outputChatBox("(( Nie jesteś już członkiem organizacji przestępczej. ))", v)
		end
		setElementData(v, "character", c)

		return true
	    end
	end
    end
    return false
end

addEvent("onPlayerRequestCoData", true)
addEventHandler("onPlayerRequestCoData", root, function(cid)
    if (not cid) then return end
    --local query=string.format("select c.id character_id,cf.rank rank_id,c.imie,c.nazwisko,fr.name ranga,cf.lastduty from lss_character_factions cf JOIN lss_faction_ranks fr ON fr.faction_id=cf.faction_id AND fr.rank_id=cf.rank JOIN lss_characters c ON c.id=cf.character_id WHERE cf.faction_id=%d;", fid)
	local query=string.format("select c.id character_id,cc.rank rank_id,c.imie,c.nazwisko,cc.jointime lastduty,cc.skin,cr.name ranga from lss_character_co cc JOIN lss_characters c ON c.id=cc.character_id JOIN lss_co_ranks cr ON cr.co_id=cc.co_id AND cr.rank_id=cc.rank WHERE cc.co_id=%d",cid)

    local dane=exports.DB:pobierzTabeleWynikow(query)
    triggerClientEvent(source, "doFillCoData", resourceRoot, dane)
end)

addEvent("onCoCharacterDetailsRequest", true)
addEventHandler("onCoCharacterDetailsRequest", root, function(coid,cid)
    if (not coid or not cid) then return end
    local query
    -- rangi
    query=string.format("SELECT rank_id,name FROM lss_co_ranks WHERE co_id=%d ORDER BY rank_id ASC;", coid)
    local rangi=exports.DB:pobierzTabeleWynikow(query)
    -- skiny
    query=string.format("SELECT skin from lss_co_skins WHERE co_id=%d ORDER BY skin ASC", coid)
    local skiny=exports.DB:pobierzTabeleWynikow(query);
    -- dane postaci
    query=string.format("SELECT c.id,c.imie,c.nazwisko,cc.rank,cc.skin from lss_character_co cc JOIN lss_characters c ON cc.character_id=c.id WHERE cc.character_id=%d LIMIT 1", cid)
    local postac=exports.DB:pobierzWyniki(query)
    -- todo
    local dane={
	rangi=rangi,
	skiny=skiny,
	postac=postac	
    }
    triggerClientEvent(source, "doFillCoCharacterData", resourceRoot, dane)
end)

addEvent("onCoEdycjaPostaci", true)
addEventHandler("onCoEdycjaPostaci", root, function(cid,ranga,skin)
    if (not cid or not ranga) then return end
--    outputDebugString(" cid " .. cid .. " r " .. ranga .. " skin " .. skin or domyslny)
    skin=skin and tostring(skin) or "NULL"
    local query=string.format("UPDATE lss_character_co SET skin=%s,rank=%d WHERE character_id=%d LIMIT 1", skin, ranga, cid)
    outputDebugString(query)
    exports.DB:zapytanie(query)
    triggerClientEvent(source, "onCoEdycjaComplete", resourceRoot, true)
    
    updatePlayerCoData(cid)
    
end)


addEvent("onCoPrzyjecieRequest", true)
addEventHandler("onCoPrzyjecieRequest", root, function(cid, imie, nazwisko)
    if (not cid or not imie or not nazwisko) then return end
    imie=exports.DB:esc(imie)
    nazwisko=exports.DB:esc(nazwisko)
    local query=string.format("SELECT id FROM lss_characters WHERE imie='%s' AND nazwisko='%s' LIMIT 1", imie, nazwisko)
    local dane=exports.DB:pobierzWyniki(query)
    if (dane and dane.id) then
	-- mamy gracza, sprawdzamy czy nie pracuje on juz w jakiejkolwiek co
	query=string.format("SELECT 1 FROM lss_character_co WHERE character_id=%d", dane.id)
	if (exports.DB:pobierzWyniki(query)) then
	    triggerClientEvent(source, "onCoZatrudnienieReply", resourceRoot, false, "Ta osoba jest już zatrudniona.")
	    return
	end
	-- dopisujemy gracza do frakcji z najniższą rangą
	query=string.format("INSERT INTO lss_character_co SET character_id=%d,co_id=%d,rank=1", dane.id, cid)
	exports.DB:zapytanie(query)
        triggerClientEvent(source, "onCoZatrudnienieReply", resourceRoot, true)
	-- sprawdzamy czy gracz jest online i informujemy go o tym
	updatePlayerCoData(dane.id)
	
    else
        triggerClientEvent(source, "onCoZatrudnienieReply", resourceRoot, false, "Nie odnaleziono podanej osoby.")
    end

end)

addEvent("onCoZwolnienieRequest", true)
addEventHandler("onCoZwolnienieRequest", root, function(fid,cid)
    -- todo weryfikacje
    if (not fid or not cid) then return end
    local query=string.format("DELETE FROM lss_character_co WHERE character_id=%d AND co_id=%d LIMIT 1", cid, fid)
--    outputChatBox(query)
    exports.DB:zapytanie(query)
    triggerClientEvent(source,"onCoZwolnienieComplete",resourceRoot)
    updatePlayerCoData(cid)
end)
