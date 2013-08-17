function createDrawingWindow()
	local sw,sh = guiGetScreenSize()
	draw_window = guiCreateWindow((sw-512)*0.5,(sh-384)*0.5,512,384,"Szkicownik",false)
	guiWindowSetSizable(draw_window,false)
--	button_close = guiCreateButton(352,256,96,32,"Close",false,draw_window)--
	button_done = guiCreateButton(304,344,64,24,"Zamknij",false,draw_window)
	button_clear = guiCreateButton(432,344,64,24,"Wyczyść",false,draw_window)
	guiSetVisible(draw_window,false)
	setDefaultColors()
	drawdest = dxCreateRenderTarget(128,128,true)
	if not drawdest then return end
	black = tocolor(0,0,0,255)
	white = tocolor(255,255,255,255)
	green = tocolor(0,128,0,255)
	midblue = tocolor(0,0,192,255)
	red = tocolor(255,0,0,255)
	lime = tocolor(0,255,0,255)
	blue = tocolor(0,0,255,255)
	transparent = tocolor(255,255,255,128)
--	addEventHandler("onClientGUIClick",button_close,buttonCloseDrawingWindow,false)--
	addEventHandler("onClientGUIClick",button_done,buttonDoneDrawing,false)
	addEventHandler("onClientGUIClick",button_clear,buttonClearImage,false)
end

function setDefaultColors()
	local r,g,b = {},{},{}
	colors = {r = r,g = g,b = b}
	r[0x01],g[0x01],b[0x01] = 0,0,0
	r[0x02],g[0x02],b[0x02] = 255,255,255
	r[0x03],g[0x03],b[0x03] = 255,0,0
	r[0x04],g[0x04],b[0x04] = 255,255,0
	r[0x05],g[0x05],b[0x05] = 0,255,0
	r[0x06],g[0x06],b[0x06] = 0,255,255
	r[0x07],g[0x07],b[0x07] = 0,0,255
	r[0x08],g[0x08],b[0x08] = 255,0,255
	r[0x09],g[0x09],b[0x09] = 128,128,128
	r[0x0A],g[0x0A],b[0x0A] = 192,192,192
	r[0x0B],g[0x0B],b[0x0B] = 128,0,0
	r[0x0C],g[0x0C],b[0x0C] = 128,128,0
	r[0x0D],g[0x0D],b[0x0D] = 0,128,0
	r[0x0E],g[0x0E],b[0x0E] = 0,128,128
	r[0x0F],g[0x0F],b[0x0F] = 0,0,128
	r[0x10],g[0x10],b[0x10] = 128,0,128
	active_color = 1
end

--[[
function buttonCloseDrawingWindow(button,state)
	if button ~= "left" or state ~= "up" then return end
	showDrawingWindow(false)
end
]]--

function buttonClearImage(button,state)
	if button ~= "left" or state ~= "up" then return end
	addEventHandler("onClientRender",root,clearImage)
end

function clearImage()
	dxSetRenderTarget(drawdest,true)
	dxSetRenderTarget()
	can_spray = nil
	removeEventHandler("onClientRender",root,clearImage)
end

function buttonDoneDrawing(button,state)
	if button ~= "left" or state ~= "up" then return end
	updateTagTexture()
	showDrawingWindow(false)
end

function updateTagTexture()
	local current_tag = getElementData(localPlayer,"drawtag:tag")
	if not current_tag then return end
	local pixel_data = dxConvertPixels(dxGetTexturePixels(drawdest),"png")
	setElementData(current_tag,"pngdata",pixel_data)
	destroyTagTexture(current_tag)
	createTagTexture(current_tag)
end

function showDrawingWindow(show)
	if type(show) ~= "boolean" then return false end
	guiSetVisible(draw_window,show)
	showCursor(show)
	local toggleEventHandler = show and addEventHandler or removeEventHandler
	toggleEventHandler("onClientClick",root,clickedWindow)
	toggleEventHandler("onClientRender",root,renderDrawingWindow)
	return true
end

function isDrawingWindowVisible()
	return guiGetVisible(draw_window)
end

function renderDrawingWindow()
	local prevblend = dxGetBlendMode()
	local x,y = guiGetPosition(draw_window,false)
	drawToPicture(x+32,y+32)
	editColor(x+320,y+48)
	renderPicture(x+32,y+32)
	renderColorList(x+68,y+312)
	renderColorEditor(x+320,y+48)
	dxSetBlendMode(prevblend)
end

