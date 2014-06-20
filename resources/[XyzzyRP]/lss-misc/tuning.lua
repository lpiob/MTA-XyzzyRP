--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- miejsca gdzie mozna montowac tuning

local miejscaMontazu={
--[[	warsztat1={	
				colCuboid={1846,-1784,12, 6, 17, 6}, -- colshape w ktorym musi byc pojazd
				demontaz_ml={1855.76,-1772.95,12.65}, -- lokalizacja markera demontazu czesci
				montaz_ml={1855.75,-1776.13,12.65}, -- ..................... montazu czesci
			},
]]--
	warsztat2={
				colCuboid={641.81,-120.55,24.59,12,17,4},
				demontaz_ml={641.87,-119.38,24.59},
				montaz_ml={654.47,-119.32,24.59},
			},
--[[	warsztat3={
				colCuboid={2323.87,-135.28,24.65,8,7,4},
				demontaz_ml={2330.31,-129.53,25.67},
				montaz_ml={2325.59,-129.61,25.67},
			},
]]--
	warsztat4={
				colSphere={1222.30,259.58,19.60,5},
				demontaz_ml={1217.24,255.80,18.60},
				montaz_ml={1221.76,254.00,18.60},
			},
--[[	warsztat5={
				colCuboid={109,-200,0,13,4,4},
				demontaz_ml={109.09,-195.88,0.61},
				montaz_ml={115.13,-195.70,0.61},
			},
]]--
}

for i,v in pairs(miejscaMontazu) do
	if v.colCuboid then
		v.cs=createColCuboid(unpack(v.colCuboid))
--		setElementData(v.cs, "tuning", true)
	elseif v.colSphere then
		v.cs=createColSphere(unpack(v.colSphere))
	end
	if v.demontaz_ml then
		v.marker_demontaz=createMarker(v.demontaz_ml[1],v.demontaz_ml[2],v.demontaz_ml[3],"cylinder",1)
		setElementData(v.marker_demontaz, "typ", "demontaz")
		if v.cs then
			setElementParent(v.marker_demontaz,v.cs)
		end
	end
	if v.montaz_ml then
		v.marker_montaz=createMarker(v.montaz_ml[1],v.montaz_ml[2],v.montaz_ml[3],"cylinder",1)
		setElementData(v.marker_montaz, "typ", "montaz")
		if v.cs then
			setElementParent(v.marker_montaz,v.cs)
		end
	end
end

-- triggerServerEvent("demontujTuning", resourceRoot, przetwarzany_pojazd, czesc_id)
addEvent("demontujTuning", true)
addEventHandler("demontujTuning", resourceRoot, function(pojazd, czesc)
	local dbid=tonumber(getElementData(pojazd,"dbid"))
	if not dbid then return end
	if (getVehicleUpgradeSlotName(czesc)=="Hydraulics") then
		if not removeVehicleUpgrade(pojazd, czesc) then
			return -- nie powinno sie wydarzyc
		end
		if not exports["lss-core"]:eq_giveItem(client, 102, 1, czesc) then -- nie ma miejsca w eq
			addVehicleUpgrade(pojazd, czesc)
			return
		end
		exports["lss-vehicles"]:veh_save(pojazd)
		triggerEvent("broadcastCaptionedEvent", client, getPlayerName(client).. " demontuje zestaw hydrauliczny w pojeździe.", 5, 15, true)
		local c=getElementData(client,"character")

		local t=string.format("Demontaz tuningu, gracz %d, pojazd %d, czesc %d", c.id or 0, dbid, czesc)
		exports["lss-admin"]:gameView_add(t)
	elseif (getVehicleUpgradeSlotName(czesc)=="Wheels") then
		if not removeVehicleUpgrade(pojazd, czesc) then
			return -- nie powinno sie wydarzyc
		end
		if not exports["lss-core"]:eq_giveItem(client, 79, 1, czesc) then -- nie ma miejsca w eq
			addVehicleUpgrade(pojazd, czesc)
			return
		end
		exports["lss-vehicles"]:veh_save(pojazd)
		triggerEvent("broadcastCaptionedEvent", client, getPlayerName(client).. " demontuje koła pojazdu.", 5, 15, true)
		local c=getElementData(client,"character")

		local t=string.format("Demontaz tuningu, gracz %d, pojazd %d, czesc %d", c.id or 0, dbid, czesc)
		exports["lss-admin"]:gameView_add(t)
	end
end)

addEvent("montujTuning", true)
addEventHandler("montujTuning", resourceRoot, function(pojazd, czesc)
	local dbid=tonumber(getElementData(pojazd,"dbid"))
	if not dbid then return end
	if (getVehicleUpgradeSlotName(czesc)=="Hydraulics") then
		-- sprawdzamy, czy pojazd ma już jakis tuning w tym slocie
		local iu=getVehicleUpgradeOnSlot(pojazd, 9)
		if iu and iu~=0 then
			outputChatBox("(( Ten pojazd posiada juz zamontowany tuning. ))", client)
			return
		end
		if not exports["lss-core"]:eq_takeItem(client, 102, 1, czesc) then -- nie ma przedmiotu
			return
		end
		addVehicleUpgrade(pojazd, czesc)
		exports["lss-vehicles"]:veh_save(pojazd)
		triggerEvent("broadcastCaptionedEvent", client, getPlayerName(client).. " montuje zestaw hydrauliczny w pojeździe.", 5, 15, true)
		local c=getElementData(client,"character")

		local t=string.format("Montaz tuningu, gracz %d, pojazd %d, czesc %d", c.id or 0, dbid, czesc)
		exports["lss-admin"]:gameView_add(t)

	elseif (getVehicleUpgradeSlotName(czesc)=="Wheels") then
		-- sprawdzamy, czy pojazd ma już jakis tuning w tym slocie
		local iu=getVehicleUpgradeOnSlot(pojazd, 12)
		if iu and iu~=0 then
			outputChatBox("(( Najpierw zdemontuj istniejące koła. ))", client)
			return
		end
		if not exports["lss-core"]:eq_takeItem(client, 79, 1, czesc) then -- nie ma przedmiotu
			return
		end
		addVehicleUpgrade(pojazd, czesc)
		exports["lss-vehicles"]:veh_save(pojazd)
		triggerEvent("broadcastCaptionedEvent", client, getPlayerName(client).. " montuje koła pojazdu.", 5, 15, true)
		local c=getElementData(client,"character")

		local t=string.format("Montaz tuningu, gracz %d, pojazd %d, czesc %d", c.id or 0, dbid, czesc)
		exports["lss-admin"]:gameView_add(t)
	end
end)