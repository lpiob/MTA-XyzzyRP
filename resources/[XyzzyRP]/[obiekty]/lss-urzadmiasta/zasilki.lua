-- zasilki + wyplaty

local ITEMID_KWIT=13

local pI=1
local pD=1
local wysokosc_zasilku=120 -- tylko liczby calkowite!

local oz_text=createElement("text")
setElementPosition(oz_text, 1469.56,-1798.16,1135.96)
setElementData(oz_text, "text", "Zasiłki")
setElementInterior(oz_text, pI)
setElementDimension(oz_text, pD)

local odbiorZasilku=createMarker(1469.56,-1798.16,1132.96-1,"cylinder", 1.1)
setElementInterior(odbiorZasilku, pI)
setElementDimension(odbiorZasilku, pD)

local wy_text=createElement("text")
setElementPosition(wy_text, 1469.23,-1781.87,1135.96)
setElementData(wy_text, "text", "Wypłaty\nz kwitów")
setElementInterior(wy_text, pI)
setElementDimension(wy_text, pD)

local wyplata=createMarker(1469.23,-1781.87,1132.96-1,"cylinder",1.1)
setElementInterior(wyplata, pI)
setElementDimension(wyplata, pD)

--local wy2_text=createElement("text")
--setElementPosition(wy2_text, 1469.00,-1786.5,1135.96)
--setElementData(wy2_text, "text", "Wypłaty\nfrakcyjne")
--setElementInterior(wy2_text, pI)
--setElementDimension(wy2_text, pD)

local wyplata2=createMarker(1469.24,-1779.94,1132.96-1,"cylinder",1.1,255,255,100,100)
setElementInterior(wyplata2,pI)
setElementDimension(wyplata2,pD)

local wyplata2_text=createElement("text")
setElementPosition(wyplata2_text, 1469.24,-1779.94,1135.96)
setElementData(wyplata2_text, "text", "Wypłaty\nfrakcyjne")
setElementInterior(wyplata2_text, pI)
setElementDimension(wyplata2_text, pD)


local geo_text=createElement("text")
setElementPosition(geo_text, 1469.54,-1801.36,1135.96)
setElementData(geo_text, "text", "Praca geodety")
setElementInterior(geo_text, pI)
setElementDimension(geo_text, pD)

local geodetaMarker=createMarker(1469.54,-1801.36,1132.96-1,"cylinder", 1.1)
setElementInterior(geodetaMarker, pI)
setElementDimension(geodetaMarker, pD)



local eg_text=createElement("text")
setElementPosition(eg_text, 1469.26,-1780.00,1165.96)
setElementData(eg_text, "text", "Prawa jazdy")
setElementInterior(eg_text, pI)
setElementDimension(eg_text, pD)

local egzamin_npc=createPed(57,1467.03,-1779.96,1162.95,270,false)
setElementInterior(egzamin_npc, I)
setElementDimension(egzamin_npc, D)
setElementData(egzamin_npc, "npc", true)
setElementData(egzamin_npc, "name", "Urzędnik")

local egzamin=createMarker(1469.26,-1780.00,1162.96-1,"cylinder",1.1)
setElementInterior(egzamin,pI)
setElementDimension(egzamin,pD)

local CS_REQUIRED=10

--GEODETA
addEventHandler("onMarkerHit", geodetaMarker, function(el,md)
  if getElementType(el)~="player" or not md or getPedOccupiedVehicle(el) then return end
  outputChatBox("Urzędniczka mówi: Praca geodety polega na robieniu zdjec miejscom z kilku stron.", el)
  outputChatBox("Urzędniczka mówi: Potrzebuje Pan jedynie aparat i GPS.", el)
  outputChatBox("(( Wpisz /geodeta aby zacząć pracę geodety. ))", el)
  return
end)

function isPlayerInGeodetaMarker(plr)
	return isElementWithinMarker(plr, geodetaMarker)
end
--END OF GEODETA

