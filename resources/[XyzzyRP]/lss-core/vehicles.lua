--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--



-- kod od wyrzucania gracza z pojadu przy duzym uderzenu. wylaczony bo nie wyglada zbyt efektywnie (animacje)
--[[
addEvent("OnVehicleCollision",true)
addEventHandler("OnVehicleCollision", root, function(force,vx,vy,vz)
    outputChatBox("S OVC")
    local kierowca=getVehicleController(source)

    local x,y,z=getElementPosition(source)
    removePedFromVehicle(kierowca)
    setElementPosition(kierowca,x,y,z)
    setPedAnimation(kierowca, "ped","FALL_front",-1,false,true,true,false)
    setElementVelocity(kierowca, -vx,-vy,-vz)
    
end)
]]--


-- domykanie drzwi

addEventHandler ( "onVehicleEnter", getRootElement(), function(thePlayer, seat, jacked) 
	if seat==0 then
--		setVehicleDoorOpenRatio(source, 2, 0, 500)
		if (getVehicleDoorState(source,2)==0) then
		    setVehicleDoorState(source,2,1)
		    setVehicleDoorState(source,2,0)
		end
	elseif seat==1 then
		if (getVehicleDoorState(source,3)==0) then
		    setVehicleDoorState(source,3,1)
		    setVehicleDoorState(source,3,0)
		end
	else
--		if (getVehicleDoorState(source,4)==0) then
		    setVehicleDoorState(source,4,1)
		    setVehicleDoorState(source,4,0)
--		end
--		if (getVehicleDoorState(source,5)==0) then
		    setVehicleDoorState(source,5,1)
		    setVehicleDoorState(source,5,0)
--		end

	end
end)


-- wylaczenie zniszczen na pustych pojazdach

local function pojazdPusty(veh)
    local occupants = getVehicleOccupants(veh)
    local seats = getVehicleMaxPassengers(veh)
	if (not seats) then return true end
    for i=0,seats do
	local occupant = occupants[seat]
	if occupant and (getElementType(occupant)=="player" or getElementType(occupant)=="ped") then
	    return false
	end
    end
    return true
end


for i,v in ipairs(getElementsByType("vehicle")) do
    if (pojazdPusty(v)) then
        setVehicleDamageProof(v,true)
    else
	if getElementData(v,"damageproof") then setVehicleDamageProof(v, true) return end
	setVehicleDamageProof(v,false)
    end
end

addEventHandler ( "onVehicleEnter", root, function()
	if getElementData(source,"damageproof") then setVehicleDamageProof(source, true) return end
    setVehicleDamageProof(source, false)
end)

addEventHandler ( "onVehicleExit", root, function()
    if (pojazdPusty(source)) then
        setVehicleDamageProof(source, true)
    else
		if getElementData(source,"damageproof") then setVehicleDamageProof(source, true) return end
        setVehicleDamageProof(source, false)
    end
end)



-- co jakis czas przetwarzamy pojazdy i tym ktore są w ruchu i maja przebite opony, usuwamy calkiem kola (losowo)

setTimer(function()
    local pojazdy=shuffle(getElementsByType("vehicle"))
    local i2=0
    for i,v in ipairs(pojazdy) do
	i2=i2+1
	if (i2>100) then return end
	if (getVehicleEngineState(v) and getVehicleController(v)) then
	    local ws={}
	    ws[1],ws[2],ws[3],ws[4]=getVehicleWheelStates(v)
	    local change=false
	    for i2,v2 in ipairs(ws) do
		if (v2==1 and math.random(1,3)==1) then ws[i2]=2 change=true end
	    end
	    if (change) then
--		outputDebugString("zmiana")
		setVehicleWheelStates(v, ws[1],ws[2],ws[3],ws[4])
		i2=i2+25
	    end
	end
    end
end, 35000, 0)


addCommandHandler("vopis", function(plr,cmd,...)
    local opis=table.concat(arg, " ")
    if (string.len(opis)<3) then
	outputChatBox("Użyj: /vopis <opis>, lub /vopis usun", plr)
	return
    end
    local veh=getPedOccupiedVehicle(plr)
    if (not veh) then
	outputChatBox("Musisz być w pojeździe którego opis chcesz zmienić.", plr, 255,0,0)
	return
    end
    local dbid=getElementData(veh,"dbid")
    if not dbid then
	outputChatBox("Nie można zmienić opisu tego pojazdu.", plr, 255,0,0)
	return
    end
    if not exports["lss-core"]:eq_getItem(plr, 6, tonumber(dbid)) then
	outputChatBox("Nie masz kluczy od tego pojazdu.", plr, 255,0,0)
	return
    end
    if (opis=="usun" or opis=="USUN") then
	removeElementData(veh,"opis")
    else
        setElementData(veh, "opis", opis)
    end
end,false,false)