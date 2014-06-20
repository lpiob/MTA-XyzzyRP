--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



function pda_vehinfo(vehicle)
--    outputChatBox("pda_vehinfo")
--    outputChatBox("od " .. getPlayerName(source))
    local dbid=getElementData(vehicle,"dbid")
    local output="Model: " .. getVehicleName(vehicle).."\n"
    if (not dbid) then	-- tak naprawde nie powinno sie wydarzyc bo pda sprawdza to przed wyslaniem zapytania
	    output=output .. "\nUWAGA POJAZD NIE POSIADA NUMEROW SERYJNYCH\n\nPrawdopodobnie zostały przebite a pojazd pochodzi z kradzieży\n\nNatychmiast powiadomić policję!"
	    triggerClientEvent(source, "onPDAReturnInformation", root, output)
	    return
    end
    output=output.."Numer rej.: " .. dbid .. "\n"
    dane=exports.DB:pobierzWyniki(string.format("SELECT v.created,f.name faction_name FROM lss_vehicles v LEFT JOIN lss_faction f ON f.id=v.owning_faction WHERE v.id=%d",dbid))
    if (not dane or not dane.created) then
	output=output.."\nPojazd nie figuruje w bazie miejskiej"
    else
	output=output.."\nData rejestracji: " .. dane.created .. "\n"
	if (type(dane.faction_name)=="string") then
	    output=output.."Własność frakcji " .. (dane.faction_name)
	end 
    end
    dane=exports.DB:pobierzWyniki(string.format("select c.imie,c.nazwisko from lss_vehicles v join lss_characters c ON c.id=v.owning_player where v.id=%d limit 1",dbid))
    if (dane and dane.imie) then
	output=output.."\nZarejestrowano na: " .. dane.imie .. " " .. dane.nazwisko .. "\n"
    end
    triggerClientEvent(source, "onPDAReturnInformation", root, output)
    
end

addEvent("onPDARequestVehicleInformation", true)
addEventHandler("onPDARequestVehicleInformation", root, pda_vehinfo)