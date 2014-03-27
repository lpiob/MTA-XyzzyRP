--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local ITEMID_KWIT=13

local towary={
  [1]="Artykuły biurowe",
  [2]="Części do samolotów",
  [3]="Artykuły spożywcze",
  [4]="Części do rowerów",
  [5]="Części do samochodów",
  [6]="Narzędzia",
  [7]="Manekiny",
  [8]="Ubrania",
  [9]="Złom",
  [10]="Dokumentacja",
  [11]="Broń",
  [12]="Leki",
  [13]="Surowce płynne",
  [14]="Alkohol",

  
}

local punkty={
  -- x,y,z
  { 735.65,-1353.06,13.35, nazwa="Firma kurierska", dzielnica="Vinewood", angle=270, nadawczy=true },
  { 1482.00,-1826.36,12.60, nazwa="Urząd miasta", dzielnica="Commerce", towary={1, 3, 10} },
  { 1768.33,-2030.72,12.72, nazwa="Firma przewozowa", dzielnica="El Corona", angle=270, nadawczy=true },
  { 2049.39,-2358.23,12.61, nazwa="Lotnisko", dzielnica="Los Santos International", towary={2,6,10} },
  { 2874.15,-1817.59,10.57, nazwa="Przechowalnia pojazdów", dzielnica="East Beach", angle=90, towary={6,1,10,13	} },
  { 1138.82,-1758.93,12.65, nazwa="Korporacja taksówkarska", dzielnica="Conference Center", angle=1, towary={ 1, 5, 6, 10} },
  { 1424.35,-1354.08,12.61, nazwa="Strzelnica", dzielnica="Downtown", angle=0, towary={11,10,7}},
  { 2014.42,-1453.33,12.55, nazwa="Szpital", dzielnica="Jefferson", angle=90, towary={1, 3, 8, 13, 12}},
  { 2756.52,-1679.39,8.98, nazwa="Stadion", dzielnica="East Beach", angle=0, towary={1,3,7,8,10,12}},
  { 2667.65,-2123.23,12.61, nazwa="Rafineria", dzielnica="Ocean Docks", towary={ 6, 9, 13}},
  { 1876.77,-1740.52,12.54, nazwa="Kasyno", dzielnica="Idlewood", angle=180, towary={1,10, 5}},
  { 1939.80,-1795.01,12.55, nazwa="Warsztat I", dzielnica="Idlewood", angle=270, towary={1,10,5}},
  { 672.89,-139.75,23.77, nazwa="Warsztat II", dzielnica="Fern Ridge", angle=240, towary={1,10,5}},
  { 2267.05,-105.95,25.48, nazwa="Warsztat III", dzielnica="Palamino Creek", angle=0, towary={1,10,5}},
  { 1181.61,248.23,18.63, nazwa="Warsztat IV", dzielnica="Montgomery", angle=250, towary={1,10,5}},
  { 126.03,-173.66,0.58, nazwa="Warsztat V", dzielnica="Blueberry", angle=180, towary={1,10,5}},
  { 2250.98,106.21,25.48, nazwa="Prywatna Przychodnia Lekarska", dzielnica="Palamino Creek", angle=315, towary={1, 3, 8, 13, 12}},
  { 1541.08,-1620.52,12.55, nazwa="Departament Policji", dzielnica="Pershing Square", angle=90, towary={1, 3, 8, 13, 12}},
  { 927.18,-1227.98,15.96, nazwa="Departament Straży Pożarnej", dzielnica="Idlewood", angle=270, towary={1, 3, 8, 13, 12}},
  { 1228.13,-1486.18,12.55, nazwa="Departament Służb Specjalnych", dzielnica="Market", angle=270, towary={1, 3, 8, 13, 12}},
  { 3040.69,-874.73,11.56, nazwa="Punkt garażowy", dzielnica="East Los Santos", angle=180, towary={1,3, 6, 10, 12}},
  { 1417.58,-1137.75,22.91, nazwa="Sąd Rejonowy", dzielnica="Downtown Los Santos", angle=180, towary={1, 3, 8, 13, 12}},
  { 2773.35,-2471.96,12.64, nazwa="Kolonia Karna Los Santos", dzielnica="Downtown Los Santos", angle=90, towary={1, 3, 8, 13, 12}},

}

