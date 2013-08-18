--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


local EQ={}	-- bedzie zawierac aktualnie przetwarzany ekwipunek

function eq_getItemByID(id,subtype)
    for i,v in ipairs(EQ) do
	if (v.itemid==id and (not subtype or v.subtype==subtype)) then return v end
    end
    return nil
end

function eq_getItemBySlot(plr, slot)
	local eq=getElementData(plr,"EQ")
    if (not eq) then
      return false
    end
    
    EQ={}
    
    for i=1,28 do
	EQ[i]={}
	EQ[i].itemid=tonumber(table.remove(eq,1))
	EQ[i].count=tonumber(table.remove(eq,1))
	EQ[i].subtype=tonumber(table.remove(eq,1))
    end
    for i,v in ipairs(EQ) do
		if i == slot then
			return v
		end
    end
    return nil
end

function eq_getItem(plr,id,subtype)
    local eq=getElementData(plr,"EQ")
    if (not eq) then
      outputDebugString("Operacja na ekwipunku gracza, ktory nie ma zarejestrowanego ekwipunku!")
      return false
    end
    
    EQ={}
    
    for i=1,28 do
	EQ[i]={}
	EQ[i].itemid=tonumber(table.remove(eq,1))
	EQ[i].count=tonumber(table.remove(eq,1))
	EQ[i].subtype=tonumber(table.remove(eq,1))
    end
    -- sprawdzamy czy podany przedmiot juz ma swoje miejsce w ekwipunku
    return eq_getItemByID(id,subtype)
end




function eq_getFreeIndex()
    for i,v in ipairs(EQ) do
      if (not v.itemid or v.itemid==0) then return i end
    end
    return nil
end

function eq_compact()
    -- zamienia tabele EQ na taka postac:
    -- { itemid, ilosc, subtype, itemid, ilosc, subtype, itemid, ilosc, subtype ... }
    local compact={}
	
    for i,v in ipairs(EQ) do
	table.insert(compact, v.itemid or 0)
	table.insert(compact, v.count or 0)
	table.insert(compact, v.subtype or 0)
    end
    return compact
end

function eq_playerHasFreeSpace(plr)
    -- czy gracz ma wolne miejsce w ekwipunku
    local eq=getElementData(plr,"EQ")
    if (not eq) then
      outputDebugString("Operacja na ekwipunku gracza, ktory nie ma zarejestrowanego ekwipunku!")
      return false
    end

    EQ={}
    for i=1,28 do
      EQ[i]={}
      EQ[i].itemid=table.remove(eq,1)
      if (tonumber(EQ[i].itemid)==0) then return true end
        EQ[i].count=table.remove(eq,1)
        EQ[i].subtype=table.remove(eq,1)
      end
    return false

end

function eq_giveItem(plr,id,count,subtype)
    local eq=getElementData(plr,"EQ")
    if (not eq) then
	outputDebugString("Operacja na ekwipunku gracza, ktory nie ma zarejestrowanego ekwipunku!")
	return false
    end
    
    EQ={}
    
    -- rozkompresowujemy tabele z postaci:
    -- {itemid, ilosc, subtype, itemid,ilosc,subtype, ... }
    -- do postaci:
    -- { {itemid=, count=, subtype=}, {itemid=, count=, subtype=}, ... }

--[[    	kod debugujacy    
    outputChatBox("dane:")
    for i,v in ipairs(eq) do
	outputChatBox(tostring(i)..": "..v)
    end]]--
    
    for i=1,28 do
	EQ[i]={}
	EQ[i].itemid=tonumber(table.remove(eq,1))
	EQ[i].count=tonumber(table.remove(eq,1))
	EQ[i].subtype=tonumber(table.remove(eq,1))
    end
--[[    	kod debugujacy
    outputChatBox("Zawartosc")
    for i,v in ipairs(EQ) do
	outputChatBox(tostring(i) .. " " .. v.itemid .. " - " .. v.count)
    end
]]--    
    -- sprawdzamy czy podany przedmiot juz ma swoje miejsce w ekwipunku
    local przedmiot=eq_getItemByID(id,subtype)
    if (przedmiot) then
	przedmiot.count=przedmiot.count+(count or 1)
	setElementData(plr, "EQ", eq_compact())
	EQ={}	-- zerujemy na wszelki wypadek
	return true
    end

    -- nie ma, wiec sprawdzmy czy ma wolne miejsce na ten przedmiot
    local wolny_indeks=eq_getFreeIndex()
    if (not wolny_indeks) then
      triggerClientEvent(plr,"onCaptionedEvent", root, "Nie masz miejsca w inwentarzu.", 3)
      return false
    end
    EQ[wolny_indeks].itemid=id
    EQ[wolny_indeks].count=count or 1
    EQ[wolny_indeks].subtype=subtype or 0
    
    setElementData(plr, "EQ", eq_compact())    
    EQ={}	-- zerujemy na wszelki wypadek
    return true
    
