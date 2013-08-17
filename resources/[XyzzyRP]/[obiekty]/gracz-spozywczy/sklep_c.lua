


local I=2
local D=13
local sejfid = 895

local oferta ={
	{ name="Dropsy miętowe", name_biernik="dropsy", itemid=100, count=30, cost=9},
	{ name="Chleb", name_biernik="chleb", itemid=86, count=1, cost=3},
	{ name="Cola", name_biernik="colę", itemid=84, count=1, cost=3},
	{ name="Papierosy", name_biernik="papierosy", itemid=1, count=10, cost=20},
	{ name="Baton", name_biernik="batona", itemid=90, count=1, cost=4},
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
	    if (exports["lss-gui"]:eq_giveItem(v.itemid,v.count,v.subtype)) then
			takePlayerMoney(v.cost)
		    triggerServerEvent("takePlayerMoney", localPlayer, v.cost)
		    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zakupuje " .. v.name_biernik..".", 5, 15, true)
			triggerServerEvent("insertItemToContainerS", getRootElement(), sejfid, -1, math.ceil(v.cost/4), 0, "Gotówka")
	    end


	end
     end
     return
end

addEventHandler( "onClientGUIDoubleClick", GUI_sklep, oferta_wybor, false );


local lada=createColSphere(1348.34,-1761.00,2035.48,1)
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


