--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author RacheT <rachet@pylife.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local current_cp=nil
local current_zrobionychzdjec=-1
local current_rotations={}

local trojnog={}

local function usunTrojnog()
  for i,v in ipairs(trojnog) do
    destroyElement(v)
  end
  trojnog={}

end

local function utworzTrojnog(x,y,z)
  usunTrojnog()
--[[<object id="object (vgsNscffple) (1)" interior="0" collisions="false" alpha="255" doublesided="true" model="3503" scale="0.5" dimension="0" posX="9.79456" posY="10.34028" posZ="2.70801" rotX="30" rotY="0" rotZ="0"></object>
    <object id="object (vgsNscffple) (2)" interior="0" collisions="false" alpha="255" doublesided="true" model="3503" scale="0.5" dimension="0" posX="9.46442" posY="10.04857" posZ="2.72884" rotX="29.998" rotY="0" rotZ="90"></object>
    <object id="object (vgsNscffple) (3)" interior="0" collisions="false" alpha="255" doublesided="true" model="3503" scaposZ="2.70801" rotX="29.998" rotY="0" rotZ="225"></object>
    <object id="object (1)" interior="0" alpha="255" doublesided="false" model="367" scale="1" dimension="0" posX="9.92599" posY="10.04202" posZ="3.33074" rotX="0" rotY="0" rotZ="130"></object>
    <object id="object (ab_hook) (1)" interior="0" collisions="false" alpha="255" doublesided="false" model="2590" scale="0.5" dimension="0" posX="9.77356" posY="10.00918" posZ="3.20133" rotX="0" rotY="0" rotZ="0"></object>
]]--
  local o=createObject(3503,9.79456+x-9,10.34028+y-10,2.70801+z-2,30)
  setObjectScale(o, 0.5)
  setElementCollisionsEnabled(o,false)
  table.insert(trojnog, o)

  o=createObject(3503,9.46442+x-9,10.04875+y-10,2.72884+z-2,29.998,0,90)
  setObjectScale(o, 0.5)
  setElementCollisionsEnabled(o,false)
  table.insert(trojnog, o)

  o=createObject(3503,10.01434+x-9,9.77147+y-10,2.70801+z-2,29.998,0,225)
  setObjectScale(o, 0.5)
  setElementCollisionsEnabled(o,false)
  table.insert(trojnog, o)

  current_zrobionychzdjec=-1
  current_rotations={}
end

function findRotation(startX, startY, targetX, targetY)	-- Doomed-Space-Marine
	local t = -math.deg(math.atan2(targetX - startX, targetY - startY))
	if t < 0 then
		t = t + 360
	end
	return t
end




function displayNextCP()
  local punkt=punkty_pomiarow[math.random(#punkty_pomiarow)]
  if current_cp and isElement(current_cp) then
    destroyElement(current_cp)
  end
  current_cp=createMarker(punkt[1],punkt[2],punkt[3]-0.9, "cylinder", 1)
  txt=string.format("(( [Geodezja] następny punkt znajduje się w: %s, %s ))", getZoneName(punkt[1], punkt[2], punkt[3]), getZoneName(punkt[1], punkt[2], punkt[3],true))
  outputChatBox(txt, 255,100,255)
  setElementData(current_cp,"geodezja", true)
  -- exports["lss-gui"]:setGPSTarget(localPlayer, punkt[1],punkt[2],punkt[3])
  local zone = getZoneName(punkt[1], punkt[2], punkt[3], true)..", "..getZoneName(punkt[1], punkt[2], punkt[3])
  local setTarget = exports["lss-gui"]:setGPSTarget(getLocalPlayer(), {punkt[1], punkt[2], punkt[3]}, zone)
  -- call(getResourceFromName("lss-gui"), "setGPSTarget", localPlayer, punkt[1],punkt[2],punkt[3])
  current_zrobionychzdjec=-1
end


addEventHandler("onClientMarkerHit", resourceRoot, function(el,md)
  if el~=localPlayer or not md then return end
--  if getMarkerType(source)~="corona" then return end
  if not getElementData(source,"geodezja") then return end
  if current_zrobionychzdjec<0 then
    -- rozstawiamy trojnog
    local x,y,z=getElementPosition(source)
    utworzTrojnog(x-0.9,y,z-0.4)
    current_zrobionychzdjec=0
    current_rotations={}
    outputChatBox("(( [Geodezja] wykonaj zdjęcie trójnogu z conajmniej dwóch różnych punktów ))", 255,255,0)
    outputChatBox("(( [Geodezja] odległych o minimum 25m i 60 stopni. ))", 255,255,0)
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " rozstawia trójnóg", 5, 50, true)
  elseif current_zrobionychzdjec<3 then
    outputChatBox("(( [Geodezja] musisz wykonać conajmniej 3 zdjęcia. Wykonano tylko " .. current_zrobionychzdjec.." ))", 255,255,0)
    return
  elseif current_zrobionychzdjec>=3 then
    usunTrojnog()
    displayNextCP()
    triggerServerEvent("givePlayerMoney", getRootElement(), localPlayer, math.random(3,6))
    playSoundFrontEnd(14)
  end
end)

addEventHandler("onClientPlayerWeaponFire", localPlayer, function(weapon)
  if weapon~=43 then return end

  if current_zrobionychzdjec<0 then return end
  if current_zrobionychzdjec>=3 then
    outputChatBox("(( [Geodezja] Punkty zanotowane, zabierz trójnóg. ))", 255,0,255)
    return
  end

  if not current_cp or not isElement(current_cp) then return end

  if not isElementOnScreen(trojnog[1]) then return end 
  local x1,y1,z1=getCameraMatrix()
  local x2,y2,z2=getElementPosition(trojnog[1])
  if not isLineOfSightClear(x1,y1,z1,x2,y2,z2) then return end
  local dist=getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)
  local rotation=findRotation(x1,y1,x2,y2)
  local txt=string.format("(( [Geodezja] Odległość: %.1fm, Kąt: %.1f stopni ))", dist, rotation)
  outputChatBox(txt, 255,255,0)

  if dist<25 then
    outputChatBox("(( [Geodezja] Jesteś zbyt blisko - wymagana odległość 25m ))", 255,0,0)
    return
  end

  for i,v in ipairs(current_rotations) do

    local od=math.abs((v-rotation)%360)
    if od<60 or od>300 then
      outputChatBox("(( [Geodezja] Jesteś zbyt blisko poprzedniego punktu zrobienia zdjęcia. ))", 255,0,0)
      return
    end
  end

  table.insert(current_rotations, rotation)
  current_zrobionychzdjec=current_zrobionychzdjec+1
  if current_zrobionychzdjec==3 then
    outputChatBox("(( [Geodezja] Punkty zanotowane, zabierz trójnóg. ))", 255,0,255)
    return
  else
    outputChatBox("(( [Geodezja] Punkt zanotowany, zrób kolejne zdjęcie ("..current_zrobionychzdjec.."/3) ))", 255,255,0)
    return
  end
end)


addEvent("startJob", true)
addEventHandler("startJob", resourceRoot, function()
  pracaLU=getTickCount()
  displayNextCP()

end)
