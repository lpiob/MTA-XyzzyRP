-- based on 3dtext by The_Kid
defscale=1
defr=255
defg=255
defb=255
defa=255
defdd=100
defscale3d=true
deffont="default-bold"


local sx, sy     = guiGetScreenSize ( )
local gx         = sx * 0.1
local gy         = sy * 0.1

local posX    = 0
local posY    = 0
local sizeX   = 0
local sizeY   = 0

local pd,pi

local teksty={}

function refreshNearbyTexts()
 teksty=getElementsByType ( "text", getRootElement(), true )
 local px,py,_ = getCameraMatrix()

 pd=getElementDimension(localPlayer)
 pi=getElementInterior(localPlayer)

 for i, t in pairs ( teksty  ) do
	if (getElementDimension(t)~=pd or getElementInterior(t)~=pi) then
		teksty[i]=nil
	else
		local cx, cy, _ = getElementPosition ( t )
		local dist = getDistanceBetweenPoints2D ( px, py, cx, cy)
		if (dist>defdd) then
			teksty[i]=nil
		end
	end
 end

end

setTimer(refreshNearbyTexts, 2000, 0)


addEventHandler ( "onClientRender", getRootElement ( ),
function ( )
 local px,py,pz = getCameraMatrix()
 for i, t in pairs ( teksty ) do
	if (t and isElement(t) and getElementDimension(t)==pd and getElementInterior(t)==pi) then
			local cx, cy, cz = getElementPosition ( t )
			
			if ( getElementData(t, "attach") ) and (not getElementPosition(getElementData(t, "attach"))) then destroyElement(t) end
			if getElementData(t, "attach") and isElement(getElementData(t, "attach")) and getElementType(getElementData(t, "attach"))=="ped" then
				cx,cy,cz = getElementPosition(getElementData(t, "attach"))
			end
			
			if getElementData(t, "addz") then
				cz = cz+getElementData(t, "addz") or cz
			end
			
			local dist = getDistanceBetweenPoints3D ( px, py, pz, cx, cy, cz )
			if dist < defdd then
				local scx, scy = getScreenFromWorldPosition ( cx, cy, cz, 100, true )
				if scx and scy and isLineOfSightClear ( px, py, pz, cx, cy, cz, true,false, true, true ) then
					--The text default parameters
					local alpha   = defa
					local r       = defr
					local g       = defg
					local b       = defb
					local scale   = defscale
					local scale3d = defscale3d
					local font = deffont
					if getElementData ( t, "scale", false ) then scale = getElementData ( t, "scale", false ) end
					if getElementData ( t, "font", false ) then font = getElementData ( t, "font", false) end
					if scale3d == true then scale = scale * ( ( defdd - dist ) / defdd ) end
					local text  = getElementData ( t, "text" )
					if not text or text == "" then return end
					local c     = getElementData ( t, "rgba" )
					if c and type ( c ) == "table" then r = c[1] g = c[2] b = c[3] alpha = c[4] end
					local ac=(r+g+b)/3
					dxDrawText ( text, scx+2, scy+2, scx, scy, tocolor ( 255-ac, 255-ac, 255-ac, alpha ), scale, font, "center", "center" )
					dxDrawText ( text, scx-2, scy+2, scx, scy, tocolor ( 255-ac, 255-ac, 255-ac, alpha ), scale, font, "center", "center" )
					dxDrawText ( text, scx+2, scy-2, scx, scy, tocolor ( 255-ac, 255-ac, 255-ac, alpha ), scale, font, "center", "center" )
					dxDrawText ( text, scx-2, scy-2, scx, scy, tocolor ( 255-ac, 255-ac, 255-ac, alpha ), scale, font, "center", "center" )
					dxDrawText ( text, scx, scy, scx, scy, tocolor ( r, g, b, alpha ), scale, font, "center", "center" )
				end
			end
	end
 end
end )

