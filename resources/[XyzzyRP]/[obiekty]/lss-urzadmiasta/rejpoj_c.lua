local I=1
local D=1

local marker=createMarker(1469.23,-1798.99,1162.96-1,"cylinder",1.1)
setElementInterior(marker,I)
setElementDimension(marker,D)

local infowin = guiCreateWindow(0.7531,0.3479,0.2109,0.3792,"Rejestracja pojazdów",true)
local infowinlbl = guiCreateLabel(0.037,0.1209,0.9185,0.1552,"Rejestracji podlegają tylko nowe pojazdy. Warunkiem rejestracji jest posiadanie dwóch kluczy do pojazdu i 200$.", true, infowin)
local infocmb=guiCreateComboBox(0.037, 0.4, 0.9185, 0.6352, "Klucze", true, infowin)
local infobtn=guiCreateButton(0.037, 0.6, 0.9185, 0.3, "Zarejestruj pojazd", true, infowin)

guiLabelSetHorizontalAlign(infowinlbl,"center",true)
guiSetFont(infowinlbl,"default-small")
guiSetVisible(infowin, false)

addEventHandler("onClientMarkerHit", marker, function(el,md)
    if (el~=localPlayer or not md) then return end
	local _,_,z=getElementPosition(localPlayer)
	local _,_,z2=getElementPosition(source)
	if (math.abs(z2-z)>5) then return end
    guiSetVisible(infowin, true)
    guiComboBoxClear(infocmb)
    local EQ=exports["lss-gui"]:eq_get()
    for i,v in ipairs(EQ) do
	if (v.itemid and tonumber(v.itemid)==6 and v.subtype and tonumber(v.subtype) and tonumber(v.count)>=2) then
		    guiComboBoxAddItem(infocmb,tostring(v.subtype))
	end
    end
end)

addEventHandler("onClientMarkerLeave", marker, function(el,md)
    if (el~=localPlayer) then return end
    guiSetVisible(infowin, false)
end)

local function wybranyKlucz()
    local i=guiComboBoxGetSelected(infocmb)
    if not i then return nil end
    local kid = guiComboBoxGetItemText(infocmb, i)

    return tonumber(kid)
end

addEventHandler("onClientGUIClick", infobtn, function()
    
    local klucz=wybranyKlucz()
    if not klucz then
	outputChatBox("Urzędnik mówi: proszę o pokazanie kluczy.")
	return
    end    
    -- sprawdzamy czy gracz ma ten klucz w ekwipunku
    if not exports["lss-gui"]:eq_getItemByID(6,klucz) then
	outputChatBox("Urzędnik mówi: potrzebuje Pan obu sztuk kluczy aby zarejestrować pojazd.")
	return
    end
    -- sprawdzamy kase
    if (getPlayerMoney(localPlayer)<200) then
	outputChatBox("Urzędnik mówi: koszt rejestracji pojazdu wynosi 200 dolarów.")
	return
    end

    
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " uzupełnia dokumenty przy okienku.", 5, 15, true)
    
    
    triggerServerEvent("rejestrujPojazd", resourceRoot, localPlayer, klucz)

end)