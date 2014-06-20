--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local function fx()
	return math.random(-10,10)/100
end

local blu=getTickCount()
local blp={}
local blp_ME=7

local tex=dxCreateTexture("black.png")
local bcolor=tocolor(100,100,100,100)

local function renderBaner()
	for i,v in ipairs(getElementsByType("vehicle", root, true)) do
		if getElementData(v,"baner") then
			local x,y,z=getElementPosition(v)
			local vx, vy, vz = getElementVelocity(v)
			if math.abs(vx)+math.abs(vy)+math.abs(vz)<0.05 and #blp>0 then
				table.remove(blp,#blp)
			end

			local _,_,rz=getElementRotation(v)
			local rrz=math.rad(rz+180)
			local x= x + (7 * math.sin(-rrz))
			local y= y + (7 * math.cos(-rrz))
			for ii,p in ipairs(blp) do
				if ii==1 then
					dxDrawMaterialLine3D(x,y,z,p[1],p[2],p[3]+fx(), tex,5, bcolor, x,y,z-100)
				else
					dxDrawMaterialLine3D(blp[ii-1][1],blp[ii-1][2],blp[ii-1][3],p[1],p[2],p[3]+fx(), tex,5, bcolor, x,y,z-100)
				end
			end
			if getTickCount()-blu>100 then
				table.insert(blp,0,{x,y,z})
				if #blp>blp_ME then
					table.remove(blp,blp_ME+1)
				end
				blu=getTickCount()
			end

		end
	end
end


if getPlayerName(localPlayer)=="Christopher_DeLarge" then
	outputChatBox("baner")

end

addEventHandler("onClientRender", root, renderBaner)