addEventHandler("onMarkerHit", egzamin, function(hitElement, matchingDimension)
    if (getElementType(hitElement)~="player") then return end
    if (not matchingDimension or getElementInterior(hitElement)~=getElementInterior(source)) then return end
    
    local character=getElementData(hitElement, "character")
    if (not character or not character.id) then
	-- nie powinno sie wydarzyc
	triggerClientEvent(hitElement, "onCaptionedEvent", root, "Przykro nam, nie figuruje pan w naszych kartotekach.", 5)
	outputDebugString("EGZAMIN,SHOULDNTHAPPEN: proba odbioru przez nieznanego gracza " .. getPlayerName(hitElement))
	return
    end
    local query=string.format("select cs_driven,pjB from lss_characters where id=%d LIMIT 1", character.id)
    dane=exports.DB:pobierzWyniki(query)
    dane.cs_driven=tonumber(dane.cs_driven)
    dane.pjB=tonumber(dane.pjB)
    if (dane.pjB>0) then
	outputChatBox("Urzędniczka mówi: posiadasz już prawo jazdy kategorii B.", hitElement)
	return
    end
    if (dane.cs_driven<CS_REQUIRED) then
	outputChatBox(" ", hitElement)
        outputChatBox("Urzędniczka mówi: Przed przystąpieniem do egzaminu należy wyjeździć " .. CS_REQUIRED .. " minut z instruktorem.", hitElement)
	outputChatBox("Urzędniczka mówi: Obecnie posiada Pan/i wyjeżdzone zaledwie " .. dane.cs_driven .. "m.", hitElement)
	return
    end
    if (not exports["lss-core"]:eq_playerHasFreeSpace(hitElement)) then
	outputChatBox("Przygotuj sobie w ekwipunku miejsce na ewentualne prawo jazdy.", hitElement, 255,0,0,true)
	return
    end
    if (getPlayerMoney(hitElement)<14) then
	outputChatBox("Urzędniczka mówi: Egzamin na prawo jazdy kosztuje 14$.", hitElement)    
	return
    end
    
    if (not exports["lss-egzaminprawko"]:egzamin_init(hitElement)) then
	outputChatBox("Urzędniczka mówi: Niestety plac manewrowy jest obecnie zajęty, proszę przyjść za chwilę.", hitElement)
    else
	-- zerujemy licznik wyjeżdzonych godzin
	query=string.format("UPDATE lss_characters set cs_driven=0 where id=%d LIMIT 1", character.id)
	exports.DB:zapytanie(query)
	takePlayerMoney(hitElement, 14)
    end


end)

addEventHandler("onMarkerHit", odbiorZasilku, function(hitElement, matchingDimension)
    if (getElementType(hitElement)~="player") then return end
    if (not matchingDimension or getElementInterior(hitElement)~=getElementInterior(source)) then return end
    
    local character=getElementData(hitElement, "character")
    if (not character or not character.id) then
	-- nie powinno sie wydarzyc
	triggerClientEvent(hitElement, "onCaptionedEvent", root, "Przykro nam, nie figuruje pan w naszych kartotekach.", 5)
	outputDebugString("ZASILKI,SHOULDNTHAPPEN: proba odbioru przez nieznanego gracza " .. getPlayerName(hitElement))
	return
    end
    
    -- sprawdzamy czy gracz nie jest we frakcji
    local query
    query=string.format("select count(*) ile from lss_character_factions where character_id=%d", character.id)
    local dane=exports.DB:pobierzWyniki(query)
    if (dane and dane.ile and tonumber(dane.ile)>0) then
	outputChatBox("Urzędniczka mówi: przykro mi, z tego co widzę nie przysługuje Panu/i zasiłek dla bezrobotnych - posiada Pan/i już zatrudnienie.", hitElement)
	return
    end
    -- sprawdzamy czy gracz nie wziął już w tej dobie zasiłku
    query=string.format("SELECT 1 FROM lss_um_zasilki WHERE character_id=%d AND data=DATE(NOW())", character.id)
    if (exports.DB:pobierzWyniki(query)) then
        triggerClientEvent(hitElement, "onCaptionedEvent", root, "Przykro nam, odebrał Pan już dziś zasiłek.", 2)
	setTimer(triggerClientEvent, 1000, 1, hitElement, "onCaptionedEvent", root, "Proszę przyjść jutro.", 2)
	return
    end
    
    triggerClientEvent(hitElement, "onCaptionedEvent", root, "Aktualna wysokość zasiłku to " .. wysokosc_zasilku .. "$.", 4)
    givePlayerMoney(hitElement, wysokosc_zasilku)
    query=string.format("INSERT INTO lss_um_zasilki SET character_id=%d,data=NOW(),wysokosc=%d", character.id, wysokosc_zasilku)
    exports.DB:zapytanie(query)
end)

