--[[
@author Karer <karer.programmer@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



function menu_usiadz(args)
  el=args.el
  local x,y,z=getElementPosition(el)
  local lx,ly,lz=getElementPosition(localPlayer)
  outputDebugString("x" .. x)
  if getDistanceBetweenPoints3D(x,y,z,lx,ly,lz)>3 then
	outputChatBox("Podejdź bliżej.")
	return
  end
  local rx,ry,rz=getElementRotation(el)
  setPedRotation(localPlayer, rz+180)
  setElementRotation(localPlayer, 0,0, rz)

  setElementCollisionsEnabled(localPlayer, false)
  setElementPosition(localPlayer, x,y,z+1)
  triggerServerEvent("setPedAnimation", localPlayer, "INT_OFFICE", "OFF_Sit_Idle_Loop", -1, true, false )

end



