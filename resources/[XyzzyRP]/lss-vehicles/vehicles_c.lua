--[[
system pojazdow


@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



function graczMaKlucze(vehicle)
    local dbid=getElementData(vehicle,"dbid")
    if (dbid) then
	if (exports["lss-gui"]:eq_getItemByID(6,tonumber(dbid))) then
	    return true
	end

    -- pojazd org. przestepczej
    local owning_co=getElementData(vehicle,"owning_co")
    if owning_co then
      local character=getElementData(localPlayer, "character")
      if character and character.co_id and tonumber(character.co_id)==tonumber(owning_co) then
        return true
      end
    end

	-- pojazd frakcyjny
	local owning_faction=getElementData(vehicle,"owning_faction")
	if (owning_faction) then

		local lfid=getElementData(localPlayer,"faction:id")
		if tonumber(owning_faction)==24 then return true end
		if (not lfid)  then return false end
		if tonumber(lfid)~=tonumber(owning_faction) then return false end
	-- pobieramy range we frakcji do przyszlego wykorzystania
		local lfrid=getElementData(localPlayer,"faction:rank_id")

	    -- frakcja 4 - sm - kluczyki id 12
	    if (tonumber(owning_faction)==4 and exports["lss-gui"]:eq_getItemByID(12) and lfrid>=2) then
		return true
	    end
	    -- frakcja 2 - policja - kluczyki id 11
	    if (tonumber(owning_faction)==2 and exports["lss-gui"]:eq_getItemByID(11)) then
		return true
	    end
	    -- frakcja 3 warsztat kluczyki id 14
	    if (tonumber(owning_faction)==3 and exports["lss-gui"]:eq_getItemByID(14) and lfrid>=2) then
		return true
	    end
		-- frakcja 8 nauka jazdy kluczyki id 20
	    if (tonumber(owning_faction)==8 and exports["lss-gui"]:eq_getItemByID(20)) then
		return true
	    end
		-- frakcja taxi
	    if (tonumber(owning_faction)==7 and exports["lss-gui"]:eq_getItemByID(26)) then
		return true
	    end
		-- szpital
	    if (tonumber(owning_faction)==6 and exports["lss-gui"]:eq_getItemByID(29) and lfrid>=2) then
		return true
	    end
		-- straz
	    if (tonumber(owning_faction)==11 and exports["lss-gui"]:eq_getItemByID(39) and lfrid>=2) then
		return true
	    end
	    -- frakcja 5 cnn news kluczyki id 49
	    if (tonumber(owning_faction)==5 and exports["lss-gui"]:eq_getItemByID(49) and lfrid>=2) then
		return true
	    end
	    -- frakcja 1 urzad miasta kluczyki id 50
	    if (tonumber(owning_faction)==1 and exports["lss-gui"]:eq_getItemByID(50) and lfrid>=2) then
		return true
	    end
--	     frakcja 9 kurierzy kluczyki id 51
	    if (tonumber(owning_faction)==9 and exports["lss-gui"]:eq_getItemByID(51)) then
		return true
	    end
	    -- frakcja 12 warsztat II kluczyki id 52
	    if (tonumber(owning_faction)==12 and exports["lss-gui"]:eq_getItemByID(52) and lfrid>=2) then
		return true
	    end
	    -- frakcja 13 warsztat III kluczyki id 53
	    if (tonumber(owning_faction)==13 and exports["lss-gui"]:eq_getItemByID(53) and lfrid>=2) then
		return true
	    end
	    -- frakcja 18 warsztat IV kluczyki id 54
	    if (tonumber(owning_faction)==18 and exports["lss-gui"]:eq_getItemByID(54) and lfrid>=2) then
		return true
	    end
	    -- frakcja 19 warsztat V kluczyki id 55
	    if (tonumber(owning_faction)==19 and exports["lss-gui"]:eq_getItemByID(55) and lfrid>=2) then
		return true
	    end				
	    -- frakcja 16 nauka jazdy 2 kluczyki id 56
	    if (tonumber(owning_faction)==16 and exports["lss-gui"]:eq_getItemByID(56)) then
		return true
	    end		
	    -- frakcja 15 ochrona id 57
	    if (tonumber(owning_faction)==15 and exports["lss-gui"]:eq_getItemByID(57) and lfrid>=2) then
		return true
	    end
	    -- frakcja 10 import id 62
	    if (tonumber(owning_faction)==10 and exports["lss-gui"]:eq_getItemByID(62)) then
		return true
	    end
	    -- frakcja 14 kopalnia id 74
	    if (tonumber(owning_faction)==14 and exports["lss-gui"]:eq_getItemByID(75)) then
		return true
	    end
	    -- frakcja 17 sąd rejonowy id 77
	    if (tonumber(owning_faction)==17 and exports["lss-gui"]:eq_getItemByID(77) and lfrid>=2) then
		return true
	    end
	    -- frakcja 20 służby więzienne id 78
	    if (tonumber(owning_faction)==20 and exports["lss-gui"]:eq_getItemByID(78) and lfrid>=2) then
		return true
	    end
	    -- frakcja 22 służby specjalne id 80
	    if (tonumber(owning_faction)==22 and exports["lss-gui"]:eq_getItemByID(80) and lfrid>=2) then
		return true
	    end
	    -- frakcja 23 prywatna przychodna lekarska id 92
	    if (tonumber(owning_faction)==23 and exports["lss-gui"]:eq_getItemByID(92) and lfrid>=2) then
		return true
	    end
	    -- frakcja 21 sluzby koscielne
	    if (tonumber(owning_faction)==21 and exports["lss-gui"]:eq_getItemByID(101)) then
		return true
	    end		

		-- 24 tartak klucz 103
	    if (tonumber(owning_faction)==24) then
		return true
	    end
		
		-- 25 szkola lotnicza klucz 106
	    if (tonumber(owning_faction)==25 and exports["lss-gui"]:eq_getItemByID(106) and lfrid>=2) then
		return true
	    end
		
		-- klucze Sklep 'na rogu' I
	    if (tonumber(owning_faction)==26 and exports["lss-gui"]:eq_getItemByID(117) and lfrid>=2) then
		return true
	    end
		
		-- klucze Sklep Spożywczy 'Strug' II
	    if (tonumber(owning_faction)==27 and exports["lss-gui"]:eq_getItemByID(118) and lfrid>=2) then
		return true
	    end
		
		-- klucze Knajpka 'na molo' III
	    if (tonumber(owning_faction)==28 and exports["lss-gui"]:eq_getItemByID(119) and lfrid>=2) then
		return true
	    end
		
		-- klucze Restauracja 'The Well Stacked Pizza' IV
	    if (tonumber(owning_faction)==29 and exports["lss-gui"]:eq_getItemByID(120) and lfrid>=2) then
		return true
	    end
		
		-- klucze Restauracja Hot-Food V
	    if (tonumber(owning_faction)==30 and exports["lss-gui"]:eq_getItemByID(121) and lfrid>=2) then
		return true
	    end
		
		-- klucze Market 'Prima' VI
	    if (tonumber(owning_faction)==31 and exports["lss-gui"]:eq_getItemByID(122) and lfrid>=2) then
		return true
	    end
		
		-- klucze Market 'Super Sam' VII
	    if (tonumber(owning_faction)==32 and exports["lss-gui"]:eq_getItemByID(123) and lfrid>=2) then
		return true
	    end
		
		-- klucze Kawiarnia 'pod sceną' VIII
	    if (tonumber(owning_faction)==33 and exports["lss-gui"]:eq_getItemByID(124) and lfrid>=2) then
		return true
	    end
		
		-- klucze Knajpa 'Paszcza Wieloryba' IX
	    if (tonumber(owning_faction)==34 and exports["lss-gui"]:eq_getItemByID(125) and lfrid>=2) then
		return true
	    end
		
		-- klucze Departament Turystyki
	    if (tonumber(owning_faction)==35 and exports["lss-gui"]:eq_getItemByID(126) and lfrid>=2) then
		return true
	    end
	
		-- klucze Knajpa 'Isaura' X
	    if (tonumber(owning_faction)==36 and exports["lss-gui"]:eq_getItemByID(128) and lfrid>=2) then
		return true
	    end
		
		-- klucze Market 'Łubin' XI
	    if (tonumber(owning_faction)==37 and exports["lss-gui"]:eq_getItemByID(127) and lfrid>=2) then
		return true
	    end
		
		-- klucze Restauracja 'Przy skarpie' XII
	    if (tonumber(owning_faction)==38 and exports["lss-gui"]:eq_getItemByID(129) and lfrid>=2) then
		return true
	    end
		
		-- klucze Knajpa 'Diabelski mlyn' XIII
	    if (tonumber(owning_faction)==39 and exports["lss-gui"]:eq_getItemByID(149) and lfrid>=2) then
		return true
	    end
		
		-- klucze Klubu Miasta Los Santos
	    if (tonumber(owning_faction)==40 and exports["lss-gui"]:eq_getItemByID(163) and lfrid>=1) then
		return true
	    end




	    
	end
    end

    return false
end


function menu_startEngine(args)
    local vehicle=args.vehicle
    if (not isElement(vehicle) or getElementType(vehicle)~="vehicle") then	-- nie powinno sie wydarzyc
	outputDebugString("menu_startEngine na elemencie ktory nie jest pojazdem!")
	return
    end
    -- sprawdzamy czy gracz ma klucz do tego pojazdu
    if (not graczMaKlucze(vehicle)) then
        outputChatBox("Nie masz kluczy do tego pojazdu.", 255,0,0,true)
	return
    end

    if (getElementHealth(vehicle)<300) then
        triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " próbuje uruchomić silnik.", 5, 10, true)
	return
    end

--    setVehicleEngineState(vehicle, true)
    triggerServerEvent("setVehicleEngineState", vehicle, true)
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " uruchamia silnik.", 5, 10, true)
end

