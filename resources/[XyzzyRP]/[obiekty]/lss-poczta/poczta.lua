-- Compatibility: Lua-5.1
function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

local function splitCharName(adres)
    local seppos=string.find(adres," ")
    
    if (not seppos) then return nil end
    return string.sub(adres, 1, seppos-1), string.sub(adres, seppos+1)
    
end
local function getDestination(adres)
    -- mozliwe adresy
    -- LS 7
    -- LS7
    -- Shawn Hanks
    -- adresy specjalne - frakcje - adres to -1*id frakcji
    -- UM = -1
    if (string.len(adres)<2) then return false end
    adres=string.upper(adres)
    if (string.sub(adres,1,2)=="LS") then
	-- LS7, LS 7
	local dom=tonumber(string.sub(adres,3))
	if (tonumber(dom)>0) then
	    local query=string.format("SELECT ownerid FROM lss_domy WHERE id=%d AND paidTo>NOW() LIMIT 1", dom)
	    local wynik=exports.DB:pobierzWyniki(query)
	    if (wynik and wynik.ownerid) then return tonumber(wynik.ownerid) else return false end
	else
	    return false
	end
    elseif (string.len(adres)==2) then
	local query=string.format("SELECT id FROM lss_faction WHERE skrot='%s' LIMIT 1", exports.DB:esc(adres))
	local wynik=exports.DB:pobierzWyniki(query)
	if (wynik and wynik.id) then return -tonumber(wynik.id) else return false end
    else
	-- szukamy takiego imienia i nazwiska
	local imie,nazwisko=splitCharName(adres)
	if (not imie or not nazwisko) then return false end
	local query=string.format("SELECT id FROM lss_characters WHERE imie='%s' AND nazwisko='%s' LIMIT 1", exports.DB:esc(imie), exports.DB:esc(nazwisko))
	local wynik=exports.DB:pobierzWyniki(query)
	if (wynik and wynik.id) then return tonumber(wynik.id) else return false end
    end
    return true
end

local function getDeliveryAddress(mail)
    outputDebugString(tostring(mail))
    mail=math.abs(tonumber(mail))
    local query=string.format("select odbiorca FROM lss_poczta WHERE id=%d LIMIT 1", mail)
    local wynik=exports.DB:pobierzWyniki(query)
    if not wynik or not wynik.odbiorca then return false end
    local odbiorca=tonumber(wynik.odbiorca)
    if (odbiorca<0) then
		-- dostawa do frakcji
		return false
    else	-- dostawa do gracza
		-- sprawdzamy czy gracz ma dom
		query=string.format("SELECT id,drzwi FROM lss_domy WHERE ownerid=%d ORDER BY RAND() LIMIT 1", odbiorca)
--		outputDebugString(query)
		wynik=exports.DB:pobierzWyniki(query)
		if not wynik or not wynik.drzwi then
		    -- gracz nie ma domu, dostawa do skrzynek przy urzedzie
		    
		else
		    -- gracz ma dom
--		    outputDebugString(wynik.drzwi)
		    local drzwi=split(wynik.drzwi,",")
		    return { tonumber(drzwi[1]), tonumber(drzwi[2]), tonumber(drzwi[3]), 0, nazwa="LS "..wynik.id}
		end
    end
    return false
--    return { 0,0,0,0,nazwa="LS 7" }
end


addEvent("doVerifyPostalAddress", true)
addEventHandler("doVerifyPostalAddress", root, function(adres)
    local cel=getDestination(adres)
    triggerClientEvent(source, "doVerifyPostalAddressResponse", resourceRoot, adres, cel and true or false, cel)
end)

-- triggerServerEvent("doSendPost", root, pw.adresat, temat, tresc)
addEvent("doSendPost", true)
addEventHandler("doSendPost", root, function(adresat, temat, tresc)
    if (not adresat or not temat or not tresc) then return end
    temat=exports.DB:esc(temat)
    tresc=exports.DB:esc(tresc)
    adresat=tonumber(adresat)
--  outputDebugString(getElementType(source))
    local c=getElementData(source, "character")
    if (not c or not c.id) then return end -- nie powinno sie wydarzyc
    local nadawca=tonumber(c.id)
    local query=string.format("INSERT INTO lss_poczta SET nadawca=%d,odbiorca=%d,temat='%s',tresc='%s'", nadawca, adresat, temat, tresc)
    exports.DB:zapytanie(query)
    takePlayerMoney(source, 25)
    outputChatBox("Urzędniczka mówi: list został nadany.", source)
    
end)



addEvent("onPlayerRequestMailInfo", true) -- do pobierania informacji o celu listu
addEventHandler("onPlayerRequestMailInfo", root, function(idx)
    cel=getDeliveryAddress(idx)
    if (not cel) then
	outputChatBox("Adres na kopercie jest zamazany - nie mozna go odczytac.", source)
	return
    end
    triggerClientEvent(source, "onPackageInfo", root, cel)
end)