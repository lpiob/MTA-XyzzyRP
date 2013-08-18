local listy_do_dostarczenia=0

local I=1
local D=30

local strefa=createColSphere(1265.09,-1554.66,1381.83,1.0)
setElementDimension(strefa,D)
setElementInterior(strefa,I)


addEventHandler("onColShapeHit", strefa, function(el,md)
    if (not md) then return end
    if (getElementType(el)~="player") then return end
--    outputChatBox("Urzędniczka mówi: Witam", el)
    if (listy_do_dostarczenia<=0) then
        outputChatBox("Urzędniczka mówi: Nie ma obecnie listów do dostarczenia.",el)
	return
    end
    if (not exports["lss-core"]:eq_getItem(el, 16)) then
	outputChatBox("Urzedniczka mówi: Musisz się zaopatrzyć w nawigację aby móc roznosić listy.",el)
	return
    end
    outputChatBox("Mam list do dostarczenia.",el)
end)


local function spool()
    local query="select count(id) ilosc from lss_poczta where dostarczone=0;"
    local wynik=exports.DB:pobierzWyniki(query)
    if wynik and wynik.ilosc and tonumber(wynik.ilosc)>0 then
	listy_do_dostarczenia=tonumber(wynik.ilosc)
    else
	listy_do_dostarczenia=0
    end
end

setTimer(spool, 2*60000, 0)
spool()

local function getMailToDeliver()
    local query="SELECT id FROM lss_poczta WHERE dostarczone=0 ORDER BY deliveryAttempt ASC LIMIT 1"
    local wynik=exports.DB:pobierzWyniki(query)
    if (not wynik or not wynik.id) then return false end
    local id=tonumber(wynik.id)
    query=string.format("UPDATE lss_poczta SET deliveryAttempt=NOW() WHERE id=%d LIMIT 1", id)
    exports.DB:zapytanie(query)
    return id
end

local function giveMailToDeliver(gracz)
    if (not exports["lss-core"]:eq_playerHasFreeSpace(gracz)) then return false end
    if (listy_do_dostarczenia<=0) then return false end
    local mailidx=getMailToDeliver()

    if (not mailidx) then return false end
    if (exports["lss-core"]:eq_getItem(gracz,38,-mailidx)) then return false end
    return exports["lss-core"]:eq_giveItem(gracz,38,1,-mailidx)
end


addEvent("doPlayerPickupMail", true)
addEventHandler("doPlayerPickupMail", resourceRoot, function(gracz)
    if (getPlayerName(gracz)~="Shawn_Hanks") then
	outputChatBox("(( poczta jest obecnie w przygotowaniu ))", gracz)
	return
    end
    if (listy_do_dostarczenia<=0) then
        outputChatBox("Urzędniczka mówi: Nie ma obecnie listów do dostarczenia.",gracz)
	return
    end
    if (not exports["lss-core"]:eq_getItem(gracz, 16)) then
	outputChatBox("Urzedniczka mówi: Musisz się zaopatrzyć w nawigację aby móc roznosić listy.",gracz)
	return
    end
    if (not exports["lss-core"]:eq_playerHasFreeSpace(gracz)) then
	outputChatBox("(( Nie masz miejsca w ekwipunku. ))", gracz)
	return
    end
    local count=0
    while (giveMailToDeliver(gracz)) do
	count=count+1
    end
    if (count>1) then
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " odbiera listy do dostarczenia.", 5, 15, true)
    elseif (count==1) then
    	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " odbiera list do dostarczenia.", 5, 15, true)
    else
	outputChatBox("Urzędniczka mówi: nie ma więcej listów do dostarczenia.", gracz)
	return    
    end
end)