local spawnyNaStatku={
--    {2511.81,-2719.10-10.8,5.69+ 5.4453001022339,216.6},
--    {2503.32,-2728.08-10.8,5.68+ 5.4453001022339,270.8},
--    {2538.14,-2730.35-10.8,5.68+ 5.4453001022339,274.6},
--    {2555.14,-2729.90-10.8,5.67+ 5.4453001022339,270.8},
--    {2573.29,-2729.65-10.8,5.67+ 5.4453001022339,270.8},
--    {2595.04,-2729.35-10.8,5.68+ 5.4453001022339,270.8},
--    {2606.68,-2715.20-10.8,5.68+ 5.4453001022339,224.7},
--    {2619.93,-2715.17-10.8,5.68+ 5.4453001022339,227.4},
--    {2633.58,-2715.69-10.8,5.68+ 5.4453001022339,229.9},

{2425.13,-2614.61,14.28,270},
{2425.17,-2609.47,14.28,270},
{2425.43,-2603.95,14.29,270},
{2425.28,-2597.94,14.28,270},
{2425.18,-2592.43,14.29,270},
{2425.63,-2586.14,14.28,270},

{2443.53,-2615.72,14.28,90},
{2443.37,-2609.99,14.28,90},
{2443.22,-2604.94,14.29,90},
{2443.01,-2599.42,14.29,90},
{2442.76,-2594.09,14.28,90},
{2442.47,-2588.59,14.29,90},

{2432.36,-2593.33,14.29,180},
{2437.50,-2593.66,14.29,180},
}

local t3d=createElement("text")
setElementPosition(t3d,2449.45,-2684.48,16.35)
setElementData(t3d,"text","Przyblizony czas cumowania statku: nieznany")


function attachRotationAdjusted ( from, to )
    -- Note: Objects being attached to ('to') should have at least two of their rotations set to zero
    --       Objects being attached ('from') should have at least one of their rotations set to zero
    -- Otherwise it will look all funny
 
    local frPosX, frPosY, frPosZ = getElementPosition( from )
    local frRotX, frRotY, frRotZ = getElementRotation( from )
    local toPosX, toPosY, toPosZ = getElementPosition( to )
    local toRotX, toRotY, toRotZ = getElementRotation( to )
    local offsetPosX = frPosX - toPosX
    local offsetPosY = frPosY - toPosY
    local offsetPosZ = frPosZ - toPosZ
    local offsetRotX = frRotX - toRotX
    local offsetRotY = frRotY - toRotY
    local offsetRotZ = frRotZ - toRotZ
 
    offsetPosX, offsetPosY, offsetPosZ = applyInverseRotation ( offsetPosX, offsetPosY, offsetPosZ, toRotX, toRotY, toRotZ )
 
    attachElements( from, to, offsetPosX, offsetPosY, offsetPosZ, offsetRotX, offsetRotY, offsetRotZ )
end
 
 
function applyInverseRotation ( x,y,z, rx,ry,rz )
    -- Degress to radians
    local DEG2RAD = (math.pi * 2) / 360
    rx = rx * DEG2RAD
    ry = ry * DEG2RAD
    rz = rz * DEG2RAD
 
    -- unrotate each axis
    local tempY = y
    y =  math.cos ( rx ) * tempY + math.sin ( rx ) * z
    z = -math.sin ( rx ) * tempY + math.cos ( rx ) * z
 
    local tempX = x
    x =  math.cos ( ry ) * tempX - math.sin ( ry ) * z
    z =  math.sin ( ry ) * tempX + math.cos ( ry ) * z
 
    tempX = x
    x =  math.cos ( rz ) * tempX + math.sin ( rz ) * y
    y = -math.sin ( rz ) * tempX + math.cos ( rz ) * y
 
    return x, y, z
end


local o_statek={}
-- laczymy obiekty

