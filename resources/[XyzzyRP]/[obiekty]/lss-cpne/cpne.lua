--[[
cpn elektryczny

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--


local deftext="Stacja ładowania\npoj. elektrycznych"

local stacje={
--  x,y,z,r,d,i, repairing=<czy ma naprawiac pojazdy>
  -- stacje na stadionie (kart)
  {2659.46,-1772.80,1427.80,0,24,1,repairing=true},
  {2656.94,-1772.80,1427.81,0,24,1,repairing=true},
  -- stacje na stadionie2 (nrg)
  {2688.17,-1778.71,3071.66,0,77,1,repairing=true},
  {2680.27,-1778.71,3071.66,0,77,1,repairing=true},
  {2672.15,-1778.71,3071.66,0,77,1,repairing=true},
  {2664.75,-1778.71,3071.66,0,77,1,repairing=true},
  
  -- stacje na stadionie (Hotring Racer)
  {2780.87,-1662.16,1440.25,0,24,1,repairing=true},
  {2768.77,-1657.16,1440.25,0,24,1,repairing=true},
  {2757.04,-1653.84,1440.27,0,24,1,repairing=true},
  {2743.66,-1652.05,1440.28,0,24,1,repairing=true},
  {2728.07,-1652.85,1440.29,0,24,1,repairing=true},
  {2716.84,-1653.97,1440.31,0,24,1,repairing=true},
  {2706.28,-1656.81,1440.32,0,24,1,repairing=true},
  {2696.50,-1660.52,1440.34,0,24,1,repairing=true},
  -- stacja w tartaku the panopticon
  {-534.95,-177.10,78.40,3, 0, 0,0, repairing=true},

}

for i,v in ipairs(stacje) do
  v.podstawa=createObject(1642,v[1],v[2],v[3]-1,0,0,0)
  setElementDimension(v.podstawa,v[5])
  setElementInterior(v.podstawa,v[6])
  setObjectScale(v.podstawa,3)
  v.slupek=createObject(1444, v[1],v[2],v[3],0,0,0)
  setElementDimension(v.slupek,v[5])
  setElementInterior(v.slupek,v[6])
  setObjectScale(v.slupek,1.5)

  v.cs=createColSphere(v[1],v[2]-1.5,v[3]-1,2.5)
  setElementDimension(v.cs,v[5])
  setElementInterior(v.cs,v[6])
  
  v.t3d=createElement("text")
  setElementPosition(v.t3d,v[1],v[2],v[3]+1)
  setElementData(v.t3d,"text",deftext)
  setElementDimension(v.t3d,v[5])
  setElementInterior(v.t3d,v[6])
end

local function poziomNaladowania(pojazd)
  if (not pojazd) then return nil end
  local paliwo=getElementData(pojazd,"paliwo")
  if not paliwo then return nil end
  return paliwo[1]/paliwo[2]*100
end
local function doladujPojazd(pojazd)
  if (not pojazd) then return nil end
  local paliwo=getElementData(pojazd,"paliwo")
  if not paliwo then return nil end
  paliwo[1]=tonumber(paliwo[1]+0.01)
  if (paliwo[1]>paliwo[2]) then paliwo[1]=paliwo[2] end
  setElementData(pojazd,"paliwo",paliwo)
  return true
end

local function stacje_spool(laduj)
  for i,v in ipairs(stacje) do
	local pojazdy=getElementsWithinColShape(v.cs,"vehicle")
	if (not pojazdy or #pojazdy==0) then
		setElementData(v.t3d,"text",deftext)
	else
		local text=deftext.."\n\n"
		for i2,v2 in ipairs(pojazdy) do
		  if (laduj and v.repairing) then
			fixVehicle(v2)
		  end
		  if (getVehicleHandling(v2).engineType=="electric") then
			  local dbid=getElementData(v2,"dbid")
			  if (laduj) then doladujPojazd(v2) end
			  if (dbid) then
				text=text..getVehicleName(v2) .." ["..dbid.."] - "..string.format("%.1f",poziomNaladowania(v2)).."%\n"
			  end

			end
		  end
		setElementData(v.t3d,"text",text)
	end
  end
end

stacje_spool()
setTimer(stacje_spool, 60000, 0, true)

addEventHandler("onColShapeHit", resourceRoot, function(el,md)
  if (not md) then return end
  if (getElementType(el)=="vehicle") then
	stacje_spool()
  end
end)

addEventHandler("onColShapeLeave", resourceRoot, function(el,md)
  if (not md) then return end
  if (getElementType(el)=="vehicle") then
	stacje_spool()
  end
end)

