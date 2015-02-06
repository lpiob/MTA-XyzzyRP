--[[
vehicles retrieval - mechanizm wylawiajacy pojazdy z wody

@todo isElementInWater nie zawsze dziala dobrze po stronie serwera.
Klienci wiedzący o aucie w wodzie powinni informować o tym serwer.

@todo zamiast shuffle uzyć math.random - będzie znacznie szybsze

@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--


-- colshape w ktorym beda pojawiac sie pojazdy
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
	-- jesli jakis pojazd jest w punkcie wydawania, to nic nie robimy
	if (#getElementsWithinColShape(cs,"vehicle")>0) then
		return
	end

	local pojazdy=getElementsByType("vehicle")

	if (#pojazdy<1) then return end

	-- tworzymy liste pojazdow w wodzie
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

	outputDebugString("Pojazdow w wodzie/pod mapa: " .. #wybrane)

	-- tasujemy tą listę
	shuffle(wybrane)
	
	-- przenosimy losowy pojazd w wybrane miejsce
	local pojazd=wybrane[1]
	setElementPosition(pojazd, 2747.16,-2277.38,20.82)
	setElementFrozen(pojazd,false)
end

-- uruchamiamy powyższy mechanizm co 35s
setTimer(vr, 35000, 0)
