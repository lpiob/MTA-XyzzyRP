--[[
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local wplatocheck={
--x,y,z, INT, DIM, factionid
{2028.01,-1394.39,1280.87,1,8,6, minrank=1}, --pogotowie
{2816.40,-1119.14,1593.72,1,51,35, minrank=1}, --turystki
{1561.27,-1653.24,1464.87,1,5,2, minrank=1}, --policja
{930.76,-1290.30,1440.93,1,26,11, minrank=1}, --straz pozarna
{455.44,-1294.01,1196.32,1,7,5, minrank=1}, --cnn
{1224.93,-1443.54,2197.98,1,40,22, minrank=1}, --sluzby specjalne
{1301.86,-924.99,1441.78,1,21,17, minrank=1}, --sad
{1477.71,-1700.85,1132.83,1,1,4, minrank=1}, --sluzby miejskie
{1479.97,-1795.88,1286.00,1,1,1, minrank=1}, --urzad
{2433.59,-2667.05,2035.17,2,3,10, minrank=1}, --urzad
}


function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

for i,v in ipairs(wplatocheck) do
	v.cs=createMarker(v[1],v[2],v[3]-1, "cylinder", 0.8, 0, 164, 209, 210)
	setElementInterior(v.cs,v[4] or 0)
	setElementDimension(v.cs,v[5] or 0)
	setElementData(v.cs, "wplatocheck:minrank", v.minrank)
	
	if v[6] then setElementData(v.cs, "wplatocheck:faction", v[6]) end
end



wche_window = guiCreateWindow(0.22, 0.32, 0.55, 0.46, "Lista wpłat z wpłatomatów", true)
guiWindowSetSizable(wche_window, false)

wche_gridlist = guiCreateGridList(0.02, 0.07, 0.97, 0.67, true, wche_window)
wche_column1 = guiGridListAddColumn(wche_gridlist, "Imię i nazwisko", 0.4)
wche_column2 = guiGridListAddColumn(wche_gridlist, "Kwota", 0.2)
wche_column3 = guiGridListAddColumn(wche_gridlist, "Data", 0.3)
wche_button = guiCreateButton(0.39, 0.88, 0.21, 0.09, "Zamknij", true, wche_window)
wche_memo = guiCreateMemo(0.02, 0.75, 0.97, 0.09, "", true, wche_window)
wche_label = guiCreateLabel(0.60, 0.88, 0.36, 0.10, "Frakcja: ", true, wche_window)
guiLabelSetHorizontalAlign(wche_label, "center", false)
guiLabelSetVerticalAlign(wche_label, "center")    
guiMemoSetReadOnly(wche_memo, true)

guiSetVisible(wche_window, false)
centerWindow(wche_window)



addEventHandler("onClientMarkerHit", resourceRoot, function(el,md)
	if not md or el~=localPlayer then return end
	if not getPlayerName(localPlayer)=="Karer_Brown" then return end
	if (getElementData(localPlayer, "faction:id")~=getElementData(source, "wplatocheck:faction")) then return end
	if (getElementData(localPlayer, "faction:rank_id")<getElementData(source, "wplatocheck:minrank")) then outputChatBox("(( Nie posiadasz klucza do archiwum! ))", 255, 0, 0) return end
	if not getElementData(localPlayer,"faction:name") then return end
	guiSetText(wche_label, "Frakcja: "..getElementData(localPlayer,"faction:name"))
	guiSetVisible(wche_window, true)
	setElementData(wche_window, "wplatocheck:faction", getElementData(source, "wplatocheck:faction"))
	guiGridListClear(wche_gridlist)
	triggerServerEvent("onWplatomatDataRequest", getRootElement(), el, getElementData(source, "wplatocheck:faction"))
end)

addEventHandler("onClientMarkerLeave", resourceRoot, function(el,md)
	if el~=localPlayer then return end
	if not getPlayerName(localPlayer)=="Karer_Brown" then return end
	guiSetVisible(wche_window, false)
end)

addEvent("onWplatomatDataReceived", true)
addEventHandler("onWplatomatDataReceived", resourceRoot, function(data)
	for k,mrow in ipairs(data) do
		local row = guiGridListAddRow(wche_gridlist)
		guiGridListSetItemText(wche_gridlist, row, wche_column1, mrow["imie"].." "..mrow["nazwisko"], false, false)
		guiGridListSetItemText(wche_gridlist, row, wche_column2, mrow.kwota, false, false)
		guiGridListSetItemText(wche_gridlist, row, wche_column3, mrow.time, false, false)
		guiGridListSetItemData(wche_gridlist, row, wche_column1, mrow.tytul)
	end
end)

addEventHandler("onClientGUIClick", wche_gridlist, function()
	if not guiGridListGetSelectedItem(wche_gridlist) then guiSetText(wche_memo, "") return end
	local selected = guiGridListGetSelectedItem(wche_gridlist)
	local tytul = guiGridListGetItemData(wche_gridlist, selected, wche_column1)
	guiSetText(wche_memo, tytul)
end,false)

addEventHandler("onClientGUIClick", wche_button, function()
	guiSetVisible(wche_window, false)
end,false)