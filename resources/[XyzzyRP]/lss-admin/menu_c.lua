--[[
lss-admin: funkcje dla supporterow dostepne pod PPM

@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub

]]--


function menu_unfreeze(args)
    triggerServerEvent("support_setElementFrozen", root, args.el, false)
end

function menu_freeze(args)
    triggerServerEvent("support_setElementFrozen", root, args.el, false)
end

function menu_lift1(args)
    triggerServerEvent("support_lift", root, args.el, 1)
end

function menu_bringHere(args)
    triggerServerEvent("support_bringHere", localPlayer, args.el)
end

function menu_vehinfo(args)
  local clickedElement = args.el
  local id = getElementData(clickedElement, "dbid")
  outputChatBox("Id: " .. id .. ", model: " .. getElementModel(clickedElement))
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
end