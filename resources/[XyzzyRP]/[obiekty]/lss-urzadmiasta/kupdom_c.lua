local I=1
local D=1

--wykorzystujemy zmienne:
--UM_HOUSE_ID
--UM_HOUSE_CENA

local marker=createMarker(1469.26,-1779.97,1192.96-1,"cylinder",1.1)
setElementInterior(marker,I)
setElementDimension(marker,D)

local infowin = guiCreateWindow(0.7531,0.3479,0.2109,0.3792,"Kupno domku",true)
local infowinlbl = guiCreateLabel(0.037,0.1209,0.9185,0.1,"", true, infowin)
local infoedit=guiCreateEdit(0.037, 0.3, 0.9185, 0.1, "ID DOMU", true, infowin)
local infobtn=guiCreateButton(0.037, 0.5, 0.9185, 0.2, "Następny krok (1/3)", true, infowin)

guiLabelSetHorizontalAlign(infowinlbl,"center",true)
guiSetFont(infowinlbl,"default-small")
guiSetVisible(infowin, false)

addEventHandler("onClientMarkerHit", marker, function(el,md)
    if (el~=localPlayer or not md) then return end
	local _,_,z=getElementPosition(localPlayer)
	local _,_,z2=getElementPosition(source)
	if (math.abs(z2-z)>5) then return end
	guiSetText(infobtn, "Następny krok (1/3)")
	guiSetText(infoedit, "ID DOMU")
	guiSetText(infowinlbl, "")
	guiSetVisible(infowin, true)
	umlasttick = getTickCount()
end)

addEventHandler("onClientMarkerLeave", marker, function(el,md)
    if (el~=localPlayer) then return end
    guiSetVisible(infowin, false)
	guiSetText(infoedit, "")
end)

addEventHandler("onClientGUIClick", infobtn, function()
	if getTickCount()-umlasttick < 2000 then return end
	local text = guiGetText(infoedit)
	local btntext = guiGetText(infobtn)
	if btntext=="Następny krok (1/3)" then
		if string.len(text)<=0 then return end
		guiSetText(infoedit, "CZAS WYNAJMU")
		UM_HOUSE_ID = text
		guiSetEnabled(infobtn, false)
		guiSetText(infobtn, "Następny krok (2/3)")
		triggerServerEvent("onUmDomyWantInfo", localPlayer, tonumber(text))
	elseif btntext=="Następny krok (2/3)" then
		if tonumber(text)<=0 or tonumber(text)>14 then guiSetText(infowinlbl, "Maksymalny czas wynajmu to 14 dni!") return end
		UM_HOUSE_DNI = text
		guiSetText(infoedit, "")
		guiSetText(infowinlbl, "Potwierdź zakup - \n"..tonumber(UM_HOUSE_CENA)*tonumber(UM_HOUSE_DNI))
		guiSetText(infobtn, "Zakup")
	elseif btntext == "Zakup" then
		--hehe
		local money = getPlayerMoney(localPlayer)
		local koszt = tonumber(UM_HOUSE_CENA)*tonumber(UM_HOUSE_DNI)
		if money-koszt < 0 then outputChatBox("(( Nie stać cię na to! ))") end
		guiSetText(infobtn, "Następny krok (1/3)")
		guiSetText(infoedit, "ID DOMU")
		guiSetText(infowinlbl, "")
		triggerServerEvent("onHousePaymentRequest", getRootElement(), tonumber(UM_HOUSE_ID), tonumber(UM_HOUSE_DNI))
	end
	playSoundFrontEnd(40)
end,false)


addEvent("onUmDomyWantInfoCompleted", true)
addEventHandler("onUmDomyWantInfoCompleted", getRootElement(), function(v)
	if not v then guiSetText(infowinlbl, "Błąd") guiSetText(infoedit, "ID DOMU") guiSetText(infobtn, "Następny krok (1/3)") guiSetEnabled(infobtn, true) return end
	house_info = ""
	if v.ownerid or v.paidTo then guiSetText(infobtn, "Następny krok (1/3)") guiSetText(infoedit, "ID DOMU") house_info = house_info.."\n--Dom jest już wynajęty!--" guiSetEnabled(infobtn, true) end
	house_info = house_info.."\nKoszt wynajmu na dzień: "..(v.koszt/100)*2
	guiSetText(infowinlbl, house_info)
	UM_HOUSE_CENA = (v.koszt/100)*2
	guiSetEnabled(infobtn, true)
end)