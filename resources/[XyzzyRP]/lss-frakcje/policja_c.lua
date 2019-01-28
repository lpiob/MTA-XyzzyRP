--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@author MrDadosz <mrdadosz@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--
local lagTimer

local function checkLagTimer()
  if isTimer(lagTimer) then
	return false
  end
  lagTimer = setTimer(function() end, 1000, 1)
  return true
end

local function follow()
	local dokogo=getElementData(localPlayer,"kajdanki")
	if (not dokogo or not isElement(dokogo)) then
      triggerEvent("onKajdankiRozkuj", localPlayer)
	  triggerServerEvent("onKajdankiZakuj", resourceRoot, nil, localPlayer)
	  return
	end

	if (getPedOccupiedVehicle(dokogo) and not getPedOccupiedVehicle(localPlayer)) or (getPedOccupiedVehicle(dokogo) and getPedOccupiedVehicle(localPlayer) and getPedOccupiedVehicle(dokogo) ~= getPedOccupiedVehicle(localPlayer)) then -- zakuwający jest w aucie a zakuwany nie / zawukający jest w aucie a zakuwany jest w innym
      if not checkLagTimer() then return end
	  triggerServerEvent("onKajdankiWejsciePojazd", resourceRoot)
	elseif (not getPedOccupiedVehicle(dokogo) and getPedOccupiedVehicle(localPlayer)) then -- zakuwający wyszedł z pojazdu
      triggerServerEvent("onKajdankiWyjsciePojazd", resourceRoot)
	elseif getElementInterior(dokogo)~=getElementInterior(localPlayer) or getElementDimension(dokogo)~=getElementDimension(localPlayer) then
	  if not checkLagTimer() then return end
	  triggerServerEvent("onKajdankiZmiana", resourceRoot)
	  return
	end


	local x,y,z=getElementPosition(dokogo)
	local x2,y2,z2=getElementPosition(localPlayer)
	local kat=0
	kat=math.deg(math.atan(-1*(x2-x)/(y2-y)))
	if (y2-y)<0 then
		kat=kat+180.0
	end
	kat=(kat+180)%360

	setPedRotation(localPlayer, kat)
	local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
	if (dist<1) then
		setControlState("forwards", false)
	else
		setControlState("forwards", true)
	end
	if (dist>30) then
	  setElementPosition(localPlayer, x+math.random(-1,1), y+math.random(-1,1), z+math.random(0,10)/10)
	  return
	end
	if (dist>2) then
		setControlState("sprint", true)
		setControlState("walk", false)
	else
		setControlState("walk", true)
		setControlState("sprint", false)
	end
--	setPedAnimation(localPlayer, "ped" ,"WALK_csaw",  0, true, true, true )
--	triggerServerEvent("spac", localPlayer)
end


function menu_zakuj(args)
  local x,y,z=getElementPosition(localPlayer)
  local x2,y2,z2=getElementPosition(args.with)
  if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>5) then
	outputChatBox("Podejdź bliżej.", 255,0,0,true)
	return
  end
  triggerServerEvent("onKajdankiZakuj", resourceRoot, localPlayer, args.with)
end

addEvent("onKajdankiZakuj", true)
addEventHandler("onKajdankiZakuj", resourceRoot, function()
  addEventHandler("onClientPreRender", root, follow)
end)

addEvent("onKajdankiRozkuj", true)
addEventHandler("onKajdankiRozkuj", resourceRoot, function()
  removeEventHandler("onClientPreRender", root, follow)
  triggerServerEvent("setPedAnimation", localPlayer)
end)


local obecnie=getElementData(localPlayer, "kajdanki")
if (obecnie and isElement(obecnie)) then
  addEventHandler("onClientPreRender", root, follow)
end
