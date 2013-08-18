--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--



addEvent("setGarageOpen", true)
addEventHandler("setGarageOpen", root, function(garaz, stan)
    setGarageOpen(garaz,stan)
end)