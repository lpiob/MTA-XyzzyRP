local I=1
local D=10
local sejfid = 3701

local marker=createMarker(808.31,-492.19,1205.88,"cylinder",1,255,0,255,50)
setElementInterior(marker,I)
setElementDimension(marker,D)

local infowin = guiCreateWindow(0.7531,0.3479,0.2109,0.3792,"Dorabianie kluczy",true)
local infowinlbl = guiCreateLabel(0.037,0.1209,0.9185,0.2352,"Dorobienie klucza - 700$\n\n\n\n> Aby dorobić klucz potrzebny\njest ślusarzowi na wzór ich komplet <", true, infowin)
local infocmb=guiCreateComboBox(0.037, 0.4, 0.9185, 0.6352, "Klucz", true, infowin)
local infobtn=guiCreateButton(0.037, 0.6, 0.9185, 0.3, "Dorób klucz", true, infowin)

guiLabelSetHorizontalAlign(infowinlbl,"center",true)
guiSetFont(infowinlbl,"default-small")
guiSetVisible(infowin, false)

local function playerAllowed(plr)
    local c=getElementData(plr,"character")
    if not c then return false end
--    local fid=getElementData(plr,"faction:id")
--    if not fid then return false end
--    if tonumber(fid)~=4 then return false end -- sm
--    local rid=getElementData(plr,"faction:rank_id")
--    if not rid then return false end
--    if tonumber(rid)<3 then return false end
    return true
end

addEventHandler("onClientMarkerHit", marker, function(el,md)
    if (el~=localPlayer or not md) then return end
    if not playerAllowed(localPlayer) then
	return
    end
    guiSetVisible(infowin, true)
    guiComboBoxClear(infocmb)
    local EQ=exports["lss-gui"]:eq_get()
    for i,v in ipairs(EQ) do
	if (v.itemid and tonumber(v.itemid)==6 and v.count and tonumber(v.count)>=2 and v.subtype and tonumber(v.subtype)) then
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
    if (not playerAllowed(localPlayer)) then
	outputChatBox("Nie potrafisz dorabiać kluczy.")
	return
    end
    local klucz=wybranyKlucz()
    if not klucz then
	outputChatBox("(( Wybierz z listy klucze do dorobienia. ))")
	return
    end    
    -- sprawdzamy czy gracz ma ten klucz w ekwipunku
    if not exports["lss-gui"]:eq_getItemByID(6,klucz) then
	outputChatBox("(( Nie masz tych kluczy w ekwipunku. ))")
	return
    end
    -- sprawdzamy kase
    if (getPlayerMoney(localPlayer)<700) then
	outputChatBox("Nie stać Cię na dorobienie klucza.")
	return
    end
    if (exports["lss-gui"]:eq_giveItem(6,1,klucz)) then
        triggerServerEvent("takePlayerMoney", localPlayer, 700)
	triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " ślusarz dorabia klucz.", 5, 15, true)
	triggerServerEvent("insertItemToContainerS", getRootElement(), sejfid, -1, math.ceil(1/1), 0, "Gotówka")
    end
end)