--[[
Handel pomiędzy graczami

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local tradeOffers={}	-- tabela przechowujaca ostatnie oferty otrzymane od graczy

addEventHandler ( "onPlayerQuit", getRootElement(), function() tradeOffers[source]=nil end )	-- autoczyszczenie tablicy

function processTradeRequest(with)

    if (not with or not isElement(with) or getElementType(with)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("processTradeRequest wywolane z obiektem with ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end
    if (not isElement(source) or getElementType(source)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("processTradeRequest wywolane z obiektem source ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end
    outputDebugString("Żądanie handlu " .. getPlayerName(source) .. " z " .. getPlayerName(with))
    triggerClientEvent(with, "onTradeRequestAllowance", source)
end



addEvent("onTradeRequest", true)
addEventHandler("onTradeRequest", root, processTradeRequest)

function initTrade(with)
    local p1=source
    local p2=with

--[[
	if not (getPlayerName(p1)=="Shawn_Hanks" or getPlayerName(p2)=="Shawn_Hanks") then
		outputChatBox("(( Handel w trakcie poprawek, bedzie dostepny za 5 minut ))", with)
		outputChatBox("(( Handel w trakcie poprawek, bedzie dostepny za 5 minut ))", source)
		return
	end
]]--

    if (not p1 or not isElement(p1) or getElementType(p1)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("initTrade wywolane z obiektem with ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end
    if (not p2 or not isElement(p2) or getElementType(p2)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("initTrade wywolane z obiektem source ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end
    triggerClientEvent(p1, "startTrade", p2)
    triggerClientEvent(p2, "startTrade", p1)
    outputDebugString("Zainicjowany handel pomiedzy " .. getPlayerName(p1).." a " .. getPlayerName(p2))

end

addEvent("onTradeRequestAllowed", true)
addEventHandler("onTradeRequestAllowed", root, initTrade)


function cancelTrade(with)
    tradeOffers[source]=nil
    triggerClientEvent(with, "cancelTrade", source)
end

addEvent("onTradeCancel", true)	-- rezygnacja z trwajacego handlu
addEventHandler("onTradeCancel", root, cancelTrade)

local function verifyPlayerEQ(plr,offer)	-- moze byc powolne, ale co zrobić
  for i,v in ipairs(offer) do
		if (v.itemid==-1 and v.count>0) then		-- gotowka
		  if (v.count>getPlayerMoney(plr)) then return false end
		elseif (v.itemid>0 and v.count>0) then
		  local item=exports["lss-core"]:eq_getItem(plr,v.itemid,v.subtype)
		  if (not item or (item and item.count and tonumber(item.count)<tonumber(v.count))) then 
--			outputDebugString("vpe nie ma "..v.itemid)
--			if (item) then outputDebugString("item jest") end
			return false 
		  end
		end
  end
  return true
end


local function executeTradeTransaction(p1,p2)
    -- no dobra, nie jest to atomiczne, ale kogo to obchodzi?
    
    -- czy mamy w ogole informacje o tej transakcji?
    if (not tradeOffers[p1] or not tradeOffers[p2]) then return false end
    -- czy jest akceptacja po obu stronach
    if (not tradeOffers[p1][2] or not tradeOffers[p2][2]) then return false end


    -- najpierw sprawdzmy czy wszystkie strony faktycznie maja przedmioty ktorymi chca handlowac
	if (not verifyPlayerEQ(p1,tradeOffers[p1][1]) or not verifyPlayerEQ(p2, tradeOffers[p2][1])) then
	  outputChatBox("(( Transakcja przerwana, ktoras ze stron nie posiada juz wszystkich przedmiotow. ))", p1)
	  outputChatBox("(( Transakcja przerwana, ktoras ze stron nie posiada juz wszystkich przedmiotow. ))", p2)
	  return
	end

    -- logowanie transakcji

    -- jedziemy z koksem, najpierw zabieramy rzeczy obu graczom
    for i,v in ipairs(tradeOffers[p1][1]) do
	if (v.itemid==-1 and v.count>0) then		-- gotowka
        exports["lss-admin"]:gameView_add(string.format("WYMIANA %s daje %s gotowke %d$", getPlayerName(p1), getPlayerName(p2), v.count))
        if (getElementData(p1,"kary:blokada_aj") or getElementData(p2,"kary:blokada_aj")) then
          exports["lss-admin"]:outputLog("WYMIANA Jeden z graczy uczestniczacych w tej wymianie byl a AJ.")
        end

	    takePlayerMoney(p1, v.count)
		givePlayerMoney(p2, v.count)
	elseif (v.itemid>0 and v.count>0) then	-- przedmiot
		if not exports["lss-core"]:eq_giveItem(p2, v.itemid, v.count, v.subtype) then
		  outputChatBox("(( Nie masz wystarczajaco duzo miejsca w inwentatrzu, transakcja przerwana. ))", p2)
		  outputChatBox("(( Transakcja przerwana, drugi gracz nie ma wystarczająco dużo miejsca w inwentarzu. ))", p1)
		  return
		end
        exports["lss-admin"]:gameView_add(string.format("WYMIANA %s daje %s item %d podtyp %d ilosc %d", getPlayerName(p1), getPlayerName(p2), v.itemid, v.count, v.subtype or 0))
        if (getElementData(p1,"kary:blokada_aj") or getElementData(p2,"kary:blokada_aj")) then
          exports["lss-admin"]:outputLog("WYMIANA Jeden z graczy uczestniczacych w tej wymianie byl a AJ.")
        end
	    exports["lss-core"]:eq_takeItem(p1, v.itemid, v.count,v.subtype)
	end
    end
    
    for i,v in ipairs(tradeOffers[p2][1]) do
	if (v.itemid==-1 and v.count>0) then		-- gotowka
        exports["lss-admin"]:gameView_add(string.format("WYMIANA %s daje %s gotowke %d$", getPlayerName(p2), getPlayerName(p1), v.count))
        if (getElementData(p1,"kary:blokada_aj") or getElementData(p2,"kary:blokada_aj")) then
          exports["lss-admin"]:outputLog("WYMIANA Jeden z graczy uczestniczacych w tej wymianie byl a AJ.")
        end

	    takePlayerMoney(p2, v.count)
		givePlayerMoney(p1, v.count)
	elseif (v.itemid>0 and v.count>0) then	-- przedmiot
		if not exports["lss-core"]:eq_giveItem(p1, v.itemid, v.count, v.subtype) then

		  outputChatBox("(( Nie masz wystarczajaco duzo miejsca w inwentatrzu, transakcja przerwana. ))", p1)
		  outputChatBox("(( Transakcja przerwana, drugi gracz nie ma wystarczająco dużo miejsca w inwentarzu. ))", p2)
		  return
		end
        exports["lss-admin"]:gameView_add(string.format("WYMIANA %s daje %s item %d podtyp %d ilosc %d", getPlayerName(p2), getPlayerName(p1), v.itemid, v.count, v.subtype or 0))
        if (getElementData(p1,"kary:blokada_aj") or getElementData(p2,"kary:blokada_aj")) then
          exports["lss-admin"]:outputLog("WYMIANA Jeden z graczy uczestniczacych w tej wymianie byl a AJ.")
        end
		exports["lss-core"]:eq_takeItem(p2, v.itemid, v.count,v.subtype)
	end
    end
    

    -- zerujemy pamiec o transakcji
    tradeOffers[p1]=nil
    tradeOffers[p2]=nil

    -- finito
    return true    
end

function offerProposalReceived(trade_with, trade_offer, accepted)
    -- sprawdzmy pierw czy gracze sa w ogole kolo siebie
    if (not (isElement(trade_with) and getElementType(trade_with) and getElementDimension(trade_with)==getElementDimension(source) and getElementInterior(trade_with)==getElementInterior(source))) then
	if (isElement(trade_with)) then
		triggerClientEvent(trade_with, "cancelTrade", source)

	end
	triggerClientEvent(source, "cancelTrade", trade_with)
	tradeOffers[trade_with]=nil
	tradeOffers[source]=nil
	return
    end
    -- odleglosc pomiedzy graczami
    local x1,y1,z1=getElementPosition(source)
    local x2,y2,z2=getElementPosition(trade_with)
    if (getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)>10) then
    	triggerClientEvent(trade_with, "cancelTrade", source)
	triggerClientEvent(source, "cancelTrade", trade_with)
	tradeOffers[trade_with]=nil
	tradeOffers[source]=nil
	return
    end
    -- zapisujemy lokalnie zawartosc oferty
    tradeOffers[source]={ trade_offer, accepted }
    -- przesylamy oferte do drugiego gracza
    triggerClientEvent(trade_with, "onTradeOffer", source, trade_offer, accepted)
    if (accepted and tradeOffers[trade_with] and tradeOffers[trade_with][2]) then
	    
	    local wynik=executeTradeTransaction(source, trade_with)
	    if (not wynik) then
		triggerClientEvent(trade_with, "cancelTrade", source)
		triggerClientEvent(source, "cancelTrade", trade_with)
	    else
		triggerClientEvent(trade_with, "finishTrade", source)
		triggerClientEvent(source, "finishTrade", trade_with)
	    end

	    tradeOffers[trade_with]=nil
	    tradeOffers[source]=nil

	    
    
    end
end

addEvent("onOfferProposal", true)
addEventHandler("onOfferProposal", root, offerProposalReceived)


