local I=1
local D=30

local punkt_nadawczy=createMarker(1265.09,-1550.22,1381.83,"corona",1, 255,255,255,0)
setElementDimension(punkt_nadawczy,D)
setElementInterior(punkt_nadawczy,I)

local pw={}

pw.win = guiCreateWindow(0.2281,0.2021,0.5938,0.6417,"",true)
pw.lbl_adres = guiCreateLabel(0.0263,0.0682,0.2553,0.0649,"Adres/Adresat:",true,pw.win)
pw.edt_adres = guiCreateEdit(0.0263,0.1331,0.5158,0.0844,"",true,pw.win)
pw.btn_adres = guiCreateButton(0.5579,0.1364,0.4079,0.0812,"Sprawdź poprawność",true,pw.win)
pw.lbl_temat = guiCreateLabel(0.0263,0.237,0.2553,0.0649,"Temat:",true,pw.win)
pw.edt_temat = guiCreateEdit(0.0263,0.3019,0.9395,0.0844,"",true,pw.win)
pw.lbl_tresc = guiCreateLabel(0.0263,0.4058,0.2553,0.0649,"Treść:",true,pw.win)
pw.mem_tresc = guiCreateMemo(0.0237,0.4773,0.9421,0.4026,"",true,pw.win)
pw.btn_wyslij = guiCreateButton(0.0263,0.8961,0.4079,0.0747,"Wyślij (25$)",true,pw.win)
pw.btn_anuluj = guiCreateButton(0.5421,0.8961,0.4237,0.0747,"Zrezygnuj",true,pw.win)

guiSetVisible(pw.win,false)

pw.verifyok=false
pw.adresat=nil

pw.pokaz=function()
    guiSetVisible(pw.win,true)
    guiSetEnabled(pw.btn_wyslij,false)
    guiSetEnabled(pw.edt_adres,true)
    pw.verifyok=false
    guiSetText(pw.btn_adres, "Sprawdź poprawność")
    guiSetInputMode("no_binds_when_editing")
    pw.adresat=nil
end

pw.sprawdzAdres=function()
    local adres=guiGetText(pw.edt_adres)
    if (string.len(adres)<2) then
	guiSetText(pw.btn_adres,"Adres jest za krótki")
	pw.verifyok=false
	pw.adresat=nil
	guiSetEnabled(pw.btn_wyslij,false)
	setTimer(guiSetText, 1500, 1, pw.btn_adres, "Sprawdź poprawność")
	return
    end
    triggerServerEvent("doVerifyPostalAddress", localPlayer, adres)
end

pw.sprawdzAdresResponse=function(adres,wynik,adresat)
--    outputChatBox("a1" .. adres)
--    outputChatBox("a2" .. guiGetText(pw.edt_adres))
    if (adres~=guiGetText(pw.edt_adres)) then return end
    if (wynik) then
	guiSetText(pw.btn_adres,"Adres jest prawidłowy")
	guiSetEnabled(pw.edt_adres,false)
	guiSetEnabled(pw.btn_wyslij,true)
	pw.verifyok=true
	pw.adresat=adresat

    else
	guiSetText(pw.btn_adres,"Adres jest błędny")
	setTimer(guiSetText, 2500, 1, pw.btn_adres, "Sprawdź poprawność")
	guiSetEnabled(pw.btn_wyslij,false)
	pw.verifyok=false
	pw.adresat=nil
    end
end

pw.schowaj=function()
    guiSetVisible(pw.win,false)
end

pw.wyslij=function()
    if (getPlayerMoney(localPlayer)<25) then
	outputChatBox("(( nie stać Cię na wysłanie listu - wymagane 25$ ))")
	pw.schowaj()
	return
    end
--    outputChatBox("adresat: " .. pw.adresat)
    if (not pw.adresat) then return end
--    outputChatBox("pw 2")
    local temat=guiGetText(pw.edt_temat)
    local tresc=guiGetText(pw.mem_tresc)
    if (string.len(temat)<1) then
	outputChatBox("(( wprowadź temat wiadomości ))")
	return
    end
    if (string.len(tresc)<1) then
	outputChatBox("(( wprowadź treść wiadomości ))")
	return
    end
    

    triggerServerEvent("doSendPost", localPlayer, pw.adresat, temat, tresc)
    pw.schowaj()
end

addEventHandler("onClientMarkerHit", punkt_nadawczy, function(el,md)
    if (el~=localPlayer) then return end
    if (not md) then return end
    if (getPlayerMoney(localPlayer)<25) then
	outputChatBox("(( nie stać Cię na wysłanie listu - wymagane 25$ ))")
	return
    end
    outputChatBox("(( poczta w przygotowaniu. ))")
    if (getPlayerName(localPlayer)~="Shawn_Hanks" and getPlayerName(localPlayer)~="Dozer_Baltaar") then return end
    pw.pokaz()
end)


addEventHandler("onClientMarkerLeave", punkt_nadawczy, function(el,md)
    if (el~=localPlayer) then return end
    pw.schowaj()
end)

addEventHandler("onClientGUIClick", pw.btn_anuluj, pw.schowaj, false)
addEventHandler("onClientGUIClick", pw.btn_wyslij, pw.wyslij, false)
addEventHandler("onClientGUIClick", pw.btn_adres, pw.sprawdzAdres, false)
addEvent("doVerifyPostalAddressResponse", true)
addEventHandler("doVerifyPostalAddressResponse", resourceRoot, pw.sprawdzAdresResponse)