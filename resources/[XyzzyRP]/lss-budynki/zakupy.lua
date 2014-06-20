--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


-- triggerServerEvent("doPlayerBuyFromShop", resourceRoot, localPlayer, pojemnik, tonumber(przedmiot.itemid), tonumber(przedmiot.subtype), tonumber(przedmiot.sellprice))
addEvent("doPlayerBuyFromShop", true)
addEventHandler("doPlayerBuyFromShop", resourceRoot, function(plr, pojemnik, itemid, subtype, price)
    if (price>getPlayerMoney(plr)) then
	outputChatBox("Nie stać Cię na to.", plr)
	return
    end
--    if not subtype then subtype=0 end
    
    -- insertItemToContainer(cid, itemid, count, subtype, name)
    -- update lss_container_contents SET count=count-1 WHERE container_id=275 AND itemid=27 AND IFNULL(subtype,0)=0;
    if (not exports["lss-pojemniki"]:insertItemToContainer(pojemnik, itemid, -1, subtype)) then

	outputChatBox("Niestety nie mam już tego przedmiotu w ofercie.", plr)
	return
    end
    outputDebugString("zakup pojemnik " .. pojemnik .. ", itemid " .. itemid .. " cena " .. price)
    -- dajemy kase
    takePlayerMoney(plr,price)
	outputChatBox(".")
    exports["lss-pojemniki"]:insertItemToContainer(pojemnik, -1, math.ceil(price/2))

    -- dajemy przedmiot
    exports["lss-core"]:eq_giveItem(plr, itemid, 1, subtype)
    triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " zakupuje coś u sprzedawcy.", 5, 5, true)

    
end)