function menu_stopEngine(args)
    local vehicle=args.vehicle
    if (not isElement(vehicle) or getElementType(vehicle)~="vehicle") then	-- nie powinno sie wydarzyc
	outputDebugString("menu_startEngine na elemencie ktory nie jest pojazdem!")
	return
    end
    -- sprawdzamy czy gracz ma klucz do tego pojazdu
    if (not graczMaKlucze(vehicle)) then
        outputChatBox("Nie masz kluczy do tego pojazdu.", 255,0,0,true)
	return
    end


--    setVehicleEngineState(vehicle, false)
    triggerServerEvent("setVehicleEngineState", vehicle, false)
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " gasi silnik.", 5, 10, true)
end

function menu_openVehicle(args)
    local vehicle=args.vehicle
    if (not isElement(vehicle) or getElementType(vehicle)~="vehicle") then	-- nie powinno sie wydarzyc
	outputDebugString("menu_openVehicle na elemencie ktory nie jest pojazdem!")
	return
    end
    -- sprawdzamy odleglosc
    local x,y,z=getElementPosition(localPlayer)
    local vx,vy,vz=getElementPosition(vehicle)
    if (getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)>5) then
	outputChatBox("Musisz podejść bliżej do pojazdu aby go otworzyć", 255,0,0,true)
	return
    end
    -- sprawdzamy czy gracz ma klucz do tego pojazdu
    if (not graczMaKlucze(vehicle)) then
        outputChatBox("Nie masz kluczy do tego pojazdu.", 255,0,0,true)
	return
    end

    -- otwieramy go
    triggerServerEvent("setVehicleLocked", vehicle, false)

    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " otwiera zamek w " .. (getVehicleType(vehicle)=="Automobile" and "samochodzie" or "pojeździe" ) .. ".", 5, 15, true)