for i,v in ipairs(punkty) do
  v.marker=createMarker(v[1],v[2],v[3],"cylinder",1.5, 0,0,0,0)
  v.marker2=createMarker(v[1],v[2],v[3],"cylinder",4, v.nadawczy and 255 or 0, 255, v.nadawczy and 0 or 255,10)
  setElementData(v.marker,"spedycja:index", i)
end

local function zaladujTowar(veh,pi)
-- wyznaczamy cel
  local ci=pi
  while (ci==pi) do
    ci=math.random(1,#punkty)
  end
  local cel=punkty[ci]
  local spedycja={ci=ci,pi=pi}

  if (cel.towary) then
	spedycja.towar=towary[cel.towary[math.random(1,#cel.towary) ] ]
  else
	spedycja.towar=towary[math.random(1,#towary)]
  end
  local kierowca=getVehicleController(veh)
  spedycja[1]=cel[1]
  spedycja[2]=cel[2]
  spedycja[3]=cel[3]
  spedycja.nazwa=cel.nazwa.."\n"..cel.dzielnica
  
  setElementData(veh,"spedycja", spedycja)
    
  outputChatBox("Wieziesz: #FFFFFF" .. spedycja.towar, kierowca, 231, 217, 176, true)
  
  triggerClientEvent(kierowca, "onPackageInfo", root, spedycja)

end
local function obliczWynagrodzenie(skad,dokad)
  if (skad and dokad and punkty[skad] and punkty[dokad]) then
	local odleglosc=getDistanceBetweenPoints2D(punkty[skad][1], punkty[skad][2], punkty[dokad][1], punkty[dokad][2])
	return math.ceil(math.sqrt(odleglosc))
    end
    return 5
end

local function dostawaTowaru(veh,cel)
  local s=getElementData(veh,"spedycja")
  if (not s) then return false end
  local kierowca=getVehicleController(veh)
  if s.ci and tonumber(s.ci)==tonumber(cel) then
	triggerEvent("broadcastCaptionedEvent", kierowca, getPlayerName(kierowca) .. " rozładowuje towar.", 5, 15, true)
	removeElementData(veh,"spedycja")
	local zaplata=obliczWynagrodzenie(s.pi or 1,s.ci)
	outputChatBox("(( Otrzymujesz " .. zaplata .. " kwitów za dostawę ))", kierowca)
	exports["lss-core"]:eq_giveItem(kierowca,ITEMID_KWIT, zaplata)
	triggerClientEvent(kierowca, "hideGPS", resourceRoot)
	return true
  end
  return false
end

addEventHandler("onMarkerHit", resourceRoot, function(el,md)
  if (not md) then return end
  if (getElementType(el)~="vehicle") then return end
  local kierowca=getVehicleController(el)
  if (not kierowca) then return end
  if (getElementModel(el)~=440) then
--    outputChatBox("Wymagany pojazd dostawczy Rumpo.", kierowca, 255,0,0,0)
    return
  end
  local pi=getElementData(source,"spedycja:index")
  if (not pi) then return end
  if (punkty[pi].angle) then
	local _,_,rz=getElementRotation(el)
	rz=(punkty[pi].angle-rz)%360
	if (rz>10 and rz<350) then
	  outputChatBox("Podjedź od właściwej strony.", kierowca, 255,0,0,0)
	  return
	end
  end

  if (getElementData(el,"spedycja")) then
	if (dostawaTowaru(el,pi)) then
	  return
	end
	outputChatBox("Ten pojazd posiada już ładunek, który ma być dostarczony gdzieś indziej.", kierowca)
	outputChatBox("(( użyj PPM na pojeździe aby wprowadzić adres do nawigacji ))", kierowca)
	return
  end
  if (punkty[pi].nadawczy) then
      zaladujTowar(el,pi)
  end
  --outputChatBox("hit", kierowca)
end)

addEvent("onPlayerRequestSpedycjaInfo", true) -- do pobierania informacji o celu paczki
addEventHandler("onPlayerRequestSpedycjaInfo", root, function(veh)
    local s=getElementData(veh,"spedycja")
	if (not s) then  return	end
    triggerClientEvent(source, "onPackageInfo", root, s)
end)

