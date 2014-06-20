--[[
lss-autobusy

@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


local przystanki={
--  { x,y,z,obrot, nazwa= }
--[[
    lotnisko={ 1703.14,-2261.15,13.51,270, nazwa="Lotnisko"},
    urzad_miejski={ 1454.74,-1739.99,13.55,270, nazwa="Centrum" },
    sannews={479.58,-1084.71,82.48,356.5-90, nazwa="CNN News" },
    grove_street={2430.82,-1648.16,13.53,90,nazwa="Grove Street" },
    verona_beach={1162.12,-1719.95,14.23,270,nazwa="Verona Beach" },
    santa_maria_beach={377.26,-1996.77,7.84,0,nazwa="Santa Maria Beach" },
    idlewood={1966.23,-1743.63,13.55,90,nazwa="Idlewood" },
    wysypisko={673.59,-680.67,16.27,266-90,nazwa="Wysypisko śmieci"} ,
    kurierzy={618.6,-1360.17,13.59,268.7-90,nazwa="Firma kurierska"},
	szpital={2001.60,-1474.90,13.56,-90,nazwa="Szpital" },
	straz_pozarna={934.74,-1257.84,15.80,180, nazwa="Straż pożarna" },
	osrodek_strazakow={1357.11,-17.49,34.28,135, nazwa="Ośrodek Szkolenia Strażaków" },
	urzad_pocztowy={1229.44,-1564.98,13.58,90, nazwa="Urząd pocztowy" },
	kopalnia={1043.82,-457.91,51.77,289,nazwa="Kopalnia" },
	kierowcy_salon={ 1101.94,-1288.10,13.55,270,nazwa="Market" },
	downtown={ 1461.35,-1044.10,23.83,270, nazwa="Downtown" },
	lascolinas={ 2159.50,-1108.95,25.54,347.0-90, nazwa="Las Colinas" },
	oceandocks={2733.94,-2495.57,13.66,180.0-90, nazwa="Ocean Docks" },
	eastbeach={2853.01,-1855.18,11.08,0.0, nazwa="East Beach" },
    palamino_creek={2205.36,33.58,26.48,90,nazwa="Wioska Palomino Creek"},
	blueberry={225.74,-99.67,1.58,180, nazwa="Wioska Blueberry" },
	montgomery={1347.00,359.03,19.55,335, nazwa="Wioska Montgomery" },
	east_beach={2898.14,-1159.80,11.15,4, nazwa="East Beach" },
	tartak_na_wsi={-818.35,-125.07,63.33, 285, nazwa="Tartak na wsi" },
]]--

    lotnisko={ 1703.14,-2261.15,13.81,0, nazwa="Lotnisko"},
    urzad_miejski={ 1429.58,-1739.99,13.95,0, nazwa="Centrum" },
    sannews={479.88,-1084.11,82.55,0, nazwa="CNN News" },
    grove_street={2430.82,-1648.16,13.93,180,nazwa="Grove Street" },
    verona_beach={1162.12,-1719.95,14.23,0,nazwa="Verona Beach" },
    santa_maria_beach={377.26,-1996.77,8.24,90,nazwa="Santa Maria Beach" },
    idlewood={1966.08,-1744.83,13.95,180,nazwa="Idlewood" },
    wysypisko={673.59,-680.67,16.57,270,nazwa="Wysypisko śmieci"} ,
    kurierzy={619.1,-1360.17,13.99,270,nazwa="Firma kurierska"},
	szpital={2001.60,-1474.00,13.96,0,nazwa="Szpital" },
	straz_pozarna={934.13,-1264.38,15.94,270, nazwa="Straż pożarna" },
	urzad_pocztowy={1229.44,-1564.48,13.98,180, nazwa="Urząd pocztowy" },
	kopalnia={1040.43,-460.82,51.89,24,nazwa="Kopalnia" },
	kierowcy_salon={ 1101.94,-1288.10,13.95,0,nazwa="Market" },
	downtown={ 1461.35,-1042.10,24.23,0, nazwa="Downtown" },
	lascolinas={ 2162.38,-1109.29,25.75,168, nazwa="Las Colinas" },
	departament_turystyki={ 2902.60,-957.04,11.44,90, nazwa="Departament Turystyki" },
	oceandocks={2733.94,-2495.57,14.06,180, nazwa="Ocean Docks" },
    palamino_creek={2205.36,33.78,26.88,0,nazwa="Wioska Palomino Creek"},
	blueberry={225.34,-99.67,1.98,270, nazwa="Wioska Blueberry" },
	montgomery={1341.33,347.17,19.95,65, nazwa="Wioska Montgomery" },
	tartak_na_wsi={-818.35,-125.07,63.43, 16, nazwa="Tartak na wsi" },
}


function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end


g_przystanki = guiCreateGridList(0.7163,0.2267,0.3525,0.63,true)
guiGridListSetSelectionMode(g_przystanki,0)
g_przystanki_c_cel=guiGridListAddColumn(g_przystanki,"Cel",0.6)
g_przystanki_c_koszt=guiGridListAddColumn(g_przystanki,"Koszt",0.2)
guiSetVisible(g_przystanki,false)



for i,v in pairs(przystanki) do
--[[ tak bylo, dzialalo prawidlowo tylko przy jednym obrocie
    v.obiekt_buda=createObject(5837, v[1], v[2], v[3], 0,0,v[4])
    v.obiekt_lawka=createObject(1368, v[1]+1.6, v[2]-0.7,v[3]-0.7, 0,0,v[4]+180)
    v.obiekt_kosz=createObject(1359, v[1]-5.2, v[2]+0.6, v[3]-0.8, 0,0,v[4]+180)
    v.obiekt_tablica=createObject(2611, v[1]+1.1, v[2]+1.3, v[3]+0.38, 0,0,v[4]+0)
]]--


    v.obiekt_buda=createObject(5837, v[1], v[2], v[3], 0,0,v[4])
    v.obiekt_lawka=createObject(1368, v[1], v[2], v[3], 0,0,v[4])
	attachElements(v.obiekt_lawka, v.obiekt_buda, 1.6, -0.7, -0.7,0,0,180) -- przyczepiamy te obiekty i niech mta sie martwi o obliczenie obrotu

    v.obiekt_kosz=createObject(1359, v[1], v[2], v[3], 0,0,v[4])
	attachElements(v.obiekt_kosz, v.obiekt_buda, -5.2, 0.6,-0.8,0,0,180)

    v.obiekt_tablica=createObject(2611, v[1], v[2], v[3], 0,0,v[4])
	attachElements(v.obiekt_tablica, v.obiekt_buda, 1.1, 1.3, 0.38)





--    setElementData(v.obiekt,"desc","Przystanek")
--    setElementData(v.obiekt,"customAction",{label="Transport",resource="lss-autobusy",funkcja="menu_przystanek",args={indeks=i}})
    v.colshape=createColSphere(v[1],v[2],v[3],3)
end

function przystanki_find(el)
    for i,v in pairs(przystanki) do
	if (v.colshape==el) then return i end
    end
    return nil
end

function calculateCost(p1, p2)
    local dist=getDistanceBetweenPoints3D(p1[1],p1[2],p1[3], p2[1],p2[2],p2[3])+64
    return (math.ceil(math.sqrt(dist)/4))
end

function przystanki_fill(przystanek)
    guiGridListClear(g_przystanki)
--    g_przystanki_c_cel=guiGridListAddColumn(g_przystanki,"Cel",0.6)
--    g_przystanki_c_koszt=guiGridListAddColumn(g_przystanki,"Koszt",0.2)

    for i,v in pairs(przystanki) do
	if (not przystanek or i~=przystanek) then
		if (v.row and isElement(v.row)) then destroyElement(v.row) end
		v.row = guiGridListAddRow ( g_przystanki )
		guiGridListSetItemText ( g_przystanki, v.row, g_przystanki_c_cel, v.nazwa, false, false )
		v.koszt=calculateCost(przystanki[i], przystanki[przystanek])
		guiGridListSetItemText ( g_przystanki, v.row, g_przystanki_c_koszt, v.koszt.."$", false, false )
		if (v.koszt>getPlayerMoney()) then
			guiGridListSetItemColor(g_przystanki, v.row, g_przystanki_c_koszt, 255,0,0)
		else
			guiGridListSetItemColor(g_przystanki, v.row, g_przystanki_c_koszt, 155,255,155)
		end
	end
    end
end

fadeCamera(true)

function string.explode(self, separator)
 
    if (#self == 0) then return {} end
    if (#separator == 0) then return { self } end
 
    return loadstring("return {\""..self:gsub(separator, "\",\"").."\"}")()
end

function przystanek_wybor()
--    removeEventHandler( "onClientGUIDoubleClick", g_przystanki, przystanek_wybor, false );
     local selectedRow, selectedCol = guiGridListGetSelectedItem( g_przystanki );
     if (not selectedRow) then return end
     for i,v in pairs(przystanki) do
        if (v.row==selectedRow) then
	    if (v.koszt>getPlayerMoney()) then
		outputChatBox("Nie stać Cię na to.", 255,0,0,true)
--		addEventHandler( "onClientGUIDoubleClick", g_przystanki, przystanek_wybor, false );
		return
	    end
	    guiSetVisible(g_przystanki,false)	-- aby nie klikli 2x
	    exports["lss-gui"]:panel_hide()
--	    outputChatBox("row " .. v.row .. " nazwa " .. v.nazwa)
	    triggerServerEvent("takePlayerMoney", localPlayer, v.koszt)
	    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " odjeżdża autobusem.", 5, 15, false)
		x,y,z = getElementPosition(localPlayer)
			triggerServerEvent("insertItemToContainerS", getRootElement(), 1533, -1, v.koszt, 0, "Gotówka")
			setElementPosition(localPlayer, 2021.93, 2236.74, 2110.95)
				setTimer(setElementPosition, 1000, 1, localPlayer, 2021.93, 2236.74, 2103.95)
				setTimer(triggerServerEvent, 1000, 1, "broadcastCaptionedEvent", localPlayer, "Bus zatrzymuje się, ktoś wchodzi do środka.", 5, 15, false)
				do setElementPosition(localPlayer, 2021.93, 2236.74, 2103.95) end
				local czas_jazdy = math.round(math.ceil(getDistanceBetweenPoints3D(x,y,z,v[1],v[2],v[3]))/500,1) or 1.50
				if czas_jazdy<0.1 then
					czas_jazdy = 1.50
				end
				
				time = tostring(czas_jazdy):explode("%.")
				sekundy = tonumber(time[2]) or 0
				sekundy = tostring(sekundy*6) or 0
				outputChatBox("Głos z głośników: następny przystanek za "..(time[1] or 1).." minut i "..(tostring(sekundy) or 30).." sekund")
				setElementRotation(localPlayer, 0,0,360)
				fadeCamera(true)
				sound = playSound("autobus.ogg",true)
				text = createElement("text")
				setElementPosition(text, 2021.93,2235.41,2106)
				setElementData(text, "scale", 1.5)
				pozostalo_m=tonumber(time[1])
				pozostalo_s=tonumber(sekundy)
				setTimer(function()
					pozostalo_s = pozostalo_s-1
					if pozostalo_m <0 then pozostalo_m=0 end
					if pozostalo_s <= 0 then pozostalo_s=60 pozostalo_m=pozostalo_m-1 end
		
					setElementData(text, "text", "Czas podróży: "..pozostalo_m..":"..pozostalo_s)
				end, 1000, (tonumber(time[1])*60)+sekundy)
				
				setTimer(function()
					fadeCamera(false)
					
					setTimer(function()
						setElementPosition(localPlayer, v[1], v[2], v[3])
						do setElementPosition(localPlayer, v[1], v[2], v[3]) end
						fadeCamera(true)
						destroyElement(sound)
						destroyElement(text)
						triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wychodzi z autobusu.", 5, 15, false)
						setTimer(triggerServerEvent, 1000, 1, "broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " przyjeżdża autobusem.", 5, 15, false)
					end, 1000, 1)
				end, czas_jazdy*60000, 1)
				
	    return
	end
     end
     return
end

addEventHandler( "onClientGUIDoubleClick", g_przystanki, przystanek_wybor, false );

addEventHandler("onClientColShapeHit", resourceRoot, function(hitElement, matchingDimension)
    if (hitElement~=localPlayer or not matchingDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    if (getPedOccupiedVehicle(localPlayer)) then return end
    local przystanek=przystanki_find(source)
    if (not przystanek) then return false end
    
    przystanki_fill(przystanek)
    guiSetVisible(g_przystanki,true)
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(hitElement, matchingDimension)
    if (hitElement~=localPlayer or not matchingDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    guiSetVisible(g_przystanki,false)
end)

--[[
function menu_przystanek(argumenty)
    local i=argumenty.indeks

    if (getElementInterior(localPlayer)~=getElementInterior(przystanki[i].obiekt) or getElementDimension(localPlayer)~=getElementDimension(przystanki[i].obiekt)) then return end -- nie powinno sie wydarzyc
    local x,y,z=getElementPosition(localPlayer)
    if (getDistanceBetweenPoints3D(x,y,z,przystanki[i][1], przystanki[i][2], przystanki[i][3])>5) then
	outputChatBox("Jesteś zbyt daleko od przystanku. Podejdź bliżej.", 255,0,0,true)
	return
    end
    

end
]]--