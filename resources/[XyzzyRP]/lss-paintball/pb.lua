--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local I=2
local D=38
local BRON=33


-- -1137.12,1099.75,2645.83,35.5
-- -967.81,1018.71,2646.47,217.9
local cs=createColCuboid(-1138,1017.02,2635,180,85,30)
setElementInterior(cs, I)
setElementDimension(cs, D)

for i,v in ipairs(getElementsByType("player")) do
	if getElementDimension(v)==D and getElementInterior(v)==I and isElementWithinColShape(v,cs) then
		giveWeapon(v, BRON, -1,true)
		
	else
		takeWeapon(v,BRON)
	end
end

addEventHandler("onColShapeHit", cs, function(el,md)
	if not md or getElementType(el)~="player" then return end
	giveWeapon(el, BRON, -1,true)
end)

addEventHandler("onColShapeLeave", cs, function(el,md)
	if getElementType(el)~="player" then return end
	takeWeapon(el, BRON, -1)
end)

setWeaponProperty("rifle","pro","damage", 0)
setWeaponProperty("rifle","std","damage", 0)
setWeaponProperty("rifle","poor","damage", 0)

-- strefy ustawiajace druzyne i zdejmujace te ustawienie

-- -1023.23,830.89,2665.66,297.3
-- -1026.51,833.56,2665.66,74.9
local soff=createColCuboid(-1047, 833, 2663, 25, 2, 6)
setElementInterior(soff, I)
setElementDimension(soff, D)

addEventHandler("onColShapeHit", soff, function(el,md)
	if not md or getElementType(el)~="player" then return end
	takeWeapon(el, BRON, -1)
	removeElementData(el,"pb:team")
end)

local sblue=createColSphere(-1024.79,824.81,2665.68,3)
setElementInterior(sblue, I)
setElementDimension(sblue, D)


local sred=createColSphere(-1045.79,824.81,2665.68,3.5)
setElementInterior(sred, I)
setElementDimension(sred, D)

addEventHandler("onColShapeHit", sred, function(el,md)
	if not md or getElementType(el)~="player" then return end
	setElementData(el,"pb:team",0)
end)

addEventHandler("onColShapeHit", sblue, function(el,md)
	if not md or getElementType(el)~="player" then return end
	setElementData(el,"pb:team",1)
end)