end

function menu_closeVehicle(args)
    local vehicle=args.vehicle
    if (not isElement(vehicle) or getElementType(vehicle)~="vehicle") then	-- nie powinno sie wydarzyc
	outputDebugString("menu_openVehicle na elemencie ktory nie jest pojazdem!")
	return
    end
    
    -- sprawdzamy odleglosc
    local x,y,z=getElementPosition(localPlayer)
    local vx,vy,vz=getElementPosition(vehicle)
    if (getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)>5) then
	outputChatBox("Musisz podejść bliżej do pojazdu aby go zamknąć", 255,0,0,true)
	return
    end
    -- sprawdzamy czy gracz ma klucz do tego pojazdu
    if (not graczMaKlucze(vehicle)) then
        outputChatBox("Nie masz kluczy do tego pojazdu.", 255,0,0,true)
	return
    end

    -- otwieramy go
    triggerServerEvent("setVehicleLocked", vehicle, true)
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zamyka zamek w " .. (getVehicleType(vehicle)=="Automobile" and "samochodzie" or "pojeździe" ) .. ".", 5, 15, true)
end



function menu_freeze(args)
    local vehicle=args.vehicle
    if (not isElement(vehicle) or getElementType(vehicle)~="vehicle") then	-- nie powinno sie wydarzyc
	outputDebugString("menu_maska na elemencie ktory nie jest pojazdem!")
	return
    end

    -- zaciagamy reczny
    triggerServerEvent("setVehicleFrozen", vehicle, true)
	local vt=getVehicleType(vehicle)
	if (vt=="Boat") then
      triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zarzuca kotwice.", 5, 25, true)
	else
      triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zaciąga hamulec ręczny.", 5, 15, true)
	end


