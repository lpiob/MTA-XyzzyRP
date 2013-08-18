-- 4247 platforma

-- min 
-- 1095.32, -328
-- max
-- 1314, -96
--local kopalnia_1=createColPolygon(
local kopalnia_poly={
  {x=1116.23,y=-313.45},
  {x=1129.81,y=-330.21},
  {x=1171.57,y=-320.11},
  {x=1172.28,y=-303.08},
  {x=1207.96,y=-285.51},
  {x=1257.16,y=-275.91},
  {x=1274.10,y=-296.23},
  {x=1295.55,y=-306.51},
  {x=1332.10,y=-319.11},
  {x=1372.02,y=-318.39},
  {x=1413.53,y=-311.93},
  {x=1422.30,y=-293.65},
  {x=1408.82,y=-296.17},
  {x=1390.86,y=-309.83},
  {x=1372.09,y=-302.36},
  {x=1346.27,y=-304.83},
  {x=1326.79,y=-308.69},
  {x=1307.94,y=-285.6},
  {x=1289.42,y=-277.17},
  {x=1289.18,y=-241.03},
  {x=1307.56,y=-222.91},
  {x=1300.50,y=-203.30},
  {x=1315.57,y=-180.00},
  {x=1296.08,y=-168.11},
  {x=1281.94,y=-139.96},
  {x=1258.40,y=-141.83},
  {x=1238.28,y=-124.78},
  {x=1222.47,y=-136.34},
  {x=1201.71,y=-133.27},
  {x=1183.46,y=-139.32},
  {x=1187.27,y=-157.48},
  {x=1205.52,y=-157.73},
  {x=1220.37,y=-145.16},
  {x=1233.14,y=-148.80},
  {x=1252.93,y=-144.91},
  {x=1270.90,y=-157.91},
  {x=1282.89,y=-170.82},
  {x=1291.76,y=-176.71},
  {x=1297.57,y=-206.76},
  {x=1288.89,y=-224.32},
  {x=1279.47,y=-229.68},
  {x=1275.25,y=-248.79},
  {x=1248.16,y=-266.26},
  {x=1228.34,y=-262.56},
  {x=1212.97,y=-276.28},
  {x=1167.57,y=-281.27},
  {x=1168.04,y=-294.92},
  {x=1140.11,y=-298.26},
  {x=1131.70,y=-275.14},
  {x=1110.33,y=-278.27},
--[[
{x=  1131.74,y=-291.99},
{x=  1121.61,y=-321.65},
{x=  1128.18,y=-328.70},
{x=  1170.50,y=-328.91},
{x=  1173.09,y=-308.71},
{x=  1198.33,y=-288.71},
{x=  1210.18,y=-287.54},
{x=  1229.30,y=-297.92},
{x=  1241.76,y=-284.69},
{x=  1276.35,y=-286.01},
{x=  1282.92,y=-269.64},
{x=  1299.45,y=-260.29},
{x=  1304.91,y=-237.74},
{x=  1293.92,y=-218.73},
{x=  1297.42,y=-205.54},
{x=  1314.06,y=-193.95},
{x=  1300.11,y=-185.41},
{x=  1295.03,y=-172.73},
{x=  1301.50,y=-153.67},
{x=  1282.71,y=-154.25},
{x=  1267.07,y=-139.48},
{x=  1256.27,y=-154.29},
{x=  1245.30,y=-161.22},
{x=  1226.11,y=-158.70},
{x=  1224.59,y=-181.93},
{x=  1208.18,y=-192.47},
{x=  1205.98,y=-210.18},
{x=  1196.38,y=-216.02},
{x=  1182.06,y=-219.22},
{x=  1168.19,y=-217.30},
{x=  1155.85,y=-191.39},
{x=  1141.19,y=-181.83},
{x=  1142.65,y=-155.59},
{x=  1143.47,y=-140.82},
{x=  1152.52,y=-130.41},
{x=  1171.93,y=-127.60},
{x=  1166.22,y=-105.28},
{x=  1138.01,y=-96.24},
{x=  1130.47,y=-116.25},
{x=  1114.47,y=-127.11},
{x=  1095.32,y=-130.90},
{x=  1105.85,y=-140.19},
{x=  1110.28,y=-153.07},
{x=  1101.46,y=-169.88},
{x=  1107.66,y=-185.26},
{x=  1129.06,y=-193.08},
{x=  1134.71,y=-206.09},
{x=  1125.68,y=-223.47},
{x=  1133.49,y=-242.80},
{x=  1122.34,y=-259.31}
]]--
--  1102.42,-y=267.66 -- byc moze zbedny
}            
function pointInPolygon( points, dot )
        local i, j = #points, #points
        local oddNodes = false
 
        for i=1, #points do
                if ((points[i].y < dot.y and points[j].y>=dot.y
                        or points[j].y< dot.y and points[i].y>=dot.y) and (points[i].x<=dot.x
                        or points[j].x<=dot.x)) then
                        if (points[i].x+(dot.y-points[i].y)/(points[j].y-points[i].y)*(points[j].x-points[i].x)<dot.x) then
                                oddNodes = not oddNodes
                        end
                end
                j = i
        end
 
        return oddNodes
end

local sx,sy,sz=0,0,1366

local I=1
local D=19
-- min 
-- 1095.32, -328
-- max
-- 1314, -96


--createObject(4247,sx,sy,sz-1)
--local sufit=createObject(4247,sx,sy,sz+6)
--setElementDoubleSided(sufit,true)
--createObject(3374, sx-4, sy-4, sz)
local obiektow=0
for x=1095,1314,4 do
    for y=-328,-96,4 do
	    if (math.random(1,6)>2) then
		local punkt={x=x, y=y}
		if (pointInPolygon(kopalnia_poly, punkt)) then
			local s=createObject(3374, x, y, sz+0, math.random(0,6),math.random(0,6),math.random(0,45))
			  setElementDimension(s,D)	  		
			  setElementInterior(s,I)

		if (math.random(1,3)>2) then
			s=createObject(3374, x, y, sz+3, math.random(0,6),math.random(0,6),math.random(0,45))
			  setElementDimension(s,D)	  		
			  setElementInterior(s,I)
		end


			obiektow=obiektow+1
		end
	    end
--	createObject(3374, x, y, sz+math.random(0,3), math.random(0,90), math.random(0,90), math.random(0,90))
--	createObject(3374, x, y, sz+3, math.random(0,6),math.random(0,6),math.random(0,45))
	--3347 skaly
    end
end
outputDebugString("obiektow: " .. obiektow)
--[[
for i=1,3 do
x=math.random(2,9)
y=math.random(2,9)
z=math.random(1,3)
createMarker(sx+(x-1)*4, sy+(y-1)*4,sz+z, "corona", 1, 255,255,0)
end
]]--