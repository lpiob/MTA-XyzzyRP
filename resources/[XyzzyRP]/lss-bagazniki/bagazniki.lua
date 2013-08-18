--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


function findVehicleContainer(veh)
	if not pojazdMaBagaznik(veh) then return nil end

    local dbid=tonumber(getElementData(veh,"dbid"))
    if (not dbid) then return nil end

    local query=string.format("SELECT id FROM lss_containers WHERE owning_vehicle=%d AND typ='bagaznik' LIMIT 1", dbid)
    local id=exports.DB:pobierzWyniki(query)
    if (not id) then
	outputDebugString("Tworzenie bagaznika dla pojazdu " .. dbid)
	local nazwa=exports.DB:esc(getVehicleNameFromModel(getElementModel(veh)) .. " [" .. dbid .. "]")
	query=string.format("INSERT INTO lss_containers SET owning_vehicle=%d,created=NOW(),last_access=NOW(),typ='bagaznik',nazwa='Bagaznik pojazdu %s'", dbid, nazwa)
	exports.DB:zapytanie(query)
	id=exports.DB:insertID()
	return id
    else
	return tonumber(id.id)
    end
end


addEvent("doOtworzBagaznik", true)
addEventHandler("doOtworzBagaznik", resourceRoot, function(plr,veh)
	local bid=findVehicleContainer(veh)
	if not bid then
		return
	end
	triggerEvent("onPojemnikOpenRequest", plr, bid)
end)