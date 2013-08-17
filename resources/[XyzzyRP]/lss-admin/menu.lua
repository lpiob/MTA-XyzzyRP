--[[
lss-admin: funkcje dla supporterow dostępne pod PPM

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


addEvent("support_setElementFrozen",true)
addEventHandler("support_setElementFrozen", resourceRoot, function(element,state)
    setElementFrozen(element,state)
end)

addEvent("support_lift",true)
addEventHandler("support_lift", resourceRoot, function(element,ile)
    local x,y,z=getElementPosition(element)
    setElementPosition(element, x,y,z+(ile or 1))
end)

addEvent("support_bringHere", true)
addEventHandler("support_bringHere", root, function(el)
    local x,y,z=getElementPosition(source)
    z=z+1
    x=x+math.random(-1,1)
    y=y+math.random(-1,1)
    setElementRotation(el,0,0,0)
    setElementPosition(el,x,y,z)
end)