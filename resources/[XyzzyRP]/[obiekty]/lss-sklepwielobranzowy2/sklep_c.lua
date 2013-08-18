


local I=2
local D=73


local oferta ={
	{ name="Kanister 5 litrów", name_biernik="karnister", itemid=161, count=1, cost=35},
	{ name="Kanister 10 litrów", name_biernik="karnister", itemid=162, count=1, cost=55},
	{ name="Spray (czarny)", name_biernik="czarny spray", itemid=25, count=1000, subtype=0, cost=13},
	{ name="Spray (biały)", name_biernik="biały spray", itemid=25, count=1000, subtype=0xFFFFFF, cost=10},
	{ name="Spray (brązowy)", name_biernik="brązowy spray", itemid=25, count=1000, subtype=0x220C00, cost=14},
	{ name="Spray (czerwony)", name_biernik="czerwony spray", itemid=25, count=1000, subtype=0xFF0000, cost=14},
	{ name="Spray (zielony)", name_biernik="zielony spray", itemid=25, count=1000, subtype=0x004000, cost=15},
	{ name="Spray (niebieski)", name_biernik="niebieski spray", itemid=25, count=1000, subtype=0x0E316D, cost=14},
	{ name="Spray (żółty)", name_biernik="żółty spray", itemid=25, count=1000, subtype=0xD78E10, cost=15},
	{ name="Spray (morski)", name_biernik="morski spray", itemid=25, count=1000, subtype=0x00FFFF, cost=15},
	{ name="Spray (metalik)", name_biernik="morski spray", itemid=25, count=1000, subtype=0xAAAAAA, cost=18},
	{ name="Spray (playboy)", name_biernik="różowy spray", itemid=25, count=1000, subtype=0xFF00F6, cost=16},
	{ name="Szkicownik", name_biernik="szkicownik", itemid=43, count=1, cost=15},
	{ name="Notes (100 stron)", name_biernik="notes", itemid=47, subtype=0, count=100, cost=14},
	{ name="Neon czerwony", name_biernik="czerwony komplet oświetlenia neonowego", itemid=61, count=1, subtype=1, cost=5499},
	{ name="Neon niebieski", name_biernik="niebieski komplet oświetlenia neonowego", itemid=61, count=1, subtype=2, cost=5449},
	{ name="Neon zielony", name_biernik="zielony komplet oświetlenia neonowego", itemid=61, count=1, subtype=3, cost=5799},
	{ name="Neon żółty", name_biernik="żółty komplet oświetlenia neonowego", itemid=61, count=1, subtype=4, cost=5649},

	{ name="Obroża", name_biernik="obrożę", itemid=165, count=1, cost=40},
	{ name="Karma (pies)", name_biernik="karmę dla psa", itemid=167, count=1, cost=10},

	{ name="Felgi offroad", name_biernik="Koła offroad", itemid=79, count=1, subtype=1025, cost=1799},
	
	{ name="Alufelgi 1073", name_biernik="Alufelgi 1073", itemid=79, count=1, subtype=1073, cost=3299},
	{ name="Alufelgi 1098", name_biernik="Alufelgi 1098", itemid=79, count=1, subtype=1098, cost=3699},
	{ name="Alufelgi 1074", name_biernik="Alufelgi 1074", itemid=79, count=1, subtype=1074, cost=4203},
	
--	{ name="Alufelgi 1085", name_biernik="Alufelgi 1085", itemid=79, count=1, subtype=1085, cost=3164},
--	{ name="Alufelgi 1080", name_biernik="Alufelgi 1080", itemid=79, count=1, subtype=1080, cost=3512},
--	{ name="Alufelgi 1077", name_biernik="Alufelgi 1077", itemid=79, count=1, subtype=1077, cost=4328},

--	{ name="Alufelgi 1082", name_biernik="Alufelgi 1082", itemid=79, count=1, subtype=1082, cost=3477},
--	{ name="Alufelgi 1079", name_biernik="Alufelgi 1079", itemid=79, count=1, subtype=1079, cost=4264},
--	{ name="Alufelgi 1075", name_biernik="Alufelgi 1075", itemid=79, count=1, subtype=1075, cost=4299},
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

	guiGridListSetItemText ( GUI_sklep, v.row, GUI_sklep_c_koszt, v.cost.."$", false, false)
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
	    end


	end
     end
     return
end

addEventHandler( "onClientGUIDoubleClick", GUI_sklep, oferta_wybor, false );


local lada=createColSphere(2060.62,-1788.82,1635.41,2)
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


