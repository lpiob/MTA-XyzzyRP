--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- granat hukowo-blyskowy

smoke = {}

addEventHandler("onClientExplosion", root, function(x,y,z,etype)
  if etype~=0 then return end -- tylko granaty
  if getElementData(source, "granat")=="hukowy" then
	  cancelEvent()
	  local px,py,pz=getPedBonePosition(localPlayer,5)
	  if not isLineOfSightClear(px,py,pz,x,y,z) then return end
	  -- todo obrot peda
	  fadeCamera(false,0,255,255,255)
	  triggerEvent("odtworzDzwiek", root, "flashbang")
	  setTimer(fadeCamera, math.random(4,10)*1000, 1, true, math.random(8,15))
  elseif getElementData(source, "granat")=="dymny" then --dymny ;)
	  cancelEvent()
	  local px,py,pz=getPedBonePosition(localPlayer,5)
	  smoke[source] = createObject(2057, x, y, z-10)
	  setTimer(function(source) 
		if source then destroyElement(source) end
	  end, 30000, 1, smoke[source])
	  if not isLineOfSightClear(px,py,pz,x,y,z) then return end
	  triggerEvent("odtworzDzwiek", root, "smokegrenade")
  end
end)