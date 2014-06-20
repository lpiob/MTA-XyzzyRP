--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local I=1
local D=42

local sortedAmount=0
local sortedItems={0,0,0,0,0,0,0,0}
local lastClickedButton,previousClickedButton



local spoolTimer

GUIEditor_Window = {}
GUIEditor_Button = {}

GUIEditor_Window[1] = guiCreateWindow(0.2925,0.5717,0.3862,0.33,"Sortownia surowców",true)
guiSetVisible(GUIEditor_Window[1], false)
GUIEditor_Button[1] = guiCreateButton(0.0356,0.1717,0.2039,0.3535,"Szkło",true,GUIEditor_Window[1])
guiSetFont(GUIEditor_Button[1],"default-small")
GUIEditor_Button[2] = guiCreateButton(0.0356,0.5758,0.2039,0.3535,"Stal",true,GUIEditor_Window[1])
guiSetFont(GUIEditor_Button[2],"default-small")
GUIEditor_Button[3] = guiCreateButton(0.2718,0.1717,0.2039,0.3535,"Polistyren",true,GUIEditor_Window[1])
guiSetFont(GUIEditor_Button[3],"default-small")
GUIEditor_Button[4] = guiCreateButton(0.5081,0.1717,0.2039,0.3535,"Polipropylen",true,GUIEditor_Window[1])
guiSetFont(GUIEditor_Button[4],"default-small")
GUIEditor_Button[5] = guiCreateButton(0.7443,0.1717,0.2039,0.3535,"Polietylen",true,GUIEditor_Window[1])
guiSetFont(GUIEditor_Button[5],"default-small")
GUIEditor_Button[6] = guiCreateButton(0.2718,0.5758,0.2039,0.3535,"Papier",true,GUIEditor_Window[1])
guiSetFont(GUIEditor_Button[6],"default-small")
GUIEditor_Button[7] = guiCreateButton(0.5081,0.5758,0.2039,0.3535,"Drewno",true,GUIEditor_Window[1])
guiSetFont(GUIEditor_Button[7],"default-small")
GUIEditor_Button[8] = guiCreateButton(0.7443,0.5758,0.2039,0.3535,"Aluminium",true,GUIEditor_Window[1])
guiSetFont(GUIEditor_Button[8],"default-small")



local function sortowniaSpool()
	if getElementDimension(localPlayer)~=D or getElementInterior(localPlayer)~=I then
		killTimer(spoolTimer)
	end

	local b1=math.random(1,10)
	local b2=math.random(1,10)
	for i=1,8 do
		if (i==b1 or i==b2) and lastClickedButton~=GUIEditor_Button[i] and previousClickedButton~=GUIEditor_Button[i] then
			guiSetEnabled(GUIEditor_Button[i],true)
		else
			guiSetEnabled(GUIEditor_Button[i],false)
		end
	end
end

local function syncSortedAmounts()
	local suma=0
	for i,v in ipairs(sortedItems) do
		suma=suma+v
	end
	if suma==0 then return end
	triggerServerEvent("playerSortedItems", resourceRoot, sortedItems)

	sortedItems={0,0,0,0,0,0,0,0}
end

addEventHandler("onClientMarkerHit", resourceRoot, function(el,md)
	if el~=localPlayer or not md then return end

	local sortownia=getElementParent(source)
	if not sortownia then return end
	local iloscSmieci=getElementData(sortownia,"smieci") or 0
	if iloscSmieci<10 then
		outputChatBox("(( W sortowni nie ma żadnych surowców do posortowania. ))")
		return
	end
	outputChatBox("Na wyświetlaczu widać ilość surowców do posortowania: " .. iloscSmieci)

	for i=1,8 do
		guiSetEnabled(GUIEditor_Button[i],false)
	end
	guiSetVisible(GUIEditor_Window[1], true)
	sortedAmount=0

	sortedItems={0,0,0,0,0,0,0,0}

	if isTimer(spoolTimer) then killTimer(spoolTimer) end
	spoolTimer=setTimer(sortowniaSpool, 1000, 0)


end)

addEventHandler("onClientMarkerLeave", resourceRoot, function(el,md)
	if el~=localPlayer then return end
	guiSetVisible(GUIEditor_Window[1], false)

	if isTimer(spoolTimer) then killTimer(spoolTimer) end
	syncSortedAmounts()
	sortedAmount=0
	sortedItems={0,0,0,0,0,0,0,0}
end)

addEventHandler("onClientGUIClick", resourceRoot, function()
	if getElementType(source)~="gui-button" then return end
	guiSetEnabled(source, false)
	playSoundFrontEnd(33)
	sortedAmount=sortedAmount+1
	local itemidx=math.random(1,8)
	sortedItems[itemidx]=sortedItems[itemidx]+1

	if sortedAmount%10==0 then
		if not exports["lss-gui"]:eq_giveItem(13, 1) then
			outputChatBox("(( Nie masz miejsca w inwentarzu! ))" ,255,0,0)
		end
		if sortedAmount%20==0 then
			syncSortedAmounts()
		end
	end
	previousClickedButton=lastClickedButton
	lastClickedButton=source
end)