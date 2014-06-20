--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



interiory={}

function getInterior(id)
	id=tonumber(id)
	if (interiory[id] and type(interiory[id])=="table") then return interiory[id] end

	local query=string.format("select id,interior,entrance,`exit`,dimension,opis FROM lss_interiory WHERE 1 and id=%d LIMIT 1", id)

	local int=exports.DB:pobierzWyniki(query)

	if (not int) then
		return nil
	end

	if (int.entrance and type(int.entrance)=="string") then 
		int.entrance=split(int.entrance,",")
	else
		int.entrance=nil
	end

	if (int.exit and type(int.exit)=="string") then
		int.exit=split(int.exit,",")			-- wyjscie
	else
		int.exit=nil
	end

	interiory[id]=int


	return int

end