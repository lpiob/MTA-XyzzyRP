--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



addEventHandler("onClientMarkerHit", resourceRoot, function(el,md)
	if not md or el~=localPlayer then return end

	if getPedOccupiedVehicle(localPlayer) then return end

--	if (#getElements
	local et=getElementData(source,"typ")
	if not et or et~="ladowanie" then return end
	outputChatBox("Ladowanie.")
end)