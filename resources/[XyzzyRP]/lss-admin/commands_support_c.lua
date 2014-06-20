--[[
lss-admin: różne komendy dla supportu

@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub

]]--


addCommandHandler("podpalacz", function()

	if not getElementData(localPlayer,"admin:rank") then
		return
	end

	local pos={}
	pos[1],pos[2],pos[3]=getElementPosition(localPlayer)
for i=1,50 do
	
    local radius=math.random(5,50)
    local kat=math.random(0,360)
    local x=pos[1]+(radius*math.sin(kat))
    local y=pos[2]+(radius*math.cos(kat))
    local z=getGroundPosition(x,y,pos[3])

    if (z and z>0) then
		triggerServerEvent("doCreateFire", root, x,y, z-0.5, getElementDimension(localPlayer), getElementInterior(localPlayer))
    end
end


end)
