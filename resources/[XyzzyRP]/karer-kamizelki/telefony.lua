--[[
karer - rozne

@author Karer <karer.programmer@gmail.com>
@license Dual GPLv2/MIT
]]--


for i,v in ipairs(getElementsByType("player")) do
	removeElementData(v,"iphone")
end

local telefony={}

function kamizelkaPDoff(komu)
	if (not telefony[komu] or not isElement(telefony[komu])) then 
		return 
	end
	if (isElement(komu)) then
		-- triggerEvent("broadcastCaptionedEvent", komu, getPlayerName(komu).. " zdjmuje kamizelkę LSPD.", 3, 20, true)
	end
	exports["bone_attach"]:detachElementFromBone(telefony[komu])
	destroyElement(telefony[komu])
	removeElementData(komu,"iphone")
end


function onIPHONE(player)
	source = player
	if (telefony[source] and isElement(telefony[source])) then destroyElement(telefony[source]) end
	telefony[source]=createObject(4007,0,0,0)
	setElementCollisionsEnabled(telefony[source], false)
	setObjectScale(telefony[source], 1.2)
	exports["bone_attach"]:attachElementToBone(telefony[source], source, 12, -0.04, 0.04, 0.06, 0, 160, 90)
end

addEvent("onIPHONE",true)
addEventHandler("onIPHONE", root, onIPHONE)

addEventHandler("onPlayerQuit", root, function()
	if (telefony[source] and isElement(telefony[source])) then 
		destroyElement(telefony[source]) 
		telefony[source]=nil
	end
end)


addCommandHandler("smoke", function(player,cmd,id)
	if getElementData(player, "level") or 0 > 1 then
	local x,y,z = getElementPosition(player)
	createObject(tonumber(id),x,y,z)
	end
end)
