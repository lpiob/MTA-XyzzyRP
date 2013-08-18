local D=1
local I=1


local ob_marker=createMarker(1469.23,-1799.35,1192.96-1,"cylinder",1)
setElementInterior(ob_marker, I)
setElementDimension(ob_marker, D)

local obw={}

obw.win = guiCreateWindow(0.2188,0.3183,0.6363,0.4583,"Opłacanie budynków",true)
obw.grid_listab = guiCreateGridList(0.0314,0.2327,0.4204,0.7127,true,obw.win)
guiGridListSetSelectionMode(obw.grid_listab,0)

guiGridListAddColumn(obw.grid_listab,"ID",0.2)

guiGridListAddColumn(obw.grid_listab,"Nazwa",0.2)

guiGridListAddColumn(obw.grid_listab,"Opis",0.4)
obw.lbl1 = guiCreateLabel(0.0314,0.1236,0.2122,0.0727,"Budynek:",true,obw.win)
obw.lbl2 = guiCreateLabel(0.4931,0.1236,0.2122,0.0727,"Własność:",true,obw.win)
obw.memo_wlasnosc = guiCreateMemo(0.4892,0.24,0.4754,0.2836,"",true,obw.win)
guiMemoSetReadOnly(obw.memo_wlasnosc,true)
obw.lbl3 = guiCreateLabel(0.4892,0.5964,0.2122,0.0727,"Opłacony do:",true,obw.win)
obw.lbl_oplaconydo = guiCreateLabel(0.721,0.5964,0.2122,0.0727,"-",true,obw.win)
obw.lbl4 = guiCreateLabel(0.4892,0.7055,0.2122,0.0727,"Koszt za tydzień:",true,obw.win)
obw.lbl_koszt = guiCreateLabel(0.721,0.7055,0.2122,0.0727,"-",true,obw.win)
obw.btn_oplac = guiCreateButton(0.4912,0.8364,0.2141,0.1091,"Opłać na kolejny tydzień",true,obw.win)
obw.btn_zamknij = guiCreateButton(0.7505,0.8364,0.2141,0.1091,"Zamknij",true,obw.win)

guiSetVisible(obw.win, false)
addEventHandler("onClientMarkerHit", ob_marker, function(he, md)
  if not md or he~=localPlayer then return end
  local _,_,z=getElementPosition(localPlayer)
  local _,_,z2=getElementPosition(source)
  if (math.abs(z2-z)>5) then return end
  guiSetVisible(obw.win, true)
  guiGridListClear(obw.grid_listab)
  guiSetText(obw.lbl_koszt,"-")
  guiSetText(obw.lbl_oplaconydo,"-")
  guiSetText(obw.memo_wlasnosc,"")
  guiSetEnabled(obw.btn_oplac,false)
  triggerServerEvent("onPlayerRequestBuildingList", resourceRoot, localPlayer)
end)

addEventHandler("onClientMarkerLeave", ob_marker, function(he, md)
  if he~=localPlayer then return end
  guiSetVisible(obw.win, false)
end)


addEventHandler("onClientGUIClick", obw.btn_zamknij, function()
  guiSetVisible(obw.win, false)
end, false)

addEventHandler("onClientGUIClick", obw.btn_oplac, function()
  local row=guiGridListGetSelectedItem(obw.grid_listab)
  local dane
  if row then
	dane=guiGridListGetItemData( obw.grid_listab, row, 1)
  end
  if (row<0 or not dane) then
    guiSetText(obw.lbl_koszt,"-")
    guiSetText(obw.lbl_oplaconydo,"-")
    guiSetText(obw.memo_wlasnosc,"")
    guiSetEnabled(obw.btn_oplac,false)
	return
  end
  local cena=tonumber(dane.koszt)
  if not cena then return end
  if (getPlayerMoney()<cena) then
	outputChatBox("(( Nie masz przy sobie tyle gotówki ))")
	return
  end
  triggerServerEvent("onBuildingPayment", resourceRoot, localPlayer, dane.budynek_id, cena)
end, false)

addEventHandler("onClientGUIClick", obw.grid_listab, function()
  local row=guiGridListGetSelectedItem(obw.grid_listab)
  local dane
  if row then
	dane=guiGridListGetItemData( obw.grid_listab, row, 1)
  end
  if (row<0 or not dane) then
    guiSetText(obw.lbl_koszt,"-")
    guiSetText(obw.lbl_oplaconydo,"-")
    guiSetText(obw.memo_wlasnosc,"")
    guiSetEnabled(obw.btn_oplac,false)
	return
  end
  guiSetText(obw.memo_wlasnosc,table.concat(dane.wlasciciele,", "))
  guiSetText(obw.lbl_oplaconydo,dane.paidTo)
  guiSetText(obw.lbl_koszt,"$"..string.format("%.02f",tonumber(dane.koszt)/100))
  guiSetEnabled(obw.btn_oplac, true)
end, false)

-- triggerClientEvent(plr, "doPopulateBuildingsList", resourceRoot, budynki)
addEvent("doPopulateBuildingsList", true)
addEventHandler("doPopulateBuildingsList", resourceRoot, function(budynki)
  guiGridListClear(obw.grid_listab)
  guiSetText(obw.lbl_koszt,"-")
  guiSetText(obw.lbl_oplaconydo,"-")
  guiSetText(obw.memo_wlasnosc,"")
  guiSetEnabled(obw.btn_oplac,false)

  for i,v in ipairs(budynki) do
	local row = guiGridListAddRow ( obw.grid_listab )
	 guiGridListSetItemText ( obw.grid_listab, row, 1, tostring(v.budynek_id) or "-", false, false )
	 guiGridListSetItemText ( obw.grid_listab, row, 2, tostring(v.descr) or "-", false, false )
	 guiGridListSetItemText ( obw.grid_listab, row, 3, tostring(v.descr2) or "-", false, false )
	 guiGridListSetItemData ( obw.grid_listab, row, 1, v)
  end
end)