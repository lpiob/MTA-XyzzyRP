--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local I=1
local D=48

local cele = {
    { 546.82,-1264.55,17.24,216.2, nazwa="Salon samochodowy" },
    { 438.48,-1111.55,85.21,357.4, nazwa="CNN News" },
    { 865.05,-555.15,18.16,189.9, nazwa="Wysypisko śmieci" },
    { 1588.79,-1170.44,24.08,1.6, nazwa="Sklep z elektroniką" },
    { 1445.12,-1288.85,13.55,266.2, nazwa="Sklep 24/7" },
    { 1464.55,-1749.90,15.45,0.2, nazwa="Urząd Miasta" },
    { 1547.55,-1679.49,13.56,180.5, nazwa="Policja" },
    { 1009.55,-1873.21,12.62,278.3, nazwa="Plaża" },
    { 1238.87,-2043.35,59.87,272.3, nazwa="Rezydencja na wzgórzu" },
    { 1776.50,-1867.33,13.57,1.0, nazwa="Dworzec kolejowy" },
    { 1917.90,-1765.86,13.55,355.7, nazwa="Warsztat samochodowy" },
    { 1837.37,-1666.70,13.32,89.1, nazwa="Kasyno" },
    { 393.23,-2064.39,7.84,92.0, nazwa="Pomost wędkarski" },
    { 327.04,-1512.91,36.03,231.6, nazwa="Hotel" },
    { 725.36,-1273.82,13.65,267.0, nazwa="Pole golfowe" },
    { 949.63,-1109.51,24.05,331.6, nazwa="Cmentarz" },
    { 1144.94,-1417.69,13.60,91.0, nazwa="Market" },
    { 1022.76,-1310.58,13.55,177.4, nazwa="Nauka jazdy" },
    { 1688.04,-2266.24,13.48,90.0, nazwa="Lotnisko" },
    { 2502.19,-2641.04,13.65,91.0, nazwa="Port" },
    { 2039.64,-1405.26,13.53,90, nazwa="Szpital" },
	{ 1059.13,-352.77,73.99,358.9, nazwa="Kopalnia" },
--    { 733.47,-1331.04,13.55, nazwa="Koło śmietnika" },
--    { 777.89,-1383.82,13.71, nazwa="Przy wejściu" }
}

for i,v in ipairs(cele) do
    v.obiekt=createObject(1291, v[1], v[2], v[3]-0.5, 0,0, v[4]+180)
    setElementData(v.obiekt,"customAction",{label="Wrzuć paczkę", resource="lss-kurierzy", funkcja="menu_dostawaPaczki", args={cel=i,obiekt=v.obiekt}})
end


local ped=createPed(9,705.23,-1338.28,1759.03,45,false)
setElementInterior(ped, I)
setElementDimension(ped, D)
setElementData(ped,"npc",true)
setElementData(ped,"name","Magazynier")
setElementData(ped,"customAction",{label="Weź paczkę",resource="lss-kurierzy",funkcja="menu_odbiorPaczki",args={ped=ped}})
setElementFrozen(ped, true)
local cs=createColSphere(703.90,-1337.01,1759.03,2)
setElementInterior(cs, I)
setElementDimension(cs, D)

addEventHandler("onColShapeHit", resourceRoot, function(el,md)
    if (not md) then return end
    if (getElementType(el)~="player") then return end
    outputChatBox("Magazynier mówi: Witam", el)
    if (not exports["lss-core"]:eq_getItem(el, 16)) then
	outputChatBox("Magazynier mówi: Musisz się zaopatrzyć w nawigację aby móc roznosić paczki.",el)
	return
    end
    outputChatBox("Mam paczkę do dostarczenia.",el)
end)

function dajPaczke()
    local cel=math.random(1,#cele)
    exports["lss-core"]:eq_takeItem(source,15)
    exports["lss-core"]:eq_giveItem(source,15,1,cel)
end

addEvent("onPlayerRequestPackage", true)
addEventHandler("onPlayerRequestPackage", root, dajPaczke)

addEvent("onPlayerRequestPackageInfo", true) -- do pobierania informacji o celu paczki
addEventHandler("onPlayerRequestPackageInfo", root, function(cel)
    triggerClientEvent(source, "onPackageInfo", root, cele[cel])
end)