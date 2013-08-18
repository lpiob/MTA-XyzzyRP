--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- punkt odbioru drzewa
local CONTAINER_ID=2462 -- pojemnik do ktorego trafiaja surowce
local ITEMID=67	-- drewno

local m=createMarker(-488.08,-179.94,77.21,"cylinder", 4.5,100,100,100,100)
local m2=createMarker(-536.98,-74.41,61.86,"cylinder", 4.5, 100,100,100,100)
local m3=createMarker(-528.71,-60.98,61.97,"cylinder", 4.5, 100,100,100,100)
local m4=createMarker(-472.82,-180.96,77.21,"cylinder", 4.5, 100,100,100,100)

local function znajdzWiezioneDrzewo(p)
	local elementy=getAttachedElements(p)
	for i,v in ipairs(elementy) do
		if getElementType(v)=="object" and getElementModel(v)==1463 then return v end
	end
	return nul
end

local function przyjecieDrzewa(el,md)
	if not md then return end
	if getElementType(el)~="vehicle" then return end
	if getElementModel(el)~=530 then return end -- forklift
	local drzewo=znajdzWiezioneDrzewo(el)
	if not drzewo then return end
	destroyElement(drzewo)
	triggerEvent("broadcastCaptionedEvent", getVehicleController(el), getPlayerName(getVehicleController(el)).." rozładowuje drewno", 4, 10, true)
	setElementFrozen(el,true)
	setTimer(function(el)
		local kwity = math.random(1,2)
		exports["lss-core"]:eq_giveItem(getVehicleController(el), 13, kwity)
		outputChatBox("(( Otrzymałeś "..kwity.." kwitów do wypłaty ))", getVehicleController(el))
		setElementFrozen(el,false)
	end, 5000, 1, el)
--	exports["lss-pojemniki"]:insertItemToContainer(CONTAINER_ID, ITEMID, 5, 0, "Drewno")
end
addEventHandler("onMarkerHit", m, przyjecieDrzewa)
addEventHandler("onMarkerHit", m2, przyjecieDrzewa)
addEventHandler("onMarkerHit", m3, przyjecieDrzewa)
addEventHandler("onMarkerHit", m4, przyjecieDrzewa)
