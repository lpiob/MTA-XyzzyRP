--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



    -- albo robimy event do kazdego gracza i czekamy az ten laskawie odpowie
    -- albo przegladamy wszystkich graczy eq
    -- pierwsze podatni na lagi, drugie obciazy serwer
    -- narazie zakoduje drugie rozwiazanie

local function graczMaTelefon(gracz,numer)
    if (not gracz or not numer or not tonumber(numer)) then return false end
    if (exports["lss-core"]:eq_getItem(gracz, 21,tonumber(numer))) then return true end
    return false
end

local function znajdzGraczaZTelefonem(numer)
    for i,v in ipairs(getElementsByType("player")) do
	if (getElementData(v,"character")) then
	    if (graczMaTelefon(v,numer)) then return v end
	end
    end
    return false
end

local function znajdzPojazd(numer)
  for i,v in ipairs(getElementsByType("vehicle")) do
	  local dbid=getElementData(v,"dbid")
	  if (dbid and tonumber(dbid)==numer) then return v end
  end
  return false
end

-- triggerServerEvent("doNamierzanie",resourceRoot, pojazd, numer)
addEvent("doNamierzanie", true)
addEventHandler("doNamierzanie", resourceRoot, function(pojazd,numer)
--    outputDebugString("Namierzanie " .. numer)

	numer=tonumber(numer)
	local cel
	if (getElementData(pojazd,"special")=="namierzaczt") then
	  cel=znajdzPojazd(numer)
	else
      cel=znajdzGraczaZTelefonem(numer)
	end

    if (not cel) then
	removeElementData(pojazd,"namierzanie")
    else
	local x,y,z=getElementPosition(cel)
	local strefa=getElementZoneName(cel)
	setElementData(pojazd, "namierzanie", { x,y,z, strefa, getElementInterior(cel) })
    end
end)