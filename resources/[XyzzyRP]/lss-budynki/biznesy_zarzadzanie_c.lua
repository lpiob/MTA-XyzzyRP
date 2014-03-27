--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--


wbz={}

wbz.win = guiCreateWindow(0.1297,0.2,0.7375,0.6563,"",true)
wbz.btn_anuluj = guiCreateButton(0.0254,0.8603,0.1992,0.1111,"Anuluj",true,wbz.win)
wbz.btn_zapisz = guiCreateButton(0.7818,0.8603,0.1992,0.1111,"Zapisz",true,wbz.win)
wbz.lbl1 = guiCreateLabel(0.0169,0.0857,0.3559,0.0698,"Opis na tabliczce:",true,wbz.win)
wbz.mem_opis = guiCreateMemo(0.0191,0.1651,0.5487,0.6127,"",true,wbz.win)
wbz.lbl2 = guiCreateLabel(0.625,0.0857,0.3559,0.0698,"Drzwi:",true,wbz.win)
wbz.cmb_drzwi = guiCreateComboBox(0.625, 0.1600, 0.3559, 0.4000, "Wybierz...", true, wbz.win)
guiComboBoxAddItem(wbz.cmb_drzwi,"Otwarte")
guiComboBoxAddItem(wbz.cmb_drzwi,"Zamknięte")
wbz.chk_oplata = guiCreateCheckBox(0.6271,0.2571,0.3199,0.0762,"Opłata za wstęp",false,true,wbz.win)
wbz.lbl3 = guiCreateLabel(0.625,0.4444,0.3559,0.0698,"Czynsz:",true,wbz.win)
wbz.lbl_idbudynku = guiCreateLabel(0.6441,0.506,0.3242,0.0698,"ID Budynku",true,wbz.win)
wbz.lbl_oplaconydo = guiCreateLabel(0.6441,0.5676,0.3369,0.1302,"Opłacony do:",true,wbz.win)

wbz.lbl5 = guiCreateLabel(0.625,0.6244,0.3359,0.0698,"Nowy szyfr do sejfu:",true,wbz.win)
wbz.edt_szyfr = guiCreateEdit(0.6441,0.6844,0.2373,0.073,"0",true,wbz.win)
guiCheckBoxSetSelected(wbz.chk_oplata,false)
guiSetEnabled(wbz.chk_oplata,false)

wbz.edt_oplata = guiCreateEdit(0.6441,0.3587,0.2373,0.073,"0",true,wbz.win)
guiSetEnabled(wbz.edt_oplata,false)
wbz.lbl4 = guiCreateLabel(0.8941,0.3587,0.063,0.0762,"centów",true,wbz.win)


guiSetVisible(wbz.win,false)

local edytowany_budynek=nil

wbz.pokaz=function(budynek)
    edytowany_budynek=budynek
    guiSetInputMode("no_binds_when_editing")
    guiSetText(wbz.win,edytowany_budynek.descr .. " - edycja budynku")
    guiSetText(wbz.mem_opis,edytowany_budynek.descr2_orig)
    guiSetText(wbz.lbl_idbudynku,"Posiadłość nr " .. edytowany_budynek.id)
    
    if (edytowany_budynek.linkedContainer) then	-- biznes ma przypisany pojemnik (sejf) -> mozemy zbierac oplaty za wstep
		guiSetEnabled(wbz.chk_oplata,true)
		guiSetEnabled(wbz.edt_oplata,true)	
		guiSetText(wbz.edt_oplata, edytowany_budynek.entryCost)
		if (edytowany_budynek.entryCost>0) then
		    guiCheckBoxSetSelected(wbz.chk_oplata,true)
		else
		    guiCheckBoxSetSelected(wbz.chk_oplata,false)
		    guiSetText(wbz.edt_oplata, "0")
		end

		guiSetText(wbz.edt_szyfr,"")
		guiSetEnabled(wbz.edt_szyfr, true)
    else
		guiCheckBoxSetSelected(wbz.chk_oplata,false)
		guiSetText(wbz.edt_oplata, "0")
		guiSetEnabled(wbz.chk_oplata,false)
		guiSetEnabled(wbz.edt_oplata,false)	

		guiSetText(wbz.edt_szyfr,"brak sejfu")
		guiSetEnabled(wbz.edt_szyfr, false)
	
    end
    
    guiSetText(wbz.lbl_oplaconydo,"Opłacona do " .. edytowany_budynek.paidTo)
    guiComboBoxSetSelected(wbz.cmb_drzwi, tonumber(edytowany_budynek.zamkniety))
    guiSetVisible(wbz.win,true)    
end

wbz.schowaj=function()
    edytowany_budynek=nil
    guiSetVisible(wbz.win,false)
end

wbz.zapisz=function()
    if (not edytowany_budynek) then return end
	-- sprawdzamy czy nowy szyfr jest ok
	local nowySzyfr
	if guiGetEnabled(wbz.edt_szyfr) then
		nowySzyfr=guiGetText(wbz.edt_szyfr)
		if string.len(nowySzyfr)>0 then
			if string.len(nowySzyfr)<4 or string.len(nowySzyfr)>7 then
				outputChatBox("Nowy szyfr musi mieć od 4 do 7 cyfr.", 255,0,0)
				return
			elseif not tonumber(nowySzyfr) then
				outputChatBox("Nowy szyfr może składać się tylko z cyfr.", 255,0,0)
				return
			end
		else
			nowySzyfr=nil
		end
	else
		nowySzyfr=nil
	end

	--
	edytowany_budynek.nowyszyfr=nowySzyfr
    edytowany_budynek.descr2_orig=guiGetText(wbz.mem_opis)
    local stan_drzwi=guiComboBoxGetSelected(wbz.cmb_drzwi)
    if (stan_drzwi>=0) then
	edytowany_budynek.zamkniety=stan_drzwi
    end
    if (guiCheckBoxGetSelected(wbz.chk_oplata)) then
	edytowany_budynek.entryCost=tonumber(guiGetText(wbz.edt_oplata))
    else
	edytowany_budynek.entryCost=0
    end
    triggerServerEvent("doSaveBudynekData", resourceRoot, localPlayer, edytowany_budynek)
    edytowany_budynek=nil
    guiSetVisible(wbz.win,false)
    
end

addEventHandler("onClientGUIClick", wbz.btn_anuluj, wbz.schowaj, false)
addEventHandler("onClientGUIClick", wbz.btn_zapisz, wbz.zapisz, false)