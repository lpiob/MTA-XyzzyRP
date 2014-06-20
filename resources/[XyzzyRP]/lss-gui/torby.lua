--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



for i,v in ipairs(getElementsByType("player")) do
	removeElementData(v,"plecak")
end

local plecak={}

function torbaOff()
	if (not plecak[source] or not isElement(plecak[source])) then 
		return 
	end
	exports["bone_attach"]:detachElementFromBone(plecak[source])
	destroyElement(plecak[source])
	removeElementData(source,"plecak")
end
addEvent("torbaOff", true)
addEventHandler("torbaOff", getRootElement(), torbaOff)


function torbaOn(id)
	local player = source
	if (plecak[player] and isElement(plecak[player])) then destroyElement(plecak[player]) end
	plecak[player]=createObject(id,0,0,0)
	setElementDimension(plecak[player], getElementDimension(player))
	setElementInterior(plecak[player], getElementInterior(player))
	setElementCollisionsEnabled(plecak[player], false)
	if id == 2752 then
		exports["bone_attach"]:attachElementToBone(plecak[player], player, 3, 0, 0, -0.1, 0, 270, 0)
	else
		exports["bone_attach"]:attachElementToBone(plecak[player], player, 8, 0, 0.07, 0.46, 180, -20, 0)
	end
	setElementData(player, "plecak", true)
end
addEvent("torbaOn", true)
addEventHandler("torbaOn", getRootElement(), torbaOn)

addEventHandler("onPlayerQuit", root, function()
	if (plecak[source] and isElement(plecak[source])) then 
		destroyElement(plecak[source]) 
		plecak[source]=nil
	end
end)