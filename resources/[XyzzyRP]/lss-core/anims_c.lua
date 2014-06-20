--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



-- http://bugs.mtasa.com/view.php?id=7068#bugnotes

addEvent("setPedAnimationProgress", true)
addEventHandler("setPedAnimationProgress", root, function(anim,progress)
    if (isElement(source) and isElementStreamedIn(source)) then
	setPedAnimationProgress(source, anim, progress)
    end
end)



addEvent("hasPedBlockingTalkAnimationC", true)
addEventHandler("hasPedBlockingTalkAnimationC", getRootElement(), function(plr)
	if not (plr==getLocalPlayer()) then return end
	local grupa,animacja = getPedAnimation(plr)
	-- if not ((not grupa) and (not animacja)) then return end
	-- if getPlayerName(plr) == "Karer_Brown" then
	local grupa = grupa or 0
	local animacja = animacja or 0
		if (grupa==0) and (animacja==0) then
			triggerServerEvent("pedHasNotBlockingTalkAnimationS", getRootElement(), plr)
		elseif (grupa=="GANGS") and (animacja=="prtial_gngtlkH") then
			triggerServerEvent("pedHasNotBlockingTalkAnimationS", getRootElement(), plr)
		end
	-- end
end)
--[[
--poruszanie na animce
function drawAnimLines()
	local x,y,z = getElementPosition(localPlayer)
	
	--X
	dxDrawLine3D(x, y, z, x+1, y, z, tocolor ( 255, 0, 0, 230 ), 2) --prosta
	dxDrawLine3D(x+0.5, y, z-0.2, x+1, y, z, tocolor ( 255, 0, 0, 230 ), 2) --lewa
	dxDrawLine3D(x+0.5, y, z+0.2, x+1, y, z, tocolor ( 255, 0, 0, 230 ), 2) --prawa
	
	--Y
	dxDrawLine3D(x, y, z, x, y+1, z, tocolor ( 0, 0, 255, 230 ), 2) --prosta
	dxDrawLine3D(x, y+0.5, z-0.2, x, y+1, z, tocolor ( 0, 0, 255, 230 ), 2) --lewa
	dxDrawLine3D(x, y+0.5, z+0.2, x, y+1, z, tocolor ( 0, 0, 255, 230 ), 2) --prawa
	-- Z
	dxDrawLine3D(x, y, z, x, y, z+1, tocolor ( 0, 255, 0, 230 ), 2) --prosta
	dxDrawLine3D(x-0.2, y, z+0.5, x, y, z+1, tocolor ( 0, 255, 0, 230 ), 2) --lewa
	dxDrawLine3D(x+0.2, y, z+0.5, x, y, z+1, tocolor ( 0, 255, 0, 230 ), 2) --prawa
	
	
	--NA ODWROT
	--X
	dxDrawLine3D(x, y, z, x-1, y, z, tocolor ( 255, 0, 0, 230 ), 2) --prosta
	dxDrawLine3D(x-0.5, y, z+0.2, x-1, y, z, tocolor ( 255, 0, 0, 230 ), 2) --lewa
	dxDrawLine3D(x-0.5, y, z-0.2, x-1, y, z, tocolor ( 255, 0, 0, 230 ), 2) --prawa
	
	-- Y
	dxDrawLine3D(x, y, z, x, y-1, z, tocolor ( 0, 0, 255, 230 ), 2) --prosta
	dxDrawLine3D(x, y-0.5, z+0.2, x, y-1, z, tocolor ( 0, 0, 255, 230 ), 2) --lewa
	dxDrawLine3D(x, y-0.5, z-0.2, x, y-1, z, tocolor ( 0, 0, 255, 230 ), 2) --prawa
	-- Z
	dxDrawLine3D(x, y, z, x, y, z-1, tocolor ( 0, 255, 0, 230 ), 2) --prosta
	dxDrawLine3D(x+0.2, y, z-0.5, x, y, z-1, tocolor ( 0, 255, 0, 230 ), 2) --lewa
	dxDrawLine3D(x-0.2, y, z-0.5, x, y, z-1, tocolor ( 0, 255, 0, 230 ), 2) --prawa
end

function onAnimDrawLines()
	if animMoveState then return end
	if not getPedAnimation(localPlayer) then return end
	outputChatBox("Uzyj STRZAŁEK oraz LEWY/PRAWY ALT do przesuwania postaci")
	addEventHandler("onClientRender", getRootElement(), drawAnimLines)
	animMoveState = true
end

function onAnimStopDrawLines()
	if not animMoveState then return end
	removeEventHandler("onClientRender", getRootElement(), drawAnimLines)
	animMoveState = false
end

addEvent("setElementCollisionsEnabledAnimC", true)
addEventHandler("setElementCollisionsEnabledAnimC", root, function(plr, state)
	setElementCollidableWith(plr, localPlayer, true)
end)


function onAnimLinesON()
	setTimer(function()
		if animMoveState then
			triggerServerEvent("setElementCollisionsEnabledAnim", localPlayer, false)
			-- if getElementData(localPlayer, "animStartPos") then
				-- if getPedAnimation(localPlayer) then
					-- local x,y,z = unpack(getElementData(localPlayer, "animStartPos"))
					-- setElementPosition(localPlayer, x,y,z,false)
				-- end
			-- end
			local a,b,c = getElementPosition(localPlayer)
			setElementData(localPlayer, "animStartPos", {a,b,c})
		end
	end, 500, 1)
end

function onAnimLinesOFF()
	triggerServerEvent("setElementCollisionsEnabledAnim", localPlayer, true)
end
--]]



