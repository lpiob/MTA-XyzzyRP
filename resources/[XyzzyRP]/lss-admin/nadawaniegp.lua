--[[
lss-admin: nadawanie GP

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub

]]--


local MAXGP=20
local GP_PER_S_DAY=20 -- ile supporter moze dac maksymalnie GP jednego dnia
local GP_PER_S_WEEK=70 -- ile supporter moze dac maksymalnie GP w ciagu tygodnia

local function findPlayerByCID(cid)
	for i,v in ipairs(getElementsByType("player")) do
		local c=getElementData(v,"character")
		if c and c.id and tonumber(c.id)==cid then
			return v
		end
	end
	return nil
end

-- triggerServerEvent("doNadajGP", resourceRoot, id_postaci, powod, setScrollAmount)
addEvent("doNadajGP", true)
addEventHandler("doNadajGP", resourceRoot, function(id_postaci,powod,ilosc)

	local alogin=getElementData(client,"auth:login")
	local auid=getElementData(client,"auth:uid")

	if not alogin or not auid then return end -- nie powinno sie wydarzyc

	if not ilosc or not tonumber(ilosc) or ilosc<1 then
		return
	end
	if ilosc>MAXGP then
		outputChatBox("Maksymalna ilość GP które możesz nadać naraz to " .. MAXGP, client, 255,0,0)
		return
	end

	local playerdata=exports.DB2:pobierzWyniki("SELECT login,id FROM lss_users WHERE id=(SELECT userid FROM lss_characters WHERE id=? LIMIT 1) LIMIT 1", id_postaci)
	if not playerdata then return end

	do -- sprawdzenie czy gracz nie otrzymal gp w ciagu ostatniej pol godziny
		local lmt=exports.DB2:pobierzWyniki("select 1 from lss_achievements_history WHERE user_id=? AND timediff(NOW(),ts)<'00:30:00' LIMIT 1",playerdata.id)
		if lmt then
			outputChatBox("Ten gracz otrzymał już punkty GP w ciągu ostatniej pół godziny.", client)
			return
		end
	end
    
    if (auid or 0)~=2 then
--	do -- sprawdzenie czy supporter nie przekroczyl limitu dobowego punktow GP
		local lmt=exports.DB2:pobierzWyniki("select IFNULL(sum(amount),0) suma from lss_achievements_history where given_by=? AND timediff(now(),ts)<'24:00:00';", auid)
		if lmt and lmt.suma then
			if tonumber(lmt.suma)>=GP_PER_S_DAY then
				outputChatBox("Wydałeś/as już maksymalną ilość punktów GP na dobę.", client)
				return
			elseif tonumber(lmt.suma)+ilosc>GP_PER_S_DAY then
				outputChatBox("Nie masz dostępnych aż tylu punktów GP, obecnie możesz dać maksymalnie "..(GP_PER_S_DAY-tonumber(lmt.suma)), client)
				return
			end
		end
	end
	if tonumber(playerdata.id)==tonumber(auid) and auid~=2 then
		outputChatBox("Nie mozesz dac punktów sobie.", client)
		return
	end
	
	local fplayer=findPlayerByCID(tonumber(id_postaci))
	if fplayer then
		local gp=tonumber(getElementData(fplayer,"GP"))
		if not gp then return false end
		gp=gp+tonumber(ilosc)
		setElementData(fplayer,"GP", gp)
		triggerClientEvent(fplayer, "showAchievement", root, 5, "Zostałeś/aś nagrodzony/a dodatkowymi punktami GP!", powod.. "  +"..ilosc.."GP")
	end

	exports.DB2:zapytanie("INSERT INTO lss_achievements_history SET ts=NOW(),achname=?,user_id=(SELECT userid FROM lss_characters WHERE id=?),character_id=?,amount=?,given_by=?,notes=?",
		"GP",id_postaci,id_postaci,ilosc,auid,powod)
	local log=string.format("NadanieGP %s/%d nadał %dGP dla gracza %s/%s(%d/%d), powód %s", alogin,auid, ilosc, fplayer and getPlayerName(fplayer) or "-",playerdata.login,id_postaci, playerdata.id, powod)
	gameView_add(log)
	triggerClientEvent(client,"doHideNadajGPWindows", resourceRoot)
	outputChatBox("Punkty GP zostały nadane.", client)
end)

