local D=13
local I=1

local pracownik=createPed(9,1143.55,-1815.64,1440.49,95.7)
setElementDimension(pracownik,D)
setElementInterior(pracownik, I)
setElementData(pracownik, "npc", true)
setElementFrozen(pracownik, true)
setElementData(pracownik,"name", "Sekretarka")

-- cs w ktorym mozna rozpoczac prace dorywcza w taxi
local cs=createColSphere(1141.92,-1815.74,1440.49,1)
setElementDimension(cs, D)
setElementInterior(cs, I)

-- gui
local infowin = guiCreateWindow(0.7531,0.3479,0.2109,0.3792,"Praca w Taxi",true)
local infowinlbl = guiCreateLabel(0.037,0.1209,0.9185,0.2552,"Do rozpoczęcia pracy w taxi wymagany jest pojazd w kolorze żółtym, GPS lub mapa oraz prawo jazdy kategorii B.", true, infowin)
local infocmb=guiCreateComboBox(0.037, 0.4, 0.9185, 0.6352, "Wskaż pojazd", true, infowin)
local infobtn=guiCreateButton(0.037, 0.6, 0.9185, 0.3, "Rozpocznij pracę", true, infowin)

guiLabelSetHorizontalAlign(infowinlbl,"center",true)
guiSetFont(infowinlbl,"default-small")
guiSetVisible(infowin, false)


addEventHandler("onClientColShapeHit", cs, function(el,md)
	if not md then return end
	if getElementType(el)~="player" or el~=localPlayer then return end
	local c=getElementData(el,"character")
	if not c or not c.id then return end
	-- sprawdzamy czy gracz ma prawo jazdy przy sobie
	-- 17
	if not exports["lss-gui"]:eq_getItemByID(17,c.id) then
		outputChatBox("Sekretarka mówi: do rozpoczęcia pracy potrzebne jest prawo jazdy kategorii B.")
		return
	end

	-- gps/mapa
	if not exports["lss-gui"]:eq_getItemByID(4) and not exports["lss-gui"]:eq_getItemByID(16) then
		outputChatBox("Sekretarka mówi: do rozpoczęcia pracy potrzebny jest GPS lub mapa.")
		return
	end

	guiSetVisible(infowin, true)
    guiComboBoxClear(infocmb)
    local EQ=exports["lss-gui"]:eq_get()
    for i,v in ipairs(EQ) do
	if (v.itemid and tonumber(v.itemid)==6 and v.subtype and tonumber(v.subtype) and tonumber(v.count)>=1) then
		    guiComboBoxAddItem(infocmb,tostring(v.subtype))
	end
    end

end)

addEventHandler("onClientColShapeLeave", cs, function(el)
	if el~=localPlayer then return end
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
	if not klucz then return end
	triggerServerEvent("doStartTaxiJob", resourceRoot, klucz)
end, false)