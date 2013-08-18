--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local czesciCiala={
	[3]="tors",
	[4]="pośladki",
	[5]="lewe ramię",
	[6]="prawe ramię",
	[7]="lewą nogę",
	[8]="prawą nogę",
--	[8]="głowę",
}

function weaponDamage ( attacker, weapon, bodypart, loss )
	-- paralizator
	setElementData(localPlayer, "ck:bron", weapon)
	if ( weapon == 23 and attacker ) then
		local x,y,z=getElementPosition(localPlayer)
		local x2,y2,z2=getElementPosition(attacker)
		if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<=15 and not isElementFrozen(localPlayer) and not isPedInVehicle(localPlayer)) then
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zostaje trafiony/a paralizatorem.", 3, 15, true)
			setElementFrozen(localPlayer,true)
			local ar=math.random(1,3)
			if (ar==1) then
				triggerServerEvent("setPedAnimation", localPlayer, "CRACK", "crckdeth1", -1, false )
			elseif ar==2 then
				triggerServerEvent("setPedAnimation", localPlayer, "CRACK", "crckdeth2", -1, true, false )
			elseif ar==3 then
				triggerServerEvent("setPedAnimation", localPlayer, "CRACK", "crckidle3", -1, true, false )
			end

			setTimer(function()
				setElementFrozen(localPlayer, false)
				triggerServerEvent("setPedAnimation", localPlayer)

				end, 30000, 1)
		end
		cancelEvent()
	elseif ((weapon==24 or weapon==25 or weapon==28 or weapon==30 or weapon==29 or weapon==31 or weapon==22 or weapon==26) and attacker) then -- deagle, uzi, ak47, mp5, m4, shotgun, glock
		--kamizelka kuloodporna
		
		if getElementData(localPlayer, "kamizelkaPD") then
			if (bodypart==3) or (bodypart==5) or (bodypart==6) then
				triggerServerEvent("onKevlarDefense", getRootElement(), localPlayer)
				cancelEvent()
				return
			end
		end
		
		if getElementHealth(localPlayer)<=loss then -- gracz zginie wskutek postrzalu, nie robimy nic z animacjami
			return
		end

		if (not isElementFrozen(localPlayer) and not isPedInVehicle(localPlayer)) then
			local opis=getPlayerName(localPlayer) .. " zostaje trafiony/a pociskiem wystrzelonym przez " .. getPlayerName(attacker)
			if bodypart and czesciCiala[bodypart] then 
				opis=opis.." w " .. czesciCiala[bodypart]
			end
			opis=opis.."."

			triggerServerEvent("broadcastCaptionedEvent", localPlayer, opis, 15, 15, true)
			setElementFrozen(localPlayer,true)
			local ar=math.random(1,3)
			if (ar==1) then
				triggerServerEvent("setPedAnimation", localPlayer, "CRACK", "crckdeth1", -1, false )
			elseif ar==2 then
				triggerServerEvent("setPedAnimation", localPlayer, "CRACK", "crckdeth2", -1, true, false )
			elseif ar==3 then
				triggerServerEvent("setPedAnimation", localPlayer, "CRACK", "crckidle3", -1, true, false )
			end

			setTimer(function()
				setElementFrozen(localPlayer, false)
				triggerServerEvent("setPedAnimation", localPlayer)
				triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " odzyskuje sprawność po postrzale.", 15, 15, true)
				end, math.random(45000,60000), 1)
		end


	end
end
addEventHandler ( "onClientPlayerDamage", localPlayer, weaponDamage )