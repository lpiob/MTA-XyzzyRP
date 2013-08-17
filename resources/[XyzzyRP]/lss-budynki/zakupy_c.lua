--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--



GUI_sklep = guiCreateGridList(0.7713,0.2267,0.2025,0.63,true)
guiGridListSetSelectionMode(GUI_sklep,0)
GUI_sklep_c_nazwa=guiGridListAddColumn(GUI_sklep,"Nazwa",0.5)
GUI_sklep_c_koszt=guiGridListAddColumn(GUI_sklep,"Koszt",0.2)
guiSetVisible(GUI_sklep,false)

local aktualny_sprzedawca=nil

function oferta_fill(sprzedawca)
    local oferta=getElementData(sprzedawca,"budynek:oferta")
    if (not oferta) then
	outputChatBox("Sprzedawca mówi: niestety nie mam nic w ofercie!")
	return false
    end
    aktualny_sprzedawca=sprzedawca
    guiGridListClear(GUI_sklep)

    for i,v in pairs(oferta) do
	local row = guiGridListAddRow ( GUI_sklep )
	guiGridListSetItemText ( GUI_sklep, row, GUI_sklep_c_nazwa, v.name, false, false )
	guiGridListSetItemData ( GUI_sklep, row, GUI_sklep_c_nazwa, v )
	guiGridListSetItemText ( GUI_sklep, row, GUI_sklep_c_koszt, v.sellprice.."$", false, false )
	if (tonumber(v.sellprice)>getPlayerMoney()) then
		guiGridListSetItemColor(GUI_sklep, row, GUI_sklep_c_koszt, 255,0,0)
	else
		guiGridListSetItemColor(GUI_sklep, row, GUI_sklep_c_koszt, 155,255,155)
	end
    end

    return true
end



function oferta_wybor()

    if not aktualny_sprzedawca then return end
    local pojemnik=getElementData(aktualny_sprzedawca,"budynek:container_id")    
    if not pojemnik then return end
    
    local selectedRow, selectedCol = guiGridListGetSelectedItem( GUI_sklep );
    if (not selectedRow) then return end
    local przedmiot=guiGridListGetItemData(GUI_sklep, selectedRow, selectedCol)
    if (not przedmiot or type(przedmiot)~="table") then return end
    outputDebugString("Cena: " .. przedmiot.sellprice)
    if (tonumber(przedmiot.sellprice)>getPlayerMoney()) then
	outputChatBox("Nie stać Cię na to.", 255,0,0,true)
	return
    end

    triggerServerEvent("doPlayerBuyFromShop", resourceRoot, localPlayer, pojemnik, tonumber(przedmiot.itemid), tonumber(przedmiot.subtype), tonumber(przedmiot.sellprice))
    
    return
    
end

addEventHandler( "onClientGUIDoubleClick", GUI_sklep, oferta_wybor, false );


addEventHandler("onClientColShapeHit", resourceRoot, function(hitElement, matchindDimension)
    if (hitElement~=localPlayer or not matchindDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    local elpar=getElementParent(source)
    if (elpar and getElementType(elpar)=="ped") then
        if oferta_fill(elpar) then
            guiSetVisible(GUI_sklep,true)
	end

    end

end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(hitElement, matchindDimension)
    if (hitElement~=localPlayer or not matchindDimension or getElementInterior(localPlayer)~=getElementInterior(source)) then return end
    local elpar=getElementParent(source)
    if (elpar and getElementType(elpar)=="ped") then
        guiSetVisible(GUI_sklep,false)
	aktualny_sprzedawca=nil
    end
end)


