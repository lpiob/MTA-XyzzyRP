--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local D=38


local trails={}

addEventHandler("onClientRender", root, function()
	for i=#trails,1,-1 do
		dxDrawLine3D(trails[i][1],trails[i][2],trails[i][3],trails[i][4],trails[i][5],trails[i][6], tocolor(unpack(trails[i][7])))
		if trails[i][7][4]>=0 then
			trails[i][7][4]=math.max(trails[i][7][4]-16,0)
		else
			table.remove(trails,i)
		end
	end
end)

local function getNearestBonePosition(ped,hX,hY,hZ)
	local nX,nY,nZ,dist,bone
	for i=1,20 do
		local x,y,z=exports["bone_attach"]:getBonePositionAndRotation(ped,i)
		local ndist=getDistanceBetweenPoints3D(x,y,z,hX,hY,hZ)
		if not dist or ndist<dist then
			nX,nY,nZ=x,y,z
			dist=ndist
			bone=i
		end
	end
	return nX,nY,nZ,bone
end

addEventHandler("onClientPlayerWeaponFire", root, function(weapon, ammo, aic, hX ,hY, hZ, hitElement, sX, sY, sZ)
	if getElementDimension(localPlayer)~=D then return end
	if hX and hY and hZ and sX and sY and sZ then
		local pbt=getElementData(source,"pb:team") or 0
		table.insert(trails, { hX, hY, hZ, sX, sY, sZ, pbt==0 and {255,0,0,128} or {0,0,255,128} })

		local m=createMarker(hX,hY,hZ, "corona", 0.1, pbt==0 and 255 or 0,0,pbt==0 and 0 or 255)
		setElementDimension(m,D)
		setElementInterior(m,getElementInterior(source))
		if hitElement and getElementType(hitElement)=="player" then
			local x,y,z,bone=getNearestBonePosition(hitElement,hX, hY, hZ)
			--getElementPosition(hitElement)
--			attachElements(m, hitElement, hX-x, hY-y, hZ-z)
			if bone then
				exports["bone_attach"]:attachElementToBone(m,hitElement,bone,0,0,0)
			end
		end

		setElementData(m,"ts",getTickCount())
	end

end)

local function clearOldMarkers()
	for i,v in ipairs(getElementsByType("marker", resourceRoot)) do
		if getTickCount()-getElementData(v,"ts")>30000 then
			destroyElement(v)
		end
	end
end

setTimer(clearOldMarkers, 5000, 0)