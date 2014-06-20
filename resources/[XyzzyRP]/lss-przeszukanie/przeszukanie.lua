--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--


local przeszukanieRequests={}	-- tabela przechowujaca ostatnie oferty otrzymane od graczy

addEventHandler ( "onPlayerQuit", getRootElement(), function() przeszukanieRequests[source]=nil end )	-- autoczyszczenie tablicy


function processPrzeszukanieRequest(with)

    if (not with or not isElement(with) or getElementType(with)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("processPrzeszukanieRequest wywolane z obiektem with ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end
    if (not isElement(source) or getElementType(source)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("processPrzeszukanieRequest wywolane z obiektem source ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end
    outputDebugString("Żądanie przeszukania " .. getPlayerName(source) .. " z " .. getPlayerName(with))
	if (isPedDead(with)) then
		initPrzeszukanie(with,source)
	else
      triggerClientEvent(with, "onPrzeszukanieRequestAllowance", source)
	end
end



addEvent("onPrzeszukanieRequest", true)
addEventHandler("onPrzeszukanieRequest", root, processPrzeszukanieRequest)

function initPrzeszukanie(with,by)
	local p1
	if (not source and by) then
		p1=by
	else
		p1=source
	end
    local p2=with
--[[

    if (not p1 or not isElement(p1) or getElementType(p1)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("initPrzeszukanie wywolane z obiektem with ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end
    if (not p2 or not isElement(p2) or getElementType(p2)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("initPrzeszukanie wywolane z obiektem source ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end
    triggerClientEvent(p1, "startPrzeszukanie", p2)
    triggerClientEvent(p2, "startPrzeszukanie", p1)
]]--
	triggerClientEvent(p1, "onEQDataRequest", root, p2, true)
    outputDebugString("Zainicjowane przeszukanie " .. getPlayerName(p2).." przez " .. getPlayerName(p1))
end

addEvent("onPrzeszukanieRequestAllowed", true)
addEventHandler("onPrzeszukanieRequestAllowed", root, initPrzeszukanie)


function cancelPrzeszukanie(with)
    przeszukanieRequests[source]=nil
    triggerClientEvent(with, "cancelPrzeszukanie", source)
end

addEvent("onPrzeszukanieCancel", true)	-- rezygnacja z trwajacego handlu
addEventHandler("onPrzeszukanieCancel", root, cancelPrzeszukanie)


