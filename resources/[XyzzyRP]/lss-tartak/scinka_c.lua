--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local scinane_drzewo=nil
local scinanie_timer=nil

function findRotation(x1,y1,x2,y2)
 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
 
end

local function zetnijDrzewo()
	if not scinane_drzewo then return end
	local c1,c2=getPedAnimation(localPlayer)
	-- if not c1 or c1~="chainsaw" or c2~="WEAPON_csaw" then return end

	triggerServerEvent("scieteDrzewo", scinane_drzewo)
	scinane_drzewo=nil
--	if math.random(1,8)==1 then			triggerServerEvent("onLaweczkaProgress", localPlayer)	end
--	if math.random(1,10)==1 then			triggerServerEvent("onTreadProgress", localPlayer)	end
end

function menu_zetnij(drzewo)
--	outputChatBox("(( Tartak jest w trakcie przygotowywania. ))")
--	if not args.drzewo or not isElement(args.drzewo) then	return	end
	local x,y=getElementPosition(localPlayer)
	local x2,y2=getElementPosition(drzewo)
	if getDistanceBetweenPoints2D(x,y,x2,y2)>5 then
		outputChatBox("(( Musisz podejść bliżej ))")
		return
	end
	if getPedWeapon(localPlayer)~=9 then
		outputChatBox("(( Musisz mieć w rękach piłę spalinową, aby ściąc drzewo. ))")
		return
	end
	triggerServerEvent("setPedAnimation", localPlayer, localPlayer)
	toggleControl("fire", false)
	setTimer(triggerServerEvent, 700, 1, "setPedAnimation", localPlayer, "CHAINSAW", "WEAPON_csaw", true)
	local rot = findRotation(x,y,x2,y2)
	setElementRotation(localPlayer, 0, 0, rot)
	scinane_drzewo=drzewo
	setElementFrozen(localPlayer, true)
	if isTimer(scinanie_timer) then killTimer(scinanie_timer) end
	scinanie_timer=setTimer(function(plr)
	zetnijDrzewo()
	setElementFrozen(plr, false)
	if not getElementData(plr, "kary:blokada_bicia") then toggleControl("fire", true) end
	end, math.random(7000,14000), 1, localPlayer)
end

-- triggerClientEvent("setObjectBreakable", source, false)
addEvent("setObjectBreakable", true)
addEventHandler("setObjectBreakable", resourceRoot, function(state)
	setObjectBreakable(source, state)
end)

-- obsluga forklifta
-- w przyszlosci do przeniesienia do innego zasobu

local function czyForkliftWiezieObiekty(v)
	local wiezione=getAttachedElements(v)
	for i,v in ipairs(wiezione) do
		if getElementType(v)=="object" then return true end
	end
	return false
end

local function checkForklift()
	local v=getPedOccupiedVehicle(localPlayer)
	if not v then return end
	if getElementModel(v)~=530 then return end

	local ap=getVehicleAdjustableProperty(v)
	if ap>0 then return end
	
	-- sprawdzamy czy juz cos wieziemy
	if czyForkliftWiezieObiekty(v) then
		triggerServerEvent("forklift_opusc", v)
	else	-- podnosimy obiekt
		triggerServerEvent("forklift_podnies", v)
		
	end
	

end

bindKey("special_control_up", "up", checkForklift)
bindKey("special_control_down", "up", checkForklift)






-- scinanie drzewa lpm

local function znajdzDrzewo()
  local x,y,z=getElementPosition(localPlayer)
  local drzewa=getElementsByType("object", resourceRoot)

  
  for i,v in ipairs(drzewa) do
    local x2,y2,z2=getElementPosition(v)
    if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<5 then
      if getElementData(v,"tartak:drzewo") then return v end
    end

  end
  return nil
end

bindKey("fire", "down", function()
  if getPedWeaponSlot(localPlayer)~=1 or getPedWeapon(localPlayer)~=9 then return end
  local cs=getElementByID("tartak:cs")

  if not cs then return end
  if not isElementWithinColShape(localPlayer,cs) then return end

  local drzewo=znajdzDrzewo()
  if not drzewo then return end
  menu_zetnij(drzewo)

  
end)