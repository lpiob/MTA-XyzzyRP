-- 2057.07,-1835.52,14.91,101.2
-- 2070.08,-1827.47,13.55,306.4

local lakiernia_cs=createColCuboid(2059.24,-1835.52,13, 9, 3, 3) -- w centrum (niczyja lakiernia)
local lakiernia_cs2=createColCuboid(2253.99,-140.65,26, 9,3,3) -- warsztat Palomino Creek
--local lakiernia_cs3=createColCuboid(642,-111,24, 6.5, 10, 3) -- warsztat Fern Ridge
--local lakiernia_cs4=createColCuboid(648.5,-111,24, 6.5, 10, 3) -- warsztat Fern Ridge

--local lakiernia_cs5=createColCuboid(1221.44,256.37,19.10, 5, 5, 1.6) -- warsztat Montgomery
local lakiernia_cs6=createColCuboid(116.19,-200.79,1.01, 6, 6.5, 1.6) -- warsztat Blueberry
local lakiernia_cs7=createColCuboid(109.09,-200.80,1.01, 6, 6.5, 1.6) -- warsztat Blueberry
local lakiernia_cs8=createColCuboid(2059.24,-1830.33, 13, 9, 3, 3) -- w centrum (niczyja lakiernia)
local lakiernia_cs9=createColCuboid(2254.04,-135.65,26, 9,3,3) -- warsztat Palomino Creek

-- 641.88,-111.99,27.02,90.6
-- 647.98,-101.50,25.93,325.2
local function wlakierni(hitElement)

  if (isElementWithinColShape(hitElement, lakiernia_cs) or isElementWithinColShape(hitElement, lakiernia_cs2) or isElementWithinColShape(hitElement, lakiernia_cs6)) then
	  return true,1
  elseif (isElementWithinColShape(hitElement, lakiernia_cs7) or isElementWithinColShape(hitElement, lakiernia_cs8) or isElementWithinColShape(hitElement, lakiernia_cs9)) then
	  return true,2
  end
  
  return false
end

function malowanie(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
	if (weapon~=41) then return end
	if not hitElement then return end
	local inside,ktora=wlakierni(hitElement)
	if (hitElement and getElementType(hitElement)=="vehicle" and inside) then
		local spraycolor=getElementData(localPlayer,"spray:color")
		if (spraycolor) then
			triggerServerEvent("onCarPainting", hitElement, math.floor(spraycolor/65536), math.floor(spraycolor/256%256), spraycolor%256, ktora)
		end
	end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), malowanie)