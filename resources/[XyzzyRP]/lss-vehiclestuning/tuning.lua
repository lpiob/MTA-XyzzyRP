--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local tuning_items = {
	{1, "Opony typu slick"},
	{2, "Opony z miękkiej mieszanki"},
	
	{3, "Chipset eco"},
	{4, "Chipset hard"},
	
	{5, "Rozpórka pod maską"},
	{6, "Klatka bezpieczenstwa"},
	
	{7, "Filtr stożkowy"},
	{8, "Filtr sportowy"},
	
	{9, "Zestaw wtrysku wody z metanolem"},
	{10, "Wtryski sportowe"},
	
	{11, "Zestaw elementów karoseri z włókna węglowego"},
	{12, "Zestaw wzmocnionych elementów karoseri alphaBx"},
	
	{13, "Biturbo"},
	{14, "Twin-turbo"},
	
	{15, "Drążek stabilizatora"},
	{16, "Amortyzator gazowy o zwiększonej sile tłumienia"},
	
	{17, "Zestaw ciężkiego zawieszenia gwintowanego"},
	
	{18, "Folia R10"},
	{19, "Folia przyciemniająca"},
	
	{20, "Zestaw tuningowy Bi-ksenon XBluePower"},
	{21, "Zestaw tuningowy LED XGreenPower"},
	
	{22, "Klocki hamulcowe z twardej mieszanki"},
	{23, "Zacisk hamulcowy  z żeliwa"},
	{24, "Tarcza hamulcowa wentylowana"},
	
	{25, "Skrzynia biegów SPRINT"},
	{26, "Skrzynia biegów FAST"},
	
	{27, "System audio Little music"},
	{28, "System audio BIG BASTARD"},
}

function reloadOneVehicleTuning(vehid)
	for k,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "dbid") then
			if (tonumber(getElementData(v, "dbid")) == tonumber(vehid)) then
				local dbid = tonumber(getElementData(v, "dbid"))
				local t = exports.DB2:pobierzWyniki("SELECT tuning FROM lss_vehicles WHERE id=? LIMIT 1",dbid)
				local tuning = t.tuning
				
				if tuning then --JEST TUNING
					setElementData(v, "vehicle:tuning", tuning)
					local explode = loadstring("return {\""..tuning:gsub("|", "\",\"").."\"}")()
					if #explode <=0 then return end
					
					for i,id in ipairs(explode) do
						local id=tonumber(id)

						setElementData(v, "vehicle:folia", false)
						
						if id==1 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "tractionBias", ((handling.tractionBias)*0.08)+handling.tractionBias )
						elseif id==2 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "tractionBias", handling.tractionBias-((handling.tractionBias)*0.07) )
							setVehicleHandling(v, "brakeDeceleration", ((handling.brakeDeceleration)*0.05)+handling.brakeDeceleration )
						elseif id==3 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", ((handling.maxVelocity)*0.07)+handling.maxVelocity )
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.09)+handling.engineAcceleration )
						elseif id==4 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", ((handling.maxVelocity)*0.15)+handling.maxVelocity )
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.06)+handling.engineAcceleration )
						elseif id==5 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "collisionDamageMultiplier", handling.collisionDamageMultiplier-((handling.collisionDamageMultiplier)*0.07) )
						elseif id==6 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "collisionDamageMultiplier", handling.collisionDamageMultiplier-((handling.collisionDamageMultiplier)*0.15) )
						elseif id==7 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", ((handling.maxVelocity)*0.04)+handling.maxVelocity )
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.06)+handling.engineAcceleration )
						elseif id==8 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", ((handling.maxVelocity)*0.06)+handling.maxVelocity )
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.03)+handling.engineAcceleration )
						elseif id==9 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.10)+handling.engineAcceleration )
						elseif id==10 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", ((handling.maxVelocity)*0.14)+handling.maxVelocity )
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.02)+handling.engineAcceleration )
						elseif id==11 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "collisionDamageMultiplier", handling.collisionDamageMultiplier-((handling.collisionDamageMultiplier)*0.25) )
						elseif id==12 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "collisionDamageMultiplier", handling.collisionDamageMultiplier-((handling.collisionDamageMultiplier)*0.15) )
							setVehicleHandling(v, "maxVelocity", handling.maxVelocity-(handling.maxVelocity)*0.05 )
							setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration-((handling.engineAcceleration)*0.05) )
						elseif id==13 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration+(handling.engineAcceleration)*0.12 )
						elseif id==14 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration+(handling.engineAcceleration)*0.09 )
						elseif id==15 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "tractionBias", ((handling.tractionBias)*0.10)-handling.tractionBias )
						elseif id==16 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "tractionBias", ((handling.tractionBias)*0.07)-handling.tractionBias )
						elseif id==17 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "tractionBias", ((handling.tractionBias)*0.18)-handling.tractionBias )
							setVehicleHandling(v, "maxVelocity", handling.maxVelocity-(handling.maxVelocity)*0.06 )
							setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration-((handling.engineAcceleration)*0.06) )
						elseif id==18 then
							setElementData(v, "vehicle:folia", 1)
						elseif id==19 then
							setElementData(v, "vehicle:folia", 2)
						elseif id==20 then
							setVehicleHeadLightColor(v, 13, 134, 255)
						elseif id==21 then
							setVehicleHeadLightColor(v, 150, 255, 69)
						elseif id==22 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "brakeDeceleration", ((handling.brakeDeceleration)*0.04)+handling.brakeDeceleration )
						elseif id==23 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "brakeDeceleration", ((handling.brakeDeceleration)*0.03)+handling.brakeDeceleration )
						elseif id==24 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "brakeDeceleration", ((handling.brakeDeceleration)*0.03)+handling.brakeDeceleration )
						elseif id==25 then 
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", handling.maxVelocity-((handling.maxVelocity)*0.13) )
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.07)+handling.engineAcceleration )
						elseif id==26 then 
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", handling.maxVelocity+((handling.maxVelocity)*0.07) )
							setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration-((handling.engineAcceleration)*0.04) )
						elseif id==27 then
							setElementData(v, "vehicle:audio", 1)
						elseif id==28 then
							setElementData(v, "vehicle:audio", 2)
						end
					end
				end
			end
		end
	end
