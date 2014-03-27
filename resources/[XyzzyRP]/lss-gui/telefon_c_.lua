--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



--if (getPlayerName(localPlayer)=="Shawn_Hanks" or getPlayerName(localPlayer)=="Dozer_Baltaar" or getPlayerName(localPlayer)=="Tom_Rosales") then 

local telefon_numer=0
local stan_konta=10


local kontakty={
--    { 300001, "Shawn Hanks", true },
--    { 300016, "Dozer Baltaar", true },
--    { 300008, "Tom Rosales", false },
}

local wiadomosci={
--[[
    [ 300001 ]={
	    { incoming=true, tresc="Testowa wiadomość przychodząca", ts="2012.03.04 12:57" },
	    { incoming=false, tresc="Testowa odpowiedź", ts="2012.03.04 13:57" },
	    },
    [ 300016 ]={
	    { incoming=true, tresc="Testowa wiadomość przychodząca", ts="2012.03.04 12:57" },
	    { incoming=false, tresc="Testowa odpowiedź", ts="2012.03.04 13:57" },
	    },
	    
]]--
}

phoneSong = {}


local telefon={}


local wybrany_numer=nil

telefon.img=guiCreateStaticImage(0.74,0.25,0.25,0.6,"img/telefon.png", true)
guiSetVisible(telefon.img,false)
telefon.btn_home=guiCreateButton(0.4,0.85,0.2,0.1," ", true, telefon.img)
telefon.lbl_info=guiCreateLabel(0.1,0.23, 0.8,0.1,"Trwa łączenie z siecią GSM", true, telefon.img)
guiLabelSetHorizontalAlign(telefon.lbl_info,"center", true)
guiLabelSetVerticalAlign(telefon.lbl_info,"center")
guiLabelSetColor(telefon.lbl_info,0,0,0)
guiSetFont(telefon.lbl_info, "default-bold-small")
telefon.btn_kontakty=guiCreateButton(0.1, 0.36, 0.8,0.2,"Kontakty", true, telefon.img)
telefon.btn_wiadomosci=guiCreateButton(0.1, 0.57, 0.8,0.2,"Wiadomości", true, telefon.img)

telefon.grid_kontakty=guiCreateGridList(0.08,0.20,0.845,0.51,true, telefon.img)
guiGridListSetSortingEnabled(telefon.grid_kontakty,false)
telefon.grid_kontakt_c_nazwa = guiGridListAddColumn( telefon.grid_kontakty, "Nazwa", 0.6 )
telefon.grid_kontakt_c_numer = guiGridListAddColumn( telefon.grid_kontakty, "Numer", 0.35 )
telefon.btn_dodajkontakt=guiCreateButton(0.08,0.71,0.845,0.11, "Dodaj kontakt", true, telefon.img)

telefon.lbl_dk_numer=guiCreateLabel(0.1,0.23,0.8,0.1,"Numer telefonu:", true, telefon.img)
telefon.edit_dk_numer=guiCreateEdit(0.1,0.34,0.8,0.1,"", true, telefon.img)
telefon.lbl_dk_nazwa=guiCreateLabel(0.1,0.45,0.8,0.1,"Nazwa:", true, telefon.img)
telefon.edit_dk_nazwa=guiCreateEdit(0.1,0.56,0.8,0.1,"", true, telefon.img)
guiLabelSetHorizontalAlign(telefon.lbl_dk_numer,"center", true)
guiLabelSetVerticalAlign(telefon.lbl_dk_numer,"center")
guiLabelSetColor(telefon.lbl_dk_numer,0,0,0)
guiSetFont(telefon.lbl_dk_numer, "default-bold-small")
guiLabelSetHorizontalAlign(telefon.lbl_dk_nazwa,"center", true)
guiLabelSetVerticalAlign(telefon.lbl_dk_nazwa,"center")
guiLabelSetColor(telefon.lbl_dk_nazwa,0,0,0)
guiSetFont(telefon.lbl_dk_nazwa, "default-bold-small")


