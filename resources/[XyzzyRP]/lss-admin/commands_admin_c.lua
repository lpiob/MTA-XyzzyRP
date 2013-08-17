--[[
lss-admin: różne funkcje dla adminów

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


local licence=[[

==============================================================================
LSS-RP (c) Wielebny <wielebny@bestplay.pl>

2012-

]]

addCommandHandler("xdevmodex",function()
	setDevelopmentMode(true)
end)

addCommandHandler("gp",function()
	x,y,z=getElementPosition(localPlayer)
	_,_,a=getElementRotation(localPlayer)
  	p=string.format("%.2f,%.2f,%.2f,%.1f",x,y,z,a)
	setClipboard(p)
	outputChatBox(p)
end)



function worldClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
  if (not clickedElement) then return end
  if getElementType(clickedElement)=="vehicle" then
	id = getElementData(clickedElement, "dbid")
  else
	id = getElementID(clickedElement) or "-brak-"
  end
  outputChatBox("Typ: " .. getElementType(clickedElement) .. ", id: " .. id .. ", model: " .. getElementModel(clickedElement))
  local x,y,z=getElementPosition(clickedElement)
  local rx,ry,rz=getElementRotation(clickedElement)
  local i,d=getElementInterior(clickedElement), getElementDimension(clickedElement)
  outputChatBox(string.format("x,y,z: %.2f,%.2f,%.2f",x,y,z))
  outputChatBox(string.format("rx,ry,rz: %d,%d,%d", rx,ry,rz))
  outputChatBox("Interior: " .. i ..", dimension: ".. d)
  local ep=getElementParent(clickedElement)
  outputChatBox("Parent: " .. getElementType(ep))
  ep=getElementParent(ep)
  outputChatBox("Parent2: " .. getElementType(ep))
  if (getElementType(ep)=="resource") then
	outputChatBox("  nazwa: " .. getElementID(ep))
  end


  removeEventHandler ( "onClientClick", root, worldClick )
end

addCommandHandler("identifyelement", function()
  outputChatBox("Kliknij LPM w element")
  addEventHandler ( "onClientClick", root, worldClick )
end,false)
