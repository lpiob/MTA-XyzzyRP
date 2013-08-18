--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local function iloscGotowkiWPojemniku(pojemnik)
	local query=string.format("SELECT count FROM lss_container_contents WHERE itemid=-1 AND container_id=%d AND subtype=0", tonumber(pojemnik) or 0)
	local dane=exports.DB:pobierzWyniki(query)
	if not dane or not dane.count then return 0 end
	return tonumber(dane.count)
end

local function pobierzDaneMagazynu(magazyn)
	local dane={}
	local m=magazyny[magazyn]
	dane.magazyn=magazyn
	dane.nazwa=m.nazwa
	-- gotowka w pojemniku
	if not m.money_container_id then
		dane.gotowka=0
	else
		dane.gotowka=iloscGotowkiWPojemniku(m.money_container_id)
	end
	-- stan magazynowy
	dane.stan_magazynowy=exports.DB2:pobierzTabeleWynikow("SELECT i.id item_id,i.name item_name,sm.count stan_magazynowy,mo.buyprice,mo.sellprice from lss_items i LEFT JOIN lss_container_contents sm ON sm.itemid=i.id AND sm.container_id=? AND sm.subtype=0 LEFT JOIN lss_magazyny_oferta mo ON mo.container_id=sm.container_id AND mo.itemid=i.id WHERE i.surowiec=1", m.item_container_id)
	return dane
end

-- triggerServerEvent("doFetchDaneMagazynu", resourceRoot, getElementData(source, "magazyn"))
addEvent("doFetchDaneMagazynu", true)
addEventHandler("doFetchDaneMagazynu", resourceRoot, function(magazyn)
	if not magazyny[magazyn] then
		outputDebugString("Otrzymano żądanie otwarcia magazynu ktory nie istnieje.")
		return
	end
	triggerClientEvent(client, "doFillDaneMagazynu", resourceRoot, pobierzDaneMagazynu(magazyn))
end)


addEvent("doSaveDaneMagazynu", true)
addEventHandler("doSaveDaneMagazynu", resourceRoot, function(dane)

	if not magazyny[dane.magazyn] then return end -- nie pwinno sie wydarzyc
	local ccid=magazyny[dane.magazyn].item_container_id
	-- todo weryfikacja uprawnien
	for i,v in ipairs(dane.stany_magazynowe) do
		if tonumber(v.buyprice) and v.buyprice==0 then v.buyprice=nil end
		if tonumber(v.sellprice) and v.sellprice==0 then v.sellprice=nil end
		if (not v.buyprice or v.buyprice==0) and (not v.sellprice or v.sellprice==0) then
			exports.DB2:zapytanie("DELETE FROM lss_magazyny_oferta WHERE container_id=? AND itemid=? LIMIT 1", ccid, v.item_id)
		else
			outputDebugString("a")
			exports.DB2:zapytanie("INSERT INTO lss_magazyny_oferta SET container_id=?,itemid=?,buyprice=?,sellprice=? ON DUPLICATE KEY UPDATE buyprice=?,sellprice=?",
			ccid,v.item_id,v.buyprice,v.sellprice,v.buyprice,v.sellprice)
		end
	end

end)