end

function reloadVehiclesTuning()
	for k,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "dbid") then
			local dbid = tonumber(getElementData(v, "dbid"))
				local t = exports.DB2:pobierzWyniki("SELECT tuning FROM lss_vehicles WHERE id=? LIMIT 1",dbid)
				local tuning = t.tuning
				
				if tuning then --JEST TUNING
					setElementData(v, "vehicle:tuning", tuning)
					local explode = loadstring("return {\""..tuning:gsub("|", "\",\"").."\"}")()
					if #explode <=0 then return end
					
					for i,id in ipairs(explode) do
						local id=tonumber(id)
setElementData(v, "vehicle:folia", false)
						
						if id==1 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "tractionBias", ((handling.tractionBias)*0.08)+handling.tractionBias )
						elseif id==2 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "tractionBias", handling.tractionBias-((handling.tractionBias)*0.07) )
							setVehicleHandling(v, "brakeDeceleration", ((handling.brakeDeceleration)*0.05)+handling.brakeDeceleration )
						elseif id==3 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", ((handling.maxVelocity)*0.07)+handling.maxVelocity )
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.09)+handling.engineAcceleration )
						elseif id==4 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", ((handling.maxVelocity)*0.15)+handling.maxVelocity )
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.06)+handling.engineAcceleration )
						elseif id==5 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "collisionDamageMultiplier", handling.collisionDamageMultiplier-((handling.collisionDamageMultiplier)*0.07) )
						elseif id==6 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "collisionDamageMultiplier", handling.collisionDamageMultiplier-((handling.collisionDamageMultiplier)*0.15) )
						elseif id==7 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", ((handling.maxVelocity)*0.04)+handling.maxVelocity )
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.06)+handling.engineAcceleration )
						elseif id==8 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", ((handling.maxVelocity)*0.06)+handling.maxVelocity )
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.03)+handling.engineAcceleration )
						elseif id==9 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.10)+handling.engineAcceleration )
						elseif id==10 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", ((handling.maxVelocity)*0.14)+handling.maxVelocity )
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.02)+handling.engineAcceleration )
						elseif id==11 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "collisionDamageMultiplier", handling.collisionDamageMultiplier-((handling.collisionDamageMultiplier)*0.25) )
						elseif id==12 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "collisionDamageMultiplier", handling.collisionDamageMultiplier-((handling.collisionDamageMultiplier)*0.15) )
							setVehicleHandling(v, "maxVelocity", handling.maxVelocity-(handling.maxVelocity)*0.05 )
							setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration-((handling.engineAcceleration)*0.05) )
						elseif id==13 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration+(handling.engineAcceleration)*0.12 )
						elseif id==14 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration+(handling.engineAcceleration)*0.09 )
						elseif id==15 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "tractionBias", ((handling.tractionBias)*0.10)-handling.tractionBias )
						elseif id==16 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "tractionBias", ((handling.tractionBias)*0.07)-handling.tractionBias )
						elseif id==17 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "tractionBias", ((handling.tractionBias)*0.18)-handling.tractionBias )
							setVehicleHandling(v, "maxVelocity", handling.maxVelocity-(handling.maxVelocity)*0.06 )
							setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration-((handling.engineAcceleration)*0.06) )
						elseif id==18 then
							setElementData(v, "vehicle:folia", 1)
						elseif id==19 then
							setElementData(v, "vehicle:folia", 2)
						elseif id==20 then
							setVehicleHeadLightColor(v, 13, 134, 255)
						elseif id==21 then
							setVehicleHeadLightColor(v, 150, 255, 69)
						elseif id==22 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "brakeDeceleration", ((handling.brakeDeceleration)*0.04)+handling.brakeDeceleration )
						elseif id==23 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "brakeDeceleration", ((handling.brakeDeceleration)*0.03)+handling.brakeDeceleration )
						elseif id==24 then
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "brakeDeceleration", ((handling.brakeDeceleration)*0.03)+handling.brakeDeceleration )
						elseif id==25 then 
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", handling.maxVelocity-((handling.maxVelocity)*0.13) )
							setVehicleHandling(v, "engineAcceleration", ((handling.engineAcceleration)*0.07)+handling.engineAcceleration )
						elseif id==26 then 
							local handling=getVehicleHandling(v)
							setVehicleHandling(v, "maxVelocity", handling.maxVelocity+((handling.maxVelocity)*0.07) )
							setVehicleHandling(v, "engineAcceleration", handling.engineAcceleration-((handling.engineAcceleration)*0.04) )
						end
					end
				end
		end
	end
end


addCommandHandler("tuning", function(player,cmd,id)
	reloadOneVehicleTuning(tonumber(id))
-- outputDebugString(getElementData(getPedOccupiedVehicle(player), "dbid"))
end)