end

function menu_unfreeze(args)
    local vehicle=args.vehicle
    if (not isElement(vehicle) or getElementType(vehicle)~="vehicle") then	-- nie powinno sie wydarzyc
	outputDebugString("menu_unfreeze na elemencie ktory nie jest pojazdem!")
	return
    end

	-- jezeli to motor lub lodz to wymagamy kluczyka
	local vt=getVehicleType(vehicle)
	if (vt=="Boat" or vt=="Bike") then
      if (not graczMaKlucze(vehicle)) then
        outputChatBox("Nie masz kluczy do tego pojazdu.", 255,0,0,true)
		return
      end

	end

    -- spuszczamy reczny
    triggerServerEvent("setVehicleFrozen", vehicle, false)
	if (vt=="Boat") then
      triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wciąga kotwice.", 5, 25, true)
	else
      triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " spuszcza hamulec ręczny.", 5, 10, true)
	end
end



function menu_maska(args)
    local vehicle=args.vehicle
    if (not isElement(vehicle) or getElementType(vehicle)~="vehicle") then	-- nie powinno sie wydarzyc
	outputDebugString("menu_maska na elemencie ktory nie jest pojazdem!")
	return
    end
    -- sprawdzamy odleglosc
    local x,y,z=getElementPosition(localPlayer)
    local vx,vy,vz=getElementPosition(vehicle)
    if (getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)>5) then
	outputChatBox("Musisz podejść bliżej do pojazdu.", 255,0,0,true)
	return
    end

    if (isPedInVehicle(localPlayer)) then
	outputChatBox("Musisz wysiąść z pojazdu aby to zrobić.", 255,0,0,true)
	return
    end

    
    if (getVehicleDoorOpenRatio(vehicle,0)>0) then	-- zamykanie maski
        triggerServerEvent("setVehicleDoorOpenRatio", vehicle, 0, 0, 1000)
        triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zamyka maskę w samochodzie.", 5, 15, true)
	return
    end
    
    -- sprawdzamy czy pojazd jest otwarty
    if (isVehicleLocked(vehicle)) then
	outputChatBox("Pojazd jest zamknięty.", 255,0,0,true)
	return
    end
    -- otwieramy maske
    triggerServerEvent("setVehicleDoorOpenRatio", vehicle, 0, 1, 1000)
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " otwiera maskę w samochodzie.", 5, 15, true)
end

