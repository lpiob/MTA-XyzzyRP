--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--

-- triggerServerEvent("gaszeniePojazdu", hitElement)
addEvent("gaszeniePojazdu", true)
addEventHandler("gaszeniePojazdu", root, function()
    if (getElementType(source)~="vehicle") then return end
    local vhp=getElementHealth(source)
    if (vhp<400) then
	vhp=vhp+math.random(1,4)
	setElementHealth(source, vhp)
	
    end
end)