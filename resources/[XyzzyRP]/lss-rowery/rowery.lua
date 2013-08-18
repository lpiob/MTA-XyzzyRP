--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- bike 509


local MAX_DIST=3	-- powinno byc ustawione na taka sama wartosc jak promien colsphere w rowery_c.lua

-- uwaga te dane muszą być powtórzone w pliku rowery_c.lua
local wypozyczalnie={
    lotnisko={	1682.78,-2298.91,12.53,0 },
    ratusz={ 1479.76,-1603.43,12.40, 0 },
    litlemexico={ 1804.51,-1641.41,12.52,90.0 },
    veronabeach={ 1133.97,-1688.90,12.78,180.0 },
    santamariabeach={ 387.10,-2056.04,6.84,0 },
	grovestreet={ 2423.27,-1674.14,12.65,0 },
    kurierzy={ 678.18,-1302.39,12.62, 90 },
	skatepark={ 1866.52,-1395.18,12.50,90 },
	naukajazdy={ 983.82,-1303.85,12.38,180 },
	lascolinas={ 2146.04,-1105.40,24.48,160.3 },
	temple={ 1004.02,-948.40,41.28,7.2 },
	port={ 2758.72,-2390.23,12.63,0 },
	wysypisko={ 664.29,-678.81,15.34,0 },
	palamino={ 2255.71,-83.73,25.52,0 },
	blueberry={ 245.22,-151.41,0.58,90 },
	montgomery={ 1341.29,282.57,18.56,66 },
}

function wypozyczalnia_process(v)
    v.cs=createColSphere(v[1],v[2],v[3],MAX_DIST)
    -- zamrazamy wszystkie pojazdy stojące w wypozyczalni - aby gracze nie mogli przepchnac ich poza jej teren
    local pojazdy=getElementsWithinColShape(v.cs,"vehicle")
    for i,v in ipairs(pojazdy) do
	local vm=getElementModel(v)
	if (vm==509 or vm==510 or vm==481) then
	    if (not getVehicleController(v) and getElementData(v,"dbid")) then
		setElementFrozen(v,true)
	    end
	end
    end
end

for i,v in pairs(wypozyczalnie) do
    wypozyczalnia_process(v)
end


function check_vexit(vehicle,player)
    if (getElementDimension(vehicle)~=0 or getElementInterior(vehicle)~=0) then return end
    local x,y,z=getElementPosition(vehicle)
    for i,v in pairs(wypozyczalnie) do
	if (getDistanceBetweenPoints3D(x,y,z,v[1],v[2],v[3])<=MAX_DIST) then
	    -- gracz wysiadl z roweru na terenie wypozyczalni
	    setElementFrozen(vehicle,true)
	    setVehicleLocked(vehicle,true)
	    exports["lss-vehicles"]:veh_save(vehicle)
	    triggerEvent("broadcastCaptionedEvent", player, getPlayerName(player).." parkuje rower i wyciąga z niego monetę.", 5,35,true)
        exports["lss-admin"]:outputLog("ODSTAWIENIEROWERU " .. getPlayerName(player))
	    givePlayerMoney(player,3)
	end
    end
end

function check_venter(vehicle,player)
    if (getElementDimension(vehicle)~=0 or getElementInterior(vehicle)~=0) then return end
    local x,y,z=getElementPosition(vehicle)
    for i,v in pairs(wypozyczalnie) do
	if (getDistanceBetweenPoints3D(x,y,z,v[1],v[2],v[3])<=MAX_DIST) then
	    -- gracz wsiadl na rower na terenie wypozyczalni
	    takePlayerMoney(player,7)
--[[
	    if (getPlayerMoney(player)<500) then
			outputChatBox("Nie stać Cię na wypożyczenie roweru.",player)
--			cancelEvent()
--			removePedFromVehicle(player)
			return
	    end
]]--

	    setElementFrozen(vehicle,false)
	    setVehicleLocked(vehicle,false)
--	    exports["lss-vehicles"]:veh_save(vehicle)
	    triggerEvent("broadcastCaptionedEvent", player, getPlayerName(player).." wrzuca monetę i wypożycza rower.", 5,35,true)
		exports["lss-achievements"]:checkAchievementForPlayer(player, "rower")
	else
		setElementFrozen(vehicle, false)
	end
    end
end

addEventHandler("onColShapeHit", resourceRoot, function(el,md)
    if (not md) then return end

    
    if (getElementType(el)~="vehicle") then return end
    local em=getElementModel(el)
    if (getVehicleController(el)) then
	return
    end
    if (em==509 or em==510 or em==481) then
	
	-- na parkingu pojawil sie rower bez kierowcy - np. wykonano restart zasobu lss-vehicles, badz ktos tam rower wepchnal
	setElementFrozen(el,true)
    end
end)

addEventHandler ( "onVehicleExit", getRootElement(), function(player,seat)
    if (seat~=0) then return end
    local vm=getElementModel(source)
    if (vm==509 or vm==510 or vm==481) then
	check_vexit(source,player)
    end
end )

local function rowerNaTerenieWypozyczalni(rower)
    local x,y,z=getElementPosition(rower)
    for i,v in pairs(wypozyczalnie) do
	if (getDistanceBetweenPoints3D(x,y,z,v[1],v[2],v[3])<=MAX_DIST) then
	    return true
	end
    end
    return false
end

addEventHandler ( "onVehicleStartEnter", getRootElement(), function(player,seat,jacked)
    if (seat~=0) then return end
    local vm=getElementModel(source)
    if (vm==509 or vm==510 or vm==481) then
		if (jacked) then	-- nie pozwalamy na nj rowerow
		    cancelEvent()
		end
		if (not rowerNaTerenieWypozyczalni(source)) then return end    
		if (getPlayerMoney(player)<7) then
			outputChatBox("Nie stać Cię na wypożyczenie roweru!", player, 255,0,0,true)
			cancelEvent()
		end
	end

end)

addEventHandler ( "onVehicleEnter", getRootElement(), function(player,seat)
    if (seat~=0) then return end
    local vm=getElementModel(source)
    if (vm==509 or vm==510 or vm==481) then
		check_venter(source,player)
    end
    
end)

