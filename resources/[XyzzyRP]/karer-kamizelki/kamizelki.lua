--[[
karer - rozne

@author Karer <karer.programmer@gmail.com>
@license Dual GPLv2/MIT
]]--


for i,v in ipairs(getElementsByType("player")) do
	removeElementData(v,"kamizelkaPD")
end

local kamizelkiPD={}

function kamizelkaPDoff(komu)
	if (not kamizelkiPD[komu] or not isElement(kamizelkiPD[komu])) then 
		return 
	end
	if (isElement(komu)) then
		triggerEvent("broadcastCaptionedEvent", komu, getPlayerName(komu).. " zdjmuje kamizelkę LSPD.", 3, 20, true)
	end
	exports["bone_attach"]:detachElementFromBone(kamizelkiPD[komu])
	destroyElement(kamizelkiPD[komu])
	removeElementData(komu,"kamizelkaPD")
end


function onKamizelkaPD(player)
	source = player
	if (kamizelkiPD[source] and isElement(kamizelkiPD[source])) then destroyElement(kamizelkiPD[source]) end
	kamizelkiPD[source]=createObject(4006,0,0,0)
	setElementCollisionsEnabled(kamizelkiPD[source], false)
	setObjectScale(kamizelkiPD[source], 1.2)
	exports["bone_attach"]:attachElementToBone(kamizelkiPD[source], source, 3, 0, 0.07, 0.04, 0, -90, 0)
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).. " zakłada kamizelkę LSPD.", 3, 20, true)
end

addEvent("onKamizelkaPD",true)
addEventHandler("onKamizelkaPD", root, onKamizelkaPD)

addEventHandler("onPlayerQuit", root, function()
	if (kamizelkiPD[source] and isElement(kamizelkiPD[source])) then 
		destroyElement(kamizelkiPD[source]) 
		kamizelkiPD[source]=nil
	end
end)