function drawToPicture(x,y)
	if not isCursorShowing() then return end
	dxSetBlendMode("modulate_add")
	local cx,cy = getCursorPosition()
	local sw,sh = guiGetScreenSize()

	cx,cy = cx*sw-x,cy*sh-y
	cx,cy = cx,cy

	if drawing then
		dxSetRenderTarget(drawdest)
		local color = tocolor(colors.r[active_color],colors.g[active_color],colors.b[active_color],255)
		dxDrawLine(px/2,py/2,cx/2,cy/2,color,4)
		drawCircle(px/2,py/2,2,color)
		drawCircle(cx/2,cy/2,2,color)
		dxSetRenderTarget()
		can_spray = true
	end
	px,py = cx,cy
end

function editColor(x,y)
	if not editingcolor or not isCursorShowing() then return end
	if not getKeyState("mouse1") and not getKeyState("mouse2") then stopEditingColor() return end
	local cx = getCursorPosition()
	local sw = guiGetScreenSize()
	cx = cx*sw-x
	local new_color = cx*256/160
	if editingsnap then
		new_color = new_color+8
		new_color = new_color-new_color%16
	end
	new_color = math.min(math.max(new_color,0),255)
	editingcolor[active_color] = new_color
end

function drawCircle(x,y,r,color)
	for yoff = -r,r do
		local xoff = math.sqrt(r*r-yoff*yoff)
		dxDrawRectangle(x-xoff,y+yoff,2*xoff,1,color)
	end
end

function renderPicture(x,y)
	dxSetBlendMode("blend")
	dxDrawRectangle(x-4,y-4,264,264,green,true)
	dxDrawImageSection(x,y,256,256,getTickCount()*0.004,0,256,256,"imgs/transparent.png",0,0,0,white,true)
	dxSetBlendMode("add")
	dxDrawImage(x,y,256,256,drawdest,0,0,0,white,true)
end

function renderColorList(x,y)
	dxSetBlendMode("blend")
	dxDrawRectangle(x-8,y-8,200,56,white,true)
	for c = 1,16 do
		local cx = x+(c-1)%8*24
		local cy = y+math.floor((c-1)/8)*24
		dxDrawRectangle(cx-3,cy-3,22,22,(c == active_color) and midblue or black,true)
		dxDrawRectangle(cx,cy,16,16,tocolor(colors.r[c],colors.g[c],colors.b[c],255),true)
	end
end

function renderColorEditor(x,y)
	local r = colors.r[active_color]
	local g = colors.g[active_color]
	local b = colors.b[active_color]
	dxDrawImage(x,y,160,24,"imgs/red.png",0,0,0,tocolor(255,g,b,255),true)
	dxDrawImage(x,y+48,160,24,"imgs/green.png",0,0,0,tocolor(r,255,b,255),true)
	dxDrawImage(x,y+96,160,24,"imgs/blue.png",0,0,0,tocolor(r,g,255,255),true)
	local rx = x+r*160/256
	local gx = x+g*160/256
	local bx = x+b*160/256
	dxDrawRectangle(rx-3,y-3,6,30,white,true)
	dxDrawRectangle(rx-2,y-2,4,28,red,true)
	dxDrawRectangle(gx-3,y+48-3,6,30,white,true)
	dxDrawRectangle(gx-2,y+48-2,4,28,lime,true)
	dxDrawRectangle(bx-3,y+96-3,6,30,white,true)
	dxDrawRectangle(bx-2,y+96-2,4,28,blue,true)
	dxDrawRectangle(x+48,y+144,64,48,white,true)
	dxDrawRectangle(x+52,y+148,56,40,tocolor(r,g,b,255),true)
end

function clickedWindow(button,state,x,y)
	if state == "down" then
		local wx,wy = guiGetPosition(draw_window,false)
		x,y = x-wx,y-wy
		if button == "left" then
			selectColor(x,y)
			startDrawing(x,y)
		end
		if button == "left" or button == "right" then
			startEditingColor(button,x,y)
		end
	else
		if button == "left" then
			stopDrawing()
		end
	end
end

function selectColor(x,y)
	x,y = x-68,y-312
	if x < 0 or x >= 192 or y < 0 or y >= 48 then return end
	if x%24 >= 16 or y%24 >= 16 then return end
	active_color = math.floor(y/24)*8+math.floor(x/24)+1
end

function startDrawing(x,y)
	x,y = x-32,y-32
	if x < 0 or x >= 256 or y < 0 or y >= 256 then return end
	px,py = x,y
	drawing = true
end

function stopDrawing()
	drawing = nil
end

function startEditingColor(btn,x,y)
	x,y = x-320,y-48
	if x < 0 or x >= 160 or y < 0 or y >= 144 then return end
	if y%48 >= 24 then return end
	y = math.floor(y/48)
	if y == 0 then
		editingcolor = colors.r
	elseif y == 1 then
		editingcolor = colors.g
	elseif y == 2 then
		editingcolor = colors.b
	end
	editingsnap = btn == "right"
end

function stopEditingColor()
	editingcolor = nil
	editingsnap = nil
end

