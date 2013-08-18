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
	  smoke[source] = createObject(2057, x, y, z-100)
	  setTimer(function(source) 
		if source then destroyElement(source) end
	  end, 30000, 1, smoke[source])
	  if not isLineOfSightClear(px,py,pz,x,y,z) then return end
	  triggerEvent("odtworzDzwiek", root, "smokegrenade")
  end
end)