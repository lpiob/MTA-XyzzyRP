--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--




local I=1
local D=42

local sortedAmount=0
local lastClickedButton,previousClickedButton

local sortownie={
	wysypisko={
		container_id=1728,	-- id magazynu z tabeli lss_containers
		punkty={
		 	{658.25,-613.50,1595.63},
			{653.32,-613.42,1595.63},
			{637.39,-613.35,1595.64},
			{631.62,-613.30,1595.63},
		}
	},
}

local function smieciWPojemniku(container_id)
	local w=exports.DB2:pobierzWyniki("select count from lss_container_contents where container_id=? and itemid=9", container_id)
	if not w or not w.count then return 0 end
	return w.count
end


for _,magazyn in pairs(sortownie) do
	magazyn.element=createElement("sortownia")
	setElementData(magazyn.element,"smieci", smieciWPojemniku(magazyn.container_id))
	for i,v in ipairs(magazyn.punkty) do
		v.marker=createMarker(v[1],v[2],v[3],"corona",2,100,0,0,100)
		setElementInterior(v.marker, I)
		setElementDimension(v.marker, D)
		setElementParent(v.marker,magazyn.element)
	end
end

local function sortownieSpool()
	for _,magazyn in pairs(sortownie) do
		setElementData(magazyn.element,"smieci", smieciWPojemniku(magazyn.container_id))
	end
end

setTimer(sortownieSpool, 60*1000, 0)


local itemids={73,72,71,70,69,68,67,66}

local container_id=1728

-- triggerServerEvent("playerSortedItems", resourceRoot, sortedItems)
addEvent("playerSortedItems", true)
addEventHandler("playerSortedItems", resourceRoot, function(amnts)
	local suma=0
	for i,v in ipairs(amnts) do
		if v and v>0 then
			local itemid=itemids[i]
			exports["lss-pojemniki"]:insertItemToContainer(container_id, itemid, v)
			suma=suma+v
		end
	end
	if suma>0 then
		if not exports["lss-pojemniki"]:insertItemToContainer(container_id, 9, -suma) then
			exports["lss-pojemniki"]:insertItemToContainer(container_id, 9, -1)
		end
	end
end)