function attachRotationAdjusted ( from, to )
    -- Note: Objects being attached to ('to') should have at least two of their rotations set to zero
        --       Objects being attached ('from') should have at least one of their rotations set to zero
	    -- Otherwise it will look all funny
	     
	        local frPosX, frPosY, frPosZ = getElementPosition( from )
		    local frRotX, frRotY, frRotZ = getElementRotation( from )
		        local toPosX, toPosY, toPosZ = getElementPosition( to )
			    local toRotX, toRotY, toRotZ = getElementRotation( to )
			        local offsetPosX = frPosX - toPosX
				    local offsetPosY = frPosY - toPosY
				        local offsetPosZ = frPosZ - toPosZ
					    local offsetRotX = frRotX - toRotX
					        local offsetRotY = frRotY - toRotY
						    local offsetRotZ = frRotZ - toRotZ
						     
						        offsetPosX, offsetPosY, offsetPosZ = applyInverseRotation ( offsetPosX, offsetPosY, offsetPosZ, toRotX, toRotY, toRotZ )
							 
							    attachElements( from, to, offsetPosX, offsetPosY, offsetPosZ, offsetRotX, offsetRotY, offsetRotZ )
							    end
							     
							     
							    function applyInverseRotation ( x,y,z, rx,ry,rz )
							        -- Degress to radians
								    local DEG2RAD = (math.pi * 2) / 360
								        rx = rx * DEG2RAD
									    ry = ry * DEG2RAD
									        rz = rz * DEG2RAD
										 
										    -- unrotate each axis
										        local tempY = y
											    y =  math.cos ( rx ) * tempY + math.sin ( rx ) * z
											        z = -math.sin ( rx ) * tempY + math.cos ( rx ) * z
												 
												    local tempX = x
												        x =  math.cos ( ry ) * tempX - math.sin ( ry ) * z
													    z =  math.sin ( ry ) * tempX + math.cos ( ry ) * z
													     
													        tempX = x
														    x =  math.cos ( rz ) * tempX + math.sin ( rz ) * y
														        y = -math.sin ( rz ) * tempX + math.cos ( rz ) * y
															 
															    return x, y, z
															    end





addEvent("onVehicleUnloadRequest", true)
addEventHandler("onVehicleUnloadRequest", root, function(plr)
    local dft=source
    
    if (getElementModel(dft)~=578) then	return end
    
    -- najpierw sprawdzmy czy ten dft czegos nie wiezie
    local cnt=0
    local wiezione=getAttachedElements(dft)
    if (#wiezione<1) then
	outputChatBox("Nie wieziesz żadnego pojazdu.", plr, 255,0,0,true)
	return
    end
    

    local x,y,z=getElementPosition(dft)
    -- szukamy pojazdu za DFT
    local _,_,rz=getElementRotation(dft)

    local rrz=math.rad(rz+180)
    local x2= x + (2 * math.sin(-rrz))
    local y2= y + (2 * math.cos(-rrz))
    local strefa=createColSphere(x2,y2,z+1,4)

    local pojazdy=getElementsWithinColShape(strefa, "vehicle")
    destroyElement(strefa)

    if (not pojazdy or #pojazdy<1) then
	return
    end
    cnt=0
	outputDebugString("1")
    for _,pojazd in ipairs(pojazdy) do
	if (pojazd~=dft) then
		cnt=cnt+1
		detachElements(pojazd, dft)
	--    setElementPosition(pojazd, x2,y2,z)
	        setElementVelocity(pojazd, x2,y2,-0.1)
		setElementSyncer(pojazd,plr)
	end
    end
    if (cnt>0) then
        triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " wyładowuje pojazdy z naczepy.", 5, 15, true)
    end
end)


addEvent("onWheelLockRequest", true)
addEventHandler("onWheelLockRequest", root, function(plr)
    local dft=source
    
    if (getElementModel(dft)~=578) then	return end
    
    -- najpierw sprawdzmy czy ten dft czegos nie wiezie
    local cnt=0
    local wiezione=getAttachedElements(dft)
    for _,el in ipairs(wiezione) do
	if (getElementType(el)=="vehicle") then
	    cnt=cnt+1
	end
    end
    if (cnt>0) then
        triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " zdejmuje blokade z kół pojazdów na naczepie.", 5, 15, true)
	for _,el in ipairs(wiezione) do
	    if (getElementType(el)=="vehicle") then
		detachElements(el, dft)
	    end
	end
	return
    end
    
    local x,y,z=getElementPosition(dft)
    -- szukamy pojazdu za DFT
    local _,_,rz=getElementRotation(dft)

    local rrz=math.rad(rz+180)
    local x2= x + (2 * math.sin(-rrz))
    local y2= y + (2 * math.cos(-rrz))
    local strefa=createColSphere(x2,y2,z+1,4)

    local pojazdy=getElementsWithinColShape(strefa, "vehicle")
    destroyElement(strefa)
    if (not pojazdy or #pojazdy<1) then
	return
    end
    cnt=0
    for _,pojazd in ipairs(pojazdy) do
	local dftx,dfty,dftz=getElementPosition(dft)
	local px,py,pz=getElementPosition(pojazd)
	local rx=(px-dftx) * math.sin(-rrz)
	local ry=(py-dfty) * math.cos(-rrz)
	local rz=pz-dftz

	attachRotationAdjusted(pojazd,dft)
	cnt=cnt+1
    end
    triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " blokuje koła pojazdów na naczepie.", 5, 15, true)


end)

