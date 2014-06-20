--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author RacheT <rachet@pylife.pl>
@author karer <karer.programmer@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

-- marker rozpoczynania prac

addCommandHandler("geodeta", function(plr,cmd)
 if not exports["lss-urzadmiasta"]:isPlayerInGeodetaMarker(plr) then return end

  -- if getPlayerName(plr)~="Karer_Brown" then
    -- outputChatBox("Praca w trakcie przygotowywania.", plr,255,0,0)
    -- return
  -- end
	
  if not( (exports["lss-core"]:eq_getItem(plr, 16)) and (exports["lss-core"]:eq_getItem(plr, 2)) ) then outputChatBox("(( Nie masz aparatu i/lub GPSa! ))", plr) return end
  triggerClientEvent(plr, "startJob", resourceRoot)
end, false,false)

addEvent("givePlayerMoney", true)
addEventHandler("givePlayerMoney", getRootElement(), function(player,much)
	givePlayerMoney(player,much)
end)