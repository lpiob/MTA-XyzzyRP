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
	removeElementData(v,"papieros")
	removeElementData(v,"joint")
	removeElementData(v,"cygaro")
end

local papierosy={}

function papierosOff(komu)
			if (not papierosy[komu] or not isElement(papierosy[komu])) then 
--				outputDebugString("nie ma")
				return 
			end
			if (isElement(komu)) then
				triggerEvent("broadcastCaptionedEvent", komu, getPlayerName(komu).. " kończy palić papierosa", 3, 20, true)
			end
			exports["bone_attach"]:detachElementFromBone(papierosy[komu])
			destroyElement(papierosy[komu])
			removeElementData(komu,"papieros")
end
function jointOff(komu)
			if (not papierosy[komu] or not isElement(papierosy[komu])) then 
--				outputDebugString("nie ma")
				return 
			end
			if (isElement(komu)) then
				triggerEvent("broadcastCaptionedEvent", komu, getPlayerName(komu).. " kończy palić jointa", 3, 20, true)
			end
			exports["bone_attach"]:detachElementFromBone(papierosy[komu])
			destroyElement(papierosy[komu])
			removeElementData(komu,"joint")
end
function cygaroOff(komu)
			if (not papierosy[komu] or not isElement(papierosy[komu])) then 
--				outputDebugString("nie ma")
				return 
			end
			if (isElement(komu)) then
				triggerEvent("broadcastCaptionedEvent", komu, getPlayerName(komu).. " kończy palić cygaro", 3, 20, true)
			end
			exports["bone_attach"]:detachElementFromBone(papierosy[komu])
			destroyElement(papierosy[komu])
			removeElementData(komu,"cygaro")
end



addEvent("onPapieros",true)
addEventHandler("onPapieros", root, function()
	if (papierosy[source] and isElement(papierosy[source])) then destroyElement(papierosy[source]) end
	papierosy[source]=createObject(1485,0,0,0)
	setElementDimension(papierosy[source], getElementDimension(source))
	setElementInterior(papierosy[source], getElementInterior(source))

	exports["bone_attach"]:attachElementToBone(papierosy[source], source, 1, 0.062237, 0.006420, -0.018719, 61.115173, 0.000000, 140.122970)
	setTimer(papierosOff, math.random(120000,180000), 1, source)
end)

addEvent("onJoint",true)
addEventHandler("onJoint", root, function()
	if (papierosy[source] and isElement(papierosy[source])) then destroyElement(papierosy[source]) end
	papierosy[source]=createObject(1485,0,0,0)
	setElementDimension(papierosy[source], getElementDimension(source))
	setElementInterior(papierosy[source], getElementInterior(source))

	exports["bone_attach"]:attachElementToBone(papierosy[source], source, 1, 0.062237, 0.006420, -0.018719, 61.115173, 0.000000, 140.122970)
	setTimer(jointOff, math.random(120000,180000), 1, source)
end)

addEvent("onCygaro",true)
addEventHandler("onCygaro", root, function()
	if (papierosy[source] and isElement(papierosy[source])) then destroyElement(papierosy[source]) end
	papierosy[source]=createObject(1485,0,0,0)
	setElementDimension(papierosy[source], getElementDimension(source))
	setElementInterior(papierosy[source], getElementInterior(source))

	exports["bone_attach"]:attachElementToBone(papierosy[source], source, 1, 0.062237, 0.026420, -0.018719, 61.115173, 0.000000, 160.122970)
	setTimer(cygaroOff, math.random(120000,180000), 1, source)
end)




addEventHandler("onPlayerQuit", root, function()
	if (papierosy[source] and isElement(papierosy[source])) then 
		destroyElement(papierosy[source]) 
		papierosy[source]=nil
	end
end)