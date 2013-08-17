function initSpraying()
	addEvent("drawtag:onTagStartSpray",true)
	addEvent("drawtag:onTagFinishSpray",true)
	addEvent("drawtag:onTagStartErase",true)
	addEvent("drawtag:onTagFinishErase",true)
	tag_root = createElement("drawtag:tags","drawtag:tags")
	addEventHandler("onElementDataChange",tag_root,detectSprayOrErase)
	addEventHandler("onPlayerJoin",root,createTagOnJoin)
	addEventHandler("onPlayerQuit",root,destroyTagOnQuit)
	local all_players = getElementsByType("player")
	for plnum,player in ipairs(all_players) do initSprayingForPlayer(player) end
end

function createTagForPlayer(player)
	local player_tag = createElement("drawtag:tag")
	setElementParent(player_tag,tag_root)
	setElementData(player,"drawtag:tag",player_tag)
end

function initSprayingForPlayer(player)
	createTagForPlayer(player)
	addEventHandler("onElementDataChange",player,createAnotherTagForPlayer)
end

function createAnotherTagForPlayer(dataname,oldval)
	if
		client ~= source or
		dataname ~= "drawtag:tag" or
		getElementData(source,"drawtag:tag")
	then
		return
	end
	if isElement(oldval) then triggerEvent("drawtag:onTagStartSpray",oldval,source) end
	createTagForPlayer(source)
end

function createTagOnJoin()
	initSprayingForPlayer(source)
end

function destroyTagOnQuit()
	destroyElement(getElementData(source,"drawtag:tag"))
end

function detectSprayOrErase(dataname,oldval)
	if dataname ~= "visibility" then return end
	local visibility = getElementData(source,"visibility")
	if visibility == 90 then
		triggerEvent("drawtag:onTagFinishSpray",source,client)
	elseif visibility == 0 then
		triggerEvent("drawtag:onTagFinishErase",source,client)
		destroyElement(source)
	elseif oldval == 90 then
		triggerEvent("drawtag:onTagStartErase",source,client)
	end
end

function setPlayerSprayMode(player,mode)
	if not isElement(player) or getElementType(player) ~= "player" then return false end
	if mode == "none" then
		return removeElementData(player,"drawtag:spraymode")
	elseif mode == "draw" or mode == "erase" then
		return setElementData(player,"drawtag:spraymode",mode)
	end
end

function getPlayerSprayMode(player)
	return getElementData(player,"drawtag:spraymode") or "none"
end

