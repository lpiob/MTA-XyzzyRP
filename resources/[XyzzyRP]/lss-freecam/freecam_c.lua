--[[
Okazjonalnie uzywany zasob do robienia ss

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local active=false

function freecam(key)
  local x,y,z,rx,ry,rz=getCameraMatrix()
  if (key=="u") then
	y=y+1
  elseif (key=="j") then
	y=y-1
  elseif (key=="h") then
	x=x+1
  elseif (key=="k") then
	x=x-1
  end

  setCameraMatrix(x,y,z,rx,ry,rz)
end


function freecam_toggle()
  if (not active) then
    active=true
    bindKey("u", "down", freecam)
    bindKey("h", "down", freecam)
    bindKey("j", "down", freecam)
    bindKey("k", "down", freecam)
  else
	setCameraTarget(localPlayer)
	active=false
	unbindKey("u", "down", freecam)
	unbindKey("h", "down", freecam)
	unbindKey("j", "down", freecam)
	unbindKey("k", "down", freecam)
  end

end

addCommandHandler("Xf", freecam_toggle)

addEventHandler("onClientResourceStop", resourceRoot, function()
  if (active) then
	freecam_toggle()
  end
end)