p2={}
p2.w = guiCreateWindow(0.7047,0.4833,0.25,0.2646,"",true)
p2.b={}
p2.b[1] = guiCreateButton(0.0562,0.1811,0.2562,0.3307,"1",true,p2.w)
p2.b[2] = guiCreateButton(0.375,0.1811,0.2562,0.3307,"2",true,p2.w)
p2.b[3] = guiCreateButton(0.6938,0.1811,0.25,0.3307,"3",true,p2.w)
p2.b[4] = guiCreateButton(0.0562,0.5906,0.2562,0.3307,"4",true,p2.w)
p2.b[5] = guiCreateButton(0.375,0.5906,0.2562,0.3307,"5",true,p2.w)
p2.b[6] = guiCreateButton(0.6938,0.5906,0.25,0.3307,"6",true,p2.w)

local I=1
local D=1


local strefa=createColCuboid(1483.52,-1808.50,1132.06,1,1,190)
setElementInterior(strefa,I)
setElementDimension(strefa,D)

guiSetVisible(p2.w,false)


addEventHandler("onClientColShapeHit", strefa, function(el,md)
  if (el~=localPlayer) then return end
  if (not md) then return end
  guiSetVisible(p2.w,true)
end,false)

addEventHandler("onClientColShapeLeave", strefa, function(el,md)
  if (el~=localPlayer) then return end
  guiSetVisible(p2.w,false)
end,false)

for i=1,6 do
  addEventHandler("onClientGUIClick", p2.b[i], function()
    triggerServerEvent("onPlayerRequestWinda", resourceRoot, nil, i)
  end, false)
end