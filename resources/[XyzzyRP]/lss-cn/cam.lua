--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


local lastPhoto

addEvent("onPlayerTakePhoto", true)
addEventHandler("onPlayerTakePhoto", resourceRoot, function(pixels)
    lastPhoto=pixels
--	outputChatBox("Photo from " .. getPlayerName(client))
--	local t=createElement("photo")
--	setElementData(t,"pixels", pixels)
	triggerLatentClientEvent("updatePhoto", 50000, resourceRoot, pixels)
end)


local tvroot=createElement("tvroot")

addEvent("requestLastPhoto", true)
addEventHandler("requestLastPhoto", resourceRoot, function()
  if lastPhoto then
    triggerLatentClientEvent(client, "updatePhoto", 50000, resourceRoot, lastPhoto)
  end
end)

