--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- 1453 sciete
-- 2901 sciete
-- 806,818, 855, 

--[[local pola={
  {type="points", { 
	  {2.72,-17.96,3.12},
	  {2.37,-22.78,3.12},
	  {-2.68,-22.91,3.12},
	  {-2.84,-18.33,3.12},
	}}
}]]--

local linie={
--	  {{-5.45,-4.94,2.12},{-12.29,-19.85,2.12}},
--	{{-38.72,-109.15,2.12},{-8.86,-26.73,2.12}},

--[[
  {{20.04,65.82,3.12},{10.12,36.05,3.12}},
  {{26.82,62.98,3.12},{14.57,27.80,3.12}},
  {{33.50,61.12,3.12},{18.76,19.77,3.12}},
]]--

}
for i=0,8 do
  table.insert(linie, {{20+8*i,65-i*4,2.12-i/3},{10+i*8,46-i*12,2.12-i/3}});
end

local function zasadzNaLinii(linia)
    liniaUprawy = createElement ( "liniaUprawy" )
	-- stworzymy dwa cs
	local cs=createColSphere(linia[1][1], linia[1][2], linia[1][3], 3)
	setElementParent(cs,liniaUprawy)
	cs=createColSphere(linia[2][1], linia[2][2], linia[2][3], 3)
	setElementParent(cs,liniaUprawy)

	local dlugosc=getDistanceBetweenPoints3D(linia[1][1], linia[1][2], linia[1][3], linia[2][1], linia[2][2], linia[2][3])
--	v.object=createObject(3409, v[1], v[2], v[3], 0,0,math.random(0,360))

	for i=0,1,(6/dlugosc) do
	  --http://answers.yahoo.com/question/index?qid=20110824161149AAUbdJj
	  local nx,ny,nz=i*linia[1][1]+(1-i)*linia[2][1], i*linia[1][2]+(1-i)*linia[2][2], i*linia[1][3]+(1-i)*linia[2][3]
	  local o=createObject(818, nx, ny, nz, 0,0,math.random(0,360))
	  setElementParent(o,liniaUprawy)
	end
	return liniaUprawy
end

local function findLinieIDX(lU)
  for i,v in ipairs(linie) do
	if v.liniaUprawy==lU then return i end
  end
  return nil
end

local function scietoLinie(lU)
  local elementy=getElementChildren(lU)
  local x,y,z=getElementPosition(elementy[math.floor(#elementy/2)+1])
  local lidx=findLinieIDX(lU)
  if (not lidx) then return end -- nie powinno sie wydarzyc
  for i,v in ipairs(elementy) do
	destroyElement(v)
  end
  destroyElement(lU)
  linie[lidx].liniaUprawy=nil
  linie[lidx].snopek=createObject(2901, x,y,z+0.5)
  setElementData(linie[lidx].snopek,"customAction",{label="Podnieś",resource="lss-uprawy",funkcja="menu_podnies",args={snopek=linie[lidx].snopek}})
end

for i,v in ipairs(linie) do
	v.liniaUprawy=zasadzNaLinii(v)
end


local function respawnUpraw()
  for i,v in ipairs(linie) do
	if (not v.snopek or not isElement(v.snopek)) and not v.liniaUprawy and math.random(1,3)==1 then
		v.liniaUprawy=zasadzNaLinii(v)
	end

  end
end

setTimer(respawnUpraw, 1000*60*30, 0)

-- traktor i przyczepa

--createVehicle(531,-13.18,-1.76,3.12)
--createVehicle(610, -13.22,-5.35,3.12)


addEventHandler("onColShapeHit", resourceRoot, function(el,md)

--  if not md then return end
  if getElementType(el)~="vehicle" then return end
  local em=getElementModel(el)
--  if em~=610 then return end	 bug #6251 - onColShapeHit nie uruchamia sie na trailerze
  if em~=531 then return end
  local przyczepa=getVehicleTowedByVehicle(el)
  if not przyczepa then return end
  em=getElementModel(przyczepa)
  if (em~=610) then return end

  local scs=getElementData(przyczepa,"uprawy:cs")
  if scs and getTickCount()-scs[1]<(1000*120) then
	if (scs[2] and isElement(scs[2]) and scs[2]~=source) then
	  if (getElementParent(scs[2])==getElementParent(source)) then
		scietoLinie(getElementParent(source))
		removeElementData(przyczepa,"uprawy:cs")
		return
	  end
	end
  end                                     
  -- zapisujemy cs do ktorego wjechala przyczepa
  setElementData(przyczepa,"uprawy:cs", { getTickCount(),source },false)
end)



-- triggerServerEvent("onSnopekPickup", resourceRoot, localPlayer, snopek)
addEvent("onSnopekPickup", true)
addEventHandler("onSnopekPickup", resourceRoot, function(plr, snopek)
  if (not isElement(snopek)) then return end
  local c=getElementData(plr,"character")
  if not c or not c.id then return end
  if (exports["lss-core"]:eq_giveItem(plr, 44, 1)) then
	triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " podnosi snopek z ziemii.", 5, 15, true)
	destroyElement(snopek)
  end
end)