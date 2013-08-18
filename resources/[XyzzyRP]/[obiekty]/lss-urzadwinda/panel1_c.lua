local I=1
local D=1


local strefa=createColCuboid(1481.32,-1806.50,1132.06,1,1,190)
setElementInterior(strefa,I)
setElementDimension(strefa,D)

local p1={}

p1.w = guiCreateWindow(0.7312,0.4979,0.2406,0.2958,"",true)
p1.b = guiCreateButton(0.0649,0.6901,0.8766,0.2465,"Wezwij windę",true,p1.w)
p1.l = guiCreateLabel(0.0909,0.1901,0.8247,0.4577,"1",true,p1.w)
guiLabelSetVerticalAlign(p1.l,"center")
guiLabelSetHorizontalAlign(p1.l,"center",false)
guiSetFont(p1.l,"sa-gothic")

guiSetVisible(p1.w,false)


addEventHandler("onClientColShapeHit", strefa, function(el,md)
  if (el~=localPlayer) then return end
  if (not md) then return end
  guiSetVisible(p1.w,true)
end,false)

addEventHandler("onClientColShapeLeave", strefa, function(el,md)
  if (el~=localPlayer) then return end
  guiSetVisible(p1.w,false)
end,false)

addEventHandler("onClientGUIClick", p1.b, function()
  local _,_,z=getElementPosition(localPlayer)
  triggerServerEvent("onPlayerRequestWinda", resourceRoot, z+2)
end, false)


addEvent("onWindaPositionUpdate", true)
addEventHandler("onWindaPositionUpdate", resourceRoot, function(pietro)
  guiSetText(p1.l, pietro)
end)