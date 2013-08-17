-- triggerServerEvent("doDelivery", resourceRoot, localPlayer, listy, odbiorca)
addEvent("doDelivery", true)
addEventHandler("doDelivery", resourceRoot, function(gracz, listy, odbiorca)
    -- w listy mamy tabele z id listow ktore ma gracz
    -- {1,2,3,4}
    local count=0
    if (odbiorca>0 or odbiorca<0) then	-- dostawa do domu
	listy=table.concat(listy,",")
	local query=string.format("SELECT p.id FROM lss_poczta p WHERE p.id in (%s) AND odbiorca=%d", exports.DB:esc(listy),odbiorca)
	local wyniki=exports.DB:pobierzTabeleWynikow(query)
	if (wyniki) then 
	    for i,v in ipairs(wyniki) do
		exports["lss-core"]:eq_takeItem(gracz, 38, 1, -(tonumber(v.id))) -- zabieramy list
	        exports["lss-core"]:eq_giveItem(gracz, 13, 8)	-- dajemy kwit
    	        query=string.format("UPDATE lss_poczta SET dostarczone=1,deliveryAttempt=NOW() WHERE id=%d LIMIT 1", tonumber(v.id))
		exports.DB:zapytanie(query)
		count=count+1
	    end
	end
    end
    if (count==0) then
	outputChatBox("Nie masz listów do dostarczenia pod ten adres", gracz)
    elseif (count==1) then
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " wrzuca list do skrzynki.", 5, 15, true)
    else
    	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " wrzuca listy do skrzynki.", 5, 15, true)
    end
    
end)


-- skrzynka zbiorcza
local skrzynka=createObject(1291, 1495.48,-1749.35,14.95,0,0,180)
-- exports["lss-poczta"]:dostarczListy(dom.ownerid)
setElementData(skrzynka,"customAction",{label="Wrzuć list", resource="lss-poczta", funkcja="dostarczListy", args={skrzynka=0}})
