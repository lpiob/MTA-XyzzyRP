--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



addEvent("broadcastCaptionedEvent", true)
addEventHandler("broadcastCaptionedEvent", root, function(descr, lifetime, range, includesource)
    if (not source or not isElement(source)) then return end
    descr=string.gsub(descr,"_", " ")
    local x,y,z=getElementPosition(source)
    local strefa=createColSphere(x,y,z,range)
    local gracze=getElementsWithinColShape(strefa, "player")
    for i,v in ipairs(gracze) do
	if ((includesource or (source~=v)) and getElementInterior(v)==getElementInterior(source) and getElementDimension(v)==getElementDimension(source)) then
		if not getElementData(v,"hud:removeclouds") then
			triggerClientEvent(v,"onCaptionedEvent", root, descr, lifetime)
			outputChatBox("* " .. descr, v)
		end
	end
    end
    destroyElement(strefa)
end)