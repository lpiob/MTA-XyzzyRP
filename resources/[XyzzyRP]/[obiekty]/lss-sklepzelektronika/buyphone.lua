local function wolnyNumer(numer)
    if (not numer) then return false end
    local q=string.format("SELECT 1 FROM lss_phone WHERE numer=%d", numer)
    local dane=exports.DB:pobierzWyniki(q)
    if (dane) then return false end
    return true
end
local function zarejestrujNumer(numer)
    if (not numer) then return false end
    local q=string.format("INSERT INTO lss_phone SET numer=%d", numer)
    exports.DB:zapytanie(q)
    
end

local function znajdzWolnyNumer()
    local numer=nil

    while (not wolnyNumer(numer)) do
        numer=math.random(40000,99999)

    end
    return numer
end

addEvent("onPlayerBuyPhone", true)
addEventHandler("onPlayerBuyPhone", root, function(koszt)
    if (getPlayerMoney(source)<tonumber(koszt)) then return end -- nie powinno sie zdarzyc
    local numer=znajdzWolnyNumer()
    if (exports["lss-core"]:eq_giveItem(source,21,1,numer)) then
	zarejestrujNumer(numer)
	takePlayerMoney(source, koszt)
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source) .. " zakupuje telefon.", 5, 15, true)
    end

end)