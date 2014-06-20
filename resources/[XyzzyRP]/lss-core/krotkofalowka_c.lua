--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



--		triggerClientEvent(root, "onFactionChat", resourceRoot, source, fid, msg)
addEvent("onFactionChat", true)
addEventHandler("onFactionChat", resourceRoot, function(plr,fid,msg)
  local lfid=getElementData(localPlayer,"faction:id")
  if (not lfid or tonumber(lfid)~=fid) then return end	-- nie jest we frakcji
  if (not exports["lss-gui"]:eq_getItemByID(41))  then	-- nie ma krotkofalowki
	  return
  end
  local rchar=getElementData(plr,"character")
--  local rid=getElementData(plr,"id")
  playSoundFrontEnd(49)
--  local color=string.format("#%06x", 0xFF0000+(tonumber(rchar.id)*11%256/2)*256+(tonumber(rid)*32%256))
  outputChatBox("KF("..fid..")> #FFFFFF" ..rchar.imie.. " " .. rchar.nazwisko..": ".. msg, 255,50,255, true)
end)

--		triggerClientEvent(root, "onFactionChat", resourceRoot, source, fid, msg)
addEvent("onPublicFactionChat", true)
addEventHandler("onPublicFactionChat", resourceRoot, function(plr,msg)
  local lfid=getElementData(localPlayer,"faction:id")
  if (not lfid) then return end	-- nie jest we frakcji
  lfid=tonumber(lfid)
  if (lfid~=2 and lfid~=6 and lfid~=11 and lfid~=22 and lfid~=35) then	-- nie jest we frakcji publicznej
	return
  end
  if (not exports["lss-gui"]:eq_getItemByID(41))  then	-- nie ma krotkofalowki
	  return
  end
  local rchar=getElementData(plr,"character")
--  local rid=getElementData(plr,"id")
  playSoundFrontEnd(49)
--  local color=string.format("#%06x", 0xFF0000+(tonumber(rchar.id)*11%256/2)*256+(tonumber(rid)*32%256))
  outputChatBox("KF(U)> #FFFFFF" ..rchar.imie.. " " .. rchar.nazwisko..": ".. msg, 255,50,55, true)
end)