table.insert(o_statek,createObject(10771,-2334.8271484375,2159.9179687500,5.4443907738,0.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(11146,-2334.2656250000,2168.9072265625,12.2879123688,0.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(11145,-2334.8190917969,2222.7988281250,4.2565255165,0.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(10770,-2342.3728027344,2156.6906738281,38.6790847778,0.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(11148,-2334.8156738281,2168.9067382813,12.8799142838,0.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(11147,-2333.9990234375,2220.5000000000,5.0787291527,0.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(11149,-2340.0217285156,2165.9970703125,11.9830455780,0.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(3570,-2342.9560546875,2175.5852050781,6.8713197708,270.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(11374,-2340.0195312500,2165.9968261719,11.9788455963,0.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(10772,-2334.9995117188,2158.5732421875,17.2816219330,0.0000000000,0.0000000000,270.0000000000))

table.insert(o_statek,createObject(11400,-2331.5747070313,2091.5808105469,13.0930585861,0.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(11401,-2327.4897460938,2250.0322265625,4.8058004379,0.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(11406,-2330.7888183594,2196.7580566406,5.4569334984,0.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(11237,-2342.3708496094,2154.0649414063,38.6756210327,0.0000000000,0.0000000000,270.0000000000))
table.insert(o_statek,createObject(3115,-2334.8212890625,2258.9370117188,16.9437255859,0.0000000000,0.0000000000,270.0000000000))

winda_w_statku=o_statek[#o_statek]
winda_w_porcie=createObject(3115, 2658,-2722.3-10.8, 11.5+5.4453001022339,0,0,180)
setElementAlpha(winda_w_porcie, 0)
setElementCollisionsEnabled(winda_w_porcie,false)
setElementID(winda_w_porcie,"winda_w_porcie")


local x,y,z=getElementPosition(o_statek[1])
local rx,ry,rz=getElementRotation(o_statek[1])
for i=2,#o_statek do
--  local ex,ey,ez=getElementPosition(o_statek[i])
--  local erx,ery,erz=getElementRotation(o_statek[i])
  attachRotationAdjusted(o_statek[i],o_statek[1])
--  attachElements(o_statek[i],o_statek[1],ex-x,y-ey,ez-z, rx-erx, ry-ery, erz-rz)
end

setElementRotation(o_statek[1],0,0,180)
setElementPosition(o_statek[1],10558.90,-2722.28-10.8,0+5.4453001022339)

statek_w_porcie=false
--CZAS_ANIMACJI=360000*8
--CZAS_OCZEKIWANIA=60000*600 -- 300 minut
CZAS_ANIMACJI=3600
CZAS_OCZEKIWANIA=1000

-- 2679.16,-2699.56,29.34,96.0
-- 2431.06,-2740.30,5.14,273.4
local statek_cs=createColCuboid(2431.06,-2740-10.8,-3, 248,35, 20+5.4453001022339)

local function statek_przyplynal()
  setElementCollisionsEnabled(winda_w_statku,false)
  setElementAlpha(winda_w_statku, 0)
  setElementCollisionsEnabled(winda_w_porcie,true)
  setElementAlpha(winda_w_porcie, 255)

  setElementData(t3d,"text","")

    local pojazdy=listaPojazdowDoImportu()
    if (not pojazdy or #pojazdy<5) then return false end	-- minimalnie 5 pojazdow aby statek przyplynal
    for i,v in ipairs(pojazdy) do
	outputDebugString("i " .. i ..", v: " .. v)
	local dbid=exports["lss-vehicles"]:createVehicleEx(tonumber(v),spawnyNaStatku[i][1],spawnyNaStatku[i][2],spawnyNaStatku[i][3],0,0,spawnyNaStatku[i][4])
	if (dbid and tonumber(dbid)) then
	    exports["lss-pojemniki"]:insertItemToContainer(525, 6, 2, tonumber(dbid))
	end
    end
    exports.DB:zapytanie("DELETE FROM lss_importpojazdow")


end

local function statek_przyplywa()

--    if (math.random(1,20)~=1) then return false end
    local pojazdy=listaPojazdowDoImportu()
    if (not pojazdy or #pojazdy<5) then return false end	-- minimalnie 5 pojazdow aby statek przyplynal    

	setElementAlpha(winda_w_porcie, 0)
	setElementCollisionsEnabled(winda_w_porcie,false)

	stopObject(o_statek[1])
    setElementRotation(o_statek[1],0,0,180)
	setElementPosition(o_statek[1],10558.90,-2722.28-10.8,0+ 5.4453001022339)
    moveObject(o_statek[1], CZAS_ANIMACJI, 2558.90,-2722.28-10.8,0+5.4453001022339,0,0,0,"OutQuad")
	setTimer(statek_przyplynal, CZAS_ANIMACJI, 1)
	local czas=getRealTime()
	czas.timestamp=czas.timestamp+CZAS_ANIMACJI/1000+math.random(30,90)
	czas=getRealTime(czas.timestamp)
	setElementData(t3d,"text",string.format("Przyblizony czas cumowania statku: %02d:%02d",czas.hour,czas.minute))
	return true
end
local function czy_statek_pusty()
  local gracze=getElementsWithinColShape(statek_cs,"player")
  if (gracze and #gracze>0) then return false end
  local pojazdy=getElementsWithinColShape(statek_cs,"vehicle")
  if (pojazdy and #pojazdy>0) then return false end
  return true
end
local function statek_odplywa()

	if (not czy_statek_pusty()) then return false end
	setElementCollisionsEnabled(winda_w_statku,true)
	setElementAlpha(winda_w_statku, 255)
	setElementCollisionsEnabled(winda_w_porcie,false)
	setElementAlpha(winda_w_porcie, 0)



  	stopObject(o_statek[1])
	setElementRotation(o_statek[1],0,0,180)
	setElementPosition(o_statek[1],2558.90,-2722.28-10.8,0+ 5.4453001022339)
	moveObject(o_statek[1], CZAS_ANIMACJI, -6468.90,-4722.28-10.8,0+5.4453001022339,0,0,50,"InQuad")
	return true
end

local function statek_spool()
  local czas=CZAS_OCZEKIWANIA
  if (not statek_w_porcie) then
	if statek_przyplywa() then statek_w_porcie=not statek_w_porcie czas=czas+CZAS_ANIMACJI end
  else
	if statek_odplywa() then statek_w_porcie=not statek_w_porcie czas=czas+CZAS_ANIMACJI end
  end
  
  setTimer(statek_spool, czas, 1)
end

statek_spool()

--[[
function statekOdplywa()
  moveObject(o_statek[1], 3600000, -6468.90,-4722.28-10.8,0+ 5.4453001022339,0,0,50,"InQuad")
end
addCommandHandler("sod", statekOdplywa,false,false)
]]--


--moveObject(o_statek[1], 311337, -6468.90,-4722.28,0)

--moveObject(o_statek[1], 31337, 2955.75,-2300.60,13.17, 0,0, 900, "OutInBounce")

-- triggerServerEvent("poruszWinda", resourceRoot, stan)

addEvent("poruszWinda", true)
addEventHandler("poruszWinda", resourceRoot, function(stan)
  stopObject(winda_w_porcie)
  if (stan) then
	moveObject(winda_w_porcie, 10000, 2658,-2722.3-10.8, 11.5+ 5.4453001022339, 0,0,0, "OutInQuad")
  else
	moveObject(winda_w_porcie, 10000, 2658,-2722.3-10.8, 4.5+ 5.4453001022339, 0,0,0, "OutInQuad")
  end
end)