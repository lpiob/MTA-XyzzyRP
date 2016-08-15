--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



local I=10
local D=23


local mexit=createMarker(215.51,112.09,999.02,"arrow",1)
local aj_cs=createColSphere(215.47,109.31,999.02,358.5,10)
setElementInterior(aj_cs,I)
setElementDimension(aj_cs,D)
setElementInterior(mexit,I)
--setElementDimension(mexit,D)

addEventHandler("onMarkerHit", mexit, function(el,md)

--    if (not md) then return end
    if (getElementType(el)~="player") then return end
    local aj=getElementData(el, "kary:blokada_aj")
    if (not aj or tonumber(aj)<1) then
--	    setElementPosition(el, 2210.29,-2022.68,13.55)
	    setElementPosition(el, 1166.96,-1719.86,13.90)
	    setElementRotation(el, 0,0, 349)
	    setElementInterior(el,0)
	    setElementDimension(el,0)
	    removeElementData(el, "kary:blokada_aj")
	    triggerClientEvent(el,"onCaptionedEvent", root, "Ocknęłeś się z nieprzytomności, nie wiesz jak tu trafiłeś.", 3)	    
	    savePlayerData(el)
	    return
    else
	outputChatBox("Twój AJ kończy się za " .. aj .. " min.", el, 255,0,0,true)
    end
--[[    
    local character=getElementData(el,"character")
    if (character and character.id) then
	local query=string.format("select u.blokada_aj, timediff(blokada_aj, NOW()) roznica from lss_characters c  JOIN lss_users u ON c.userid=u.id WHERE c.id=%d AND u.blokada_aj>NOW();", character.id)
	local dane=exports.DB:pobierzWyniki(query)
	if (not dane) then
	    setElementPosition(el, 2210.29,-2022.68,13.55)
	    setElementRotation(el, 0,0, 53)
	    setElementInterior(el,0)
	    setElementDimension(el,0)
	    removeElementData(el, "kary:blokada_aj")
	    triggerClientEvent(el,"onCaptionedEvent", root, "Ocknęłeś się z nieprzytomności, nie wiesz jak tu trafiłeś.", 3)	    
	    savePlayerData(el)
	    return
	else
	    outputChatBox("Siedzisz w AJ do " .. dane.blokada_aj .. " (jeszcze " .. dane.roznica ..").", el, 255,0,0)
	end
	
	
    end
]]--
    
--    triggerClientEvent(el,"onCaptionedEvent", root, getPlayerName(el) .. " bezskutecznie próbuje przesunąć bramę.", 3)
end)


function aj_process()
    for i,v in ipairs(getElementsWithinColShape(aj_cs,"player")) do
--	if (getElementDimension(v)==D) then
	outputDebugString(" AJ " .. getPlayerName(v))
        local aj=getElementData(v, "kary:blokada_aj")
	local uid=getElementData(v,"auth:uid")
	
	if (uid and tonumber(aj)) then
	    aj=tonumber(aj)-1
	    setElementData(v,"kary:blokada_aj",aj)
		if (aj<0) then aj=0 end
	    local query=string.format("UPDATE lss_users SET blokada_aj=%d WHERE id=%d LIMIT 1",aj,uid)
	    exports.DB:zapytanie(query)
	    if (aj<=0) then
		outputChatBox("Twój AJ się skończył, możesz opuścić więzienie.", v, 255,0,0,true)
		removeElementData(v,"kary:blokada_aj")
	    end
	end
--	end
    end
end

setTimer(aj_process, 60000, 0)
