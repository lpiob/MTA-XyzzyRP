--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--


local controls={ "vehicle_left", "vehicle_right", "accelerate", "brake_reverse", "handbrake", "horn" }

function sterowanie(kierowca,instruktor)
	if (getPedOccupiedVehicle(kierowca)==getPedOccupiedVehicle(instruktor)) then
	for i,v in pairs(controls) do
		setControlState ( kierowca, v, getControlState ( instruktor, v ))
	end
	end

--	setControlState ( kierowca, "vehicle_left", getControlState ( instruktor, "vehicle_left" ))
--	setControlState ( kierowca, "vehicle_right", getControlState ( instruktor, "vehicle_right" ))
--	setControlState ( kierowca, "accelerate", getControlState ( instruktor, "accelerate" ))

end


addEvent("onVehicleSteering", true)
addEventHandler("onVehicleSteering", root, function(pojazd,btn)
--	outputDebugString(btn)
	local kierowca=getVehicleController(pojazd)
	local instruktor=getVehicleOccupant(pojazd,1)
	if (not kierowca) then return end
	if (not instruktor) then return end

	setTimer(sterowanie, 50, 6, kierowca, instruktor)
end)

local function zliczanie()
	local gracze=getElementsByType("player")
	for i,v in ipairs(gracze) do
		local pojazd=getPedOccupiedVehicle(v)
		if (pojazd and getVehicleController(pojazd)==v and  getVehicleOccupant(pojazd,1)) then
			if (getElementModel(pojazd)==589) then	-- club
				local character=getElementData(v,"character")
				if (character and tonumber(character.id)>0) then
					exports.DB:zapytanie(string.format("UPDATE lss_characters SET cs_driven=cs_driven+3 WHERE id=%d AND pjB=0", character.id))
					local wyjezdzone=exports.DB2:pobierzWyniki("SELECT cs_driven FROM lss_characters WHERE id=?", character.id).cs_driven
					if wyjezdzone and wyjezdzone>0 then
						outputChatBox("(( Kursant ma już wyjezdzone " .. wyjezdzone .. " minut ))", getVehicleOccupant(pojazd,1))
					end
				end
			elseif (getElementModel(pojazd)==462) then	-- faggio
--			     TODO: weryfikacja frakcji pasazera!
				local character=getElementData(v,"character")
				if (character and tonumber(character.id)>0) then
					exports.DB:zapytanie(string.format("UPDATE lss_characters SET cs_driven=cs_driven+3 WHERE id=%d AND pjB=1 and pjA=0", character.id))
				end
			elseif (getElementModel(pojazd)==593) then	-- dodo
--			     TODO: weryfikacja frakcji pasazera!
				local character=getElementData(v,"character")
				if (character and tonumber(character.id)>0) then
					exports.DB:zapytanie(string.format("UPDATE lss_characters SET cs_driven=cs_driven+3 WHERE id=%d AND pjB=1 and pjA=0", character.id))
				end

			end
		end
	end
end

setTimer(zliczanie, 3*60*1000, 0)