--[[

Okazjonalnie uzywany kod przy resecie broni

@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



                                                                                                                                                            
-- delete from lss_container_contents where itemid in (24, 30, 40, 48, 59, 60)

local itemy={24,30,40,48,59,60}

function usunBronieGracza(p)
	if not isElement(p) then return end
	local c=getElementData(p,"character")
	if not c.id then return end

	local ub=exports.DB2:pobierzWyniki("SELECT bu FROM lss_characters WHERE id=? AND bu IS NOT NULL",c.id)
	if not ub or ub.bu then 
      return end -- temu graczowi juz usunelismy!

	for _,item in ipairs(itemy) do
		local przedmiot=exports["lss-core"]:eq_getItem(p,item)
		if przedmiot and przedmiot.count and przedmiot.count>0 then
			exports["lss-admin"]:gameView_add("usuwanie broni, gracz " .. getPlayerName(p) .. "/"..c.id.." bron " .. item .. " ilosc " .. przedmiot.count)
			exports["lss-core"]:eq_takeItem(p,item,przedmiot.count)
		end
	end

	exports.DB2:zapytanie("UPDATE lss_characters SET bu=NOW() where id=?", c.id)

end



--for _,p in ipairs(getElementsByType("player")) do
--	usunBronieGracza(p)
--end