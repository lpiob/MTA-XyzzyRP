--[[
Domy do wynajecia

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--



addEventHandler("onMarkerHit", resourceRoot, function(el,md)
	if getElementType(el)~="player" or not md then return end
	if getElementInterior(el)~=getElementInterior(source) then return end
	local tpto=getElementData(source,"tpto")
	if not tpto then return end
	setElementPosition(el, tpto[1], tpto[2],tpto[3])
	setElementInterior(el, 0)
	setElementDimension(el, 0)
	if tpto[4] then
		setPedRotation(el, tpto[4])
	end
end)