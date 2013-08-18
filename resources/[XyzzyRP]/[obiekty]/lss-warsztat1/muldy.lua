-- ten skrypt mozesz skopiowac i wstawic do innego zasobu

-- spis obiektow ruszanych przez skrypt
local obiekty={ "maszyna1", "maszyna2", "maszyna3", "maszyna4", "maszyna5", "maszyna6", "maszyna7", "maszyna8" }
		-- , "statek5", "statek6", "statek7", "statek8", "statek9", "statek10", "statek11", "statek12", "statek13", "statek14", "statek15", "statek16", "statek17", "statek18"}


local sekwencja={
	{ nazwa="1", czas=0.5, opoznienie=0.2 },
	{ nazwa="2", czas=0.5, opoznienie=0.2 },
	{ nazwa="3", czas=0.5, opoznienie=0.2 },
	{ nazwa="4", czas=0.5, opoznienie=0.2 },	
}

local krok=1	-- rozpoczynamy od pierwszego kroku w powyzszej sekwencji (mozna zmienic na inna wartosc)

--[[
	w pliku map musza byc zdefiniowane obiekty o ID podanym w 'obiekty'
	kazdy obiekt musi miec dodatkowo zdefiniowane dodatkowe polozenia, zgodne z nazwami w sekwencji, np.:

    <object id="statek1" doublesided="false" model="10771" interior="0" dimension="0" posX="-2334.8271484375" posY="2159.91796875" posZ="5.4443907737732" rotX="0" rotY="0" rotZ="270"
		posX_bayside="..." posY_bayside="...." posZ_bayside="..."
		posX_sf="..." posZ_sf="..."></object>

	jezeli dany argument jest pominiety (np. posX_sf) to znaczy ze sie nie zmienia, nie ma koniecznosci podawania niezmienionych pozycji

]]--

-- ponizej nic nie trzeba zmieniac --------------------------------------------------------------------------------------------------------------

function ruchObiektow()
	-- przechodzimy do nastepnego kroku
	krok=krok+1
	if (krok>#sekwencja) then
		krok=1
	end
--	outputDebugString("Sekwencja " .. sekwencja[krok].nazwa)

	-- dokonujemy ruchu obiektow
	local postfix="_"..sekwencja[krok].nazwa

	for _,nazwa_obiektu in ipairs(obiekty) do
		local obiekt=getElementByID(nazwa_obiektu)
		if (obiekt) then
			local cx,cy,cz=getElementPosition(obiekt)

			local posX=getElementData(obiekt,"posX"..postfix)
			if (not posX) then posX=cx end
			local posY=getElementData(obiekt,"posY"..postfix)
			if (not posY) then posY=cy end
			local posZ=getElementData(obiekt,"posZ"..postfix)
			if (not posZ) then posZ=cz end
			moveObject(obiekt, sekwencja[krok].czas*1000, posX, posY, posZ)
		end
	end

	-- podpinamy timer do nastepnego kroku w sekwencji
	setTimer(ruchObiektow, sekwencja[krok].czas*1000+sekwencja[krok].opoznienie*1000, 1)
end

-- rozpoczynamy pierwszy krok sekwencji
setTimer(ruchObiektow, sekwencja[krok].opoznienie*1000, 1)


