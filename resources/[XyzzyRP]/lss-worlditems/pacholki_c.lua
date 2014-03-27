--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

--- pacholki drogowe

local pacholek_lu=getTickCount()

function postawPacholek()
	if (getTickCount()-pacholek_lu<1000) then
		outputChatBox("(( Musisz odczekać 1s. ))", 255,0,0)
		return
	end
	pacholek_lu=getTickCount()
	if getPedOccupiedVehicle(localPlayer) then
		outputChatBox("(( Najpierw wysiądź z pojazdu ))", 255,0,0)
		return
	end
	-- item 76, obiekt 1238
	local x,y,z=getElementPosition(localPlayer)
	local rrz=getPedRotation(localPlayer)
	rrz=math.rad(rrz+180)
    local x= x - (1 * math.sin(-rrz))
    local y= y - (1 * math.cos(-rrz))
--	z=z-0.6
	z=z-1

--[[
	-- sprawdzamy czy przed graczem nie stoi jakis pacholek
	local strefa=createColSphere(x,y,z+0.5,2)
	local obiekty=getElementsWithinColShape(strefa,"object")
	destroyElement(strefa)

	for i,v in ipairs(obiekty) do
		outputChatBox("v")
		if getElementModel(v)==1238 then
			outputChatBox("(( W tym miejscu już stoi pachołek. ))", 255,0,0)
			return
		end
	end
]]--
	-- możemy stawiać
	exports["lss-gui"]:eq_takeItem(76,1)
	triggerServerEvent("makeTemporaryObject", resourceRoot, 1237, x,y,z, 0,0,0,getElementInterior(localPlayer), getElementDimension(localPlayer),60*1000*60, 76)
	triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " stawia pachołek.", 5, 15, true)
end