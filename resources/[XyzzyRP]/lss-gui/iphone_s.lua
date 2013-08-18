--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



for i,v in ipairs(getElementsByType("player")) do
	removeElementData(v,"iphone")
end

local telefony={}

function iPhoneOff(komu)
	if (not telefony[komu] or not isElement(telefony[komu])) then 
		return 
	end
	if (isElement(komu)) then
		-- triggerEvent("broadcastCaptionedEvent", komu, getPlayerName(komu).. " zdjmuje kamizelkę LSPD.", 3, 20, true)
	end
	if getElementData(komu, "odebralOd") or getElementData(komu, "zadzwonilDo") then return end
	exports["bone_attach"]:detachElementFromBone(telefony[komu])
	destroyElement(telefony[komu])
	removeElementData(komu,"iphone")
end
addEvent("iPhoneOff",true)
addEventHandler("iPhoneOff", root, iPhoneOff)


function onIPhone(player)
	if (telefony[player] and isElement(telefony[player])) then destroyElement(telefony[player]) end
	telefony[player]=createObject(2006,0,0,0)
	setElementDimension(telefony[player], getElementDimension(player))
	setElementInterior(telefony[player], getElementInterior(player))
	setElementCollisionsEnabled(telefony[player], false)
	exports["bone_attach"]:attachElementToBone(telefony[player], player, 12, -0.04, 0.04, 0.06, 0, 160, 90)
end

addEvent("onIPhone",true)
addEventHandler("onIPhone", root, onIPhone)

addEventHandler("onPlayerQuit", root, function()
	if (telefony[source] and isElement(telefony[source])) then 
		destroyElement(telefony[source]) 
		telefony[source]=nil
	end
end)