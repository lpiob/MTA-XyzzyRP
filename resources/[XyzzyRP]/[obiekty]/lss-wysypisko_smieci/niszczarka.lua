
local niszczarka={
  createObject(5259,661.56188964844,-569.76580810547,27.163105010986,0,180,0),
  createObject(5259,661.51794433594,-561.80981445313,23.665925979614,0,0,0),
  createObject(5259,661.52172851563,-561.80590820313,27.159378051758,0,180,0),
  createObject(5259,661.517578125,-569.7578125,23.677919387817,0,0,0),
}

niszczarka.cs=createColCuboid(656,-574,15,11, 16, 5)

-- 665.59,-557.79,16.33,252.5
-- 656.36,-574.56,16.34,184.9

do
  local x1,y1,z1=getElementPosition(niszczarka[1])
  for i=2,#niszczarka do
    local x2,y2,z2=getElementPosition(niszczarka[i])
    attachElements(niszczarka[i],niszczarka[1],x2-x1,y2-y1,z2-z1)
  end
end

niszczarka.wruchu=false

niszczarka.aktywuj=function()
  if (niszczarka.wruchu) then return false end
  niszczarka.wruchu=true
  local x,y=getElementPosition(niszczarka[1])
  moveObject(niszczarka[1],250,x,y,20.5)
  setTimer(function()
	for i,v in ipairs(getElementsWithinColShape(niszczarka.cs)) do
	  local et=getElementType(v)
	  if (et=="vehicle" or et=="player" or et=="ped") then
			if (et=="vehicle") then  setVehicleDamageProof(v,false) end
			local ex,ey,ez=getElementPosition(v)
			createExplosion(ex,ey,ez,math.random(0,5))
			createExplosion(ex+math.random(-10,10)/10,ey+math.random(-10,10)/10,ez-0.5,math.random(0,5))
	  end
	end
  end, 200, 1)
  setTimer(function()
	-- usuwamy pojazdy w strefie pod niszczarka
	for i,v in ipairs(getElementsWithinColShape(niszczarka.cs,"vehicle")) do
		local dbid=tonumber(getElementData(v,"dbid"))
		if (dbid) then
			exports["lss-vehicles"]:unregisterVehicle(dbid)
		end
		destroyElement(v)
	end
  end, 500, 1)
  setTimer(function()
	moveObject(niszczarka[1],5000,x,y,27.1631)
  end, 750, 1)
  setTimer(function()
	niszczarka.wruchu=false
  end, 6000, 1)
end


addCommandHandler("drutynastosie", niszczarka.aktywuj)