--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local function odlegloscDoZiemi(v)
	local x,y,z=getElementPosition(v)
	local vh=getGroundPosition(x,y,z)
	return z-vh
end


local function zjedzPoLinie()
	local veh=getPedOccupiedVehicle(localPlayer)
	if not veh then return end
	if getVehicleController(veh)==localPlayer then return end
	if isElementFrozen(veh) then return end


	local special=getElementData(veh,"special")
	if not special then return end
	if special~="rope" then return end

	if getPedStat(localPlayer,22)<300 or getPedStat(localPlayer,164)<400 then 
			outputChatBox("* Nie czujesz się odpowiednio pewnie by zjechać na linie (wtymagane 300 staminy, 400 siły)")
		return end
	



	local odl=odlegloscDoZiemi(veh)

	if odl<5 then
		outputChatBox("(( Pojazd jest zbyt blisko ziemi. ))")
		return
	end
	if odl>100 then
		outputChatBox("(( Pojazd jest zbyt daleko od ziemi. ))")
		return

	end

	triggerServerEvent("startZjazd", resourceRoot)
--[[
	local rrx,rry,rrz=getElementRotation(localPlayer)
	removePedFromVehicle(localPlayer)
	setElementRotation(localPlayer, rrx,rry,rrz+90)
	triggerServerEvent("setPedAnimation",localPlayer,"SWAT","swt_vent_02",-1,false,false,false)
]]--
	
end
--`addCommandHandler("zjedz", zjedzPoLinie)
bindKey("2","down", zjedzPoLinie)



addEventHandler("onClientRender", root, function()


	for i,v in ipairs(getElementsByType("player", root,true)) do
		local pojazd=getElementData(v,"zjazd")
		if pojazd then
			if v==localPlayer then
				if isPedOnGround(localPlayer) or isPedInWater(localPlayer) or isPlayerDead(localPlayer) then
					triggerServerEvent("finishZjazd", resourceRoot)
				end
			end
			if isElement(pojazd) then
				local x1,y1,z1=getElementPosition(v)
				local x2,y2,z2=getElementPosition(pojazd)
				if getDistanceBetweenPoints2D(x1,y1,x2,y2)>10 then
					triggerServerEvent("finishZjazd", resourceRoot)
				end
				if v==localPlayer then -- getDistanceBetweenPoints2D(x1,y1,x2,y2)>2 then
					setElementPosition(v,(x1+x2)/2, (y1+y2)/2, math.min(z1,z2-2),false)
					x1,y1,z1=getElementPosition(v)
				end
				local x3,y3,z3=getPedBonePosition(v,35)
				local x4,y4,z4=getPedBonePosition(v,25)
				dxDrawLine3D(x3,y3,z3,x2,y2,z2,tocolor(0,0,0),2)
				dxDrawLine3D(x3,y3,z3,x4,y4,z4,tocolor(0,0,0),2)
				dxDrawLine3D(x4,y4,z4,x4,y4,z4-2,tocolor(0,0,0),2)
				
			elseif v==localPlayer  then -- nie powinno sie wydarzyc, no ale..
				triggerServerEvent("finishZjazd", resourceRoot)
			end
		end
	end
end)