telefon.grid_wiadomosci=guiCreateGridList(0.08,0.20,0.845,0.61,true, telefon.img)
guiGridListSetSortingEnabled(telefon.grid_wiadomosci,false)
telefon.grid_wiadomosci_c = guiGridListAddColumn( telefon.grid_wiadomosci, "Wiadomości", 0.8 )

telefon.grid_rozmowa=guiCreateGridList(0.08,0.20,0.845,0.51,true, telefon.img)
guiGridListSetSortingEnabled(telefon.grid_rozmowa,false)
telefon.grid_rozmowa_c = guiGridListAddColumn( telefon.grid_rozmowa, "Wiadomości", 0.95 )

telefon.btn_nowawiadomosc=guiCreateButton(0.08,0.71,0.42,0.11, "Nowa wiadomość", true, telefon.img)
telefon.btn_zadzwon=guiCreateButton(0.501,0.71,0.43,0.11, "Zadzwoń", true, telefon.img)

telefon.lbl_odbiorca=guiCreateLabel(0.1,0.23, 0.8,0.1,"Nowa wiadomość do:\n", true, telefon.img)
guiLabelSetHorizontalAlign(telefon.lbl_odbiorca,"center", true)
guiLabelSetVerticalAlign(telefon.lbl_odbiorca,"center")
guiLabelSetColor(telefon.lbl_odbiorca,0,0,0)
guiSetFont(telefon.lbl_odbiorca, "default-bold-small")
telefon.memo_tresc=guiCreateMemo ( 0.08, 0.33, 0.845, 0.35, "", true, telefon.img)
telefon.btn_wyslij=guiCreateButton(0.08,0.71,0.845,0.11, "Wyślij", true, telefon.img)

local function nazwa_kontaktu(numer)
    for i,v in ipairs(kontakty) do
	if (tonumber(v[1])==tonumber(numer)) then return v[2] end
    end
    return numer
end

local function telefon_scr_home()
	if (guiGetVisible(telefon.img)) then
	    playSoundFrontEnd(1)
	end
    wybrany_numer=nil
	guiSetText(telefon.lbl_info, tostring(telefon_numer) .. "\nStan konta: "..tostring(stan_konta).."$")
    guiSetVisible(telefon.lbl_info, true)
    guiSetVisible(telefon.btn_kontakty, true)
    guiSetVisible(telefon.btn_wiadomosci, true)
    guiSetVisible(telefon.grid_kontakty, false)
	guiSetVisible(telefon.btn_dodajkontakt, false)
	guiSetVisible(telefon.lbl_dk_numer, false)
	guiSetVisible(telefon.lbl_dk_nazwa, false)
	guiSetVisible(telefon.edit_dk_numer, false)
	guiSetVisible(telefon.edit_dk_nazwa, false)

    guiSetVisible(telefon.grid_wiadomosci, false)
    guiSetVisible(telefon.grid_rozmowa, false)
    guiSetVisible(telefon.btn_nowawiadomosc, false)
	guiSetVisible(telefon.btn_zadzwon, false)
    guiSetVisible(telefon.lbl_odbiorca, false)
    guiSetVisible(telefon.memo_tresc, false)
    guiSetVisible(telefon.btn_wyslij, false)
end

