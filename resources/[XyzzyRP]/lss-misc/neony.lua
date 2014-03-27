--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



--
local nazwyNeonow={
 [1]="czerwony", -- 14399
 [2]="niebieski",
 [3]="zielony",
 [4]="żółty",
 [5]="purpurowy",
 [6]="biały"
}


local function getVehicleByVID(vid)
	for i,v in ipairs(getElementsByType("vehicle")) do
		local dbid=getElementData(v,"dbid")
		if dbid and tonumber(dbid)==tonumber(vid) then return v end
	end
	return nil
end

local function mozeMontowac(plr)
	local lfid=tonumber(getElementData(plr, "faction:id"))
	if not lfid then return false end
	if lfid==18 or lfid==12 or lfid==3 or lfid==13 then
		local lfrank=tonumber(getElementData(plr, "faction:rank_id"))
		if not lfrank or lfrank<=1 then return false end
		return true
	end
	return false
end



-- /zamontujneon <id pojazdu> <subtype>

addCommandHandler("zamontujneon", function(plr,cmd,pojazd,subtype)
	if not mozeMontowac(plr) then
		outputChatBox("Nie potrafisz montować osprzętu w pojeździe ((tylko mechanicy od rangi 2 i wyższych))",plr)
		return
	end

	if not pojazd or not subtype or not tonumber(pojazd) or not tonumber(subtype) or not nazwyNeonow[tonumber(subtype)] then
		return
	end

	local veh = getVehicleByVID(tonumber(pojazd))
	if not veh then
		outputChatBox("(( Nie odnaleziono podanego pojazdu. ))", plr)
		return
	end

	local x,y,z=getElementPosition(plr)
	local x2,y2,z2=getElementPosition(veh)
	if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>7 then
		outputChatBox("(( Musisz podejść bliżej do pojazdu. ))", plr)
		return
	end

	-- sprawdzamy czy gracz ma dany typ neonu
	if not exports["lss-core"]:eq_getItem(plr,61,tonumber(subtype)) then
		outputChatBox("(( Nie masz podanego ID neonu w swoim ekwipunku ))", plr)
		return
	end

	-- sprawdzamy czy ten pojazd w ogole nadaje sie do montazu neonu
	local typ=getVehicleType(veh)
	if typ~="Automobile" then
		outputChatBox("(( W tym pojeździe nie można zamontować neonów. ))", plr)
		return
	end

	-- sprwadzamy czy pojazd ma juz jakis neon
	local rodzajneonu=tonumber(getElementData(veh,"neony"))
	if rodzajneonu then
		outputChatBox("(( Ten pojazd posiada już zamontowany neon. Demontaż/zmiana neonu bedą wprowadzone wkrótce. ))", plr)
		return
	end
	
	-- zabieramy graczowi neon
	if not exports["lss-core"]:eq_takeItem(plr,61,1,tonumber(subtype)) then
		outputChatBox("(( Montaż neonu nie udał się ))", plr)
		return
	end
	
	-- montujemy neon
	setElementData(veh,"neony",tonumber(subtype))
	-- zapisujemy informacje do bazy danych
	local query=string.format("UPDATE lss_vehicles SET neony=%d WHERE id=%d LIMIT 1", tonumber(subtype), tonumber(pojazd))
	exports.DB:zapytanie(query)

	triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr).." montuje neon w pojeździe.", 5, 5, true)
	outputChatBox("(( Jeżeli neon źle przystaje do pojazdu, lub wisi pod nim, to powiadom o tym administrację ", plr)
	outputChatBox("   podając id lub model pojazdu ))", plr)

end,false,false)