--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local nazwyCzesci={
	[1087]="zestaw hydrauliczny",
-- kola
	[1074]="Racinghart Multi C4",
	[1075]="Racinghart CP",
	[1076]="O.Z. Superturismo",
	[1077]="Konig Theory",
	[1078]="5Zigen Supersix",
	[1079]="BBS CH",
	[1081]="O.Z. Superleggera III",
	[1082]="Lowenhart LDR",
	[1096]="ROJA Formula 2",
	[1097]="Volk TE37"
	
}

local function nazwaCzesci(id)
	return nazwyCzesci[id] and (nazwyCzesci[id].." ["..id.."]") or id
end

local function isUpgradeInstallable(vehicle,upgrade)
	local cu=getVehicleCompatibleUpgrades(vehicle)
	for i,v in ipairs(cu) do
		if v==upgrade then return true end
	end
	return false
end

local function graczMozeMontowac()
	local fid=tonumber(getElementData(localPlayer,"faction:id"))
	if not fid then return false end
	if fid~=12 and fid~=18 then return false end -- warsztaty
	local rankid=tonumber(getElementData(localPlayer,"faction:rank_id"))
	if not rankid then return false end
	if rankid<2 then return false end
	return true
end

local aktualny_marker=nil
local przetwarzany_pojazd=nil

local demontaz={}
local montaz={}

demontaz.win = guiCreateWindow(0.2062,0.23,0.675,0.5467,"Demontaż tuningu",true)
guiSetVisible(demontaz.win,false)
guiWindowSetMovable(demontaz.win,false)
guiWindowSetSizable(demontaz.win,false)
demontaz.lbl_pojazd = guiCreateLabel(0.0167,0.0854,0.9519,0.1189,"Pojazd XYZ, model:, przebieg: ",true,demontaz.win)
guiLabelSetVerticalAlign(demontaz.lbl_pojazd,"center")
guiLabelSetHorizontalAlign(demontaz.lbl_pojazd,"center",false)
demontaz.grid_czesci = guiCreateGridList(0.0167,0.2226,0.9593,0.5976,true,demontaz.win)
guiGridListSetSelectionMode(demontaz.grid_czesci,0)

guiGridListAddColumn(demontaz.grid_czesci,"Część",0.2)

guiGridListAddColumn(demontaz.grid_czesci,"Model",0.6)
demontaz.btn_demontuj = guiCreateButton(0.0167,0.8415,0.3796,0.125,"Demontuj element",true,demontaz.win)
demontaz.btn_zamknij = guiCreateButton(0.6,0.8445,0.3796,0.125,"Zamknij",true,demontaz.win)

montaz.win = guiCreateWindow(0.2062,0.23,0.675,0.5467,"Montaż tuningu",true)
guiSetVisible(montaz.win,false)
guiWindowSetMovable(montaz.win,false)
guiWindowSetSizable(montaz.win,false)
montaz.lbl_pojazd = guiCreateLabel(0.0167,0.0854,0.9519,0.1189,"Pojazd XYZ, model:, przebieg: ",true,montaz.win)
guiLabelSetVerticalAlign(montaz.lbl_pojazd,"center")
guiLabelSetHorizontalAlign(montaz.lbl_pojazd,"center",false)
montaz.grid_czesci = guiCreateGridList(0.0167,0.2226,0.9593,0.5976,true,montaz.win)
guiGridListSetSelectionMode(montaz.grid_czesci,0)

guiGridListAddColumn(montaz.grid_czesci,"Część",0.2)

guiGridListAddColumn(montaz.grid_czesci,"Model",0.6)
montaz.btn_montuj = guiCreateButton(0.0167,0.8415,0.3796,0.125,"Zamontuj element",true,montaz.win)
montaz.btn_zamknij = guiCreateButton(0.6,0.8445,0.3796,0.125,"Zamknij",true,montaz.win)


local function znajdzPojazd()
	if not aktualny_marker then return nil end
	local cs=getElementParent(aktualny_marker)
	if not cs or getElementType(cs)~="colshape" then return nil end
	local pojazdy=getElementsWithinColShape(cs,"vehicle")
	if not pojazdy or #pojazdy~=1 then return nil end
	return pojazdy[1]
end