addEventHandler("onMarkerHit", wyplata, function(hitElement, matchingDimension)
    if (getElementType(hitElement)~="player") then return end
    if (not matchingDimension or getElementInterior(hitElement)~=getElementInterior(source)) then return end
    
    local character=getElementData(hitElement, "character")
    if (not character or not character.id) then
	-- nie powinno sie wydarzyc
	triggerClientEvent(hitElement, "onCaptionedEvent", root, "Przykro nam, nie figuruje pan w naszych kartotekach.", 5)
	outputDebugString("WYPLATY,SHOULDNTHAPPEN: proba odbioru przez nieznanego gracza " .. getPlayerName(hitElement))
	return
    end

    local kwity=exports["lss-core"]:eq_getItem(hitElement,ITEMID_KWIT)
    if (not kwity or type(kwity)~="table" or not kwity.count) then
	outputChatBox("Urzędniczka mówi: nie masz żadnych kwitów.", hitElement)
	return
    end
    -- zamieniamy kwity na gotowke
    exports["lss-core"]:eq_takeItem(hitElement,ITEMID_KWIT, kwity.count)
    givePlayerMoney(hitElement, tonumber(kwity.count))
    outputChatBox("Urzędniczka mówi: wypłata: " .. kwity.count.."$", hitElement)
    triggerEvent("broadcastCaptionedEvent", hitElement, getPlayerName(hitElement) .. " odbiera gotówkę w okienku.", 5, 15, true)
end)


local wyplata_minuty=30

