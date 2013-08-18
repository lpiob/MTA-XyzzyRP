--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--


local nieTankowalne={
  [509]=true,	-- 3x rowery
  [510]=true,
  [481]=true,  
}


local function pojazdTankowalny(veh)
  if (not isElement(veh)) then return false end
  if (getElementType(veh)~="vehicle") then return false end
  if (not getElementData(veh, "dbid")) then return false end
  if (not getElementData(veh, "paliwo")) then return false end
  local vm=getElementModel(veh)
  if nieTankowalne[vm] then return false end
  local typSilnika=getVehicleHandling(veh).engineType
  if (typSilnika=="electric") then return false end
  return true
end

local function pojazdZuzywaPaliwo(veh)
  if (not isElement(veh)) then return false end
  if (getElementType(veh)~="vehicle") then return false end
  if (not getElementData(veh, "dbid")) then return false end
  if (not getElementData(veh, "paliwo")) then return false end
  local vm=getElementModel(veh)
  if nieTankowalne[vm] then return false end

  return true
end


function getElementSpeed(element,unit)
if (unit == nil) then unit = 0 end
if (isElement(element)) then
local x,y,z = getElementVelocity(element)
if (unit=="mph" or unit==1 or unit =='1') then
return (x^2 + y^2 + z^2) ^ 0.5 * 100
else
return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
end
else
  return 0
  end
end


setTimer(function()
  local v=getPedOccupiedVehicle(localPlayer)
  if (not v) then return end
  if (not getVehicleEngineState(v)) then return end
  if (getVehicleController(v)~=localPlayer) then return end
  if (not pojazdZuzywaPaliwo(v)) then return end

  local spd=getElementSpeed(v)
  local spd=spd/4000+0.0001

  local pp=getElementData(v,"paliwo")
  if (pp and pp[2] and pp[2]>0) then
	local paliwo,bak=unpack(pp)
	paliwo=paliwo-spd
	if (paliwo<0) then paliwo=0 end
	if (paliwo<0.1) then
	  triggerServerEvent("setVehicleEngineState", v, false)
	  triggerServerEvent("broadcastCaptionedEvent", localPlayer, "W pojeździe gaśnie silnik.", 5, 5, true)
	end
	setElementData(v,"paliwo", {paliwo,bak})
  end

end, 5000, 0)


local lu=getTickCount()

-- @todo ten kod trzeba zoptymalizowac jak na serwerze bedzie >100 graczy
local function naliczPrzebieg(veh)
    local przebieg=getElementData(veh,"przebieg") or 0
    if (getTickCount()-lu>250) then
	lu=getTickCount()
	local vx,vy,vz=getElementVelocity(veh)
	local spd=((vx^2 + vy^2 + vz^2)^(0.5)/10)
	if (spd>0) then
	    przebieg=przebieg+(spd)
	    setElementData(veh, "przebieg", przebieg)
	end
    end
end

function updatePrzebieg()
    local v=getPedOccupiedVehicle(localPlayer)
    if (not v) then return end
    if (not getVehicleEngineState(v)) then return end
    if (getVehicleController(v)~=localPlayer) then return end
    naliczPrzebieg(v)
end

addEventHandler("onClientRender", root, updatePrzebieg)	