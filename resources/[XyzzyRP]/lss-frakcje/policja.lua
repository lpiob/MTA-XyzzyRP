--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

addEvent("onKajdankiZakuj", true)
addEventHandler("onKajdankiZakuj", resourceRoot, function(kto,kogo)
  triggerClientEvent(kogo, "onKajdankiZakuj", resourceRoot, kto)
end)

addEvent("spac",true)
addEventHandler("spac", root, function()
	setPedAnimation(source, "CHAINSAW" ,"csaw_part",  0, false, true, true )
end)