---------------------------------------------------------

function render_lewo()
	if not getPedAnimation(localPlayer) then return end
	if ( (isMoving) and ( (getTickCount()-lastAnimMoveTick)>=10 ) and getKeyState("arrow_l") ) or ( (not isMoving) and getKeyState("arrow_l") ) then
		local a,b,c = getElementPosition(localPlayer)
		local d,e,f = unpack(getElementData(localPlayer, "animStartPos"))
		if getDistanceBetweenPoints3D(a-0.1,b,c,d,e,f)>=0.6 then return end
		isMoving = true
		lastAnimMoveTick = getTickCount()
		local x,y,z = getElementPosition(localPlayer)
		setElementPosition(localPlayer, x-0.01, y, z, false)
	end
end
function strzalka_lewo()
	if isMoving then return end
	if not getKeyState("arrow_l") then return end
	if not animMoveState then return end
	local a,b,c = getElementPosition(localPlayer)
	local d,e,f = unpack(getElementData(localPlayer, "animStartPos"))
	if getDistanceBetweenPoints3D(a-0.1,b,c,d,e,f)>=0.6 then return end
	lastAnimMoveTick = getTickCount()
	addEventHandler("onClientRender", getRootElement(), render_lewo)
end

------------------------------

function render_prawo()
	if not getPedAnimation(localPlayer) then return end
	if ( (isMoving) and ( (getTickCount()-lastAnimMoveTick)>=10 ) and getKeyState("arrow_r") ) or ( (not isMoving) and getKeyState("arrow_r") ) then
		local a,b,c = getElementPosition(localPlayer)
		local d,e,f = unpack(getElementData(localPlayer, "animStartPos"))
		if getDistanceBetweenPoints3D(a+0.1,b,c,d,e,f)>=0.6 then return end
		isMoving = true
		lastAnimMoveTick = getTickCount()
		local x,y,z = getElementPosition(localPlayer)
		setElementPosition(localPlayer, x+0.01, y, z, false)
	end
end
function strzalka_prawo()
	if isMoving then return end
	if not getKeyState("arrow_r") then return end
	if not animMoveState then return end
	local a,b,c = getElementPosition(localPlayer)
	local d,e,f = unpack(getElementData(localPlayer, "animStartPos"))
	if getDistanceBetweenPoints3D(a+0.1,b,c,d,e,f)>=0.6 then return end
	lastAnimMoveTick = getTickCount()
	addEventHandler("onClientRender", getRootElement(), render_prawo)
end

------------------------------

function render_gora()
	if not getPedAnimation(localPlayer) then return end
	if ( (isMoving) and ( (getTickCount()-lastAnimMoveTick)>=10 ) and getKeyState("arrow_u") ) or ( (not isMoving) and getKeyState("arrow_u") ) then
		local a,b,c = getElementPosition(localPlayer)
		local d,e,f = unpack(getElementData(localPlayer, "animStartPos"))
		if (getDistanceBetweenPoints3D(a,b+0.1,c,d,e,f)>=0.6) then return end
		isMoving = true
		lastAnimMoveTick = getTickCount()
		local x,y,z = getElementPosition(localPlayer)
		setElementPosition(localPlayer, x, y+0.01, z, false)
		-- setElementFrozen(localPlayer, true)
	end
end
function strzalka_gora()
	if isMoving then return end
	if not getKeyState("arrow_u") then return end
	if not animMoveState then return end
	local a,b,c = getElementPosition(localPlayer)
	local d,e,f = unpack(getElementData(localPlayer, "animStartPos"))
	if (getDistanceBetweenPoints3D(a,b+0.1,c,d,e,f)>=0.6) then return end
	lastAnimMoveTick = getTickCount()
	addEventHandler("onClientRender", getRootElement(), render_gora)
end

-------------------------------

function render_dol()
	if not getPedAnimation(localPlayer) then return end
	if ( (isMoving) and ( (getTickCount()-lastAnimMoveTick)>=10 ) and getKeyState("arrow_d") ) or ( (not isMoving) and getKeyState("arrow_d") ) then
		local a,b,c = getElementPosition(localPlayer)
		local d,e,f = unpack(getElementData(localPlayer, "animStartPos"))
		if (getDistanceBetweenPoints3D(a,b-0.1,c,d,e,f)>=0.6) then return end
		isMoving = true
		lastAnimMoveTick = getTickCount()
		local x,y,z = getElementPosition(localPlayer)
		setElementPosition(localPlayer, x, y-0.01, z, false)
	end
