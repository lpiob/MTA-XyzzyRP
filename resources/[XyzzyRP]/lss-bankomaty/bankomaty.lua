--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@todo przerobic z zasobu DB na DB2
]]--


local function getPlayerID(plr)
	local c=getElementData(client,"character")
	if not c or not c.id then return nil end
	return tonumber(c.id)
end

addEvent("onPlayerRequestATMInfo", true)
addEventHandler("onPlayerRequestATMInfo", resourceRoot, function()
	local c=getElementData(client,"character")
	if not c or not c.id then
		triggerClientEvent(client,"doFillATMInfo", resourceRoot, false)
		return
	end
	local dbid=tonumber(c.id)
	if not dbid then
		triggerClientEvent(client,"doFillATMInfo", resourceRoot, false)
		return
	end
	local sr=exports.DB:pobierzWyniki("SELECT bank_money FROM lss_characters WHERE id="..(tonumber(dbid) or 0).." LIMIT 1")
	if not sr or not sr.bank_money then
		triggerClientEvent(client,"doFillATMInfo", resourceRoot, false)
		return
	end
	triggerClientEvent(client,"doFillATMInfo", resourceRoot, true, tonumber(sr.bank_money))
end)

addEvent("doATMOperation", true)
addEventHandler("doATMOperation", resourceRoot, function(kwota)
	-- kwota dodatnia - wplata
	-- kwota ujemna - wyplata
	if kwota>0 and kwota>getPlayerMoney(client) then return end -- komunikat bledu po stronie klienta
	local dbid=getPlayerID(client)
	if not dbid then return end -- nie powinno sie zdarzyc
	if kwota>0 then
		if getPlayerMoney(client)<kwota then return end
		takePlayerMoney(client, kwota)
		exports.DB:zapytanie("UPDATE lss_characters SET bank_money=bank_money+"..(tonumber(kwota) or 0).." WHERE id="..tonumber(dbid).." LIMIT 1")
		exports["lss-admin"]:gameView_add("BANK wplata "..getPlayerName(client).."/"..dbid.." kwota "..kwota.."$")
		triggerEvent("broadcastCaptionedEvent", client, getPlayerName(client).." wpłaca pieniądze do bankomatu", 3, 20, true)
	elseif kwota<0 then
		local sr=exports.DB:pobierzWyniki("SELECT `bank_money` FROM `lss_characters` WHERE id="..tonumber(dbid).." LIMIT 1")
		if not sr or not sr.bank_money then return end -- nie opwinno sie wydarzyc
		sr.bank_money=tonumber(sr.bank_money)
		if (sr.bank_money<math.abs(kwota)) then
			outputChatBox("Nie masz tyle środków na koncie!", client, 255,0,0)
--			triggerClientEvent(client,"onAnnouncement3", root, "Nie masz tyle środków na koncie!", 5)
			return
		end
		triggerEvent("broadcastCaptionedEvent", client, getPlayerName(client).." wypłaca pieniądze z bankomatu", 3, 20, true)
		exports.DB:zapytanie("UPDATE lss_characters SET bank_money=bank_money-"..math.abs(tonumber(kwota)).." WHERE id="..tonumber(dbid).." LIMIT 1")
		exports["lss-admin"]:gameView_add("BANK wyplata "..getPlayerName(client).."/"..dbid.." kwota "..kwota.."$")
		givePlayerMoney(client, math.abs(kwota))
	end
	

end)

addEvent("doATMOperationFraction", true)
addEventHandler("doATMOperationFraction", resourceRoot, function(kwota,frakcja,tytul)
	local dbid=getPlayerID(client)
	if not dbid then return end -- nie powinno sie zdarzyc
	
	local sr=exports.DB:pobierzWyniki("SELECT `bank_money` FROM `lss_characters` WHERE id="..tonumber(dbid).." LIMIT 1")
	if not sr or not sr.bank_money then return end -- nie opwinno sie wydarzyc
	sr.bank_money=tonumber(sr.bank_money)
	if (sr.bank_money<math.abs(kwota)) then
		outputChatBox("Nie masz tyle środków na koncie!", client, 255,0,0)
		return
	end
	
	exports.DB:zapytanie("UPDATE lss_characters SET bank_money=bank_money-"..(tonumber(kwota) or 0).." WHERE id="..tonumber(dbid).." LIMIT 1") --zabieramy kase z konta gracza
	exports.DB2:zapytanie(string.format("INSERT INTO `lss_faction_wplaty` (`char_id`, `faction_id`, `kwota`, `tytul`) VALUES ('%f', '%f', '%f', '%s')", tonumber(dbid), tonumber(frakcja), tonumber(kwota), tytul))
	
	local sr=exports.DB:pobierzWyniki("SELECT `id` FROM `lss_containers` WHERE owning_faction="..tonumber(frakcja).." LIMIT 1")
--	exports["lss-pojemniki"]:insertItemToContainer(sr.id, -1, tonumber(kwota*0.75), 0, "Gotówka")  --75% dla firmy
	
	exports["lss-pojemniki"]:insertItemToContainer(1533, -1, tonumber(kwota*0.75), 0, "Gotówka")  --25% dla urzedu
	
	exports["lss-admin"]:gameView_add("BANK-FRAKCJA wplata "..getPlayerName(client).."/"..dbid.." kwota "..kwota.."$ NA KONTO "..frakcja.." TYTULEM "..tytul)
	triggerEvent("broadcastCaptionedEvent", client, getPlayerName(client).." przelewa środki na konto frakcyjne", 3, 20, true)
	

end)