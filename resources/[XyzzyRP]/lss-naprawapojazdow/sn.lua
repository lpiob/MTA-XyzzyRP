--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author RacheT <rachet@pylife.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- uniwersalny kod wspoldzielony pomiedzy warsztatami

local strefyNapraw={

	--idlewood
  warsztatIdlewoodStanowsko11={
    cuboid={1846.96, -1784.89, 14.1, 5, 9, 6 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={1854.92,-1780.84,12.55}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id=3, -- id frakcji ktora ma do tego dostep
  },
  
  warsztatIdlewoodStanowsko12={
    cuboid={1846.96, -1775.17, 14.1, 5, 9, 6 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={1854.44,-1772.43,12.65}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id=3, -- id frakcji ktora ma do tego dostep
  },
  
  warsztatIdlewoodStanowsko2={
    cuboid={1892.99, -1784.89, 14.1, 5, 21, 6 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={1900.45,-1779.93,12.55}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id=3, -- id frakcji ktora ma do tego dostep
  },
  
  
	--montgomery
  warsztatMontgomeryStanowsko1={
    cuboid={1184.08,253.10,19.63, 8, 6, 6 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={1182.39,253.35,18.53}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id=18, -- id frakcji ktora ma do tego dostep
  },
  warsztatMontgomeryStanowsko2={
    cuboid={1187.19,260.38,19.63, 8, 6, 6 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={1185.23,261.67,18.53}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id=18, -- id frakcji ktora ma do tego dostep
  },
  warsztatMontgomeryStanowsko3={
    cuboid={1190.69,267.41,19.63, 8, 6, 6 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={1188.04,268.48,18.53}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id=18, -- id frakcji ktora ma do tego dostep
  },
  
	--fernridge
  warsztatFernridgeStanowsko1={
    cuboid={625.54,-112.51,26, 6, 14, 6 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={634.07,-120.03,24.49}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id=12, -- id frakcji ktora ma do tego dostep
  },
  
	--blueberry
  warsztatBlueberryStanowsko1={
    cuboid={98.99,-200.74,1.63, 5, 14, 6 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={105.87,-182.61,0.63}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id=19, -- id frakcji ktora ma do tego dostep
  },
  
  warsztatBlueberryStanowsko2={
    cuboid={83.09,-200.69,1.63, 5, 14, 6 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={91.86,-186.84,0.63}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id=19, -- id frakcji ktora ma do tego dostep
  },
  
	--palomino creek
  warsztatPalominoStanowsko1={
    cuboid={2322.59,-192.69,26.49, 5, 14, 6 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={2320.13,-177.73,25.49}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id=13, -- id frakcji ktora ma do tego dostep
  },
  
  warsztatPalominoStanowsko2={
    cuboid={2305.99,-192.79,26.50, 5, 14, 6 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={2303.40,-174.48,25.50}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id=13, -- id frakcji ktora ma do tego dostep
  },
  
  warsztatPalominoStanowsko3={
    cuboid={2289.70,-192.82,26.50, 6, 14, 6 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={2297.36,-175.18,25.50}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id=13, -- id frakcji ktora ma do tego dostep
  },
  
  
  
  
}

for i,v in pairs(strefyNapraw) do
  v.cs=createColCuboid(unpack(v.cuboid))
  v.marker=createMarker(v.mpos[1], v.mpos[2], v.mpos[3], "cylinder", 1, 0,0,0,100)
  setElementData(v.marker,"cs",v.cs)
  setElementData(v.marker,"faction_id",v.faction_id)
  
end

--   triggerServerEvent("naprawaElementu", resourceRoot, naprawiany_pojazd, czesc, koszt)
addEvent("naprawaElementu", true)
addEventHandler("naprawaElementu", resourceRoot, function(pojazd, czesc, koszt)
  outputDebugString("Naprawa elementu " .. czesc .. " za " .. koszt)
  if koszt>getPlayerMoney(client) then
    return
  end

  if (czesc==-1) then
--    setElementHealth(pojazd, 1000)

    local vps={}
    local vds={}
    local vls={}

    for i=0,6 do          vps[i]=getVehiclePanelState(pojazd,i)     end
    for i=0,3 do          vds[i]=getVehicleDoorState(pojazd,i) end
    for i=0,3 do          vls[i]=getVehicleLightState(pojazd,i) end

    fixVehicle(pojazd)

    for i=0,6 do      setVehiclePanelState(pojazd, i, vps[i])    end
    for i=0,3 do      setVehicleDoorState(pojazd, i, vds[i])    end
    for i=0,3 do      setVehicleLightState(pojazd, i, vls[i])    end

    triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
  elseif czesc>=0 and czesc<=6 then
    setVehiclePanelState(pojazd, czesc, 0)
    triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
  elseif czesc>=10 and czesc<20 then
    local drzwi=czesc-10
    setVehicleDoorState(pojazd, drzwi, 0)
    triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
  elseif czesc>=20 then
    local swiatlo=czesc-20
    setVehicleLightState(pojazd, swiatlo, 0)
    triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
  end
end)