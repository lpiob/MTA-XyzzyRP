--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@todo dokonczyc
]]--


local budki={
	{1462.56,-1749.55,15.45,356.6, numer=10600},
}


budka_object = {}
budka_marker = {}


BUDKI_CENA = 1

budki_window1 = guiCreateWindow(0.6, 0.40, 0.23, 0.35, "Budka telefoniczna", true)
guiWindowSetSizable(budki_window1, false)

budki_label1 = guiCreateLabel(0.02, 0.08, 0.97, 0.19, "Numer: x\nCena/10 sek: "..BUDKI_CENA.."$", true, budki_window1)
guiSetFont(budki_label1, "default-bold-small")
guiLabelSetHorizontalAlign(budki_label1, "center", false)
guiLabelSetVerticalAlign(budki_label1, "center")
budki_edit1 = guiCreateEdit(0.49, 0.41, 0.41, 0.13, "", true, budki_window1)
budki_label2 = guiCreateLabel(0.09, 0.41, 0.40, 0.13, "Numer telefonu:", true, budki_window1)
guiSetFont(budki_label2, "default-bold-small")
guiLabelSetHorizontalAlign(budki_label2, "center", false)
guiLabelSetVerticalAlign(budki_label2, "center")
budki_button1 = guiCreateButton(0.07, 0.62, 0.83, 0.15, "Zadzwoń", true, budki_window1)
budki_button2 = guiCreateButton(0.07, 0.84, 0.83, 0.11, "Zamknij", true, budki_window1)
guiSetVisible(budki_window1,false)
showCursor(false)

addEventHandler("onClientGUIClick", budki_button1, function()
	local len = string.len(guiGetText(budki_edit1))
	if (len<=0) or (len>5) then return end
	guiSetEnabled(budki_button1, false)
	triggerServerEvent("onBudkiWantCall", localPlayer, budka_numer, tonumber(guiGetText(budki_edit1)))
end,false)

addEventHandler("onClientGUIClick", budki_button2, function()
	guiSetVisible(budki_window1,false)
	showCursor(false)
	triggerServerEvent("onPhoneEnd", getRootElement(), localPlayer)
end,false)


addEventHandler("onClientResourceStart", resourceRoot,function()
	guiSetVisible(budki_window1,false)
	for i,v in ipairs(budki) do
		budka_object[v.numer]=createObject(1216, v[1], v[2], v[3]-0.5, 0,0, v[4]-180)
		budka_marker[v.numer]=createColSphere(v[1], v[2], v[3], 1)
		
		local text = createElement("text")
		setElementPosition(text, v[1], v[2], v[3]+0.5)
		setElementData(text, "text", "Budka telefoniczna")
		setElementData(budka_marker[v.numer], "budkanumer", v.numer)
--budki[i].blip=createBlip(v.locb[1], v.locb[2], v.locb[3], 56, 1, 0, 0, 0, 255, 100,100)
	end
end)


addEventHandler("onClientColShapeHit", resourceRoot, function(el,md)
	if el~=localPlayer then return end
	if not md then return end
	
	-- if getPlayerName(el)~="Emi_Farens" then
		-- outputChatBox("* Aparat jest nieczynny - sluchawka ma urwany kabel")
		-- return
	-- end
	
	budka_numer = getElementData(source, "budkanumer")
	guiSetText(budki_label1, "Numer: "..budka_numer.."\nCena/30 sek: "..BUDKI_CENA.."$")
	guiSetVisible(budki_window1,true)
	guiSetEnabled(budki_button1, true)

end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(el,md)
	if el~=localPlayer then return end
	if not md then return end
	
	if getPlayerName(el)~="Karer_Brown" then
		return
	end
	
	guiSetVisible(budki_window1,false)
	showCursor(false)

	triggerServerEvent("onPhoneZerwane", getRootElement(), localPlayer, getElementData(localPlayer, "dzwoniDo"))
	triggerServerEvent("onPhoneEnd", getRootElement(), localPlayer)
end)