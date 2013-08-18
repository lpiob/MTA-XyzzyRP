
local I=1
local D=64


local oferta ={
	{ name="CD 'Wakacyjny Rap'", name_biernik="płytę", itemid=63, count=1, subtype=1, cost=47},	--3 kawalki jakiegos rapu
	{ name="CD 'Elektroniczna sobota'", name_biernik="płytę", itemid=63, count=1, subtype=2, cost=47},	--elektroniczne 2 kawalki
	{ name="CD 'Weekendowy relaks'", name_biernik="płytę", itemid=63, count=1, subtype=3, cost=43},	--2 kawalki jakiejs muzy
	{ name="CD 'Tylko techno!'", name_biernik="płytę", itemid=63, count=1, subtype=4, cost=53},	--techno x5
	{ name="CD 'Polskie Disco-Polo'", name_biernik="płytę", itemid=63, count=1, subtype=5, cost=62},	--j/w
	{ name="CD 'Skladanka Non-Stop'", name_biernik="płytę", itemid=63, count=1, subtype=6, cost=57},	--alg, lay
	{ name="CD 'Przeboje dziada'", name_biernik="płytę", itemid=63, count=1, subtype=7, cost=57},	--przedwojenne
	{ name="CD 'Tylko Rock'", name_biernik="płytę", itemid=63, count=1, subtype=8, cost=80},	--rockowe
	{ name="CD 'Przeboje lata'", name_biernik="płytę", itemid=63, count=1, subtype=9, cost=88},	--rockowe
	{ name="CD 'Tylko Rap'", name_biernik="płytę", itemid=63, count=1, subtype=10, cost=83},	--meksykanskie
	{ name="CD 'Amigos!'", name_biernik="płytę", itemid=63, count=1, subtype=11, cost=83},	--rap
	{ name="CD 'Old-Rock'", name_biernik="płytę", itemid=63, count=1, subtype=12, cost=51},	--rock
	{ name="CD 'Hity Pop/Dance latem'", name_biernik="płytę", itemid=63, count=1, subtype=13, cost=79},	--pop / dance
	{ name="CD 'My Little Pony'", name_biernik="płytę", itemid=63, count=1, subtype=14, cost=37},	--dziecinne
	{ name="CD 'I Love the Country'", name_biernik="płytę", itemid=63, count=1, subtype=15, cost=72},	--country
	{ name="CD 'London 1969'", name_biernik="płytę", itemid=63, count=1, subtype=16, cost=77},	--gta longon 1969
}


GUI_sklep = guiCreateGridList(0.7713,0.2267,0.2225,0.63,true)
guiGridListSetSelectionMode(GUI_sklep,0)
GUI_sklep_c_nazwa=guiGridListAddColumn(GUI_sklep,"Nazwa",0.6)
GUI_sklep_c_ilosc=guiGridListAddColumn(GUI_sklep,"Ilość",0.15)
GUI_sklep_c_koszt=guiGridListAddColumn(GUI_sklep,"Koszt",0.18)
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
	    end


	end
     end
     return
end

addEventHandler( "onClientGUIDoubleClick", GUI_sklep, oferta_wybor, false );


local lada=createColSphere(816.44,-1369.48,1401.28, 0.5)
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
