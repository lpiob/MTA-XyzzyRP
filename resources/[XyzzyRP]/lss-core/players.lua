--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@author Rootkiller <rootkiller.programmer@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--




function savePlayerData(plr)
    local character=getElementData(plr,"character")
    if (not character or not character.id) then return end	-- gracz nie zalogowal sie jeszcze/nie wybral postaci
	local uid=getElementData(plr,"auth:uid")
	if not uid then return end

	-- aktywnosc supportu
	if (isSupport(plr) or isAdmin(plr)) then -- and not isGuestAccount(plr) then

		if uid then
			local query=string.format("insert into lss_users_activity SET id_user=%d,data=DATE(NOW()),hour=HOUR(NOW()),minut=1 ON DUPLICATE KEY UPDATE minut=minut+1;",uid)
			exports.DB:zapytanie(query)
		end
	end

	-- gp
	local gp=getElementData(plr,"GP")
	if tonumber(gp) and gp>=0 then
		exports.DB2:zapytanie("UPDATE lss_users SET gp=? WHERE id=? LIMIT 1", gp, uid)
	end

    local hp=getElementHealth(plr)
    local ar=getPedArmor(plr)
    local money=getPlayerMoney(plr)
    local opis=getElementData(plr,"opis") or ""
    opis=exports.DB:esc(opis)
    if (money<0) then money=0 end

    local query = ""
    if (getElementData(plr,"kary:blokada_aj")) then 
        -- Zapisujemy statystyki gracza bez pozycji podczas tego gdy jest w aj (Pozwala zniwelować lukę umożliwiającą "generowanie" gotówki)
        query=string.format("UPDATE lss_characters SET hp=%d,ar=%d,money=%d,playtime=playtime+1,lastseen=NOW(),satiation=%d,ab_spray=%d,opis='%s' WHERE id=%d LIMIT 1", hp, ar, money, tonumber(character.satiation) or 75, tonumber(character.ab_spray) or 0, opis, character.id)
    else
        -- Zapisujemy pełne statystyki gracza włącznie z pozycją.
        local x,y,z=getElementPosition(plr)
        local _,_,rz=getElementRotation(plr)
        local interior=getElementInterior(plr)
        local dimension=getElementDimension(plr)   
        query=string.format("UPDATE lss_characters SET lastpos='%.2f,%.2f,%.2f,%d,%d,%d',hp=%d,ar=%d,money=%d,playtime=playtime+1,lastseen=NOW(),satiation=%d,ab_spray=%d,opis='%s' WHERE id=%d LIMIT 1", x,y,z,rz,interior,dimension, hp, ar, money, tonumber(character.satiation) or 75, tonumber(character.ab_spray) or 0, opis, character.id)
    end
    exports.DB:zapytanie(query)   
end

addEventHandler("onPlayerQuit", root, function()
    -- todo, moze nie zapisywac pozycji jesli powodem wyjscia jest kick/ban/timeout?
    savePlayerData(source)
end)

-- petla zapisujaca dane graczy
-- uruchamiana jest co 30 sekund i przetwarza co drugiego gracza
local lasti=0
function playerLoop()
    lasti=lasti+1
    if (lasti==2) then lasti=0 end
    for i,v in ipairs(getElementsByType("player")) do
	local id=getElementData(v,"id")
	if (id and id%2==lasti) then
--	    outputDebugString("Zapisujemy dane gracza " .. getPlayerName(v) .. " id " .. id)
	    savePlayerData(v)
	end
    end
end

setTimer(playerLoop, 30000, 0)


function getPlayerDBID(plr)
    local character=getElementData(plr,"character")
    if (not character or not character.id) then return nil end	-- gracz nie zalogowal sie jeszcze/nie wybral postaci
    return tonumber(character.id)
end

-- triggerServerEvent("setPedWalkingStyle", localPlayer, v)
addEvent("setPedWalkingStyle", true)
addEventHandler("setPedWalkingStyle", root, function(style)
	setPedWalkingStyle(source, style)
end)
