--[[
lss-admin: logowanie różnych rzeczy

@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub

]]--


addEventHandler("onPlayerWasted", root, function( ammo, attacker, weapon, bodypart )
    if (attacker and isElement(attacker) and source and isElement(source)) then
        gameView_add("ZABOJSTWO " .. getPlayerName(source) .. " zabity przez " .. getPlayerName(attacker) .. ", bron " .. getWeaponNameFromID(weapon))
    else
	gameView_add("SMIERC " .. getPlayerName(source))
    end

end)