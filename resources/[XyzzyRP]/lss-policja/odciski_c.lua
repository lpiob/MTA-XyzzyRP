--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local function znajdzGracza(obiekt)
  local gracze=getElementsByType("player",root,true)
  local znaleziony_gracz
  local ostatnia_odleglosc
  local x,y,z=getElementPosition(obiekt)
  for i,v in ipairs(gracze) do
	local x2,y2,z2=getElementPosition(v)
	local odleglosc=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
	if (v~=localPlayer and odleglosc<5 and (not ostatnia_odleglosc or odleglosc<ostatnia_odleglosc)) then
	  znaleziony_gracz=v
	  ostatnia_odleglosc=odleglosc
	end
  end
  return znaleziony_gracz
end

function menu_odciski(args)
  local gracz=znajdzGracza(args.obiekt)
  if (not gracz) then
	outputChatBox("(( w pobliżu stołu nie znajduje się nikt oprócz Ciebie. )) ")
	return
  end
  local c=getElementData(gracz,"character")
  if (not c) then
	outputChatBox("(( osoba z której chcesz ściągnąć odciski palców, nie posiada w ogóle palców! ))")
	return
  end
  triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " pobiera odciski palców ".. c.imie .. " " .. c.nazwisko.. ".", 3, 15, true)
  outputChatBox("Odciski palców: " .. c.fingerprint)
  setClipboard(c.fingerprint)
  outputChatBox("(( odcisk palca został skopiowany do schowka ))")
end