--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local nazwyItemow={
	[76]="pachołek"
}

-- obiekty tymczasowe, nie rejestrowane w bazie danych
-- triggerServerEvent("makeTemporaryObject", resourceRoot, 1238, x,y,z, getElementInterior(localPlayer), getElementDimension(localPlayer), 60*1000*60)
addEvent("makeTemporaryObject", true)
addEventHandler("makeTemporaryObject", resourceRoot, function(oid,x,y,z,rx,ry,rz,i,d,ttl,itemid)
	local o=createObject(oid,x,y,z,rx or 0,ry or 0,rz or 0)
	setElementInterior(o,i or 0)
	setElementDimension(o,d or 0)
	-- default ttl: 15 minut
	setElementData(o,'removeAfter', math.floor((getTickCount()+(ttl or 60*1000*15))/1000),false)
	if itemid then	-- obiekt mozna podniesc i wziasc do inwentarza
		setElementData(o,"customAction",{label="Podnieś",resource="lss-worlditems",funkcja="menu_podniesObiektTymczasowy",args={obiekt=o}})
		setElementData(o,"itemid", itemid, false)
	end
end)


local function removeOldObjects()
	for i,v in ipairs(getElementsByType("object",resourceRoot)) do
		local ra=getElementData(v,"removeAfter")
		if ra and getTickCount()/1000>ra then
			destroyElement(getElementData(v, "item:text"))
			destroyElement(v)
		end
	end
end

setTimer(removeOldObjects, 1000*60*1.5, 0)


-- triggerServerEvent("doPickupTemporaryObject", o)
addEvent("doPickupTemporaryObject", true)
addEventHandler("doPickupTemporaryObject", resourceRoot, function()
	local itemid=getElementData(source,"itemid")
	if not itemid then return end -- nie powinno sie wydarzyc
	if exports["lss-core"]:eq_giveItem(client, itemid, 1) then
		triggerEvent("broadcastCaptionedEvent", client, getPlayerName(client) .. " podnosi "..(nazwyItemow[itemid] or "coś")..".", 5, 15, true)
		destroyElement(source)
	end

end)

function findRotation(x1,y1,x2,y2)
 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
 
end

local SMOKE_ID = 2058
addEvent("onGrillMake", true)
addEventHandler("onGrillMake", getRootElement(), function(x,y,z)
	local px,py,pz=getElementPosition(source)
	local grill = createObject(1481, x,y,z)
	local rot = findRotation(x,y,px,py)
	setElementRotation(grill,0,0,rot-180)
	local dym = createObject(SMOKE_ID, x,y,z)
	setElementData(grill, "grill:smoke", dym)
	setElementData(grill, "grill", true)
	setElementData(grill, "grill:owner", source)
	
	
end)

addEvent("onBarierkaMake", true)
addEventHandler("onBarierkaMake", getRootElement(), function()
	if not getElementData(source, "faction:id") then return end
	local x,y,z = getElementPosition(source)
	local _,_,rot = getElementRotation(source)
	local barierka = createObject(16102, x, y, z-0.9)
	setElementRotation(barierka, 0, 180, rot+180)
	setElementData(barierka, "isBarierka", true)
	setElementData(barierka, "factionid", getElementData(source, "faction:id"))
end)



--ID poszczegolnych itemkow
local itemsModels = {
	--id itemka w eq, id objectu
	-- [1]=3044,
	[164]=2226,
	[166]=2749,
	-- [2]=367,
	-- [3]=1880,
	-- [65]=1851,
	-- [21]=330,
	-- [23]=325,
	-- [24]=325,
	-- [60]=325,
	-- [59]=325,
	-- [58]=325,
	-- [48]=325,
	-- [40]=325,
	-- [8]=1599,
	-- [10]=1599,
	-- [9]=1264,
	-- [13]=1953,
	-- [17]=1581,
	-- [25]=365,
	-- [27]=3027,
	-- [30]=346,
	-- [31]=336,
	-- [32]=333,
	-- [33]=334,
	-- [5]=ID_KLUCZY
	-- [14]=ID_KLUCZY
	-- [13]=ID_KLUCZY
	-- [12]=ID_KLUCZY
	-- [29]=ID_KLUCZY
	-- [20]=ID_KLUCZY
	-- [39]=ID_KLUCZY
	-- [57]=ID_KLUCZY
	-- [56]=ID_KLUCZY
	-- [55]=ID_KLUCZY
	-- [54]=ID_KLUCZY
	-- [53]=ID_KLUCZY
	-- [52]=ID_KLUCZY
	-- [51]=ID_KLUCZY
	-- [50]=ID_KLUCZY
	-- [49]=ID_KLUCZY
	-- [78]=ID_KLUCZY
	-- [77]=ID_KLUCZY
	-- [62]=ID_KLUCZY
	-- [75]=ID_KLUCZY
	-- [163]=ID_KLUCZY
	-- [149]=ID_KLUCZY
	-- [129]=ID_KLUCZY
	-- [128]=ID_KLUCZY
	-- [127]=ID_KLUCZY
	-- [126]=ID_KLUCZY
	-- [125]=ID_KLUCZY
	-- [124]=ID_KLUCZY
	-- [123]=ID_KLUCZY
	-- [122]=ID_KLUCZY
	-- [121]=ID_KLUCZY
	-- [120]=ID_KLUCZY
	-- [119]=ID_KLUCZY
	-- [118]=ID_KLUCZY
	-- [117]=ID_KLUCZY
	-- [106]=ID_KLUCZY
	-- [101]=ID_KLUCZY
	-- [92]=ID_KLUCZY
	-- [6]=ID_KLUCZY
	-- [80]=ID_KLUCZY
	-- [103]=ID_KLUCZY
	-- [19]=ID_GAZETA
	-- [144]=ID_NARKOTYKI
	-- [143]=ID_NARKOTYKI
	-- [142]=ID_NARKOTYKI
	-- [141]=ID_NARKOTYKI
	-- [140]=ID_NARKOTYKI
	-- [139]=ID_NARKOTYKI
	-- [138]=ID_NARKOTYKI
	-- [137]=ID_NARKOTYKI
	-- [151]=ID_Kamizelka PD
	-- [99]=2768,
	-- [98]=2769,
	-- [96]=2768,
	-- [91]=2768,
	-- [90]=2769,
	-- [89]=2769,
	-- [88]=2768,
	-- [86]=2769,
	-- [159]=2768,
	-- [158]=2769,
	-- [145]=2040,
	-- [136]=2040,
	-- [135]=2040,
	-- [134]=2040,
	-- [133]=2040,
	-- [132]=2040,
	-- [131]=2040,
	-- [130]=2040,
	-- [115]=356,
	-- [114]=353,
	-- [113]=355,
	-- [112]=352,
	-- [111]=347,
	-- [110]=348,
	-- [109]=349,
	-- [153]=2040,
	-- [152]=350,
	-- [148]=342,
	-- [81]=335,
	-- [87]=1543,
	-- [85]=1950,
	-- [84]=2647,
	-- [83]=1582,
	-- [82]=1520,
	-- [42]=1950,
	-- [46]=1581,
	-- [17]=1581,
	-- [104]=371,
	-- [74]=341,
	-- [79]=1097,
	-- [95]=3044,
	-- [15]=1221,
	-- [162]=1650,
	-- [161]=1650,
	[168]=2694,
}

