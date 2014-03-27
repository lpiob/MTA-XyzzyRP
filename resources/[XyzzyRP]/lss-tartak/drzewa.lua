--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- sciete 1463 (dyn) 

-- 984, 3275,
-- ogrodzenie

-- -438.73,-206.80,73.98,15.3
-- -586.51,-28.07,64.32,105.8
local strefa=createColCuboid(-586,-206, 50, 160, 198, 40)
setElementID(strefa,"tartak:cs")

addEventHandler("onColShapeHit", strefa, function(el,md)
	if not md then return end
	if getElementType(el)~="player" then return end
end)

addEventHandler("onColShapeLeave", strefa, function(el,md)
	if not md then return end
	if getElementType(el)~="player" then return end
	takeWeapon(el,9)

end)


local maleDrzewa={ 618, 617, 700} -- te tez sie nadaja 776, 732, 730, 729 
local duzeDrzewa={ 616, 615, 734, 733, 726}
local scieteDrzewa={ 848, 847,  834, 832, 831 }

local punkty={	-- pozycje z /gp, zostana pozniej obnizone o 1.3 przez kod automatycznie
	{-461.52,-148.38,73.47},
	{-457.87,-154.04,74.61},
	{-455.41,-163.37,76.78},
	{-448.47,-159.67,75.40},
	{-447.23,-139.58,70.04},
	{-452.06,-129.05,66.13},
	{-444.39,-122.48,64.11},
	{-451.17,-107.18,61.60},
	{-447.29,-99.55,60.25},
	{-455.83,-92.08,59.58},
	{-458.88,-83.95,59.76},
	{-452.16,-81.03,59.51},
	{-448.80,-74.99,59.41},
	{-440.93,-79.68,59.05},
	{-439.28,-91.01,58.91},
	{-439.66,-104.82,60.75},
	{-448.12,-118.93,63.36},
	{-463.11,-50.33,59.96},
	{-458.94,-46.21,59.94},
	{-464.86,-43.94,59.96},
	{-473.19,-51.01,60.12},
	{-479.17,-41.73,60.00},
	{-490.81,-46.27,60.29},
	{-495.38,-49.95,60.42},
	{-519.18,-40.83,61.54},
	{-524.98,-47.41,62.14},
	{-532.10,-43.61,62.62},
	{-538.22,-46.68,63.08},
	{-543.03,-44.82,63.38},
	{-551.88,-38.86,63.93},
	{-528.71,-39.62,62.27},
	{-519.95,-50.17,61.80},
	{-457.65,-138.68,70.13},
	{-468.58,-141.06,71.56},
	{-474.94,-149.34,74.34},
	{-477.03,-139.00,71.09},
	{-485.12,-134.01,69.43},
	{-488.93,-141.82,72.75},
	{-494.08,-138.39,71.59},
	{-496.39,-132.94,69.49},
	{-493.71,-124.51,66.74},
	{-497.99,-117.62,65.06},
	{-494.35,-113.84,64.47},
	{-482.84,-112.51,63.77},
	{-524.48,-114.92,65.32},
	{-539.14,-116.10,66.27},
	{-546.40,-107.43,63.89},
	{-547.81,-98.72,63.48},
	{-554.42,-75.63,63.63},
	{-563.47,-74.26,64.17},
	{-578.66,-38.70,65.03},
	{-571.41,-41.95,64.71},
	{-563.26,-38.35,64.40},
	{-553.67,-43.80,63.96},
	{-546.08,-39.96,63.62},
	{-526.75,-26.69,60.45},
	{-533.78,-19.86,61.31},
	{-544.67,-23.69,63.14},
	{-551.14,-16.59,63.12},
	{-563.09,-22.91,63.64},
	{-580.88,-15.88,63.61},
	{-590.11,-35.18,64.25},
	{-590.01,-19.22,63.48},
	{-521.32,-15.93,59.24},
	{-493.14,-17.21,56.79},
	{-528.17,-129.33,69.44},
	{-528.17,-129.33,69.44},
	{-534.15,-137.96,73.15},
	{-543.51,-131.48,70.93},
	{-555.05,-132.30,71.76},
	{-566.87,-150.80,77.32},
}

local function czyMaleDrzewo(obiekt)
	local model=getElementModel(obiekt)
	for i,v in ipairs(maleDrzewa) do
		if v==model then return true end
	end
	return false
end

local function czyScieteDrzewo(obiekt)
	local model=getElementModel(obiekt)
	for i,v in ipairs(scieteDrzewa) do
		if v==model then return true end
	end
	return false
end

local function moznaSadzic(x,y,z)
	local cs=createColSphere(x,y,z,2)
	local el=getElementsWithinColShape(cs)
	destroyElement(cs)
	if #el>0 then return false end
	return true
end

local function drzewaSpool()	-- funkcja ktora sadzi drzewa i powoduje ich wzrost
	for i,v in ipairs(punkty) do
		if math.random(1,4)==1 then
			if not v.obiekt or not isElement(v.obiekt) or getElementType(v.obiekt)~="object" then	-- sadzimy male drzewko
				if moznaSadzic(v[1],v[2],v[3]-0.5) then
					local oid=maleDrzewa[math.random(1,#maleDrzewa)]
					v.obiekt=createObject(oid, v[1],v[2],v[3]-1.3)
					setObjectScale(v.obiekt,0.4)
				end
			elseif czyMaleDrzewo(v.obiekt) then
				local skala=getObjectScale(v.obiekt)
				if skala<0.99 then
					setObjectScale(v.obiekt,skala+0.2)
				else
					-- zmieniany na duze drzewo
					local oid=duzeDrzewa[math.random(1,#duzeDrzewa)]
					setElementModel(v.obiekt,oid)
--					setElementData(v.obiekt,"customAction",{label="Zetnij",resource="lss-tartak",funkcja="menu_zetnij",args={drzewo=v.obiekt}})
                    setElementData(v.obiekt,"tartak:drzewo", true)

				end
			elseif czyScieteDrzewo(v.obiekt) then
				-- usuwamy sciete drzewo
				destroyElement(v.obiekt)
				v.obiekt=nil
			end
		end
	end
end

--setTimer(drzewaSpool, 120000,0)
setTimer(drzewaSpool, 41000,0)

addCommandHandler("drzewaspool", drzewaSpool)

-- triggerServerEvent("scieteDrzewo", scinane_drzewo)
addEvent("scieteDrzewo", true)
addEventHandler("scieteDrzewo", resourceRoot, function()

	local x,y,z=getElementPosition(source)
	destroyElement(source)
	local obiekt=createObject(1463,x,y,z+0.8)
	setElementData(obiekt, "tartak:wood:owner", client)
	triggerClientEvent("setObjectBreakable", obiekt, false)
	setPedAnimation(client)
	setTimer(function(obiekt) if obiekt and (getElementType(obiekt)=="object") then setElementData(obiekt, "tartak:wood:owner", false) end end, 60000, 1, obiekt)
end)