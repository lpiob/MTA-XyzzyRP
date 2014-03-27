--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- triggerServer("forklift_podnies", v, obiekty[1]) 
addEvent("forklift_podnies", true)
addEventHandler("forklift_podnies", root, function()
		-- szukamy obiektu do podniesienia
		local x,y,z=getElementPosition(source)
		local _,_,rz=getElementRotation(source)
		local rrz=math.rad(rz+180)
		local x= x - (2*math.sin(-rrz))
		local y= y - (2*math.cos(-rrz))
		local strefa=createColSphere(x,y,z,1)
		local obiekty=getElementsWithinColShape(strefa,"object")
		destroyElement(strefa)
--		outputDebugString(#obiekty)
		if #obiekty~=1 then return end
		
		if getElementModel(obiekty[1])~=1463 then return end
		local plr = getVehicleOccupant(source)
		if not plr then return end --shouldn't happen
		local owner = getElementData(obiekty[1], "tartak:wood:owner") or false
		if (owner) and (owner~=plr) then return end
		-- podnosimy!

		attachElements(obiekty[1],source, 0,1.2,0.3)
--		attachRotationAdjusted(obiekty[1],source)
end)

addEvent("forklift_opusc", true)
addEventHandler("forklift_opusc", root, function()
	local elementy=getAttachedElements(source)
	for i,v in ipairs(elementy) do
		if getElementType(v)=="object" then
			detachElements(v,source)
			local x,y,z=getElementPosition(source)
			local _,_,rz=getElementRotation(source)
			local rrz=math.rad(rz+180)
			local x= x - (2*math.sin(-rrz))
			local y= y - (2*math.cos(-rrz))

			setElementPosition(v,x,y,z-0.3)
		end
	end
end)