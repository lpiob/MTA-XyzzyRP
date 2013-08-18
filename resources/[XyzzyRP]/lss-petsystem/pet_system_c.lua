--[[
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



addEventHandler("onClientResourceStart", resourceRoot, function()
	local txd = engineLoadTXD("dog.txd" )
	engineImportTXD(txd, 310)
	local dff = engineLoadDFF("dog.dff", 310)
	engineReplaceModel(dff, 310)
	
	local txd = engineLoadTXD("pitbull.txd" )
	engineImportTXD(txd, 311)
	local dff = engineLoadDFF("pitbull.dff", 311)
	engineReplaceModel(dff, 311)
	
	local txd = engineLoadTXD("rottweiler.txd" )
	engineImportTXD(txd, 312)
	local dff = engineLoadDFF("rottweiler.dff", 312)
	engineReplaceModel(dff, 312)
end)

setTimer(function()
	--HAU HAU HAU ;3
	for k,v in ipairs(getElementsByType("ped")) do
		if math.random(1,5)==1 then
			if getElementModel(v) == 310 then
				if getElementData(v, "dog:text") then
					local smp3 = playSound3D("szczekanie.mp3", 0, 0, 0)
					setElementInterior(smp3, getElementInterior(v))
					setElementDimension(smp3, getElementDimension(v))
					attachElements(smp3, v)
				end
			end
		end
	end
end, 8000, 0)




petsystem = {
    button = {},
    window = {},
    label = {},
    combobox = {},
	edit = {}
}

petsystem.window[1] = guiCreateWindow(0.43, 0.42, 0.23, 0.32, "", true)
guiWindowSetSizable(petsystem.window[1], false)


petsystem.combobox[1] = guiCreateComboBox(0.05, 0.15, 0.91, 0.6, "--WYBIERZ--", true, petsystem.window[1])
petsystem.label[2] = guiCreateLabel(0.04, 0.25, 0.92, 0.55, "Rasa: Wilczur\nNasycenie: 100%\nKondycja: 50/50\n", true, petsystem.window[1])
petsystem.button[1] = guiCreateButton(0.05, 0.75, 0.45, 0.10, "Wydaj polecenie", true, petsystem.window[1])
petsystem.button[2] = guiCreateButton(0.51, 0.75, 0.45, 0.10, "Zamknij", true, petsystem.window[1])
petsystem.edit[1] = guiCreateEdit(0.05, 0.86, 0.91, 0.139, "Imie-PREMIUM", true, petsystem.window[1])
guiSetEnabled(petsystem.edit[1], false)

guiLabelSetHorizontalAlign(petsystem.label[2], "center", false)
guiLabelSetVerticalAlign(petsystem.label[2], "center")

guiSetVisible(petsystem.window[1], false)
showCursor(false)

function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

centerWindow(petsystem.window[1])

local function dog_refresh_skills()
	guiEditSetMaxLength(petsystem.edit[1], 12)
	guiComboBoxClear(petsystem.combobox[1])
	
	guiComboBoxAddItem(petsystem.combobox[1], "Spawn")
	guiComboBoxAddItem(petsystem.combobox[1], "Unspawn")
	local dog = getElementData(getElementData(localPlayer, "player:dog"), "dog")
	
	if getElementData(localPlayer, "premium") then guiSetEnabled(petsystem.edit[1], true) guiComboBoxAddItem(petsystem.combobox[1], "Zmiana nazwy") else guiSetEnabled(petsystem.edit[1], false) end
	-- guiSetEnabled(petsystem.edit[1], true) guiComboBoxAddItem(petsystem.combobox[1], "Zmiana nazwy")
	local s_dajglos = dog.skill_dajglos==1 and true or false
	local s_zostan = dog.skill_zostan==1 and true or false
	local s_donogi = dog.skill_donogi==1 and true or false
	
	
	if s_dajglos then guiComboBoxAddItem(petsystem.combobox[1], "P: Daj głos!") end
	if s_zostan then guiComboBoxAddItem(petsystem.combobox[1], "P: Zostań!") end
	if s_donogi then guiComboBoxAddItem(petsystem.combobox[1], "P: Do nogi!") end
	
	
end

local rasy = {
	[0]="Wilczur",
	[1]="Pitbull",
	[2]="Rottweiler",
}

local function dog_refresh_info()
	local dog = getElementData(getElementData(localPlayer, "player:dog"), "dog")
	guiSetText(petsystem.label[2], string.format("Rasa: %s\nNasycenie: %s/100\nKondycja: %s/50\n", rasy[dog.rasa], dog.nasycenie, dog.stamina))
end

addCommandHandler("pies", function()
	if (not getElementData(localPlayer, "player:dog")) then
		triggerServerEvent("onDogCommand", localPlayer, "Spawn")
	else
		dog_refresh_skills()
		dog_refresh_info()
		guiSetVisible(petsystem.window[1], true)
		showCursor(true)
		dog_tick = getTickCount()
	end
end)

addEventHandler("onClientGUIClick", petsystem.button[1], function()
	if (getTickCount()-dog_tick) < 500 then return end
	dog_tick = getTickCount()
	local item = guiComboBoxGetSelected(petsystem.combobox[1])
	local selected = guiComboBoxGetItemText(petsystem.combobox[1], item)
	if selected == "--WYBIERZ--" then return end
	
	
	if selected == "Spawn" or selected == "Unspawn" then
		triggerServerEvent("onDogCommand", localPlayer, selected)
	elseif selected == "Zmiana nazwy" then
		outputDebugString(guiGetText(petsystem.edit[1]))
		triggerServerEvent("onDogCommand", localPlayer, selected, 0, guiGetText(petsystem.edit[1]))
	else
		local dog = getElementData(getElementData(localPlayer, "player:dog") or false, "dog") or false
		triggerServerEvent("onDogCommand", localPlayer, selected, dog.nasycenie or 0)
	end
end, false)

addEventHandler("onClientGUIClick", petsystem.button[2], function()
	guiSetVisible(petsystem.window[1], false)
	showCursor(false)
end, false)

addEvent("dog_polecenie", true)
addEventHandler("dog_polecenie", getRootElement(), function(cmd)
	if cmd == "P: Daj głos!" then
		local sound = playSound3D("szczekanie.mp3", 0, 0, 0)
		setElementInterior(sound, getElementInterior(getElementData(source, "player:dog")))
		setElementDimension(sound, getElementDimension(getElementData(source, "player:dog")))
		attachElements(sound, getElementData(source, "player:dog"))
	end
end)