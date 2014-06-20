--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

-- STOG ITEMID = 44

function menu_oddajRyby()
  local ryby=exports["lss-gui"]:eq_getItemByID(8)
  if not ryby or not ryby.count or ryby.count<1 then 
	outputChatBox("Nie masz żadnych ryb.", 255,0,0)
	return
  end
  triggerServerEvent("skupRyb", resourceRoot, localPlayer)
end