addEvent("onItemDrop", true)
addEventHandler("onItemDrop", getRootElement(), function(id, subtype, nazwa, notRemoveAfter)
	-- if getPlayerName(source) ~= "Emi_Farens" then return end
	if getPedOccupiedVehicle(source) then return end
	local object_id = itemsModels[id] or 1210
	local x,y,z = getElementPosition(source)
	local ra,rb,rc = getElementRotation(source)
	local character = getElementData(source, "character")
	exports["lss-admin"]:gameView_add("ITEM_DROP "..character.imie.." "..character.nazwisko..", ID: "..id..", SUBTYPE:"..subtype)
	local shape = createColSphere(x,y,z,2)
	outputChatBox("(( Wyrzucony przedmiot zniknie za 15 minut ))", source)
	for k,v in ipairs(getElementsWithinColShape(shape,"object")) do
		if (getElementData(v, "item:id")==id) and (getElementData(v, "item:subtype")==subtype) then
			local ilosc = getElementData(v, "item:ilosc")+1
			setElementData(v, "item:ilosc", ilosc)
			setElementData(getElementData(v, "item:text"), "text", getElementData(v, "item:nazwa").." ("..ilosc..") ["..subtype.."]")
			return
		end
	end
	
	local object = createObject(object_id, x, y, z-0.9)
	local int = getElementInterior(source)
	local dim = getElementDimension(source)
	setElementInterior(object, int)
	setElementDimension(object, dim)
	setElementRotation(object, 0, 0, rc)
	setElementData(object, "item:id", id)
	setElementData(object, "item:subtype", subtype)
	setElementData(object, "item:ilosc", 1)
	setElementData(object, "item:nazwa", nazwa)
	if not notRemoveAfter then
		setElementData(object,'removeAfter', math.floor((getTickCount()+(ttl or 60*1000*15))/1000),false)
	end
	--robimy text
	local text = createElement("text")
	local int = getElementInterior(source)
	local dim = getElementDimension(source)
	setElementInterior(text, int)
	setElementDimension(text, dim)
	setElementPosition(text, x,y,z-0.3)
	setElementData(text, "text", nazwa.." (1) ["..subtype.."]")
	
	setElementData(object, "item:text", text)
	
end)


addEvent("onItemPickup", true)
addEventHandler("onItemPickup", getRootElement(), function(obj)
	-- if getPlayerName(source) ~= "Emi_Farens" then return end
	if getElementData(obj, "item:podnoszony") then return end
	local id = getElementData(obj, "item:id")
	local ilosc = getElementData(obj, "item:ilosc")
	local subtype = getElementData(obj, "item:subtype")
	local add = exports["lss-core"]:eq_giveItem(source, id, ilosc, subtype)
	setElementData(obj, "item:podnoszony", true)
	local character = getElementData(source, "character")
	exports["lss-admin"]:gameView_add("ITEM_PICKUP "..character.imie.." "..character.nazwisko..", ID: "..id..", SUBTYPE:"..subtype)
	if add then
		local x1,y1 = getElementPosition(source)
		local x2,y2 = getElementPosition(obj)
		local rot = findRotation(x1,y1,x2,y2)
		setElementRotation(source, 0, 0, rot)
		setPedAnimation(source, "MEDIC", "CPR", -1, false, false)
		triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source) .. " podnosi coś.", 5, 15, true)
		setTimer(function(obj, plr)
			destroyElement(getElementData(obj, "item:text"))
			destroyElement(obj)
			setPedAnimation(plr)
		end, 2900, 1, obj, source)
	end
end)