addEventHandler("onMarkerHit", wyplata2, function(hitElement, matchingDimension)
    if (getElementType(hitElement)~="player") then return end
    if (not matchingDimension or getElementInterior(hitElement)~=getElementInterior(source)) then return end
    
    local character=getElementData(hitElement, "character")
    if (not character or not character.id) then
	-- nie powinno sie wydarzyc
	triggerClientEvent(hitElement, "onCaptionedEvent", root, "Przykro nam, nie figuruje pan w naszych kartotekach.", 5)
	outputDebugString("WYPLATY,SHOULDNTHAPPEN: proba odbioru przez nieznanego gracza " .. getPlayerName(hitElement))
	return
    end
--  outputDebugString("hit")
    -- frakcje w ktorych jest gracz
	-- wariant standardowy
--    local query=string.format("select cf.dutytime,f.id faction_id,f.name,f.payout from lss_character_factions cf JOIN lss_faction f ON f.id=cf.faction_id AND f.public=1 where cf.character_id=%d", character.id)
	-- wariant obslugujacy zroznicowane wyplaty (payout_share w tabeli lss_faction_ranks)
	local query=string.format("select cf.dutytime,f.id faction_id,f.name,f.payout*fr.payout_share/100 payout from lss_character_factions cf JOIN lss_faction f ON f.id=cf.faction_id AND f.public=1 JOIN lss_faction_ranks fr ON fr.faction_id=f.id  AND fr.rank_id=cf.rank where cf.character_id=%d", character.id)
    local frakcje=exports.DB:pobierzTabeleWynikow(query)
    outputChatBox("* Urzędnik pisze na klawiaturze", hitElement)
    if (not frakcje or #frakcje<1) then
        outputChatBox("Urzędnik mówi: przykro mi, nie widzę aby Pan/i pracował/a w jakiejkolwiek frakcji publicznej...", hitElement)
	return
    end
    -- sumujemy
    local suma=0
    for i,v in ipairs(frakcje) do
	v.dutytime=tonumber(v.dutytime)
	v.payout=tonumber(v.payout)
	if (v.dutytime>=wyplata_minuty) then
	    local wyplata=v.dutytime/wyplata_minuty*v.payout
	    outputChatBox(" * " .. v.name .. " - minut: #FFFFFF" .. v.dutytime .. "#FFFF00, wypłata: #FFFFFF" .. wyplata .. "$", hitElement, 255,255,0,true)
	    givePlayerMoney(hitElement, wyplata)
	    suma=suma+wyplata
	    query=string.format("UPDATE lss_character_factions SET dutytime=0 WHERE character_id=%d AND faction_id=%d LIMIT 1", character.id, v.faction_id)
	    --outputDebugString(query)
	    exports.DB:zapytanie(query)
	else
	    outputChatBox(" * " .. v.name .. " - minut: #FFFFFF" .. v.dutytime, hitElement, 255,255,0,true)
	end
    end
    if (suma>0) then
	outputChatBox("Łącznie: " .. suma.."$", hitElement)
	triggerEvent("broadcastCaptionedEvent", hitElement, getPlayerName(hitElement) .. " odbiera gotówkę w okienku.", 5, 15, true)
    else
	outputChatBox("Urzędnik mówi: przykro mi, musi Pan/i przepracować więcej czasu.", hitElement)
    end

end)




local urzedniczka=createPed(11,1467.03,-1798.23,1132.95,271.1,false) -- zasiłki
setElementInterior(urzedniczka, pI)
setElementDimension(urzedniczka, pD)
setElementData(urzedniczka, "npc", true)
setElementData(urzedniczka, "name", "Urzędniczka")

local urzedniczka2=createPed(11,1467.03,-1779.50,1132.95,270,false) -- wyplaty z kwitkow
setElementInterior(urzedniczka2, pI)
setElementDimension(urzedniczka2, pD)
setElementData(urzedniczka2, "npc", true)
setElementData(urzedniczka2, "name", "Urzędniczka")

local urzedniczka3=createPed(11,1466.78,-1783.21,1162.95,270,false) -- prawo jazdy
--local urzedniczka3=createPed(11,1467.03,-1801.12,1162.95,266.6,false)
setElementInterior(urzedniczka3, pI)
setElementDimension(urzedniczka3, pD)
setElementData(urzedniczka3, "npc", true)
setElementData(urzedniczka3, "name", "Urzędniczka")

local urzedniczka4=createPed(57,1467.03,-1786.48,1132.95,268.0,false) -- wypłaty z frakcji
setElementInterior(urzedniczka4, pI)
setElementDimension(urzedniczka4, pD)
setElementData(urzedniczka4, "npc", true)
setElementData(urzedniczka4, "name", "Urzędnik")

local urzedniczka5=createPed(11,1467.03,-1801.53,1132.95,270,false) -- geodeta
--local urzedniczka3=createPed(11,1467.03,-1801.12,1162.95,266.6,false)
setElementInterior(urzedniczka5, pI)
setElementDimension(urzedniczka5, pD)
setElementData(urzedniczka5, "npc", true)
setElementData(urzedniczka5, "name", "Urzędniczka")

--[[ niestety to nie dziala po stronie serwera
    ale warto sie zastanowic czy nie zrobic uniwersalnego mechanizmu do 'lapania wzroku' wszystkich pedow-npc w poblizu gracza 
local urzedniczka_colshape=createColSphere(356.30,166.27,1008.38,10)
setElementInterior(urzedniczka_colshape, pI)
setElementDimension(urzedniczka_colshape, pD)


setTimer(function()
    local gracze_w_poblizu=getElementsWithinColShape(urzedniczka_colshape, "player")
    if (not gracze_w_poblizu or #gracze_w_poblizu<1) then
	setPedLookAt(urzedniczka, 358.24,166.24,1007.38)
    end
    
end, 10000, 0)
]]--