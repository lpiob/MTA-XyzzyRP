--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local wybraneOgraniczenie=1
local ograniczenia={nil, 90, 50, 30, 10}

local ograniczeniaModeli={
	-- rowery
	[509]=15,
	[510]=18,
	[481]=16,

	[431]=40,
	[508]=40,
	[525]=50,
	[530]=10,
	[531]=15,
	[572]=5,
	[574]=10,
	[578]=50,
	[586]=50,
	[462]=30,
	[440]=70,
	[455]=70,
	[514]=70,
	[403]=70,
	[514]=70,
	[515]=70,
	[407]=70,
	[544]=70,
--	[571]=10,
	-- elka
--	[589]=30,
}

local ograniczeniaWsteczneModeli={
	[531]=5,	-- tractor
	[530]=5,	-- wozek widlowy
	[572]=5,	-- kosiarka
	[571]=5,	-- kart

}

local function tempomat()
	local ograniczenie=ograniczenia[wybraneOgraniczenie]

	local v=getPedOccupiedVehicle(localPlayer)
	if not v then return end
	local vm=getElementModel(v)

	if getVehicleController(v)~=localPlayer then return end

	if not isVehicleOnGround(v) then return end




	local vx,vy,vz=getElementVelocity(v)

	if not getVehicleEngineState(v) then
--		outputDebugString(getDistanceBetweenPoints2D(0,0,vx,vy))
		if getDistanceBetweenPoints2D(0,0,vx,vy)<0.1 then
			vx,vy=0,0
			setElementVelocity(v,vx,vy,vz)
			return
		end
	end

	if ograniczeniaWsteczneModeli[vm] and getControlState("brake_reverse") and math.abs(vz)<0.03 then
		-- todo sprawdzic czy pojazd jedzie do tylu!
		local actualspeed = (vx^2 + vy^2 + vz^2)^(0.5) *0.6*180
		if actualspeed>ograniczeniaWsteczneModeli[vm] then
			setElementVelocity(v,vx*0.6,vy*0.6,vz*0.9)
		end
		return
	end


	if getVehicleType(v)~="Automobile" and not ograniczeniaModeli[vm] then return end
	if ograniczeniaModeli[vm] then
		ograniczenie=ograniczeniaModeli[vm]
	end

	if not ograniczenie then return end

	local actualspeed = (vx^2 + vy^2 + vz^2)^(0.5) *0.6*180
	if actualspeed>ograniczenie then
		setElementVelocity(v,vx*0.9,vy*0.9,vz*0.9)
	end
end

setTimer(tempomat, 50, 0)
addCommandHandler("Zmniejsz ograniczenie predkosci", function()
	if isCursorShowing() or isPedDoingGangDriveby(localPlayer) then return end
	local v=getPedOccupiedVehicle(localPlayer)
	if not v then return end
	if getVehicleController(v)~=localPlayer then return end
	if not isVehicleOnGround(v) then return end



	if getVehicleType(v)~="Automobile" then return end

	wybraneOgraniczenie=wybraneOgraniczenie-1
	if wybraneOgraniczenie<1 then wybraneOgraniczenie=#ograniczenia end
	if ograniczenia[wybraneOgraniczenie] then
		outputChatBox("(( Ograniczenie prędkości ustawione na " .. ograniczenia[wybraneOgraniczenie] .. "km/h ))", 150,150,150)
	else
		outputChatBox("(( Ograniczenie prędkości wyłączone. ))", 150,150,150)
	end
end)
bindKey("mouse1","down", "Zmniejsz ograniczenie predkosci")


addCommandHandler("Zwieksz ograniczenie predkosci", function()
	if isCursorShowing() or isPedDoingGangDriveby(localPlayer) then return end
	local v=getPedOccupiedVehicle(localPlayer)
	if not v then return end
	if getVehicleType(v)~="Automobile" then return end
	if getVehicleController(v)~=localPlayer then return end
	if not isVehicleOnGround(v) then return end

	wybraneOgraniczenie=wybraneOgraniczenie+1
	if wybraneOgraniczenie>#ograniczenia then wybraneOgraniczenie=1 end
	if ograniczenia[wybraneOgraniczenie] then
		outputChatBox("(( Ograniczenie prędkości ustawione na " .. ograniczenia[wybraneOgraniczenie] .. "km/h ))", 150,150,150)
	else
		outputChatBox("(( Ograniczenie prędkości wyłączone. ))", 150,150,150)
	end
end)

bindKey("mouse2","down", "Zwieksz ograniczenie predkosci")