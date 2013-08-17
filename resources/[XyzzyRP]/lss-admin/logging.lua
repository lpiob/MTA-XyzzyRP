--[[
lss-admin: logowanie różnych rzeczy

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


addEventHandler("onPlayerWasted", root, function( ammo, attacker, weapon, bodypart )
    if (attacker and isElement(attacker) and source and isElement(source)) then
        gameView_add("ZABOJSTWO " .. getPlayerName(source) .. " zabity przez " .. getPlayerName(attacker) .. ", bron " .. getWeaponNameFromID(weapon))
    else
	gameView_add("SMIERC " .. getPlayerName(source))
    end

end)