--[[
@author Karer <karer.programmer@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--



function menu_usiadz(args)
  el=args.el
  local x,y,z=getElementPosition(el)
  local lx,ly,lz=getElementPosition(localPlayer)
  outputDebugString("x" .. x)
  outputDebugString(getDistanceBetweenPoints3D(x,y,z,lx,ly,lz))
  if getDistanceBetweenPoints3D(x,y,z,lx,ly,lz)>6 then
	outputChatBox("Podejdź bliżej.")
	return
  end
  local rx,ry,rz=getElementRotation(el)
  setPedRotation(localPlayer, rz+180)
  setElementRotation(localPlayer, 0,0, rz)

  setElementCollisionsEnabled(localPlayer, false)
  
  if getElementModel(el)==1364 then
	attachElements(localPlayer, el, 0, 0.4, 0.5)
	setElementData(localPlayer, "menu_usiadz", el)
  end
  
  triggerServerEvent("setPedAnimation", localPlayer, "INT_OFFICE", "OFF_Sit_Idle_Loop", -1, true, false )

end

function menu_kielbasaUpiecz(args)
	local player = args.player
	local grill = args.grill
	triggerServerEvent("menu_kielbasaUpiecz", player, grill)
end

function menu_rybaUpiecz(args)
	local player = args.player
	local grill = args.grill
	triggerServerEvent("menu_rybaUpiecz", player, grill)
end

function menu_grillTake(args)
	local player = args.player
	local grill = args.grill
	triggerServerEvent("menu_grillTake", player, grill)
end

function menu_blokadaTake(args)
	local player = args.player
	local blokada = args.blokada
	triggerServerEvent("menu_blokadaTake", player, blokada)
end

function menu_kanisterFill(args)
	local player = args.player
	local vehicle = args.vehicle
	local pojemnosc = args.pojemnosc
	triggerServerEvent("menu_kanisterFill", player, vehicle, pojemnosc)
end

function menu_zestawAudio(args)
	local player = args.player
	local vehicle = args.vehicle
	triggerServerEvent("menu_zestawAudio", player, vehicle)
end

vehsounds = {}

addEvent("menu_zestawAudioDO",true)
addEventHandler("menu_zestawAudioDO", getRootElement(), function(veh)
	local aud=getElementData(veh, "vehicle:audio")
	local a,b = getElementPosition(source)
	local c,d = getElementPosition(localPlayer)
	if vehsounds[veh] then
			destroyElement(vehsounds[veh])
			vehsounds[veh]=false
			setElementData(veh, "vehicle:audioplaying", false)
	else
		if getElementData(veh, "vehicle:soundpath") then
		-- if url then
			vehsounds[veh]=playSound3D(getElementData(veh, "vehicle:soundpath"), 0,0,0)
			attachElements(vehsounds[veh], veh)
			if aud==1 then
				setSoundVolume(vehsounds[veh], 0.3)
			end
			setElementData(veh, "vehicle:audioplaying", true)
		else
			if source==localPlayer then
				outputChatBox("(( Ustaw radio komendą /vehradio ))")
			end
		end
	end
end)