local function telefon_scr_kontakty()
    playSoundFrontEnd(1)
    wybrany_numer=nil
	guiSetText(telefon.btn_dodajkontakt, "Dodaj kontakt")
    guiSetVisible(telefon.lbl_info, false)
    guiSetVisible(telefon.btn_kontakty, false)
    guiSetVisible(telefon.btn_wiadomosci, false)
    guiSetVisible(telefon.grid_kontakty, true)
	guiSetVisible(telefon.btn_dodajkontakt, true)
	guiSetVisible(telefon.lbl_dk_numer, false)
	guiSetVisible(telefon.lbl_dk_nazwa, false)
	guiSetVisible(telefon.edit_dk_numer, false)
	guiSetVisible(telefon.edit_dk_nazwa, false)
    guiSetVisible(telefon.grid_wiadomosci, false)
    guiSetVisible(telefon.grid_rozmowa, false)
    guiSetVisible(telefon.btn_nowawiadomosc, false)
	guiSetVisible(telefon.btn_zadzwon, false)
    guiSetVisible(telefon.lbl_odbiorca, false)
    guiSetVisible(telefon.memo_tresc, false)
    guiSetVisible(telefon.btn_wyslij, false)
    -- wypelniamy danymi
    guiGridListClear(telefon.grid_kontakty)
    for i,v in ipairs(kontakty) do
	local row = guiGridListAddRow ( telefon.grid_kontakty )
        guiGridListSetItemText ( telefon.grid_kontakty, row, telefon.grid_kontakt_c_nazwa, v[2], false, false )
        guiGridListSetItemText ( telefon.grid_kontakty, row, telefon.grid_kontakt_c_numer, v[1], false, false )
	if (v[3]) then
	    guiGridListSetItemColor(telefon.grid_kontakty, row, telefon.grid_kontakt_c_nazwa, 0,255,0)
	    guiGridListSetItemColor(telefon.grid_kontakty, row, telefon.grid_kontakt_c_numer, 0,255,0)
	else
	    guiGridListSetItemColor(telefon.grid_kontakty, row, telefon.grid_kontakt_c_nazwa, 255,0,0)
	    guiGridListSetItemColor(telefon.grid_kontakty, row, telefon.grid_kontakt_c_numer, 255,0,0)
	end
    end
end

local function wiadomosci_getSelected()
	if (wybrany_numer) then 
		return wybrany_numer
	elseif (guiGetVisible(telefon.grid_kontakty)) then
	    local selectedRow = guiGridListGetSelectedItem( telefon.grid_kontakty ); -- get double clicked item in the gridlist
	    if (not selectedRow) then return nil end
    
	    for i,v in pairs(kontakty) do
		if (selectedRow==0) then return v[1] end
		selectedRow=selectedRow-1
	    end

	elseif (guiGetVisible(telefon.grid_wiadomosci)) then

	    local selectedRow = guiGridListGetSelectedItem( telefon.grid_wiadomosci ); -- get double clicked item in the gridlist
	    if (not selectedRow) then return nil end
    
	    for i,v in pairs(wiadomosci) do
		if (selectedRow==0) then return i end
		selectedRow=selectedRow-1
	    end
	end
    return nil
end


local function telefon_scr_nowykontakt()
    playSoundFrontEnd(1)
    wybrany_numer=nil

	if (guiGetVisible(telefon.grid_kontakty)) then
		wybrany_numer=nil
		wybrany_numer=wiadomosci_getSelected()
		if (wybrany_numer) then
			-- usuwanie kontaktu
			triggerServerEvent("onPhoneContactRemove", localPlayer, telefon_numer, wybrany_numer)
			telefon_scr_home()
		else
			-- dodawanie kontaktu
		    guiSetVisible(telefon.lbl_info, false)
		    guiSetVisible(telefon.btn_kontakty, false)
		    guiSetVisible(telefon.btn_wiadomosci, false)
		    guiSetVisible(telefon.grid_kontakty, false)
			guiSetVisible(telefon.btn_dodajkontakt, true)
			guiSetVisible(telefon.lbl_dk_numer, true)
			guiSetVisible(telefon.lbl_dk_nazwa, true)
			guiSetVisible(telefon.edit_dk_numer, true)
			guiSetVisible(telefon.edit_dk_nazwa, true)
		    guiSetVisible(telefon.grid_wiadomosci, false)
		    guiSetVisible(telefon.grid_rozmowa, false)
		    guiSetVisible(telefon.btn_nowawiadomosc, false)
			guiSetVisible(telefon.btn_zadzwon, false)
		    guiSetVisible(telefon.lbl_odbiorca, false)
		    guiSetVisible(telefon.memo_tresc, false)
		    guiSetVisible(telefon.btn_wyslij, false)
		end
	else
		-- wlasciwe dodawanie kontaktu
		local nazwa=guiGetText(telefon.edit_dk_nazwa)
		local numer=tonumber(guiGetText(telefon.edit_dk_numer))
		triggerServerEvent("onPhoneContactAdd", localPlayer, telefon_numer, numer, nazwa)
		guiSetText(telefon.edit_dk_numer,"")
		guiSetText(telefon.edit_dk_nazwa,"")
		telefon_scr_home()
	end
