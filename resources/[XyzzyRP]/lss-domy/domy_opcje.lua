--[[
Domy do wynajecia

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


local function getPlayerDBID(plr)
	local c=getElementData(plr,"character")
	if not c then return nil end
	return tonumber(c.id)
end

-- triggerServerEvent("onHousePaymentRequest", resourceRoot, a_dom.id, ilosc_dni)
addEvent("onHousePaymentRequest", true)
addEventHandler("onHousePaymentRequest", getRootElement(), function(domid,ilosc_dni)
	outputDebugString(getPlayerName(client))
	
	local dbid=getPlayerDBID(client)
	if not dbid then return end
	if ilosc_dni<=0 then return end
	if not domy[domid] then return end
	if domy[domid].ownerid and domy[domid].ownerid~=dbid then return end
	local gotowka=getPlayerMoney(client)
	local koszt=((ilosc_dni*domy[domid].koszt)/100)*2
	if koszt>gotowka then outputChatBox("(( Nie stać Cię na zakup domu ))", client, 255,0,0) return end

	-- triggerClientEvent(client, "doHideHouseWindows", resourceRoot)
	if domy[domid].paidTo_dni and tonumber(domy[domid].paidTo_dni) and tonumber(domy[domid].paidTo_dni)>=14 then
		outputChatBox("(( Dom można opłacić na maksymalnie 14 dni. ))", client, 255,0,0)
		return
	end
	-- sprawdzamy ile posiada
	local rp=exports.DB2:pobierzWyniki("select count(*) ilosc from lss_domy WHERE ownerid=? AND paidTo>=NOW() AND active=1 AND id!=?", dbid, domid)
	if rp and rp.ilosc and rp.ilosc>=2 then
		outputChatBox("(( Nie możesz posiadać więcej niż dwa domy. ))", client, 255,0,0)
		return
	end

	local r=exports.DB2:zapytanie("UPDATE lss_domy SET ownerid=?,paidTo=IF(paidTo>NOW(),paidTo,NOW())+INTERVAL ? DAY WHERE id=? AND (ownerid IS NULL or ownerid=?) LIMIT 1", 
				dbid, ilosc_dni, domid, dbid)
	if r and r>0 then
		triggerEvent("broadcastCaptionedEvent", client, getPlayerName(client).." podpisuje dokumenty dotyczące nieruchomości.", 6, 10, true)
		takePlayerMoney(client, koszt)
		exports["lss-admin"]:gameView_add(string.format("Gracz %s (%d) oplaca dom %d na %d dni.", getPlayerName(client), dbid, domid, ilosc_dni))
		domReload(domid)
		exports["lss-achievements"]:checkAchievementForPlayer(client, "dom")
--		exports["bp-core"]:givePlayerScore(client, -koszt)
	end

end)

-- triggerServerEvent("onHouseChangeOptions", resourceRoot, a_dom.id, "zamkniety", true)
addEvent("onHouseChangeOptions", true)
addEventHandler("onHouseChangeOptions", resourceRoot, function(domid,opcja,stan)
	if not domid or not domy[domid] then return end
	if opcja=="zamkniety" then
		exports.DB2:zapytanie("UPDATE lss_domy SET zamkniety=? WHERE id=? LIMIT 1", stan and 1 or 0, domid)
		triggerClientEvent(client, "doHideHouseWindows", resourceRoot)
		domReload(domid)
	end
end)


