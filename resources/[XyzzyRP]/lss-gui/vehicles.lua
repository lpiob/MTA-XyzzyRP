--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



for i,v in ipairs(getElementsByType("vehicle")) do
    removeElementData(v,"migacze")
end

local function migacze(pojazd,krok)
--    outputDebugString(" migacze " .. ktore)
    local ktore=getElementData(pojazd,"migacze")
    if (not ktore) then return end
    if (ktore==1) then
        setVehicleLightState(pojazd, 0, krok%2)
        setVehicleLightState(pojazd, 3,krok%2)
    else
        setVehicleLightState(pojazd, 1, krok%2)
        setVehicleLightState(pojazd, 2, krok%2)
    end
    if (krok>0) then
	setTimer(migacze, 400, 1, pojazd, krok-1)
    else
	removeElementData(pojazd, "migacze")
    end
end

addEvent("doMigacze", true)
addEventHandler("doMigacze", root, function(ktore)
    if (not source or not isElement(source) or getElementType(source)~="vehicle") then return end
    if (getElementData(source,"migacze")) then return end
    setElementData(source,"migacze", ktore)
--    outputDebugString("migacze")
    migacze(source, 10)
end)

