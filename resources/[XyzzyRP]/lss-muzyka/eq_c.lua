--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local tt=getTickCount()

function eq_plyta(album)
	if getTickCount()-tt<2000 then
		outputChatBox("Musisz chwile odczekac.", 255,0,0)
		return
	end
	tt=getTickCount()

	album=tonumber(album)
	if not album or not albumyMuzyczne[album] then return false end
	local veh=getPedOccupiedVehicle(localPlayer)
	if not veh then
		outputChatBox("(( Płyty możesz użyc w pojezdzie. ))")
		return
	end
	if not pojazdMaRadio(veh) then
		outputChatBox("(( Ten pojazd nie posiada odtwarzacza płyt. ))")
		return
	end
	if getVehicleOccupant(veh,0)~=localPlayer then -- and getVehicleOccupant(veh,1)~=localPlayer then
		outputChatBox("(( Musisz siedzieć z przodu aby włożyć płytę do odtwarzacza. ))")
		return
		end
	setRadioChannel(0)
	local aktualnaPlyta=getElementData(veh,"audio:cd")
	if aktualnaPlyta and type(aktualnaPlyta)=="table" then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zmienia płytę w odtwarzaczu.", 3, 5, true)
	else
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wkłada płytę do odtwarzacza w pojeździe.", 3, 5, true)
	end
	setElementData(veh, "audio:cd", {album,1})
end

function menu_cdNext(args)
	local veh=args.vehicle
	if not veh or getElementType(veh)~="vehicle" then return end
	local aktualnaPlyta=getElementData(veh,"audio:cd")
	if aktualnaPlyta and type(aktualnaPlyta)=="table" then
		local album,utwor=aktualnaPlyta[1], aktualnaPlyta[2]
		if (albumyMuzyczne[album]) then
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zmienia utwór w odtwarzaczu na następny.", 3, 5, true)
			setRadioChannel(0)
			if albumyMuzyczne[album][utwor+1] then
				setElementData(veh,"audio:cd", {album, utwor+1})
				return
			else
				setElementData(veh,"audio:cd", {album, 1})
				return
			end
		end
	end
end

function menu_cdPrev(args)
	local veh=args.vehicle
	if not veh or getElementType(veh)~="vehicle" then return end
	local aktualnaPlyta=getElementData(veh,"audio:cd")
	if aktualnaPlyta and type(aktualnaPlyta)=="table" then
		local album,utwor=aktualnaPlyta[1], aktualnaPlyta[2]
		if (albumyMuzyczne[album]) then
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zmienia utwór w odtwarzaczu na poprzedni.", 3, 5, true)
			setRadioChannel(0)
			if utwor>1 and albumyMuzyczne[album][utwor-1] then
				setElementData(veh,"audio:cd", {album, utwor-1})
				return
			else
				setElementData(veh,"audio:cd", {album, #albumyMuzyczne[album]})
				return
			end
		end
	end
end

function menu_cdEject(args)
	local veh=args.vehicle
	if not veh or getElementType(veh)~="vehicle" then return end
	local aktualnaPlyta=getElementData(veh,"audio:cd")
	if aktualnaPlyta and type(aktualnaPlyta)=="table" then
		setRadioChannel(math.random(1,11))
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyłącza odtwarzacz.", 3, 5, true)
		setElementData(veh,"audio:cd", false)
	end
end


local function destroyAttachedAudio(veh)
	local ae=getAttachedElements(veh)
	for i,v in ipairs(ae) do
		if v and getElementType(v)=="sound" then
			destroyElement(v)
		end
	end
end

local function attachSoundToVehicle(vehicle)
	destroyAttachedAudio(vehicle)
	local caudio=getElementData(vehicle,"audio:cd")
	if not caudio or type(caudio)~="table" or not caudio[1] then return end
	if not albumyMuzyczne[tonumber(caudio[1])] then return end
	
	local snd=playSound3D(albumyMuzyczne[tonumber(caudio[1])][tonumber(caudio[2])], 0,0, -100, true)
	attachElements(snd, vehicle)
end

local vehResource=getResourceFromName("lss-vehicles")
addEventHandler("onClientElementDataChange", getResourceRootElement(vehResource), function(dataName, oldValue)
	if dataName~="audio:cd" then return end
	if getElementType(source)~="vehicle" then return end

	attachSoundToVehicle(source)
end, true)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for i,v in ipairs(getElementsByType("vehicle", getResourceRootElement(vehResource))) do
		local caudio=getElementData(v,"audio:cd")
		if caudio and type(caudio)=="table" and caudio[1] then
			attachSoundToVehicle(v)
		end
	end
end)