local licence=[[

==============================================================================
LSS-RP (c) Wielebny <wielebny@bestplay.pl>
Wszelkie prawa zastrzezone. Nie masz praw uzywac tego kodu bez naszej zgody.

2012-

]]


addEventHandler ( "onClientClick", root, function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  outputDebugString("click" .. getElementType(clickedElement))
end)


local sw,sh=guiGetScreenSize()

--local nametagFont = "default"
local nametagFont = "arial"
local nametagScale = 1
local nametagAlpha = 180
local nametagColor =
{
	r = 255,
	g = 255,
	b = 255
}

local function drawNametag(text, x,y, color)
    local width=dxGetTextWidth(text,nametagScale, nametagFont)
    local height=dxGetFontHeight(nametagScale,nametagFont)
    local direction="right"
    
    if (x<sw/2) then
	direction="left"
    end
    
    if (direction=="right") then
        dxDrawRectangle(x,y,width,height,tocolor(0,0,0,100))
        dxDrawText(text, x,y, x,y,color, nametagScale, nametagFont)
    else
        dxDrawRectangle(x-width,y,width,height,tocolor(0,0,0,100))
        dxDrawText(text, x-width,y, x,y,color, nametagScale, nametagFont)
    
    end

    
end


addEventHandler("onClientRender", getRootElement(), function()
    if (not isCursorShowing()) then return end
		local rootx, rooty, rootz = getCameraMatrix()--getElementPosition(getLocalPlayer())
		
		for i, o in ipairs(getElementsByType("object",resourceRoot,true)) do

			if getElementDimension(localPlayer)==getElementDimension(o) and getElementInterior(localPlayer)==getElementInterior(o) then
				local x,y,z = getElementPosition(o)

				local sx, sy = getScreenFromWorldPosition(x, y, z)
				if sx then
					local itemdata = getElementData(o, "item:data")
					if (itemdata) then
	    				local text = itemdata.itemname
						if (itemdata.subtype and tonumber(itemdata.subtype)>0) then
						  text=text.." ["..itemdata.subtype.."]"
						end                                   
						if (tonumber(itemdata.count)>1) then
						  text=text.." ("..itemdata.count..")"
						end
					    local distance = getDistanceBetweenPoints3D(rootx, rooty, rootz, x, y, z)

					    -- Sprawdzamy czy dystans jest mniejszy bądź równy 12.
					    if(distance <= 6) then
							drawNametag(text,sx, sy, tocolor(255, 255, 155, 190))
					    end
					end
				end
			end
		end	
	end
)

