--[[
@author Karer <karer.programmer@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--



addEvent("menu_kielbasaUpiecz",true)
addEventHandler("menu_kielbasaUpiecz", getRootElement(), function(grill)
	local a,b,c = getElementPosition(source)
	local d,e,f = getElementPosition(grill)
	if getDistanceBetweenPoints2D(a,b,d,e) > 2.5 then outputChatBox("(( Podejdź bliżej grilla! ))", source, 255, 0, 0) return end
	if not eq_getItem(source, 158) then return end
	eq_takeItem(source,158,1)
	eq_giveItem(source,159,1)
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).." piecze kiełbasę na grillu", 5, 10, true)
end)

addEvent("menu_rybaUpiecz",true)
addEventHandler("menu_rybaUpiecz", getRootElement(), function(grill)
	local a,b,c = getElementPosition(source)
	local d,e,f = getElementPosition(grill)
	if getDistanceBetweenPoints2D(a,b,d,e) > 2.5 then outputChatBox("(( Podejdź bliżej grilla! ))", source, 255, 0, 0) return end
	if not eq_getItem(source, 8) then return end
	eq_takeItem(source,8,1)
	eq_giveItem(source,10,1)
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).." piecze rybę na grillu", 5, 10, true)
end)

addEvent("menu_grillTake",true)
addEventHandler("menu_grillTake", getRootElement(), function(grill)
	local a,b,c = getElementPosition(source)
	local d,e,f = getElementPosition(grill)
	if getDistanceBetweenPoints2D(a,b,d,e) > 2.5 then outputChatBox("(( Podejdź bliżej grilla! ))", source, 255, 0, 0) return end
	destroyElement(getElementData(grill, "grill:smoke"))
	destroyElement(grill)
	eq_giveItem(source,157,1)
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).." zabiera grilla", 5, 10, true)
end)

addEvent("menu_blokadaTake",true)
addEventHandler("menu_blokadaTake", getRootElement(), function(blokada)
	local a,b,c = getElementPosition(source)
	local d,e,f = getElementPosition(blokada)
	if getDistanceBetweenPoints2D(a,b,d,e) > 2.5 then outputChatBox("(( Podejdź bliżej blokady! ))", source, 255, 0, 0) return end
	if getElementData(source, "faction:id") ~= getElementData(blokada, "factionid") then return end
	destroyElement(blokada)
	eq_giveItem(source,160,1)
	triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).." zabiera blokadę drogową.", 5, 10, true)
end)

local function czyKanisterPelny(plr)
	local eq=getElementData(plr,"EQ")
    if (not eq) then
      outputDebugString("Operacja na ekwipunku gracza, ktory nie ma zarejestrowanego ekwipunku!")
      return false
    end
    
    EQ={}
    
    for i=1,28 do
	EQ[i]={}
	EQ[i].itemid=tonumber(table.remove(eq,1))
	EQ[i].count=tonumber(table.remove(eq,1))
	EQ[i].subtype=tonumber(table.remove(eq,1))
    end
	
	for i,v in ipairs(EQ) do
		if ((v.itemid==161) or (v.itemid==162)) and v.subtype>0 then return v end
	end
	return false
end

addEvent("menu_kanisterFill",true)
addEventHandler("menu_kanisterFill", getRootElement(), function(vehicle,pojemnosc)
	if pojemnosc == 5 then kid = 161 else kid = 162 end
	local kanister = eq_getItem(source, kid)
	
	if (not isElement(vehicle)) then return false end
    if (getElementType(vehicle)~="vehicle") then return false end
    if (not getElementData(vehicle, "dbid")) then return false end
    if (not getElementData(vehicle, "paliwo")) then return false end
    local vm=getElementModel(vehicle)
	if not kanister then return end
	
	local a,b,c = getElementPosition(source)
	local d,e,f = getElementPosition(vehicle)
	outputDebugString(getDistanceBetweenPoints2D(a,b,d,e))
	if getDistanceBetweenPoints2D(a,b,d,e) > 2.5 then outputChatBox("(( Podejdź bliżej wozu! ))", source, 255, 0, 0) return end
	if kanister.itemid == 161 then
		eq_takeItem(source, 161, 1)
		--zalej palifo
		 local paliwo,bak=unpack(getElementData(vehicle, "paliwo"))
		 paliwo=paliwo+5
		setElementData(vehicle,"paliwo", {paliwo,bak})
		triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).." wlewa paliwo do wozu", 5, 5, true)
		if paliwo > bak then setElementData(vehicle,"paliwo", {bak,bak}) triggerEvent("broadcastCaptionedEvent", source, "Z baku pojazdu wylewa się paliwo", 5, 5, true) end
	elseif kanister.itemid == 162 then
		eq_takeItem(source, 162, 1)
		--zalej palifo
		 local paliwo,bak=unpack(getElementData(vehicle, "paliwo"))
		 paliwo=paliwo+10
		
		setElementData(vehicle,"paliwo", {paliwo,bak})
		triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).." wlewa paliwo do wozu", 5, 5, true)
		if paliwo > bak then setElementData(vehicle,"paliwo", {bak,bak}) triggerEvent("broadcastCaptionedEvent", source, "Z baku pojazdu wylewa się paliwo", 5, 5, true) end
	end
end)

for k,v in ipairs(getElementsByType("vehicle")) do
	setElementData(v, "vehicle:audioplaying", false)
end

addEvent("menu_zestawAudio",true)
addEventHandler("menu_zestawAudio", getRootElement(), function(veh)
	local aud=getElementData(veh, "vehicle:audioplaying")
	
	if not aud then
		if getElementData(veh, "vehicle:soundpath") then
			triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).." włącza system audio.", 5, 5, true)
		end
	else
		triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).." wyłącza system audio.", 5, 5, true)
	end
	
	triggerClientEvent("menu_zestawAudioDO", source, veh)
end)

addCommandHandler("vehradio", function(plr,cmd,url)
	if getPedOccupiedVehicle(plr) then
		if getElementData(getPedOccupiedVehicle(plr), "dbid") then
			if exports["lss-core"]:eq_getItem(plr, 6, tonumber(getElementData(getPedOccupiedVehicle(plr), "dbid"))) then
				setElementData(getPedOccupiedVehicle(plr), "vehicle:soundpath", url)
				triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr).." zmienia stacje radiową.", 5, 5, true)
			end
		end
	end
end)