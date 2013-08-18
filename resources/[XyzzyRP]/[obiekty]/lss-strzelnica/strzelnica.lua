-- based on Shootingranch by Zipper
local srodek={ 317.97,-64.97,1001.52 }

function createTargetToShoot ( x, y, z, rx, ry, r, int, dim )

	local frame = createObject ( 1587, -321.51257324218, 826.03668212892, 17.146434783935 )
	
	local part1 = createObject ( 1592, -321.49752807616, 826.03112792967, 17.175880432128 )
	local part2 = createObject ( 1591, -321.52035522462, 826.03167724608, 17.175880432128 )
	local part3 = createObject ( 1590, -321.52151489253, 826.03161621093, 17.154172897338 )
	local part4 = createObject ( 1589, -321.49887084962, 826.03137207032, 17.155172348021 )
	local part5 = createObject ( 1588, -321.51440429687, 826.03332519532, 17.134246826173 )
	
	attachElementsInCorrectWay ( part1, frame )
	attachElementsInCorrectWay ( part2, frame )
	attachElementsInCorrectWay ( part3, frame )
	attachElementsInCorrectWay ( part4, frame )
	attachElementsInCorrectWay ( part5, frame )
	
	setElementInterior ( frame, int )
	setElementInterior ( part1, int )
	setElementInterior ( part2, int )
	setElementInterior ( part3, int )
	setElementInterior ( part4, int )
	setElementInterior ( part5, int )
	
	setElementDimension ( frame, dim )
	setElementDimension ( part1, dim )
	setElementDimension ( part2, dim )
	setElementDimension ( part3, dim )
	setElementDimension ( part4, dim )
	setElementDimension ( part5, dim )
	
	setElementPosition ( frame, x, y, z )
	setElementRotation ( frame, rx, ry, r )
	
	setElementData ( part1, "strzelnica:cel", true )
	setElementData ( part2, "strzelnica:cel", true )
	setElementData ( part3, "strzelnica:cel", true )
	setElementData ( part4, "strzelnica:cel", true )
	setElementData ( part5, "strzelnica:cel", true )
	
	setElementParent ( part1, frame )
	setElementParent ( part2, frame )
	setElementParent ( part3, frame )
	setElementParent ( part4, frame )
	setElementParent ( part5, frame )
	return frame
end


function attachElementsInCorrectWay ( element1, element2 )
	local x1, y1, z1 = getElementPosition ( element1 )
	local x2, y2, z2 = getElementPosition ( element2 )
	attachElements ( element1, element2, x1-x2, y1-y2, z1-z2 )
end

function usunCel(obiekt)
  for i,v in ipairs( getElementChildren ( obiekt ) ) do
	destroyElement(v)
  end
  destroyElement(obiekt)
end

local obiekt1
function animacja1()
  if (obiekt1 and isElement(obiekt1)) then usunCel(obiekt1) end
  local czas=500
  local rs=math.random(1,1)
  if rs==1 then
	local rczas=math.random(7000,15000)
	czas=czas+rczas
    obiekt1=createTargetToShoot(315.63,-75.41,1002.02, 0,0,90,	4,18)
    moveObject(obiekt1, rczas, 315.63,-55.00,1002.02)
  end
  setTimer(animacja1, czas, 1)
end

local obiekt2
function animacja2()
  if (obiekt2 and isElement(obiekt2)) then usunCel(obiekt2) end
  local czas=1000
  local rs=math.random(1,1)
  if rs==1 then
	local rczas=math.random(7000,11000)
	czas=czas+rczas
    obiekt2=createTargetToShoot(320.63,-55.41,1002.02, 0,0,90,	4,18)
    moveObject(obiekt2, rczas, 320.63,-75.00,1002.02)
  end
  setTimer(animacja2, czas, 1)
end




animacja1()
animacja2()

