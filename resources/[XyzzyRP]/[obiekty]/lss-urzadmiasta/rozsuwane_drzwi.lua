--[[
Skrypt obslugujacy ruchome obiekty

@author Lukasz Biegaj <wielebny@bestplay.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


--[[
	ten skrypt mozesz skopiwac do dowolnego innego zasobu i uzupelnic tylko tabele nizej
	w sumie to powinien nawet dzialac z obiektami z innego zasobu, byleby sie ID obiektu zgadzalo

	Dane ktore musi posiadac obiekt: 
			animtime - czas przesuwu podany w milisekundach
			pos2X, pos2Y, pos2Z
]]--

local ruchome_elementy={
-- przyklady:
--  { colsphere={x,y,z,r,i,vw}, obiekty={ "obiekt1", "obiekt2" } },			
--    ^ strefa o ksztalcie kuli o promieniu r. 
--	    argumenty i,vw sa opcjonalne
--
--								^ obiekty to dowolna ilosc obiektow, moze byc jeden, moze byc wiecej niz 2
--
--  { colsphere={x,y,z,r,i,vw}, obiekty={ "obiekt1", "obiekt2" }, frakcja="Policja" },			
-- 																  ^ opcjonalny argument frakcja okresla jaka frakcja (tylko jedna) moze miec dostep
--	{ ..., haslo="xyzy", ... }	-- jesli zdefiniowane jest haslo, to brama otworzy sie tylko po wpisaniu kolo niej /haslo xyzy
--								-- gracz musi byc wewnatrz colsphere aby haslo zadzialalo!
--	{ ..., haslo="xyzy", haslo_info="Wejscie tylko dla pracownikow.", ...	} -- komentarz pojawiajacy sie przed informacja o wymaganym hasle
--						haslo_info_ann="tekst"	-- tekst pokazywany na ann - nie mzoe miec kolorow
-- 	{ ,,,. szczelne_zamykanie=true, ... } -- jesli jest taki parametr zdefiniowany, to brama zamykana jest jak tylko gracz opusci colsphere
--										  -- bez wzgledu czy jest ktos inny w colsphere. W przeciwnym wypadku zamkneicie nastapi dopiero jak nikogo nie bedzie


	{ colsphere={1482.82,-1801.00,1286.00,2, 1, 1}, obiekty={ "burmistrz" },
		haslo="paszcza", haslo_info="",
		haslo_info_ann=""
	},
	
	{ colsphere={1486.60,-1778.18,1252.97, 10, 1, 1}, obiekty={ "minister_finansow" },
		haslo="radzio", haslo_info="",
		haslo_info_ann=""
	},
	
	{ colsphere={1486.60,-1778.18,1192.96, 10, 1, 1}, obiekty={ "minister_gospodarki" },
		haslo="studnia", haslo_info="",
		haslo_info_ann=""
	},	


	-- statek w sf
--	{ colsphere={ -2090.8, 1429.6, 7, 0.5, 0, 0}, obiekty={ "statek1", "statek2", "statek3", "statek4", "statek5", "statek6", "statek7", "statek8", "statek9", "statek10", "statek11", "statek12", "statek13", "statek14", "statek15", "statek16", "statek17", "statek18" } },	
--	{ colsphere={ -2431.6, 2250.2, 5, 0.5, 0, 0}, obiekty={ "statek1", "statek2", "statek3", "statek4", "statek5", "statek6", "statek7", "statek8", "statek9", "statek10", "statek11", "statek12", "statek13", "statek14", "statek15", "statek16", "statek17", "statek18" } },		

}


-- nizej nie trzeba nic edytowac ---------------------------------------------------------------------------------------------------------------------

function ruchomeElementyCH(hitElement, matchingDimension)
	if (not matchingDimension or getElementType(hitElement)~="player") then
		return
	end
	-- szukamy elementu
	for i,v in ipairs(ruchome_elementy) do
		if (ruchome_elementy[i].colshape and ruchome_elementy[i].colshape==source) then
			if (ruchome_elementy[i].haslo) then
				if (ruchome_elementy[i].haslo_info) then
					outputChatBox(ruchome_elementy[i].haslo_info, hitElement, 255,255,255, true)
				end
				if (ruchome_elementy[i].haslo_info_ann) then
					triggerClientEvent ( hitElement, "onAnnouncement3", getRootElement(), ruchome_elementy[i].haslo_info_ann, 5 )
				end
				outputChatBox("", hitElement)
				return
			end
			-- przesuwamy!
			for i2,v2 in ipairs(ruchome_elementy[i].obiekty) do
				local o=getElementByID(v2)
				if (o) then
					moveObject(o, getElementData(o,"animtime"), getElementData(o,"pos2X"), getElementData(o,"pos2Y"), getElementData(o,"pos2Z"))
				else
					outputDebugString("" .. v2)
				end
			end
			return
		end
	end
end

addCommandHandler("haslo", function(plr,cmd,haslo)
	if (not haslo) then
		outputChatBox("", plr)
		return
	end
	-- szukamy elementu
	for i,v in ipairs(ruchome_elementy) do
			if (ruchome_elementy[i].haslo and isElementWithinColShape(plr, ruchome_elementy[i].colshape) and getElementDimension(plr)==getElementDimension(ruchome_elementy[i].colshape) and getElementInterior(plr)==getElementInterior(ruchome_elementy[i].colshape)) then	-- 
				if (haslo==ruchome_elementy[i].haslo) then
					for i2,v2 in ipairs(ruchome_elementy[i].obiekty) do
						local o=getElementByID(v2)
						if (o) then
							moveObject(o, getElementData(o,"animtime"), getElementData(o,"pos2X"), getElementData(o,"pos2Y"), getElementData(o,"pos2Z"))
						else
							outputDebugString("" .. v2)
						end
					end
					return

				else
					outputChatBox("", plr)
					return
				end
			end
	end
	outputChatBox("", plr)
	return
end, false,false)

function ruchomeElementyCL(hitElement, matchingDimension)
	if (not matchingDimension or getElementType(hitElement)~="player") then
		return
	end
	for i,v in ipairs(ruchome_elementy) do
		if (ruchome_elementy[i].colshape and ruchome_elementy[i].colshape==source) then

			if (not ruchome_elementy[i].szczelne_zamykanie) then	--sprawdzamy czy nie ma kogos innego w strefie
				if (#getElementsWithinColShape(source,"player")>0) then return end
			end

			for i2,v2 in ipairs(ruchome_elementy[i].obiekty) do
				local o=getElementByID(v2)
				if (o) then
					moveObject(o, getElementData(o,"animtime"), getElementData(o,"posX"), getElementData(o,"posY"), getElementData(o,"posZ"))
				else
					outputDebugString("" .. v2)
				end
			end
			return
		end
	end

end


for i,v in ipairs(ruchome_elementy) do
	if (ruchome_elementy[i].colsphere) then
		ruchome_elementy[i].colshape=createColSphere( ruchome_elementy[i].colsphere[1], ruchome_elementy[i].colsphere[2], ruchome_elementy[i].colsphere[3], ruchome_elementy[i].colsphere[4] )
		if (ruchome_elementy[i].colsphere[5]) then setElementInterior(ruchome_elementy[i].colshape, ruchome_elementy[i].colsphere[5]) end
		if (ruchome_elementy[i].colsphere[6]) then setElementDimension(ruchome_elementy[i].colshape, ruchome_elementy[i].colsphere[6]) end
	end
	if (ruchome_elementy[i].colshape) then
		addEventHandler ( "onColShapeHit", ruchome_elementy[i].colshape, ruchomeElementyCH )
		addEventHandler ( "onColShapeLeave", ruchome_elementy[i].colshape, ruchomeElementyCL )
	else
		outputDebugString("")
	end
end