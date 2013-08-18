local cs_zostawianie=createColCuboid(2870,-1826,10,10,18,4)
local cs_automat=createColSphere(2879.79,-1826.35,11.07,1)

local w1={}
w1.win = guiCreateWindow(0.7412,0.34,0.2313,0.4133,"Przechowalnia pojazdów",true)
w1.btn_zostaw = guiCreateButton(0.0541,0.1371,0.8919,0.379,"Zostaw pojazd",true,w1.win)
w1.btn_odbierz = guiCreateButton(0.0541,0.5565,0.8919,0.379,"Odbierz pojazd",true,w1.win)
guiSetVisible(w1.win,false)

local wz={}
wz.win = guiCreateWindow(0.7531,0.3479,0.2109,0.3792,"Rejestracja pojazdów",true)
wz.lbl = guiCreateLabel(0.037,0.1009,0.9185,0.3552,"Pojazdy mogą pozostawić tylko ich właściciele lub służby miejskie/policja. Odbiór pojazdu kosztuje $1000. Odbioru pojazdu może dokonać tylko właściciel, posiadający przy sobie klucz.", true, wz.win)
wz.cmb=guiCreateComboBox(0.037, 0.50,0.9185, 0.6352, "Pojazd", true, wz.win)
wz.btn=guiCreateButton(0.037, 0.65, 0.9185, 0.3, "Pozostaw pojazd", true, wz.win)
guiLabelSetHorizontalAlign(wz.lbl,"center",true)
guiSetFont(wz.lbl,"default-small")

guiSetVisible(wz.win, false)

local wo={}
wo.win= guiCreateWindow(0.7531,0.3479,0.2109,0.3792,"Odbiór auta",true)
wo.lbl = guiCreateLabel(0.037,0.1209,0.9185,0.1352,"Wskaż klucz do pojazdu, który chcesz odebrać", true, wo.win)
wo.cmb=guiCreateComboBox(0.037, 0.3, 0.9185, 0.6352, "Klucz", true, wo.win)
wo.btn=guiCreateButton(0.037, 0.6, 0.9185, 0.3, "Odbierz", true, wo.win)

guiLabelSetHorizontalAlign(wo.lbl,"center",true)
guiSetFont(wo.lbl,"default-small")

guiSetVisible(wo.win, false)

addEventHandler("onClientColShapeHit", cs_automat, function(he,md)
  if not md then return end
  if he~=localPlayer then return end
  guiSetVisible(w1.win, true)
  guiSetVisible(wz.win, false)
  guiSetVisible(wo.win, false)
end)

addEventHandler("onClientColShapeLeave", cs_automat, function(he,md)
  if he~=localPlayer then return end
  guiSetVisible(w1.win, false)
  guiSetVisible(wz.win, false)
  guiSetVisible(wo.win, false)
end)

local function pojazdyWStrefieZostawiania()
  local pojazdy=getElementsWithinColShape(cs_zostawianie, "vehicle")
  local pojazdy2={}
  for i,v in ipairs(pojazdy) do
	if (getElementData(v,"dbid") and not getVehicleController(v)) then
	  table.insert(pojazdy2, v)
	end
  end
  return pojazdy2
end

-- ODBIERANIE
addEventHandler("onClientGUIClick", w1.btn_odbierz, function()
--  if (getPlayerName(localPlayer)~="Bob_Euler") then 
--	outputChatBox("* Na wyświetlaczu automatu pojawia się migoczący napis 'ERROR'.")
--	guiSetVisible(w1.win, false)
--	return
--  end
  guiSetVisible(w1.win, false)
  guiSetVisible(wz.win, false)
  guiSetVisible(wo.win, true)
  guiComboBoxClear(wo.cmb)
  local EQ=exports["lss-gui"]:eq_get()
  for i,v in ipairs(EQ) do
	if (v.itemid and tonumber(v.itemid)==6 and v.subtype and tonumber(v.subtype)) then
		    guiComboBoxAddItem(wo.cmb,tostring(v.subtype))
	end
  end
end,false)

addEventHandler("onClientGUIClick", wo.btn, function()
    local i=guiComboBoxGetSelected(wo.cmb)
    if not i then return end
    local kid = tonumber(guiComboBoxGetItemText(wo.cmb, i))
	if (getPlayerMoney()<500) then
	  outputChatBox("(( Nie stać Cię na odbiór pojazdu ))")
	  return
	end
	triggerServerEvent("doOdbiorPojazdu", resourceRoot, localPlayer, kid)
  
end)


-- ZOSTAWIANIE -------------------------------------

addEventHandler("onClientGUIClick", w1.btn_zostaw, function()
--  if (getPlayerName(localPlayer)~="Bob_Euler") then 
--	outputChatBox("* Na wyświetlaczu automatu pojawia się migoczący napis 'ERROR'.")
--	guiSetVisible(w1.win, false)
--	return
--  end
  local pojazdy=pojazdyWStrefieZostawiania()
  if (#pojazdy<1) then
	outputChatBox("* Na wyświetlaczu automatu pojawia się instrukcja:")
	outputChatBox("  Zaparkuj pojazd przed bramą parkingu.")
    guiSetVisible(w1.win, false)
	return
  end

  guiSetVisible(w1.win, false)
  guiSetVisible(wz.win, true)

  guiComboBoxClear(wz.cmb)
  for i,v in ipairs(pojazdy) do
		local dbid=getElementData(v,"dbid")
		local model=getElementModel(v)
		local nazwa=getVehicleNameFromModel(model) or " "
		guiComboBoxAddItem(wz.cmb,tostring(dbid)) -- string.format("%d - %s", dbid, nazwa))
  end

end, false)

addEventHandler("onClientGUIClick", wz.btn, function()
--  if (getPlayerName(localPlayer)~="Bob_Euler") then 
--	outputChatBox("* Na wyświetlaczu automatu pojawia się migoczący napis 'ERROR'.")
--	guiSetVisible(w1.win, false)
--	guiSetVisible(wz.win, false)
    local i=guiComboBoxGetSelected(wz.cmb)
    if not i then 
	  outputChatBox("* Na wyświetlaczu automatu pojawia się migoczący napis 'ERROR'.")  
	  return
	end
    local kid = tonumber(guiComboBoxGetItemText(wz.cmb, i))
	if not kid then
		outputChatBox("* Na wyświetlaczu automatu pojawia się migoczący napis 'ERROR'.")
	end
	triggerServerEvent("doZostawieniePojazdu", resourceRoot, localPlayer, kid)
	return
--  end
end, false)


--
-- triggerClientEvent(plr, "doHideWindows", resourceRoot)
addEvent("doHideWindows",true)
addEventHandler("doHideWindows", resourceRoot, function()
	guiSetVisible(w1.win, false)
	guiSetVisible(wz.win, false)
	guiSetVisible(wo.win, false)
end)