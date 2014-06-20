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
	removeElementData(v,"kamizelkaPD")
	removeElementData(v,"kamizelkaPD:wytrzymalosc")
	removeElementData(v,"kamizelkaMC")
end

local kamizelkiPD={}
local kamizelkiMC={}

function kamizelkaPDoff(komu)
		if (not kamizelkiPD[komu] or not isElement(kamizelkiPD[komu])) then 
			return 
		end
	if (isElement(komu)) then
		triggerEvent("broadcastCaptionedEvent", komu, getPlayerName(komu).. " zdejmuje kamizelkę LSPD.", 3, 20, true)
	end
	exports["bone_attach"]:detachElementFromBone(kamizelkiPD[komu])
	destroyElement(kamizelkiPD[komu])
	removeElementData(komu,"kamizelkaPD")
	removeElementData(komu,"kamizelkaPD:wytrzymalosc")
end

function onKamizelkaPD(player,wytrzymalosc)
	local source = player
	if (kamizelkiPD[source] and isElement(kamizelkiPD[source])) then destroyElement(kamizelkiPD[source]) end
	kamizelkiPD[source]=createObject(904,0,0,0)
	-- kamizelkiPD[source]=createObject(2053,0,0,0)
	setElementCollisionsEnabled(kamizelkiPD[source], false)
	setObjectScale(kamizelkiPD[source], 1.2)
	exports["bone_attach"]:attachElementToBone(kamizelkiPD[source], source, 3, 0, 0.07, 0.055, 0, -90, 0)
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).. " zakłada kamizelkę LSPD.", 3, 20, true)
	setElementData(source, "kamizelkaPD", kamizelkiPD[source])
	setElementData(source, "kamizelkaPD:wytrzymalosc", wytrzymalosc)
end


addEvent("toggleKamizelkaPD", true)
addEventHandler("toggleKamizelkaPD", getRootElement(), function(plr,wytrzymalosc,off)
	local source = plr
	if off then kamizelkaPDoff(plr,off) return end
	if (kamizelkiPD[source] and isElement(kamizelkiPD[source])) then 
		kamizelkaPDoff(plr) 
	else  
		onKamizelkaPD(plr,wytrzymalosc) 
	end
end)




function kamizelkaMCoff(komu)
		if (not kamizelkiMC[komu] or not isElement(kamizelkiMC[komu])) then 
			return 
		end
	if (isElement(komu)) then
		triggerEvent("broadcastCaptionedEvent", komu, getPlayerName(komu).. " zdejmuje kamizelkę LSMC.", 3, 20, true)
	end
	exports["bone_attach"]:detachElementFromBone(kamizelkiMC[komu])
	destroyElement(kamizelkiMC[komu])
	removeElementData(komu,"kamizelkaMC")
end

function onKamizelkaMC(player)
	local source = player
	if (kamizelkiMC[source] and isElement(kamizelkiMC[source])) then destroyElement(kamizelkiMC[source]) end
	-- kamizelkiPD[source]=createObject(904,0,0,0)
	kamizelkiMC[source]=createObject(2053,0,0,0)
	setElementCollisionsEnabled(kamizelkiMC[source], false)
	setObjectScale(kamizelkiMC[source], 1.2)
	exports["bone_attach"]:attachElementToBone(kamizelkiMC[source], source, 3, 0, 0.07, 0.055, 0, -90, 0)
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).. " zakłada kamizelkę LSMC.", 3, 20, true)
	setElementData(source, "kamizelkaMC", kamizelkiMC[source])
end

addEvent("toggleKamizelkaMC", true)
addEventHandler("toggleKamizelkaMC", getRootElement(), function(off)
	local plr = source
	if off then kamizelkaMCoff(plr,off) return end
	if (kamizelkiMC[source] and isElement(kamizelkiMC[source])) then 
		kamizelkaMCoff(source) 
	else  
		onKamizelkaMC(source) 
	end
end)

addEventHandler("onPlayerQuit", root, function()
	if (kamizelkiPD[source] and isElement(kamizelkiPD[source])) then 
		destroyElement(kamizelkiPD[source]) 
		kamizelkiPD[source]=nil
	end
	if (kamizelkiMC[source] and isElement(kamizelkiMC[source])) then 
		destroyElement(kamizelkiMC[source]) 
		kamizelkiMC[source]=nil
	end
end)