end




local function telefon_scr_wiadomosci()
    playSoundFrontEnd(1)
    wybrany_numer=nil
    guiSetVisible(telefon.lbl_info, false)
    guiSetVisible(telefon.btn_kontakty, false)
    guiSetVisible(telefon.btn_wiadomosci, false)
    guiSetVisible(telefon.grid_kontakty, false)
	guiSetVisible(telefon.btn_dodajkontakt, false)
	guiSetVisible(telefon.lbl_dk_numer, false)
	guiSetVisible(telefon.lbl_dk_nazwa, false)
	guiSetVisible(telefon.edit_dk_numer, false)
	guiSetVisible(telefon.edit_dk_nazwa, false)
    guiSetVisible(telefon.grid_wiadomosci, true)
    guiSetVisible(telefon.grid_rozmowa, false)
    guiSetVisible(telefon.btn_nowawiadomosc, false)
	guiSetVisible(telefon.btn_zadzwon, false)
    guiSetVisible(telefon.lbl_odbiorca, false)
    guiSetVisible(telefon.memo_tresc, false)
    guiSetVisible(telefon.btn_wyslij, false)
    -- wypelniamy danymi
    guiGridListClear(telefon.grid_wiadomosci)
    for i,v in pairs(wiadomosci) do
	local row = guiGridListAddRow ( telefon.grid_wiadomosci)
        guiGridListSetItemText ( telefon.grid_wiadomosci, row, telefon.grid_wiadomosci_c, tostring(nazwa_kontaktu(i)) .. "("..#v..")", false, false )
    end
end


local function telefon_scr_rozmowa()
    local numer=wiadomosci_getSelected()
    if (not numer) then return end
    wybrany_numer=numer
--    outputChatBox( "You double-clicked: " .. numer );
    playSoundFrontEnd(1)
    guiSetVisible(telefon.lbl_info, false)
    guiSetVisible(telefon.btn_kontakty, false)
    guiSetVisible(telefon.btn_wiadomosci, false)
    guiSetVisible(telefon.grid_kontakty, false)
	guiSetVisible(telefon.btn_dodajkontakt, false)
	guiSetVisible(telefon.lbl_dk_numer, false)
	guiSetVisible(telefon.lbl_dk_nazwa, false)
	guiSetVisible(telefon.edit_dk_numer, false)
	guiSetVisible(telefon.edit_dk_nazwa, false)
    guiSetVisible(telefon.grid_wiadomosci, false)
    guiSetVisible(telefon.grid_rozmowa, true)
    guiSetVisible(telefon.btn_nowawiadomosc, true)
	guiSetVisible(telefon.btn_zadzwon, true)
    guiSetVisible(telefon.lbl_odbiorca, false)
    guiSetVisible(telefon.memo_tresc, false)
    guiSetVisible(telefon.btn_wyslij, false)
    -- wypelniamy danymi
--    guiSetText(telefon.grid_rozmowa_c,nazwa_kontaktu(numer))
    guiGridListClear(telefon.grid_rozmowa)
	if (wiadomosci[numer]) then
	    for i,v in ipairs(wiadomosci[numer]) do
		local row = guiGridListAddRow ( telefon.grid_rozmowa)
	        guiGridListSetItemText ( telefon.grid_rozmowa, row, telefon.grid_rozmowa_c, v.tresc, false, false )
		if (v.incoming) then
		    guiGridListSetItemColor(telefon.grid_rozmowa, row, telefon.grid_rozmowa_c, 255,255,0)
		else
		    guiGridListSetItemColor(telefon.grid_rozmowa, row, telefon.grid_rozmowa_c, 255,255,255)
		end
		end
	    guiGridListAutoSizeColumn(telefon.grid_rozmowa, telefon.grid_rozmowa_c)
    end

    
end

local function telefon_scr_nowawiadomosc()
    if (not wybrany_numer) then return end
    playSoundFrontEnd(1)
    guiSetVisible(telefon.lbl_info, false)
    guiSetVisible(telefon.btn_kontakty, false)
    guiSetVisible(telefon.btn_wiadomosci, false)
    guiSetVisible(telefon.grid_kontakty, false)
	guiSetVisible(telefon.btn_dodajkontakt, false)
	guiSetVisible(telefon.lbl_dk_numer, false)
	guiSetVisible(telefon.lbl_dk_nazwa, false)
	guiSetVisible(telefon.edit_dk_numer, false)
	guiSetVisible(telefon.edit_dk_nazwa, false)
    guiSetVisible(telefon.grid_wiadomosci, false)
    guiSetVisible(telefon.grid_rozmowa, false)
    guiSetVisible(telefon.btn_nowawiadomosc, false)
	guiSetVisible(telefon.btn_zadzwon, false)
    guiSetVisible(telefon.lbl_odbiorca, true)
    guiSetText(telefon.lbl_odbiorca,"Odbiorca:\n" .. nazwa_kontaktu(wybrany_numer))
    guiSetVisible(telefon.memo_tresc, true)
    guiSetVisible(telefon.btn_wyslij, true)
    
end

function telefon_wyslij_wiadomosc()
	if (not wybrany_numer) then return end
	playSoundFrontEnd(6)
	tresc=guiGetText(telefon.memo_tresc)

	triggerServerEvent("onSMSSent", resourceRoot, telefon_numer, wybrany_numer, tresc)
	if (not wiadomosci[wybrany_numer]) then wiadomosci[wybrany_numer]={} end
	table.insert(wiadomosci[wybrany_numer], { incoming=false, tresc=tresc })
	guiSetText(telefon.memo_tresc,"")
	telefon_scr_rozmowa()
end

function telefon_zadzwon()
	if (not wybrany_numer) then return end
	playSoundFrontEnd(6)

	triggerServerEvent("onPhoneCall", resourceRoot, getLocalPlayer(), telefon_numer, wybrany_numer)
end

telefon_scr_home()

addEventHandler("onClientGUIClick", telefon.btn_home, telefon_scr_home, false)
addEventHandler("onClientGUIClick", telefon.btn_kontakty, telefon_scr_kontakty, false)
addEventHandler("onClientGUIClick", telefon.btn_dodajkontakt, telefon_scr_nowykontakt, false)
addEventHandler("onClientGUIClick", telefon.btn_wiadomosci, telefon_scr_wiadomosci, false)
addEventHandler("onClientGUIClick", telefon.btn_nowawiadomosc, telefon_scr_nowawiadomosc, false)
addEventHandler("onClientGUIClick", telefon.btn_wyslij, telefon_wyslij_wiadomosc, false)
addEventHandler("onClientGUIClick", telefon.btn_zadzwon, telefon_zadzwon, false)
addEventHandler( "onClientGUIDoubleClick", telefon.grid_wiadomosci, telefon_scr_rozmowa, false )
addEventHandler( "onClientGUIDoubleClick", telefon.grid_kontakty, telefon_scr_rozmowa, false )
addEventHandler( "onClientGUIClick", telefon.grid_kontakty, function()	-- w zalzenosci od tego czy jest wybrany numer czy nie, zmieniamy button na dodaj lub usun kontakt
		wybrany_numer=nil
		wybrany_numer=wiadomosci_getSelected()
		if (wybrany_numer) then
			guiSetText(telefon.btn_dodajkontakt, "Usuń kontakt")
		else
			guiSetText(telefon.btn_dodajkontakt, "Dodaj kontakt")
		end
		end, false )

addEvent("onPhoneSync", true)
addEventHandler("onPhoneSync", resourceRoot, function(dane)
	outputDebugString("Phone sync rcvd")
	telefon_numer=dane.numer
	triggerServerEvent("setPhoneNumber", resourceRoot, localPlayer, telefon_numer)
	stan_konta=dane.stan_konta or 0
	guiSetText(telefon.lbl_info, tostring(telefon_numer) .. "\nStan konta: "..tostring(stan_konta).."$")
	kontakty=dane.kontakty or {}
	wiadomosci=dane.wiadomosci or {}
	guiSetText(telefon.btn_wiadomosci, "Wiadomości ("..tonumber(dane.wiadomosc_count or 0)..")")
end)

function telefon_toggle(numer)
		lastTelefonToggleTick = getTickCount()
		guiSetInputMode("no_binds_when_editing")
		telefon_numer=numer
		triggerServerEvent("setPhoneNumber", resourceRoot, localPlayer, telefon_numer)
		if (guiGetVisible(telefon.img)) then
			guiSetVisible(telefon.img,false)
			triggerServerEvent("iPhoneOff", getRootElement(), localPlayer)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa telefon do kieszeni", 3, 15, true)
		else
			guiSetVisible(telefon.img,true)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyjmuje telefon z kieszeni", 3, 15, true)
			triggerServerEvent("onIPhone", getRootElement(), localPlayer)
			triggerServerEvent("onPhoneRequestSync", resourceRoot, localPlayer, telefon_numer)
		end
end

--end

addEvent("onIncomingSMS", true)
addEventHandler("onIncomingSMS", resourceRoot, function(nr,tresc,from, senderElement)
  if (telefon_numer and nr and tonumber(nr)==tonumber(telefon_numer)) then
	setTimer(playSoundFrontEnd, 100, 2,1)
	outputChatBox("W twojej kieszeni wibruje telefon.")
  end
  -- pagery!
  if (not eq_getItemByID(35)) then return end
  local fid=getElementData(localPlayer, "faction:id")
  if (not fid) then return end
--[[
  if (tonumber(nr)==998 and tonumber(fid)==11) then
	outputChatBox("PAGER: #FFFFFF" .. string.gsub(tresc,"\n"," ") .. " -- ".. from, 255,0,0,true)
	if senderElement then
		exports["lss-frakcje"]:addMiscRequest(senderElement)
	end
  elseif (tonumber(nr)==999 and tonumber(fid)==6) then
	outputChatBox("PAGER: #FFFFFF" .. string.gsub(tresc,"\n"," ") .. " -- ".. from, 255,0,0,true)
	if senderElement then
		exports["lss-frakcje"]:addMiscRequest(senderElement)
	end
  elseif (tonumber(nr)==997 and tonumber(fid)==2) then
	outputChatBox("PAGER: #FFFFFF" .. string.gsub(tresc,"\n"," ") .. " -- ".. from, 255,0,0,true)
	if senderElement then
		exports["lss-frakcje"]:addMiscRequest(senderElement)
	end
  elseif (tonumber(nr)==606 and tonumber(fid)==22) then
	outputChatBox("PAGER: #FFFFFF" .. string.gsub(tresc,"\n"," ") .. " -- ".. from, 255,0,0,true)
	if senderElement then
		exports["lss-frakcje"]:addMiscRequest(senderElement)
	end
]]--
  if (tonumber(nr)==911 and (tonumber(fid)==2 or tonumber(fid)==6 or tonumber(fid)==11 or tonumber(fid)==22)) then
	outputChatBox("PAGER: #FFFFFF" .. string.gsub(tresc,"\n"," ") .. " -- ".. from, 255,0,0,true)
	if senderElement then
		exports["lss-frakcje"]:addMiscRequest(senderElement)
	end
  elseif (tonumber(nr)==990 and tonumber(fid)==4) then
	outputChatBox("PAGER: #FFFFFF" .. string.gsub(tresc,"\n"," ") .. " -- ".. from, 255,0,0,true)
	if senderElement then
		exports["lss-frakcje"]:addMiscRequest(senderElement)
	end


  elseif (tonumber(nr)==9696 and tonumber(fid)==7) then -- taxi
	outputChatBox("PAGER: #FFFFFF" .. string.gsub(tresc,"\n"," ") .. " -- ".. from, 0,0,255,true)
	if senderElement then
		exports["lss-frakcje"]:addTaxiRequest(senderElement)
	end
  elseif (tonumber(nr)==313 and tonumber(fid)==35) then -- departament turystyki
	outputChatBox("PAGER: #FFFFFF" .. string.gsub(tresc,"\n"," ") .. " -- ".. from, 0,0,255,true)
	if senderElement then
		exports["lss-frakcje"]:addTaxiRequest(senderElement)
	end
  elseif (tonumber(nr)==9292 and tonumber(fid)==5) then -- cnn news
	outputChatBox("PAGER: #FFFFFF" .. string.gsub(tresc,"\n"," ") .. " -- ".. from, 0,0,255,true)
	if senderElement then
		exports["lss-frakcje"]:addTaxiRequest(senderElement)
	end
  end
end)

addEvent("onIncomingCall", true)
addEventHandler("onIncomingCall", getLocalPlayer(), function(od,bud)
	local player = source
	outputChatBox("#E7D9B0(( Dzwoni numer #FFFCA8"..od.." #7DFF8C[ALT+1 - odbierz] #FF3639[ALT+2 - odrzuć] #E7D9B0))", 231, 217, 176, true)
	budka = bud
end)

addEvent("onIncomingCallSong", true)
addEventHandler("onIncomingCallSong", getRootElement(), function(player)
	if phoneSong[player] then destroyElement(phoneSong[player]) end
	phoneSong[player] = playSound3D("audio/nokiatune.ogg", 1, 1, 1, true)
	setSoundMaxDistance(phoneSong[player], 11)
	setElementDimension(phoneSong[player], getElementDimension(player))
	setElementInterior(phoneSong[player], getElementInterior(player))
	attachElements(phoneSong[player], player)
end)

addEvent("killPhoneSong", true)
addEventHandler("killPhoneSong", getRootElement(), function(player)
	if phoneSong[player] and isElement(phoneSong[player]) then destroyElement(phoneSong[player]) phoneSong[player]=false end
end)

function phone_accept(_,_,player)
	if (getKeyState("lalt") or getKeyState("ralt")) and getKeyState("1") then
		if getElementData(player, "odebralOd") then return false end
		if not getElementData(player, "dzwoniDoNiego") then return false end
		triggerServerEvent("onPhoneAccept", getRootElement(), player,budka)
	end
end

function phone_decline(_,_,player)
	if (getKeyState("lalt") or getKeyState("ralt")) and getKeyState("2") then
		if getElementData(player, "odebralOd") then return false end
		if not getElementData(player, "dzwoniDoNiego") then return false end
		triggerServerEvent("onPhoneDecline", getRootElement(), player,budka)
	end
end

function phone_end(_,_,player)
	if (getKeyState("lalt") or getKeyState("ralt")) and getKeyState("3") then
		triggerServerEvent("onPhoneEnd", getRootElement(), player,budka)
	end
end


addEventHandler("onClientResourceStart", resourceRoot, function()
	local player = getLocalPlayer()
	bindKey("1", "down", phone_accept, player)
	bindKey("lalt", "down", phone_accept, player)
	bindKey("ralt", "down", phone_accept, player)
	
	bindKey("2", "down", phone_decline, player)
	bindKey("lalt", "down", phone_decline, player)
	bindKey("ralt", "down", phone_decline, player)
	
	bindKey("3", "down", phone_end, player)
	bindKey("lalt", "down", phone_end, player)
	bindKey("ralt", "down", phone_end, player)
end)
