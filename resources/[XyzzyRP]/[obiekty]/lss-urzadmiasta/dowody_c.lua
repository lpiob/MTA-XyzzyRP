local dw={}
dw.win = guiCreateWindow(0.3775,0.28,0.2675,0.465,"Dane do dokumentu tożsamości",true)
dw.lbl1 = guiCreateLabel(0.0607,0.7204,0.8785,0.2509,"((Jesli chcesz podac dokladną datę urodzenia, zrób to pod adresem http://lss-rp.pl/postacie))",true,dw.win)
guiLabelSetVerticalAlign(dw.lbl1,"center")
guiLabelSetHorizontalAlign(dw.lbl1,"center",true)
dw.btn_anuluj = guiCreateButton(0.2336,0.5914,0.7056,0.0932,"Anuluj",true,dw.win)
dw.btn_zapisz = guiCreateButton(0.2336,0.448,0.7056,0.0932,"Zapisz",true,dw.win)
dw.lbl2 = guiCreateLabel(0.0607,0.1362,0.271,0.086,"Rasa:",true,dw.win)
guiLabelSetVerticalAlign(dw.lbl2,"center")
dw.lbl3 = guiCreateLabel(0.0607,0.2939,0.271,0.086,"Wiek:",true,dw.win)
guiLabelSetVerticalAlign(dw.lbl3,"center")
dw.combo_rasa = guiCreateComboBox(0.3318,0.1398,0.6075,0.3824,"wybierz",true,dw.win)
dw.edit_wiek = guiCreateEdit(0.3318,0.2975,0.6075,0.0824,"",true,dw.win)
guiComboBoxAddItem(dw.combo_rasa, "biała")
guiComboBoxAddItem(dw.combo_rasa, "czarna")
guiComboBoxAddItem(dw.combo_rasa, "żółta")

guiSetVisible(dw.win, false)


addEvent("onFormularzDanychDoDowodu", true)
addEventHandler("onFormularzDanychDoDowodu", resourceRoot, function()
  guiSetVisible(dw.win, true)
end)

addEventHandler("onClientGUIClick", dw.btn_anuluj, function()
  guiSetVisible(dw.win, false)
end)

addEventHandler("onClientGUIClick", dw.btn_zapisz, function()
  local wiek=tonumber(guiGetText(dw.edit_wiek))
  if not wiek or tonumber(wiek)<18 or tonumber(wiek)>85 then
	outputChatBox("(( Podaj wiek w zakresie 18-85 lat. ))")
	return
  end
  local rasa=guiComboBoxGetSelected(dw.combo_rasa)
  if not rasa or rasa<0 then
	outputChatBox("(( Musisz wybrać rasę. ))")
	return
  end
  triggerServerEvent("onZapisDanychDowodu", resourceRoot, localPlayer, wiek, rasa+1)
  guiSetVisible(dw.win, false)
  return
end)

