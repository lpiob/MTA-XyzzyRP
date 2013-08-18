--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--



local I
local D=7

-- klub nocny
I=2
local ped1=createPed(12,1212.49,-14.29,1000.92,270.0)
setElementInterior(ped1,I)
setElementDimension(ped1,D)
local ped2=createPed(264,1217.95,-3.63,1000.93,103.9)
setElementInterior(ped2,I)
setElementDimension(ped2,D)
local ped3=createPed(90,1214.18,-3.32,1001.33,136.5)
setElementInterior(ped3,I)
setElementDimension(ped3,D)
local ped4=createPed(85,1221.65,-6.55,1001.33,87.0)
setElementInterior(ped4,I)
setElementDimension(ped4,D)
local ped5=createPed(204,1212.37,2.42,1000.92,184.2)
setElementInterior(ped5,I)
setElementDimension(ped5,D)
local ped6=createPed(63,1213.37,-4.36,1001.33,354.5)
setElementInterior(ped6,I)
setElementDimension(ped6,D)
local ped7=createPed(39, 1219.42,-10.16,1000.92,1.1)
setElementInterior(ped7,I)
setElementDimension(ped7,D)

--PLAZA NA PALOMINO

pojazd = {}
ped = {}

I=0

--wozy
pojazd[1] = createVehicle(482, 2140.5, -71.5, 3.0999999046326, 0, 0, 66) --burrito
setVehicleOverrideLights(pojazd[1],2)

pojazd[2] = createVehicle(478, 2127.3999023438, -87.099998474121, 3, 0, 0, 303.99719238281) --walton
setVehicleOverrideLights(pojazd[2],2)

pojazd[3] = createVehicle(567, 2144.099609375, -87.69921875, 2.7999999523163, 0, 0, 159.99938964844) --savanna
setVehicleOverrideLights(pojazd[3],2)

pojazd[4] = createVehicle(513, 2110.3999023438, -122.19999694824, 15, 0, 20, 356) --stuntplane 1
setVehicleOverrideLights(pojazd[4],2)
setElementFrozen(pojazd[4], true)

pojazd[5] = createVehicle(513, 2092.1999511719, -106.30000305176, 15, 0, 331.9951171875, 283.99548339844) --stuntplane 2
setVehicleOverrideLights(pojazd[5],2)
setElementFrozen(pojazd[5], true)

pojazd[6] = createVehicle(446, 2106.8999023438, -85.800003051758, 0, 0, 26, 344) --squalo
setVehicleOverrideLights(pojazd[6],2)
setElementFrozen(pojazd[6], true)

pojazd[7] = createVehicle(454, 2125.5, -115.40000152588, 0, 0, 346, 255.99993896484) --tropic
setVehicleOverrideLights(pojazd[7],2)
setElementFrozen(pojazd[7], true)

pojazd[8] = createVehicle(508, 2135.3999023438, -90.900001525879, 3.4000000953674, 0, 0, 78) --journey
setVehicleOverrideLights(pojazd[8],2)

pojazd[9] = createVehicle(582, 2129, -72.900001525879, 2.2999999523163, 0, 0, 312) --newsvan
setVehicleOverrideLights(pojazd[9],2)

pojazd[10] = createVehicle(440, 2145.5, -80.699996948242, 3.0999999046326, 0, 0, 	286) --rumpo
setVehicleOverrideLights(pojazd[10],2)
setElementFrozen(pojazd[10], true)


--pedy
ped[1] = createPed(33, 2130.4, -78.3, 2.7, 346) --reporter
ped[2] = createPed(97, 2124.5, -101.3, 1.5) --surfer
ped[3] = createPed(45, 2110.5810546875, -116.04296875, -0.5500000119209) --plywa o_0
ped[4] = createPed(138, 2141.1025390625, -76.634765625, 3.9, 104) --babka (czerwoyn recznik)
ped[5] = createPed(138, 2134.5, -71.7, 2.3, 178) --babka (zolty recznik)
ped[6] = createPed(0, 2116.5, -92, 3.8) --motorowka 1
warpPedIntoVehicle(ped[6], pojazd[6])
ped[7] = createPed(0, 2116.5, -92, 3.8) --motorowka 2
warpPedIntoVehicle(ped[7], pojazd[7])
ped[8] = createPed(0, 2132.2, -83.9, 3) --pilot 1
warpPedIntoVehicle(ped[8], pojazd[4])
ped[9] = createPed(0, 2116.5, -92, 3.8) --pilot 2
warpPedIntoVehicle(ped[9], pojazd[5])
ped[10] = createPed(150, 2130.9267578125, -74.1025390625, 2.3989701271057, 190) --reporterczyni


for k,v in ipairs(pojazd) do
	setElementDimension(v, D)
	setElementInterior(v, I)
end	
 for k,v in ipairs(ped) do
	setElementDimension(v, D)
	setElementInterior(v, I)
end	 

setElementCollisionsEnabled(pojazd[10], false)
setVehicleDoorOpenRatio(pojazd[10], 4, 1)
setVehicleDoorOpenRatio(pojazd[10], 5, 1)

local function setAnimations()

	setPedAnimation(ped1, "DANCING", "dnce_M_b", -1, true, false )
	setPedAnimation(ped2, "DANCING", "DAN_Loop_A", -1, true, false )
	setPedAnimation(ped3, "STRIP", "strip_B", -1, true, false )
	setPedAnimation(ped4, "STRIP", "STR_C2", -1, true, false )
	setPedAnimation (ped5, "LOWRIDER", "M_smklean_loop", -1, true, false )
	setPedAnimation (ped6, "STRIP", "STR_Loop_A", -1, true, false )
	setPedAnimation (ped7, "ON_LOOKERS", "wave_loop", -1, true, false )

	setPedAnimation(ped[1], "CAMERA", "picstnd_in", -1, false, false)
	setPedAnimation(ped[2], "SKATE", "skate_idle", -1, true, false)
	setPedAnimation(ped[4], "BEACH", "bather", -1, true, false)
	setPedAnimation(ped[5], "BEACH", "Lay_Bac_Loop", -1, true, false)
	setPedAnimation(ped[10], "MISC", "bmx_talkright_loop", -1, true, false)


	giveWeapon(ped[10], 2, 1, true)
	giveWeapon(ped[1], 43, 1, true)
end

setTimer(setElementFrozen, 2000, 1, pojazd[8], true)

setTimer(setAnimations, 1000, 1)
setTimer(setAnimations, 25000, 0)