addEventHandler("onClientMarkerHit", resourceRoot, function(el,md)
	if el~=localPlayer or not md then return end
	local typ=getElementData(source,"typ")
	if not typ then return end
	if not graczMozeMontowac() then return end
	
	aktualny_marker=source
	przetwarzany_pojazd=znajdzPojazd()
	if not przetwarzany_pojazd then
		outputChatBox("(( Wjedź jednym pojazdem w miejsce montażu tuningu. ))")
		aktualny_marker=nil
		return
	end

	local dbid=getElementData(przetwarzany_pojazd,"dbid")
	local model=getVehicleNameFromModel(getElementModel(przetwarzany_pojazd))
	local przebieg=getElementData(przetwarzany_pojazd,"przebieg") or 0
	local t=string.format("Pojazd %d, model: %s, przebieg: %.2fkm", dbid, model, przebieg)
	guiSetText(demontaz.lbl_pojazd, t)
	guiSetText(montaz.lbl_pojazd, t)

	if typ=="demontaz" then
		guiGridListClear(demontaz.grid_czesci)
		
		local upg=getVehicleUpgrades(przetwarzany_pojazd)
		for i,v in pairs(upg) do
			local row=guiGridListAddRow(demontaz.grid_czesci)
			guiGridListSetItemText ( demontaz.grid_czesci, row, 1, getVehicleUpgradeSlotName ( v ), false, false )
			guiGridListSetItemText ( demontaz.grid_czesci, row, 2, nazwaCzesci(v), false, false )
			guiGridListSetItemData ( demontaz.grid_czesci, row, 2, v)
		end
		guiSetEnabled(demontaz.btn_demontuj, false)
		guiSetVisible(demontaz.win,true)
		guiSetVisible(montaz.win,false)
	elseif typ=="montaz" then
		guiGridListClear(montaz.grid_czesci)
		local eq=exports["lss-gui"]:eq_get()
		for i,v in ipairs(eq) do
			if v.itemid==102 and isUpgradeInstallable(przetwarzany_pojazd, v.subtype) then -- generyczny tuning
				local row=guiGridListAddRow(montaz.grid_czesci)
				guiGridListSetItemText ( montaz.grid_czesci, row, 1, getVehicleUpgradeSlotName ( v.subtype ), false, false )
				guiGridListSetItemText ( montaz.grid_czesci, row, 2, nazwaCzesci(v.subtype), false, false )
				guiGridListSetItemData ( montaz.grid_czesci, row, 2, v.subtype)
			elseif v.itemid==79 and isUpgradeInstallable(przetwarzany_pojazd, v.subtype) then -- koła
				local row=guiGridListAddRow(montaz.grid_czesci)
				guiGridListSetItemText ( montaz.grid_czesci, row, 1, getVehicleUpgradeSlotName ( v.subtype ), false, false )
				guiGridListSetItemText ( montaz.grid_czesci, row, 2, nazwaCzesci(v.subtype), false, false )
				guiGridListSetItemData ( montaz.grid_czesci, row, 2, v.subtype)
			end
		end
		guiSetVisible(montaz.win,true)
		guiSetVisible(demontaz.win,false)
	end

end)
local function closeWindows()
	guiSetVisible(demontaz.win, false)
	guiSetVisible(montaz.win, false)
end
addEventHandler("onClientMarkerLeave", resourceRoot, function(el,md)
	if el~=localPlayer then return end
	closeWindows()
	aktualny_marker=nil
	przetwarzany_pojazd=nil
end)



addEventHandler("onClientGUIClick", montaz.btn_zamknij, closeWindows,false)
addEventHandler("onClientGUIClick", demontaz.btn_zamknij, closeWindows,false)

addEventHandler("onClientGUIClick", demontaz.grid_czesci, function()
	local row = guiGridListGetSelectedItem(demontaz.grid_czesci)
	if not row or row<0 then
		guiSetEnabled(demontaz.btn_demontuj, false)
		return
	end
		guiSetEnabled(demontaz.btn_demontuj, true)
end)

addEventHandler("onClientGUIClick", montaz.grid_czesci, function()
	local row = guiGridListGetSelectedItem(montaz.grid_czesci)
	if not row or row<0 then
		guiSetEnabled(montaz.btn_montuj, false)
		return
	end
	guiSetEnabled(montaz.btn_montuj, true)
end)




addEventHandler("onClientGUIClick", demontaz.btn_demontuj, function()
	local row = guiGridListGetSelectedItem(demontaz.grid_czesci)
	if not row or row<0 then
		return
	end
	local czesc_id=guiGridListGetItemData(demontaz.grid_czesci, row,2)
	if getVehicleUpgradeSlotName(czesc_id)~="Wheels" and getVehicleUpgradeSlotName(czesc_id)~="Hydraulics" then
		outputChatBox("(( Tej części nie można zdemontować ))")
		closeWindows()
		return
	end
	triggerServerEvent("demontujTuning", resourceRoot, przetwarzany_pojazd, czesc_id)
	closeWindows()

end, false)

addEventHandler("onClientGUIClick", montaz.btn_montuj, function()
	local row = guiGridListGetSelectedItem(montaz.grid_czesci)
	if not row or row<0 then
		return
	end
	local czesc_id=guiGridListGetItemData(montaz.grid_czesci, row,2)
	if getVehicleUpgradeSlotName(czesc_id)~="Wheels" and getVehicleUpgradeSlotName(czesc_id)~="Hydraulics" then
		outputChatBox("(( Tej części nie można zamontować ))")
		closeWindows()
		return
	end
	triggerServerEvent("montujTuning", resourceRoot, przetwarzany_pojazd, czesc_id)
	closeWindows()

end, false)