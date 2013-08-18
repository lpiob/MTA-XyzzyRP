--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local powody={
	["Unknown"] = "rozłączenie z Internetem",
	["Bad Connection"] = "rozłączenie z Internetem",
	["Kicked"] = "kick",
	["Banned"] = "ban",
	["Timed out"] = "rozłączenie z Internetem",
	["Quit"] = "wyłączył/a grę"
}

addEventHandler("onClientPlayerQuit", root,function(reason)
	outputDebugString(getPlayerName(source) .. reason)
	if getElementInterior(localPlayer)~=getElementInterior(source) then return end
	if getElementDimension(localPlayer)~=getElementDimension(source) then return end
	local x,y,z=getElementPosition(source)
	local x2,y2,z2=getElementPosition(localPlayer)
	if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)>100 and getCameraTarget(localPlayer)~=source then
		return
	end
	local c=getElementData(source,"character")
	if not c then return end
	local komunikat=string.format("·· %s (%s) opuścił/a grę: %s", getPlayerName(source), getElementData(source,"auth:login") or "niezalogowany", powody[reason] or reason)
	outputConsole(komunikat)
	if getCameraTarget(localPlayer)==source then
		outputChatBox(komunikat)
	end
	local t=createElement("text")

	setElementPosition(t,x,y,z)
	setElementInterior(t,getElementInterior(source))
	setElementDimension(t,getElementDimension(source))
	komunikat=string.format("%s (%s)\nopuścił/a grę\n%s", getPlayerName(source), getElementData(source,"auth:login") or "niezalogowany", powody[reason] or reason)
	setElementData(t,"text",komunikat)
	setElementData(t,"rgba",{255,255,255,100})
	setTimer(destroyElement, 30000, 1, t)
end)