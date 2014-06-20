--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@author RootKiller <rootkiller.programmer@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local sw,sh=guiGetScreenSize()


--local nametagFont = "default"
local nametagFont = dxCreateFont( "droid-sans.ttf", 10 )
if not nametagFont then nametagFont = "default-bold" end

local nametagScale = 1.0
local nametagAlpha = 180
local nametagColor =
{
	r = 255,
	g = 255,
	b = 255
} 



addEventHandler("onClientRender", getRootElement(), 
	function()
		local rootx, rooty, rootz = getCameraMatrix()--getElementPosition(getLocalPlayer())
		
		for i, vehicle in ipairs(getElementsByType("vehicle", root, true)) do
		    if getVehicleType(vehicle)=="Helicopter" and not getVehicleEngineState(vehicle) then
			setHelicopterRotorSpeed(vehicle,getHelicopterRotorSpeed(vehicle)/3)
		    end
		    local opis=getElementData(vehicle,"opis")
		    if (opis) then
			local x,y,z=getElementPosition(vehicle)
			local distance = getDistanceBetweenPoints3D(rootx, rooty, rootz, x, y, z)
			if (distance<=10) then
				local sx,sy = getScreenFromWorldPosition(x,y,z, 200)
				if (sx and sy) then
					if not getElementData(localPlayer,"hud:removeclouds") then
						dxDrawText(opis, sx-(sw/5),sy,sx+(sw/5),sy, tocolor(255,255,255,155), 1.0, "default-small", "center","center",false,true)
					end
				end
			end
		    end
		end
		
		for i, player in ipairs(getElementsByType("player",root,true)) do
			if player ~= localPlayer and getElementDimension(localPlayer)==getElementDimension(player) and getElementInterior(localPlayer)==getElementInterior(player) and getElementAlpha(player)>0 then
				local x,y,z = getPedBonePosition(player,8)
--				local lookAt=getElementData(player, "lookAt")
--				if (lookAt and lookAt[1]) then
--				  setPedLookAt(player, lookAt[1], lookAt[2], lookAt[3])
--				  dxDrawLine3D(x,y,z, lookAt[1], lookAt[2], lookAt[3], tocolor(255,0,0,50))
--				end

				local sx, sy = getScreenFromWorldPosition(x, y, z+0.5)
				if sx then
					local character = getElementData(player, "character")
					local zamaskowany = getElementData(player, "zamaskowany")
					if (character) then
	    				local name = character.imie .. " " .. character.nazwisko .. " (" .. tostring(getElementData(player, "id")) .. ")"
						if zamaskowany then name="Zamaskowana osoba ("..tostring(getElementData(player, "id")) .. ")" end
					    local distance = getDistanceBetweenPoints3D(rootx, rooty, rootz, x, y, z)
					
						-- Przypisujemy pozycje ekranu do pozycji rysowanego tekstu.
					    local fX = sx
					    local fY = sy
				
					    -- Ustalamy przeźroczystość nametagu.
					    local alpha = 120
                    									 
					    -- Sprawdzamy czy dystans jest mniejszy bądź równy 12.
					    if(distance <= 12) then
							if not getElementData(localPlayer,"hud:removeclouds") then
								
								willshow = true
								
								if getPedOccupiedVehicle(player) then
									local car = getPedOccupiedVehicle(player)
									if getElementData(car, "vehicle:folia") then
										if getElementData(car, "vehicle:folia")==1 then
											willshow = false
										else  --2
											local a,b,c = getElementPosition(localPlayer)
											if getDistanceBetweenPoints2D(a,b,x,y) > 3 then
												willshow=false
											end
										end
									end
								end
							
								if willshow then
									local fname=getElementData(player, "faction:name")
									if (fname) then
										dxDrawText(fname, fX, fY+10, fX, fY+10, tocolor(200,200,200,alpha/2), nametagScale*0.9, nametagFont, "center", "center")
									end
									if (getElementData(player,"premium")) then
										dxDrawText(name, fX+1, fY+1, fX+1, fY+1, tocolor(0, 0, 0, 190), nametagScale, nametagFont, "center", "center")
										dxDrawText(name, fX, fY, fX, fY, tocolor(255, 255, 155, 190), nametagScale, nametagFont, "center", "center")
									else
										dxDrawText(name, fX+1, fY+1, fX+1, fY+1, tocolor(0, 0, 0, alpha), nametagScale, nametagFont, "center", "center")
										dxDrawText(name, fX, fY, fX, fY, tocolor(255, 255, 255, alpha), nametagScale, nametagFont, "center", "center")
									end
									local opis=getElementData(player, "opis")
									if opis then
										local alpha=255-getDistanceBetweenPoints2D(sw/2,sh/2,sx,sy)

										if alpha>5 then
											local sx, sy = getScreenFromWorldPosition(x, y, z-0.5)
											if sx and sy then
												dxDrawText(opis, sx-(sw/10),sy,sx+(sw/10),sy, tocolor(255,255,255,alpha), 1.0, "default-small", "center","center",false,true)
											end

		--								outputDebugString("a " .. alpha)
										end
									end
								end
							end
					    end
					end
				end
			end
		end	

		for i, ped in ipairs(getElementsByType("ped",root,true)) do
			-- Sprawdzamy czy dany gracz nie jest graczem lokalnym.
			if getElementData(ped, "npc") and getElementData(ped, "name") and getElementDimension(localPlayer)==getElementDimension(ped) and getElementInterior(localPlayer)==getElementInterior(ped) then
				-- Pobieramy pozycje gracza.
				local x,y,z = getElementPosition(ped)
							
				-- Obliczamy pozcje na ekranie z pozycji w świecie gry.
				local sx, sy = getScreenFromWorldPosition(x, y, z + 1)
				
				-- Sprawdzamy czy pozycja jest prawidłowa.
				if sx then
					-- Definiujemy wyświetlany tekst.
					local name = getElementData(ped, "name")
			
					-- Pobieramy dystans pomiędzy graczem a graczem lokalnym.
					local distance = getDistanceBetweenPoints3D(rootx, rooty, rootz, x, y, z)
					
					-- Przypisujemy pozycje ekranu do pozycji rysowanego tekstu.
					local fX = sx
					local fY = sy
				
					-- Ustalamy przeźroczystość nametagu.
					local alpha = 120
                    									 
					-- Sprawdzamy czy dystans jest mniejszy bądź równy 8.
					if(distance <= 8 and isLineOfSightClear(rootx,rooty,rootz,x,y,z,false,false,false)) then
						-- Jeśli jest mniejszy bądź równy 8 - rysujemy tekst nad głową gracza.
						if not getElementData(localPlayer,"hud:removeclouds") then
							dxDrawText(name, fX, fY, fX, fY, tocolor(0, 0, 0, alpha), nametagScale, nametagFont, "center", "center")	
						end
					end
				end
			end
		end	
	end
)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
	function()
		-- Usuwamy nametagi.
		for k, v in ipairs(getElementsByType("player")) do
			setPlayerNametagShowing ( v, false )
		end
	end
)

addEventHandler("onClientPlayerSpawn", getRootElement(), 
	function()
		-- Usuwamy nametagi.
		setPlayerNametagShowing ( source, false )
	end
)

--[[
setTimer(function()
		for i, player in ipairs(getElementsByType("player",root,true)) do
			if player ~= localPlayer and getElementDimension(localPlayer)==getElementDimension(player) and getElementInterior(localPlayer)==getElementInterior(player) and getElementAlpha(player)>0 then
				local x,y,z = getPedBonePosition(player,8)
				local lookAt=getElementData(player, "lookAt")
				if (lookAt and lookAt[1]) then
--				  outputDebugString("x"..lookAt[1] .. " " .. lookAt[2] .. " " .. lookAt[3])
				  setPedLookAt(player, lookAt[1], lookAt[2], lookAt[3],-1,nil)
--				  setPedLookAt(player, 2000, -2000, -1)
				  dxDrawLine3D(x,y,z, lookAt[1], lookAt[2], lookAt[3], tocolor(255,0,0,255))
				end
			end
		end
end, 1000, 0)
]]--