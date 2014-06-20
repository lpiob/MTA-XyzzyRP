--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



--
local nazwyNeonow={
 [1]="czerwone", -- 14399
 [2]="niebieskie",
 [3]="zielone",
 [4]="żółte",
 [5]="purpurowe",
 [6]="białe"
}

local function mozeMontowac()
	local lfid=tonumber(getElementData(localPlayer, "faction:id"))
	if not lfid then return false end
	if lfid==18 or lfid==12 or lfid==3 or lfid==13 then
		local lfrank=tonumber(getElementData(localPlayer, "faction:rank_id"))
		if not lfrank or lfrank<=1 then return false end
		return true
	end
	return false
end

function menu_montazWPojezdzie(args)
	if not mozeMontowac() then
		outputChatBox("Nie potrafisz montować osprzętu w pojeździe ((tylko mechanicy od rangi 2 i wyższych))")
		return
	end

	local veh,itemid=args.vehicle, tonumber(args.itemid)
	if not veh or not itemid then return end
	local veh_dbid=tonumber(getElementData(veh,"dbid"))
	if not veh_dbid then
		outputChatBox("W tym pojeździe nie można nic zamontować")
		return
	end
	local x,y,z=getElementPosition(veh)
	local x2,y2,z2=getElementPosition(localPlayer)
	if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>5 then
		outputChatBox("(( Musisz podejść bliżej ))")
		return
	end
	if itemid==61 then -- neony
		outputChatBox(" ")
		outputChatBox("Posiadasz następujące zestawy do montażu neonów:")
		local EQ=exports["lss-gui"]:eq_get()
		for i,v in ipairs(EQ) do
			if (v.itemid and tonumber(v.itemid)==61 and v.subtype and tonumber(v.subtype) and nazwyNeonow[tonumber(v.subtype)]) then
				outputChatBox(" * " .. tostring(v.subtype) .. " " .. nazwyNeonow[tonumber(v.subtype)])
			end
		end
		outputChatBox("Aby zamontować neon, użyj komendy /zamontujneon " .. veh_dbid .. " <id zestawu>")
		outputChatBox(" ")
	end

end

