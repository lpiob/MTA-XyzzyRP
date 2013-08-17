local infowin = guiCreateWindow(0.7531,0.3479,0.2109,0.3792,"Przerejestrowywanie pojazdów",true)
local infowinlbl = guiCreateLabel(0.037,0.1209,0.9185,0.1552,"Aby przerejestrować pojazd, przy okienku musi stanąć obecny i nowy właściciel. Cena przerejestrowania wozu wynosi 150$",true,infowin)
local infocmb_pojazd=guiCreateComboBox(0.037, 0.3, 0.9185, 0.6352, "Pojazd", true, infowin)
local infocmb_osoba=guiCreateComboBox(0.037, 0.45, 0.9185, 0.6352, "Nowy właściciel", true, infowin)
local infobtn=guiCreateButton(0.037, 0.6, 0.9185, 0.3, "Przerejestruj pojazd", true, infowin)

guiLabelSetHorizontalAlign(infowinlbl,"center",true)
guiSetFont(infowinlbl,"default-small")
guiSetVisible(infowin, false)


local I=1
local D=1

local marker=createMarker(1469.23,-1800.97,1162.96-1,"cylinder",1.1)
setElementInterior(marker, I)
setElementDimension(marker, D)


local prp_text=createElement("text")
setElementPosition(prp_text, 1469.23,-1800.97,1165.96)
setElementData(prp_text, "text", "Przerejestrowywanie\npojazdów")
setElementInterior(prp_text, I)
setElementDimension(prp_text, D)

local prp_npc=createPed(57,1467.02,-1800.97,1162.95,270,false)
setElementInterior(prp_npc, I)
setElementDimension(prp_npc, D)
setElementData(prp_npc, "npc", true)
setElementData(prp_npc, "name", "Urzędnik")

local function osobyWPoblizu()
	local osoby={}
	local x,y,z=getElementPosition(localPlayer)
	for i,v in ipairs(getElementsByType("player")) do
		if v~=localPlayer and getElementInterior(v)==I and getElementDimension(v)==I then
			local x2,y2,z2=getElementPosition(v)
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<5 then
				table.insert(osoby,v)
			end
		end
	end
	return osoby
end

addEventHandler("onClientMarkerHit", marker, function(el,md)
    if (not md or el~=localPlayer) then return end
	guiComboBoxClear(infocmb_osoba)
	
	--OPCJA 1: P1 i P2 w markerze - przepisuja
	--OPCJA 2: P2 w markerze - przepisuje na siebie, jezeli P1 nie jest aktywny
	
	local osoby=osobyWPoblizu()
	for i,v in ipairs(osoby) do
		local c=getElementData(v,"character")
		if c and c.imie then
			guiComboBoxAddItem(infocmb_osoba,string.format("%d - %s %s", c.id, c.imie, c.nazwisko))
		end
	end
	
	triggerServerEvent("doFetchVehiclesOwnedByPlayerList", resourceRoot)
--    guiSetVisible(infowin, true)
--    guiComboBoxClear(infocmb_pojazd)
end)

addEventHandler("onClientMarkerLeave", marker, function(el,md)
    if (el~=localPlayer) then return end
    guiSetVisible(infowin, false)
end)

addEvent("doPopulateVOBPList", true)
addEventHandler("doPopulateVOBPList", resourceRoot, function(lista)
	if not isElementWithinMarker(localPlayer, marker) then return end
	guiSetVisible(infowin, true)
	guiComboBoxClear(infocmb_pojazd)
	for i,v in ipairs(lista) do
		local item = exports["lss-gui"]:eq_getItemByID(6, v.id)
		if (item) and (item.count>=2) then
			guiComboBoxAddItem(infocmb_pojazd,string.format("%d - %s", v.id, getVehicleNameFromModel(v.model)))
		end
	end
	
end)

local function wybranyPojazd()
    local i=guiComboBoxGetSelected(infocmb_pojazd)
    if not i then return nil end
    local kid = guiComboBoxGetItemText(infocmb_pojazd, i)
	kid=tonumber(string.match(kid,"^%d+"))
	if not kid or kid<1 then return nil end

    return kid
end


local function wybranaOsoba()
    local i=guiComboBoxGetSelected(infocmb_osoba)
    if not i then return nil end
    local kid = guiComboBoxGetItemText(infocmb_osoba, i)
	outputDebugString(kid)
	if (kid=="Nowy właściciel") then return nil end
	kid=tonumber(string.match(kid,"^%d+"))
	if not kid or kid<1 then return nil end

    return kid
end

addEventHandler("onClientGUIClick", infobtn, function()
	local pojazd=wybranyPojazd()
	local osoba=wybranaOsoba()
	if not pojazd then
		outputChatBox("(( Dokonano nieprawidłowego wyboru ))",255,0,0)
		return
	end
	triggerServerEvent("przerejestrujPojazd", resourceRoot, pojazd, osoba)
	guiSetVisible(infowin, false)
end, false)