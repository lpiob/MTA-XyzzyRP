--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local function getVehicleByVID(vid)
	for i,v in ipairs(getElementsByType("vehicle")) do
		local dbid=getElementData(v,"dbid")
		if dbid and tonumber(dbid)==tonumber(vid) then return v end
	end
	return nil
end

local function wymienZamek(vehicle)
	local dbid=tonumber(getElementData(vehicle,"dbid"))
	if not dbid then return false end
	local maxid_r=exports.DB:pobierzWyniki("SELECT max(id) maxid FROM lss_vehicles")
	if not maxid_r or not maxid_r.maxid then return false end
	local maxid=tonumber(maxid_r.maxid)
	local newid=maxid+1
	local query=string.format("UPDATE lss_vehicles SET id=%d WHERE id=%d LIMIT 1", newid, dbid)
	exports.DB:zapytanie(query)
	query=string.format("UPDATE lss_containers SET owning_vehicle=%d WHERE owning_vehicle=%d LIMIT 1", newid, dbid)
	exports.DB:zapytanie(query)
	exports["lss-vehicles"]:veh_reload(dbid)
	exports["lss-vehicles"]:veh_reload(newid)
	return newid
end

addCommandHandler("veh.wymienzamek", function(plr,cmd,pojazd)
	if not pojazd then
		outputChatBox("Uzyj: /veh.wymienzamek <id pojazdu>", plr)
		return
	end
	local veh=getVehicleByVID(pojazd)
	if not veh then
		outputChatBox("Nie odnaleziono pojazdu o podanym ID.", plr)
		return
	end
	local noweid=wymienZamek(veh)
	if not noweid then
		outputChatBox("Wymiana zamka nie udala sie.", plr)
		return
	end
	outputChatBox("Zamek zmieniony, nowe ID: " .. noweid, plr)
	return
end,true,false)