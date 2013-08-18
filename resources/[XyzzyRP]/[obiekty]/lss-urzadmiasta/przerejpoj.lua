addEvent("doFetchVehiclesOwnedByPlayerList", true)
addEventHandler("doFetchVehiclesOwnedByPlayerList", resourceRoot, function()
--	outputDebugString("a")
	local c=getElementData(client,"character")
	if not c or not c.id then return end
--	outputDebugString("ab")
	local pojazdy=exports.DB2:pobierzTabeleWynikow("SELECT id,model FROM lss_vehicles")
	outputDebugString("aa " .. #pojazdy .. getPlayerName(client) .. c.id)
	triggerClientEvent(client, "doPopulateVOBPList", resourceRoot, pojazdy)
end)

local function znajdzGraczaPoCID(cid)
	for i,v in ipairs(getElementsByType("player")) do
		local c=getElementData(v,"character")
		if c and c.id and tonumber(c.id)==tonumber(cid) then
			return v
		end
	end
	return nil
end

local function maKlucze(plr,pojazd)
	local klucz=exports["lss-core"]:eq_getItem(plr, 6, tonumber(pojazd))
	if klucz and klucz.count and klucz.count>=2 then return true end
	return false
end

function string:split(sep)
        local sep, fields = sep or ":", {}
        local pattern = string.format("([^%s]+)", sep)
        self:gsub(pattern, function(c) fields[#fields+1] = c end)
        return fields
end


function przepiszNieaktywny(p1,veh)
	--p1 to playerdata
	--veh to vehid
	local query = "UPDATE lss_vehicles SET owning_player=? WHERE id=?"
	local p1ID = getElementData(p1, "character").id
	exports.DB2:zapytanie(query,p1ID,veh)
	local osobad=exports.DB2:pobierzWyniki("SELECT imie,nazwisko FROM lss_characters WHERE id=? LIMIT 1", p1ID)
	outputChatBox("Urzędnik potwierdza przerejestrowanie pojazdu "..veh.." na osobę: "..osobad.imie.." "..osobad.nazwisko, p1)
	takePlayerMoney(p1, 150)
end

-- triggerServerEvent("przerejestrujPojazd", resourceRoot, pojazd, osoba)
addEvent("przerejestrujPojazd", true)
addEventHandler("przerejestrujPojazd", resourceRoot, function(pojazd,osoba)
	local os1=client
	if osoba then os2=znajdzGraczaPoCID(osoba) end
	if (getPlayerMoney(os1)-150)<0 then outputChatBox("Urzędniczka mówi: niestety nie stać Pana na przepisanie, kosztuje to 150$", os1) return end
	outputDebugString(os2)
	if (not osoba) or (osoba=="0x1d83a") then --przepis na siebie, p1 na siebie
		if maKlucze(os1,pojazd) then
			local aktualny_wlasciciel = exports.DB2:pobierzWyniki("SELECT owning_player FROM lss_vehicles WHERE id=? LIMIT 1", pojazd)
			local aktualny_wlasciciel = tonumber(aktualny_wlasciciel.owning_player)
			
			local wlasciciel_seen = exports.DB2:pobierzWyniki("SELECT lastseen FROM lss_characters WHERE id=? LIMIT 1", aktualny_wlasciciel)
			local wlasciciel_seen = tostring(wlasciciel_seen.lastseen)
			--2013-05-09 19:54:55    trzeba to rozbic ;(
			local wlasciciel_seen = wlasciciel_seen:split("-")
			
			local wlasciciel_rok = tonumber(wlasciciel_seen[1])
			local wlasciciel_miesiac = tonumber(wlasciciel_seen[2])-1
			
			local wlasciciel_dzien = wlasciciel_seen[3]
			local wlasciciel_dzien = wlasciciel_dzien:split(" ")
			local wlasciciel_dzien = tonumber(wlasciciel_dzien[1])
			
			local nowtime = getRealTime()
			local now_rok = nowtime.year
			local now_miesiac = nowtime.month
			local now_dzien = nowtime.monthday
			
			--wlasciciel_rok
			--wlasciciel_miesiac
			--wlasciciel_dzien
			
			--now_rok
			--now_miesiac
			--now_dzien

			if now_rok-wlasciciel_rok >= 1 then przepiszNieaktywny(os1,pojazd) return end --PRZEPISZ POJAZD [[
			
			
			local wlasciciel_days = (wlasciciel_miesiac*30)+wlasciciel_dzien
			local now_days = (now_miesiac*30)+now_dzien
			--mamy teraz zajebiscie podane dni  bez miesiecy
			local roznica = tonumber(now_days-wlasciciel_days)
			if roznica>=30 then przepiszNieaktywny(os1,pojazd) return end --PRZEPISZ POJAZD [[
			outputChatBox("(( Wlasciciela nie ma przy oknie, ale logowal sie w ciagu ostatnich 30 dni ))", os1)
		else
			outputChatBox("Urzędnik mówi: aby przerejestrować pojazd, należy posiadać obydwa klucze do niego.", os1)
		end
	else
		if maKlucze(os1) or maKlucze(os2) then
			local osobad=exports.DB2:pobierzWyniki("SELECT imie,nazwisko FROM lss_characters WHERE id=? LIMIT 1", osoba)
		if not osobad then return end
			--sprawdzimy, czxy jest ownerem heh
			local c = getElementData(client, "character")
			local id = c.id
			local xxx=exports.DB2:pobierzWyniki("SELECT id FROM lss_vehicles WHERE owning_player=? LIMIT 1", id)
			if not xxx then outputChatBox("Urzędniczka mówi: nie jest Pan(i) właścicielem wozu!", client) return end
			exports["lss-admin"]:gameView_add("Przerejestrowano pojazd " .. pojazd .. " na " .. osoba)
			exports.DB2:zapytanie("UPDATE lss_vehicles SET owning_player=? WHERE id=? LIMIT 1", osoba, pojazd)

	--		triggerEvent("broadcastCaptionedEvent", client, "Urzędnik potwierdza przerejestrowanie pojazdu "..pojazd.." na osobę: "..osobad.imie.." "..osobad.nazwisko, 5, 15, true)
			outputChatBox("Urzędnik potwierdza przerejestrowanie pojazdu "..pojazd.." na osobę: "..osobad.imie.." "..osobad.nazwisko, os1)
			outputChatBox("Urzędnik potwierdza przerejestrowanie pojazdu "..pojazd.." na osobę: "..osobad.imie.." "..osobad.nazwisko, os2)
			takePlayerMoney(os1, 150)
		else
			outputChatBox("Urzędnik mówi: aby przerejestrować pojazd, należy posiadać obydwa klucze do niego.", os1)
			outputChatBox("Urzędnik mówi: aby przerejestrować pojazd, należy posiadać obydwa klucze do niego.", os2)
		end
	end
end)