end

function eq_takeItem(plr,id,count,subtype)
    local eq=getElementData(plr,"EQ")
    if (not eq) then
	outputDebugString("Operacja na ekwipunku gracza, ktory nie ma zarejestrowanego ekwipunku!")
	return false
    end
    
    EQ={}

    for i=1,28 do
	EQ[i]={}
	EQ[i].itemid=tonumber(table.remove(eq,1))
	EQ[i].count=tonumber(table.remove(eq,1))
	EQ[i].subtype=tonumber(table.remove(eq,1))
    end


    for i,v in ipairs(EQ) do
	if (v.itemid==id and (not subtype or v.subtype==subtype)) then
	    if (count and v.count<count) then	-- gracz ma mniejsza ilosc przedmiotu niz potrzeba
		return false
	    end
	    if (not count or count==v.count) then	-- zabieramy przedmiot, zapisujemy zmiany
		EQ[i].itemid=0
		EQ[i].count=0
		EQ[i].subtype=0
		setElementData(plr, "EQ", eq_compact())	
		EQ={}
		return true
	    end
	    EQ[i].count=v.count-count
	    setElementData(plr, "EQ", eq_compact())	
	    EQ={}
	    return true
	end
    end
    return false    
end

--addCommandHandler("eqtest", function(plr,cmd,itemid)
--    eq_takeItem(plr, tonumber(itemid),1)
--end)

function eq_change(name,oldvalue)
    -- zapisujemy zmiane w ekwipunku do bazy danych
	if (not source or not isElement(source)) then return end
    if (getElementType(source)~="player" or name~="EQ") then return end
--	outputDebugString("eq_change")
    
    -- gracz nie ma jeszcze zsynchronizowanego ekwipunku => nie zapisujemy zmian w bazie danych aby nie utracil przedmiotow
    if (not getElementData(source,"EQ:synced")) then return false end

    -- narazie zapisujemy kazda zmiane, pozniej trzeba bedzie to ograniczyc aby nie bylo tyle zapytan
    local eq=getElementData(source,"EQ")
    if (not eq or type(eq)~="table") then return end

    local character=getElementData(source,"character")
    if (not character or not character.id) then return end	-- gracz nie posiada wybranej postaci
--    outputChatBox("2 "..character.id .. exports.DB:esc(table.concat(eq,",")))
    outputChatBox("eqs " .. table.concat(eq,","))
    local query=string.format("UPDATE lss_characters SET eq='%s' WHERE id=%d LIMIT 1", exports.DB:esc(table.concat(eq,",")), character.id)
    exports.DB:zapytanie(query)

end
addEventHandler("onElementDataChange",getRootElement(),eq_change)

addEvent("onPlayerRequestEQSync", true)	-- wywolywane przy spawnie i przy restarcie zasobu lss-gui
addEventHandler("onPlayerRequestEQSync", root, function()
--    outputChatBox("EQ sync request for " .. getPlayerName(source))
    local character=getElementData(source,"character")
    if (not character or not character.id) then 
	outputDebugString("Zadanie synchronizacji ekwipunku dla niezalogowanej postaci - nie powinno sie wydarzyc")
	return
    end	-- gracz nie posiada wybranej postaci	
    local eq = exports.DB:pobierzWyniki(string.format("SELECT eq FROM lss_characters WHERE id=%d LIMIT 1", character.id))
	
	if (eq ~= nil) then	
		eqs = split(eq.eq,",")
        outputChatBox("EQ " .. eq.eq)
		setElementData(source,"EQ", eqs)
		setElementData(source,"EQ:synced", true)
	end
end)

addEvent("takePlayerMoney", true)
addEventHandler("takePlayerMoney", root, function(ile)
    local character=getElementData(source,"character")
    if (not character or not character.id) then 
	outputDebugString("Zadanie takePlayerMoney dla niezalogowanej postaci - nie powinno sie wydarzyc")
	return false
    end	-- gracz nie posiada wybranej postaci
    if (not getPlayerMoney(source) or getPlayerMoney(source)<ile) then return false end
    takePlayerMoney(source,ile)
    return true
end)

addEvent("givePlayerMoney", true)
addEventHandler("givePlayerMoney", root, function(ile)
    local character=getElementData(source,"character")
    if (not character or not character.id) then 
	outputDebugString("Zadanie takePlayerMoney dla niezalogowanej postaci - nie powinno sie wydarzyc")
	return false
    end	-- gracz nie posiada wybranej postaci
    givePlayerMoney(source,ile)
    return true
end)