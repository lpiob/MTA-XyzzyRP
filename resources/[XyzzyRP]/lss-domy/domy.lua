--[[
Domy do wynajecia

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2010-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--



domy={}

local function usunDom(id)
	if isElement(domy[id].wyjscie) then destroyElement(domy[id].wyjscie) end
	if isElement(domy[id].wejscie) then destroyElement(domy[id].wejscie) end
	if isElement(domy[id].cs) then destroyElement(domy[id].cs) end
	if isElement(domy[id].text) then destroyElement(domy[id].text) end
	domy[id]=nil
end

local function dodajDom(v,fast)

	if not interiory[v.interiorid] then return false end
--	if tonumber(v.id)==151 then
--		outputChatBox("151")
--	end

	if domy[v.id] then
		usunDom(v.id)
	end

	v.drzwi=split(v.drzwi,",")
	for ii,vv in ipairs(v.drzwi) do		v.drzwi[ii]=tonumber(vv)	end
	v.punkt_wyjscia=split(v.punkt_wyjscia,",")
	for ii,vv in ipairs(v.punkt_wyjscia) do		v.punkt_wyjscia[ii]=tonumber(vv)	end
	local pickupid=1272
	if (not v.ownerid) then
		pickupid=1273
	end
	v.wejscie=createPickup ( v.drzwi[1], v.drzwi[2], v.drzwi[3], 3, pickupid, 0)
	v.cs=createColSphere(v.drzwi[1],v.drzwi[2],v.drzwi[3], 1)


	if (not fast and v.ownerid) then
		v.text=createElement("text")
		setElementPosition(v.text, v.drzwi[1],v.drzwi[2],v.drzwi[3]+0.5)
--		setElementPosition(v.text, 2903.09,-32.64,-24.62)

--		setElementData(v.text,"text", "dom")
		setElementData(v.text,"text", (v.descr or "Dom").."\n"..v.owner_nick)

	end
	local interior_dimension=v.vwi or 1000+v.id

	setElementData(v.cs, "dom", { 
		["zamkniety"]=v.zamkniety>0 and true or false,
		["id"]=v.id,
		["koszt"]=v.koszt, 
		["ownerid"]=v.ownerid, 
		["owner_nick"]=v.owner_nick, 
		["descr"]=v.descr or "dom", 
		["dimension"]=interior_dimension,
		["interior"]=interiory[v.interiorid].interior,
		["interior_loc"]=interiory[v.interiorid].entrance,
		["exit_loc"]=v.punkt_wyjscia,
		["paidTo"]=v.paidTo,
		["paidTo_dni"]=v.paidTo_dni,
--		["veha"]=(v.vehicles_allowed and v.vehicles_allowed>0) and true or false
	})



-- dodajemy wyjscie
	v.wyjscie=createMarker(interiory[v.interiorid].exit[1], interiory[v.interiorid].exit[2], interiory[v.interiorid].exit[3], "arrow",1)
	setElementDimension(v.wyjscie, interior_dimension)
	setElementInterior(v.wyjscie, interiory[v.interiorid].interior)
	setElementData(v.wyjscie,"tpto", v.punkt_wyjscia)


	local dbid=v.id
	v.id=nil
	domy[dbid]=v

	return true
end

function domyGetInfo(id)
	return domy[id]
end

local function zaladujCzescDomow(procent,fast)
	local tt=getTickCount()
    i=0
	exports.DB2:zapytanie("UPDATE lss_domy SET paidTo=NULL,ownerid=NULL where paidTo<NOW() or paidTo IS NULL")
	local dbdomy
	if fast then
		dbdomy=exports.DB2:pobierzTabeleWynikow("SELECT d.id,d.descr,d.vwi,d.drzwi,d.punkt_wyjscia,d.interiorid,d.ownerid,concat(c.imie,' ',c.nazwisko) owner_nick,d.zamkniety,d.koszt,d.paidTo,datediff(d.paidTo,now()) paidTo_dni FROM lss_domy d LEFT JOIN lss_characters c ON c.id=d.ownerid WHERE d.active=1 AND d.ownerid IS NOT NULL;")
	else
		dbdomy=exports.DB2:pobierzTabeleWynikow("SELECT d.id,d.descr,d.vwi,d.drzwi,d.punkt_wyjscia,d.interiorid,d.ownerid,concat(c.imie,' ',c.nazwisko) owner_nick,d.zamkniety,d.koszt,d.paidTo,datediff(d.paidTo,now()) paidTo_dni FROM lss_domy d LEFT JOIN lss_characters c ON c.id=d.ownerid WHERE d.active=1;")
	end
	for __,v in ipairs(dbdomy) do
		if math.random(0,100)<=procent then
--			outputChatBox("Wgrywanie domu " .. v.id)
			if dodajDom(v,fast) then i=i+1 end
		end
	end                             
	outputDebugString("Zaladowano domow: " .. i .. " w " .. (getTickCount()-tt) .. "ms")
end
-- setTimer(zaladujCzescDomow, 10*1000*60, 0, 100)
addEventHandler("onResourceStart", resourceRoot, function()
	zaladujCzescDomow(100,false)
end)

local function zaladujZmienioneDomy()
	local i=0
	local dbdomy=exports.DB2:pobierzTabeleWynikow("SELECT d.id,d.descr,d.vwi,d.drzwi,d.punkt_wyjscia,d.interiorid,d.ownerid,concat(c.imie,' ',c.nazwisko) owner_nick,d.zamkniety,d.koszt,d.paidTo,datediff(d.paidTo,now()) paidTo_dni FROM lss_domy d LEFT JOIN lss_characters c ON c.id=d.ownerid WHERE d.active=1 AND timediff(now(),d.updated)<'00:09:00' AND datediff(now(),d.updated)<1")
	for __,v in ipairs(dbdomy) do

			if dodajDom(v) then i=i+1 end
	end                             
	outputDebugString("Zaladowano zmienionych domow: " .. i)
end

setTimer(zaladujZmienioneDomy, 10*1000*5, 0)


function domReload(id)
	local dbdom=exports.DB2:pobierzWyniki("SELECT d.id,d.descr,d.vwi,d.drzwi,d.punkt_wyjscia,d.interiorid,d.ownerid,concat(c.imie,' ',c.nazwisko) owner_nick,d.zamkniety,d.koszt,d.paidTo,datediff(d.paidTo,now()) paidTo_dni FROM lss_domy d LEFT JOIN lss_characters c ON c.id=d.ownerid WHERE d.active=1 and d.id=?;",id)
	if dbdom then
		return dodajDom(dbdom)
	end
	return false
end