local pojazdyWysokie={
    [578]=true,	-- dft
}

addEvent("doMagnes", true)
addEventHandler("doMagnes", root, function(plr)
    local veh=source
    
    if (getElementData(veh,"magnes")) then
	outputChatBox("(( Wyłączanie magnesu. ))", plr)
	destroyElement(getElementData(veh,"magnes"))
	removeElementData(veh,"magnes")
	return
    end
    
    local x,y,z=getElementPosition(veh)
    local strefa=createColSphere(x,y,z-5,4)
--    attachElements(strefa,veh,0,0,-5)
    local pojazdy=getElementsWithinColShape(strefa,"vehicle")
    destroyElement(strefa)
    if not pojazdy or #pojazdy<1 then
	outputChatBox("Pod magnesem nie znajduje się żaden pojazd.", plr, 255,0,0)
	return
    end
    if #pojazdy>1 then
	outputChatBox("Pod magnesem znajduje się zbyt wiele pojazdów", plr, 255,0,0)
	return
    end
    local pojazd=pojazdy[1]
    setElementFrozen(pojazd,false)
    
    local magnes=createObject(1301,0,0,0)
    setElementCollisionsEnabled(magnes, false)
--    setElementAlpha(magnes,0)
    attachElements(magnes,veh,0,1,-3,0)
    setElementData(veh, "magnes", magnes)

    local _,_,rz=getElementRotation(veh)
    setElementRotation(pojazd,0,0,rz)
    local _,_,z2=getElementPosition(pojazd)
    local offset=-(math.abs(z-z2))+3.4
--    local vm=getElementModel(pojazd)
--    if (pojazdyWysokie[vm]) then offset=-4 end
    attachElements(pojazd,magnes,0,2,offset)
    outputChatBox("(( Magnes aktywowany. ))", plr)

end)