end
function strzalka_dol()
	if isMoving then return end
	if not getKeyState("arrow_d") then return end
	if not animMoveState then return end
	local a,b,c = getElementPosition(localPlayer)
	local d,e,f = unpack(getElementData(localPlayer, "animStartPos"))
	if (getDistanceBetweenPoints3D(a,b-0.1,c,d,e,f)>=0.6) then return end
	lastAnimMoveTick = getTickCount()
	addEventHandler("onClientRender", getRootElement(), render_dol)
end


---------------------------------------

function render_up()
	if not getPedAnimation(localPlayer) then return end
	if ( (isMoving) and ( (getTickCount()-lastAnimMoveTick)>=10 ) and getKeyState("lalt") ) or ( (not isMoving) and getKeyState("lalt") ) then
		local a,b,c = getElementPosition(localPlayer)
		local d,e,f = unpack(getElementData(localPlayer, "animStartPos"))
		if (getDistanceBetweenPoints3D(a,b,c-0.1,d,e,f)>=0.6) then return end
		isMoving = true
		lastAnimMoveTick = getTickCount()
		local x,y,z = getElementPosition(localPlayer)
		setElementPosition(localPlayer, x, y, z+0.01, false)
	end
end
function strzalka_up()
	if isMoving then return end
	if not getKeyState("lalt") then return end
	if not animMoveState then return end
	local a,b,c = getElementPosition(localPlayer)
	local d,e,f = unpack(getElementData(localPlayer, "animStartPos"))
	if (getDistanceBetweenPoints3D(a,b,c-0.1,d,e,f)>=0.6) then return end
	lastAnimMoveTick = getTickCount()
	addEventHandler("onClientRender", getRootElement(), render_up)
end

------------------------------------------------------------------------------------------
function render_down()
	if not getPedAnimation(localPlayer) then return end
	if ( (isMoving) and ( (getTickCount()-lastAnimMoveTick)>=10 ) and getKeyState("ralt") ) or ( (not isMoving) and getKeyState("ralt") ) then
		local a,b,c = getElementPosition(localPlayer)
		local d,e,f = unpack(getElementData(localPlayer, "animStartPos"))
		if (getDistanceBetweenPoints3D(a,b,c+0.1,d,e,f)>=0.6) then return end
		isMoving = true
		lastAnimMoveTick = getTickCount()
		local x,y,z = getElementPosition(localPlayer)
		setElementPosition(localPlayer, x, y, z-0.01, false)
	end
end
function strzalka_down()
	if isMoving then return end
	if not getKeyState("ralt") then return end
	if not animMoveState then return end
	local a,b,c = getElementPosition(localPlayer)
	local d,e,f = unpack(getElementData(localPlayer, "animStartPos"))
	if (getDistanceBetweenPoints3D(a,b,c+0.1,d,e,f)>=0.6) then return end
	lastAnimMoveTick = getTickCount()
	addEventHandler("onClientRender", getRootElement(), render_down)
end
-------------------------------


function strzalki_cancel()
	isMoving = false
	removeEventHandler("onClientRender", getRootElement(), render_lewo)
	removeEventHandler("onClientRender", getRootElement(), render_prawo)
	removeEventHandler("onClientRender", getRootElement(), render_gora)
	removeEventHandler("onClientRender", getRootElement(), render_dol)
	removeEventHandler("onClientRender", getRootElement(), render_up)
	removeEventHandler("onClientRender", getRootElement(), render_down)
end


--[[
addEventHandler("onClientResourceStart", getRootElement(), function()
	-- if getPlayerName(localPlayer) ~= "Emi_Farens" then return end
	bindKey("lshift", "down", onAnimDrawLines)
	bindKey("lshift", "up", onAnimStopDrawLines)
	bindKey("lshift", "down", onAnimLinesON)
	
	bindKey("arrow_l", "down", strzalka_lewo)
	bindKey("arrow_l", "up", strzalki_cancel)
	
	bindKey("arrow_r", "down", strzalka_prawo)
	bindKey("arrow_r", "up", strzalki_cancel)
	
	bindKey("arrow_u", "down", strzalka_gora)
	bindKey("arrow_u", "up", strzalki_cancel)
	
	bindKey("arrow_d", "down", strzalka_dol)
	bindKey("arrow_d", "up", strzalki_cancel)
	
	bindKey("lalt", "down", strzalka_up)
	bindKey("lalt", "up", strzalki_cancel)
	
	bindKey("ralt", "down", strzalka_down)
	bindKey("ralt", "up", strzalki_cancel)

end)
]]--