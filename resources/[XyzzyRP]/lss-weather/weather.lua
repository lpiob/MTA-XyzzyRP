--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

--[[
    Jak dziala system pogody
    tablica mozliwe_pogody zawiera (surprise, surprise) mozliwe pogody
    
    tablica prognoza_pogody zawiera nastepna (lub wiecej) pogod
    
    co 4 godziny skrypt zmienia pogode na pierwsza pozycje tabeli prognoza_pogody
    
    jesli ilosc pozycji w tabeli prognoza_pogody jest mniejsza niz 5, to ilosc jest ta uzupelniana
    
    w ten sposob wiemy jakie pogody beda w przyszlosci, a takze mozemy recznie dorzucic tam jakies pozycje, tak aby zaplanowac aby jutro 
    byl np. sloneczny dzien
    
]]--

local mozliwe_pogody={
    { weatherid=7, nazwa="Pochmurno, lekki wiatr" },
--    { weatherid=0, nazwa="Gorąco i pogodnie" } ,					
    { weatherid=1, nazwa="Słonecznie" },
    { weatherid=2, nazwa="Pogodnie, lekkie zachmurzenie" },
    { weatherid=3, nazwa="Pogodnie, lekkie zachmurzenie" },
    { weatherid=4, nazwa="Pochmurnie, lekki wiatr" },
    { weatherid=5, nazwa="Lekkie zachmurzenie" },    
    { weatherid=6, nazwa="Ciepło i pogodnie" },
    { weatherid=9, nazwa="Mgliście" },
    { weatherid=10, nazwa="Bezchmurnie, pogodnie" },
    { weatherid=12, nazwa="Ciepło, lekkie zachmurzenie" },
    { weatherid=13, nazwa="Ciepło, lekkie zachmurzenie" },
}
--    { weatherid=11, nazwa="Gorąco i pogodnie" },	-- migajace obiekty

local prognoza_pogody={}

function pogoda_uzupelnij()
    while (#prognoza_pogody<7) do
	table.insert(prognoza_pogody,mozliwe_pogody[math.random(1,#mozliwe_pogody)])
    end
end


function pogodaStart()
	setTimer(pogoda_zmien, 1000, 1)
end

addEventHandler("onResourceStart", resourceRoot,pogoda_uzupelnij)
addEventHandler("onResourceStart", resourceRoot,pogodaStart)

function getPrognoza()
  return prognoza_pogody
end

function pogoda_zmien()
--	setRainLevel()	-- od 0.3 do 0.7
--    setWaterLevel(7)
    local nowapogoda=table.remove(prognoza_pogody,1)
    outputDebugString("zmiana pogody na "..nowapogoda.weatherid)    
    setWeatherBlended(nowapogoda.weatherid)
    pogoda_uzupelnij()
end
setTimer(pogoda_zmien, 1000*60*60, 0)	-- co 1h