--[[
addCommandHandler("xgowno", function(plr,cmd)
	local veh=getPedOccupiedVehicle(plr)
	if not veh then return end
    local x,y,z=getElementPosition(veh)
    -- szukamy pojazdu za DFT
    local _,_,rz=getElementRotation(veh)


	local strefa=createColSphere(0,0,0,5)
	attachElements(strefa,veh,0,0,-5)
--    local strefa=createColSphere(x,y,z-10,10)
	


--    local pojazdy=getElementsWithinColShape(strefa, "vehicle")
--    destroyElement(strefa)
--    if (not pojazdy or #pojazdy<1) then
--	return
--    end
	outputDebugString("pojazdow:" .. #pojazdy)
--	for i,v in ipairs(pojazdy) do
--		if (v~=veh) then
--			attachRotationAdjusted(v,veh)
--		end
--	end

end,false,false)
]]--
--[[
local function wiezionyPojazd(dft)
    local elementy=getAttachedElements(dft)
    for i,v in ipairs(elementy) do
	if (getElementType(v)=="vehicle") then return v end
    end
    return nil
end


function wciagnijPojazd(plr)
    local dft=getPedOccupiedVehicle(plr)
    if (not dft) then return end
    if (getElementModel(dft)~=578) then	return end
    local x,y,z=getElementPosition(dft)
    -- szukamy pojazdu za DFT
    local _,_,rz=getElementRotation(dft)

    local rrz=math.rad(rz+180)
    local x2= x + (2 * math.sin(-rrz))
    local y2= y + (2 * math.cos(-rrz))
    local strefa=createColSphere(x2,y2,z+1,2)

    local pojazdy=getElementsWithinColShape(strefa, "vehicle")
    destroyElement(strefa)
    if (not pojazdy or #pojazdy<1) then
	return
    end
    if (#pojazdy>1) then
--	outputChatBox("Nie wiem który pojazd wciągnąć, ustaw się lepiej.", plr, 255,0,0,true)
	return
    end
    local pojazd=pojazdy[1]
    
	local dftx,dfty,dftz=getElementPosition(dft)
	local px,py,pz=getElementPosition(pojazd)
	local rx=(px-dftx) * math.sin(-rrz)
	local ry=(py-dfty) * math.cos(-rrz)
	local rz=pz-dftz

	outputChatBox(string.format("%.1f %.1f %.1f x %.1f %.1f %.1f => %.1f %.1f %.1f", dftx, dfty, dftz, px, py,pz, rx,ry,rz))
--    attachElements(pojazd, dft,rx,ry,rz)
    attachRotationAdjusted(pojazd,dft)
--    createVehicle(486, x2,y2,z2, 0,0, rz)

end


function wyladujPojazd(plr)
    local dft=getPedOccupiedVehicle(plr)
    if (not dft) then return end
    if (getElementModel(dft)~=578) then	return end
    local pojazd=wiezionyPojazd(dft)
    if not pojazd then
	outputChatBox("Nie wieziesz żadnego pojazdu", plr, 255,0,0,true)
	return
    end
    local x,y,z=getElementPosition(dft)
    local _,_,rz=getElementRotation(dft)
    local rrz=math.rad(rz+180)
    local x2= (0.2 * math.sin(-rrz))
    local y2= (0.2 * math.cos(-rrz))
    detachElements(pojazd, dft)
--    setElementPosition(pojazd, x2,y2,z)
    setElementVelocity(pojazd, x2,y2,-0.1)
    setElementSyncer(pojazd,plr)
end


addCommandHandler("wciagnij", wciagnijPojazd)
addCommandHandler("wyladuj", wyladujPojazd)
]]--



-- ponizej kod na zamrazanie pojazdow na packerze
--[[
function zamrozPojazdy(plr)
    local packer=getPedOccupiedVehicle(plr)
    
    if (not packer) then return end

    if (getElementModel(packer)~=443) then	return end
    local x,y,z=getElementPosition(packer)

    local rx,ry,rz=getElementRotation(packer)
    local rrz=math.rad(rz+180)
    local x2= x+(2.5 * math.sin(-rrz))
    local y2= y+(2.5 * math.cos(-rrz))
    local z2=z+1.5

    local strefa=createColSphere(x2,y2,z2,4)
    local pojazdy=getElementsWithinColShape(strefa,"vehicle")
    destroyElement(strefa)
    if (not pojazdy or #pojazdy<1) then
	return
    end
    outputChatBox("Pojazdow: " .. #pojazdy, plr)
    for i,v in ipairs(pojazdy) do
	if (v~=packer) then
		outputChatBox("Pojazd: " .. getElementModel(v), plr)
		local x3,y3,z3=getElementPosition(v)
		
		attachElements(v, packer, x-x3, y-y3, z-z3)
	end
	
    end

end

addCommandHandler("zamroz", zamrozPojazdy)

function wyladujPojazd(plr)
    local packer=getPedOccupiedVehicle(plr)
    if (not packer) then return end
    if (getElementModel(packer)~=443) then	return end
    local pojazd=wiezionyPojazd(packer)
    if not pojazd then
	outputChatBox("Nie wieziesz żadnego pojazdu", plr, 255,0,0,true)
	return
    end
    local x,y,z=getElementPosition(packer)
    local _,_,rz=getElementRotation(packer)
    local rrz=math.rad(rz+180)
    local x2= (0.2 * math.sin(-rrz))
    local y2= (0.2 * math.cos(-rrz))
    detachElements(pojazd, packer)
--    setElementPosition(pojazd, x2,y2,z)
    setElementVelocity(pojazd, x2,y2,-0.1)
    setElementSyncer(pojazd,plr)
end

addCommandHandler("wyladuj", wyladujPojazd)
]]--