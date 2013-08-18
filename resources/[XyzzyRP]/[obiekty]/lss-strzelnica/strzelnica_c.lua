local D=18
local I=4

local strzalow=0
local trafien=0
local startTime=getTickCount()

local budki_cs=createColCuboid(302, -71.40, 1001.0, 1.1, 13, 1)
setElementDimension(budki_cs,D)
setElementInterior(budki_cs,I)
-- 302.02,-71.40,1001.52,264.5
-- 303.03,-59.25,1001.52,323.2

function onClientPlayerWeaponFireFunc(weapon,ammo,ammoInClip,hitX,hitY,hitZ,hitElement)
  if (getElementDimension(localPlayer)~=D) then return end
  strzalow=strzalow+1
  if (not hitElement) then return end
  if (not getElementData(hitElement,"strzelnica:cel")) then return end
  trafien=trafien+1
--  outputChatBox(" . " .. getElementType(hitElement))
end


addEventHandler("onClientPlayerWeaponFire", getLocalPlayer(), onClientPlayerWeaponFireFunc)

addEventHandler("onClientColShapeHit", budki_cs, function(el,md)
  if (el~=localPlayer) then return end
  if not md then return end
  strzalow=0
  trafien=0
  startTime=getTickCount()
end)

addEventHandler("onClientColShapeLeave", budki_cs, function(el,md)
  if (el~=localPlayer) then return end
  if not md then return end
  if (strzalow==0) then return end
  local sekund=(getTickCount()-startTime)/1000  
  local podsumowanie="strzałow: " .. strzalow .. ", trafień: " .. trafien .. ", celność: " .. math.floor(trafien/strzalow*100) .."%"..", trafień na minutę: " .. math.floor(trafien*60/sekund)
  triggerServerEvent("broadcastCaptionedEvent", localPlayer, "*głos w megafonie* " .. getPlayerName(localPlayer) .. " - "..podsumowanie, 5, 15, true)
  strzalow=0
  trafien=0

end)