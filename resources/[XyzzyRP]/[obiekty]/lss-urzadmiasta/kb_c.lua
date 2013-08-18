-- kupowanie budynkow


local ogladany_budynek=nil

local D=1
local I=1
-- 1469.24,-1803.20,1192.96,92.0
local kb_marker=createMarker(1469.23,-1801.00,1192.96-1,"cylinder",1.1)
setElementInterior(kb_marker, I)
setElementDimension(kb_marker, D)


local kb1={}
kb1.win = guiCreateWindow(0.34,0.5417,0.3775,0.1333,"(( Podaj ID budynku ))",true)
kb1.edt = guiCreateEdit(0.0298,0.375,0.394,0.4,"",true,kb1.win)
kb1.btn_dalej = guiCreateButton(0.457,0.375,0.245,0.4,"Dalej",true,kb1.win)
kb1.btn_anuluj = guiCreateButton(0.7351,0.375,0.2185,0.4,"Anuluj",true,kb1.win)

guiSetVisible(kb1.win, false)

local kb2={}
kb2.win = guiCreateWindow(0.2788,0.245,0.4888,0.62,"Informacje o posiadłości",true)
kb2.memo = guiCreateMemo(0.0307,0.0806,0.9284,0.7043,"",true,kb2.win)
kb2.label_czynsz = guiCreateLabel(0.046,0.8199,0.913,0.0645,"Koszt wynajmu na tydzień: $0",true,kb2.win)
kb2.btn_kup = guiCreateButton(0.046,0.8844,0.4348,0.0887,"Kup budynek",true,kb2.win)
kb2.btn_anuluj = guiCreateButton(0.5243,0.8844,0.4348,0.0887,"Rezygnuj",true,kb2.win)

guiSetVisible(kb2.win, false)
guiSetEnabled(kb2.btn_kup, false)


addEventHandler("onClientMarkerHit", kb_marker, function(he, md)
  if not md or he~=localPlayer then return end
  local _,_,z=getElementPosition(localPlayer)
  local _,_,z2=getElementPosition(source)
  if (math.abs(z2-z)>5) then return end
  outputChatBox("(( kupno budynków w przygotowaniu ))")
  guiSetText(kb1.edt, "")
  guiSetVisible(kb1.win, true)
  ogladany_budynek=nil
end)

addEventHandler("onClientMarkerLeave", kb_marker, function(he, md)
  if he~=localPlayer then return end
  guiSetVisible(kb1.win, false)
  guiSetVisible(kb2.win, false)
  ogladany_budynek=nil
end)

addEventHandler("onClientGUIClick", kb1.btn_anuluj, function()
  guiSetVisible(kb1.win, false)
  guiSetVisible(kb2.win, false)
  ogladany_budynek=nil
end, false)

addEventHandler("onClientGUIClick", kb2.btn_anuluj, function()
  guiSetVisible(kb1.win, true)
  guiSetVisible(kb2.win, false)
  ogladany_budynek=nil
end, false)




addEventHandler("onClientGUIClick", kb1.btn_dalej, function()
  local numer=guiGetText(kb1.edt)
  if not tonumber(numer) then
	outputChatBox("(( Podaj ID budynku - do odczytania w markerze wolnego budynku ))")
	return
  end
  guiSetVisible(kb1.win, false)
  ogladany_budynek=nil
  triggerServerEvent("onPlayerRequestBuildingDetails", resourceRoot, localPlayer, numer)
end, false)

addEvent("doRetryBuildingNumberSelection", true)
addEventHandler("doRetryBuildingNumberSelection", resourceRoot, function()
  if not isElementWithinMarker(localPlayer, kb_marker) then return end
  guiSetText(kb1.edt, "")
  guiSetVisible(kb1.win, true)
  guiSetVisible(kb2.win, false)
  ogladany_budynek=nil
end)

addEvent("doShowBuildingDetails", true)
addEventHandler("doShowBuildingDetails", resourceRoot, function(dane)
  ogladany_budynek=dane
  guiSetVisible(kb2.win, true)
  guiSetVisible(kb1.win, false)
  guiSetText(kb2.label_czynsz,"Koszt wynajmu na tydzień: $" .. string.format("%d",tonumber(ogladany_budynek.koszt)))
  local memo="Rodzaj budynku:\n   "..dane.descr
  memo=memo.."\nDzielnica:\n   "..dane.dzielnica
  if (dane.oplacony) then
    memo=memo.."\nObecni właściciele:\n   "..dane.wlasciciele
	memo=memo.."\nPosiadłość opłacona do:\n   "..dane.paidTo
	guiSetEnabled(kb2.btn_kup,false)
  else
	memo=memo.."\nPoprzedni właściciele:\n   "..dane.wlasciciele
	memo=memo.."\nPosiadłość ostatnio użytkowana:\n   "..dane.paidTo
	guiSetEnabled(kb2.btn_kup,true)
  end


  if (tonumber(dane.npc_count)>0 or dane.linkedContainer) then
	memo=memo.."\n\nWyposażenie:\n"
	if (tonumber(dane.npc_count)>0) then
		memo=memo.."   Sprzedawca (NPC)\n"
	end
	if (dane.linkedContainer) then
		memo=memo.."   Sejf\n"
	end
  end
  guiSetText(kb2.memo, memo)
end)

addEventHandler("onClientGUIClick", kb2.btn_kup, function()
--  if (getPlayerName(localPlayer)~="Brian_Looner") then
--	outputChatBox("(( Kupowanie budynków będzie możliwe za chwile. ))")
--	return
--  end
  if not ogladany_budynek then return end
  if getPlayerMoney()<tonumber(ogladany_budynek.koszt) then
	outputChatBox("(( Nie stać Cię na wykupienie tej posiadłości. )) ")
	return
  end
  triggerServerEvent("doPlayerBuyBuilding", resourceRoot, localPlayer, ogladany_budynek.id, ogladany_budynek.koszt)
  guiSetVisible(kb2.win, false)
  guiSetvisible(kb2.win, false)
end, false)