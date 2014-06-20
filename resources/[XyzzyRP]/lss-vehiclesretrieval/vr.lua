--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- vehicles retrieval
-- mechanizm wylawiajacy pojazdy z wody

-- 2508.15,-2629.45,13.65,91.2

--local cs=createColSphere(2625.45,-2231.66,13.55,7)
local cs=createColSphere(2747.16,-2277.38,20.82, 4)

function shuffle(t)
  local n = #t
 
  while n >= 2 do
    -- n is now the last pertinent index
    local k = math.random(n) -- 1 <= k <= n
    -- Quick swap
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
  return t
end

local function vr()

	if (#getElementsWithinColShape(cs,"vehicle")>0) then
		return
	end

	local pojazdy=getElementsByType("vehicle")

	if (#pojazdy<1) then return end


	local wybrane={}
	for _,pojazd in ipairs(pojazdy) do
		if isElementInWater(pojazd) and not getVehicleController(pojazd) then
			local x,y,z=getElementPosition(pojazd)
			if (z<-1) then
				table.insert(wybrane,pojazd)
			end
		end
	end
	if (#wybrane<1) then return end
--	for i,v in ipairs(wybrane) do
--		local dbid=getElementData(v,"dbid")
--		outputDebugString("Pojazd " .. getElementModel(v) .. (isElementInWater(v) and "woda" or "nie") .. " dbid " .. dbid)
--	end
	outputDebugString("Pojazdow w wodzie/pod mapa: " .. #wybrane)

	shuffle(wybrane)
	local pojazd=wybrane[1]
--	local x,y,z=getElementPosition(pojazd)
--	setElementPosition(pojazd, 2625.45,-2231.66,15.55)
	setElementPosition(pojazd, 2747.16,-2277.38,20.82)
	setElementFrozen(pojazd,false)
--	local rx,ry,rz=getElementRotation(pojazd)
--	setElementRotation(pojazd, rx,ry,0)

end

setTimer(vr, 35000, 0)