local I=2
local D=76


local oferta ={
    { name="Mapa LS", name_biernik="mapę", itemid=4, count=1, cost=2},
    { name="Aspiryna", name_biernik="aspirynę", itemid=5, count=2, cost=2},
	{ name="Papierosy", name_biernik="papierosy", itemid=1, count=10, cost=32},
	{ name="Grill", name_biernik="grilla", itemid=157, count=1, cost=85},
	{ name="Surowa kiełbasa", name_biernik="kiełbasę", itemid=158, count=1, cost=5},
	{ name="(( Pojemnik ))", name_biernik="(( pojemnik ))", itemid=146, count=1, cost=15},
--	{ name="Fajerwerki", name_biernik="fajerwerki", itemid=107, count=1, cost=300},
}


GUI_sklep = guiCreateGridList(0.7713,0.2267,0.2025,0.63,true)
guiGridListSetSelectionMode(GUI_sklep,0)
GUI_sklep_c_nazwa=guiGridListAddColumn(GUI_sklep,"Nazwa",0.5)
GUI_sklep_c_ilosc=guiGridListAddColumn(GUI_sklep,"Ilość",0.2)
GUI_sklep_c_koszt=guiGridListAddColumn(GUI_sklep,"Koszt",0.2)
guiSetVisible(GUI_sklep,false)



function oferta_fill()
    guiGridListClear(GUI_sklep)

    for i,v in pairs(oferta) do
	if (v.row and isElement(v.row)) then destroyElement(v.row) end
	
	v.row = guiGridListAddRow ( GUI_sklep )
	guiGridListSetItemText ( GUI_sklep, v.row, GUI_sklep_c_nazwa, v.name, false, false )
	guiGridListSetItemText ( GUI_sklep, v.row, GUI_sklep_c_ilosc, tostring(v.count), false, false)

	guiGridListSetItemText ( GUI_sklep, v.row, GUI_sklep_c_koszt, v.cost.."$", false, false )
	if (v.cost>getPlayerMoney()) then
		guiGridListSetItemColor(GUI_sklep, v.row, GUI_sklep_c_koszt, 255,0,0)
	else
		guiGridListSetItemColor(GUI_sklep, v.row, GUI_sklep_c_koszt, 155,255,155)
	end

    end

    for i,v in ipairs(oferta) do
    end
end



function oferta_wybor()
     local selectedRow, selectedCol = guiGridListGetSelectedItem( GUI_sklep );
     if (not selectedRow) then return end
     for i,v in pairs(oferta) do
        if (v.row==selectedRow) then
	    if (v.cost>getPlayerMoney()) then
		outputChatBox("Nie stać Cię na to.", 255,0,0,true)
		return
	    end
--	    guiSetVisible(GUI_sklep,false)	-- aby nie klikli 2x
--	    exports["lss-gui"]:panel_hide()
	    if (exports["lss-gui"]:eq_giveItem(v.itemid,v.count)) then
			takePlayerMoney(v.cost)
		    triggerServerEvent("takePlayerMoney", localPlayer, v.cost)
		    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zakupuje " .. v.name_biernik..".", 5, 15, true)
	    end


	end
     end
     return
end

addEventHandler( "onClientGUIDoubleClick", GUI_sklep, oferta_wybor, false );


-- -2238.83,130.36,1035.41,351.5
-- -2235.52,129.01,1036.50,261.5
local lada=createColSphere(2436.54,-1940.82,2035.41,2)
setElementDimension(lada,D)
setElementInterior(lada,I)

addEventHandler("onClientColShapeHit", resourceRoot, function(hitElement, matchindDimension)
    if (hitElement~=localPlayer or not matchindDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    oferta_fill()
    guiSetVisible(GUI_sklep,true)
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(hitElement, matchindDimension)
    if (hitElement~=localPlayer or not matchindDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    guiSetVisible(GUI_sklep,false)
end)