function menu_bagaznik(args)
	-- zastapione przez lss-bagazniki:menu_bagaznik
    local vehicle=args.vehicle
    if (not isElement(vehicle) or getElementType(vehicle)~="vehicle") then	-- nie powinno sie wydarzyc
	outputDebugString("menu_bagaznik na elemencie ktory nie jest pojazdem!")
	return
    end
    -- sprawdzamy odleglosc
    local x,y,z=getElementPosition(localPlayer)
    local vx,vy,vz=getElementPosition(vehicle)
    if (getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)>5) then
	outputChatBox("Musisz podejść bliżej do pojazdu.", 255,0,0,true)
	return
    end
    
    if (isPedInVehicle(localPlayer)) then
	outputChatBox("Musisz wysiąść z pojazdu aby to zrobić.", 255,0,0,true)
	return
    end
    
    if (getVehicleDoorOpenRatio(vehicle,1)>0) then	-- zamykanie maski
        triggerServerEvent("setVehicleDoorOpenRatio", vehicle, 1, 0, 1000)
        triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zamyka bagażnik w samochodzie.", 5, 15, true)
	return
    end
    
    -- sprawdzamy czy pojazd jest otwarty
    if (isVehicleLocked(vehicle)) then
	outputChatBox("Pojazd jest zamknięty.", 255,0,0,true)
	return
    end
    -- otwieramy maske
    triggerServerEvent("setVehicleDoorOpenRatio", vehicle, 1, 1, 1000)
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " otwiera bagażnik w samochodzie.", 5, 15, true)
end

function menu_kogut(args)
  local vehicle=args.vehicle
    if (not isElement(vehicle) or getElementType(vehicle)~="vehicle") then	-- nie powinno sie wydarzyc
	outputDebugString("menu_kogut na elemencie ktory nie jest pojazdem!")
	return
    end
  if getPedOccupiedVehicle(localPlayer)~=vehicle then
	outputChatBox("Musisz byc w pojezdzie.", 255,0,0)
	return
  end
  if not getElementData(vehicle,"kogut") then
	outputChatBox("Ten pojazd nie ma koguta", 255,0,0)
	return
  end
  triggerServerEvent("toggleVehiclePL", vehicle, localPlayer)
end

function menu_neony(args)
  local vehicle=args.vehicle
    if (not isElement(vehicle) or getElementType(vehicle)~="vehicle") then	-- nie powinno sie wydarzyc
	outputDebugString("menu_neony na elemencie ktory nie jest pojazdem!")
	return
    end
  if getPedOccupiedVehicle(localPlayer)~=vehicle then
	outputChatBox("Musisz byc w pojezdzie.", 255,0,0)
	return
  end
  if not getElementData(vehicle,"neony") then
	outputChatBox("Ten pojazd nie ma neonów", 255,0,0)
	return
  end
  triggerServerEvent("toggleVehicleNL", vehicle, localPlayer)
end

function menu_dach(args)
  local vehicle=args.vehicle
    if (not isElement(vehicle) or getElementType(vehicle)~="vehicle") then	-- nie powinno sie wydarzyc
	outputDebugString("menu_dach na elemencie ktory nie jest pojazdem!")
	return
    end
  if getPedOccupiedVehicle(localPlayer)~=vehicle then
	outputChatBox("Musisz byc w pojezdzie.", 255,0,0)
	return
  end
  if (getElementModel(vehicle)~=555) and (getElementModel(vehicle)~=439) then
	return
  end
  triggerServerEvent("toggleVehicleRoof", vehicle, localPlayer)
end




function menu_flip(args)
    local vehicle=args.vehicle
    if (not isElement(vehicle) or getElementType(vehicle)~="vehicle") then	-- nie powinno sie wydarzyc
	outputDebugString("menu_flip na elemencie ktory nie jest pojazdem!")
	return
    end
    -- sprawdzamy odleglosc
    local x,y,z=getElementPosition(localPlayer)
    local vx,vy,vz=getElementPosition(vehicle)
    if (getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)>5) then
	outputChatBox("Musisz podejść bliżej do pojazdu.", 255,0,0,true)
	return
    end
    
    if (isPedInVehicle(localPlayer)) then
	outputChatBox("Musisz wysiąść z pojazdu aby to zrobić.", 255,0,0,true)
	return
    end

    triggerServerEvent("flipVehicle", vehicle, localPlayer)

end