--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

-- bike 509

-- uwaga te dane muszą być powtórzone w pliku rowery.lua
local wypozyczalnie={
    lotnisko={	1682.78,-2298.91,12.53,0 },
    ratusz={ 1479.76,-1603.43,12.40, 0 },
    litlemexico={ 1804.51,-1641.41,12.52,90.0 },
    veronabeach={ 1133.97,-1688.90,12.78,180.0 },
    santamariabeach={ 387.10,-2056.04,6.84,0 },
	grovestreet={ 2423.27,-1674.14,12.65,0 },
    kurierzy={ 678.18,-1302.39,12.62, 90 },
	skatepark={ 1866.52,-1395.18,12.50,90 },
	naukajazdy={ 983.82,-1303.85,12.38,180 },
	lascolinas={ 2146.04,-1105.40,24.48,160.3 },
	temple={ 1004.02,-948.40,41.28,7.2 },
	port={ 2758.72,-2390.23,12.63,0 },
	wysypisko={ 664.29,-678.81,15.34,0 },
	palamino={ 2255.71,-83.73,25.52,0 },
	blueberry={ 245.22,-151.41,0.58,90 },
	montgomery={ 1341.29,282.57,18.56,66 },
}

local infowin = guiCreateWindow(0.7531,0.3479,0.2109,0.3792,"Informacja",true)
--local infowinlbl = guiCreateLabel(0.037,0.1209,0.9185,0.8352,"Wypożyczalnia rowerów.\n\nKaucja - 50$\n\n\nRower należy odstawić do dowolnego punktu.\n\nPorzucanie rowerów poza wskazanymi punktami karane jest grzywną.",true,infowin)
local infowinlbl = guiCreateLabel(0.037,0.1209,0.9185,0.8352,"WYPOŻYCZALNIA ROWERÓW\n\n\n\n***********************************\n\n\n\nWypożyczenie - 7$\nOdstawienie - 3$\n\n\nRower należy odstawić do dowolnego punktu.\n\nPorzucanie rowerów poza wskazanymi punktami karane jest grzywną.",true,infowin)
guiLabelSetHorizontalAlign(infowinlbl,"center",true)
guiSetFont(infowinlbl,"default-small")
guiSetVisible(infowin, false)

for i,v in pairs(wypozyczalnie) do
    v.obiekt_podstawa=createObject(2898,v[1],v[2],v[3],0,0,v[4]+90)
    v.obiekt_slupek=createObject(1444,v[1],v[2],v[3]+0.9,0,0,v[4])
    v.infocolshape=createColSphere(v[1],v[2],v[3],3)
end

addEventHandler("onClientColShapeHit", resourceRoot, function(hitElement, matchingDimension)
    if (hitElement~=localPlayer or not matchingDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    if (getPedOccupiedVehicle(localPlayer)) then return end
    guiSetVisible(infowin,true)
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(hitElement, matchingDimension)
    if (hitElement~=localPlayer or not matchingDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    guiSetVisible(infowin,false)
end)


