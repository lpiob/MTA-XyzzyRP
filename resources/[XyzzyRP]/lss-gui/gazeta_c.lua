--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local sw,sh = guiGetScreenSize()

-- gazeta 580x400
local gazeta_img=guiCreateStaticImage(sw/2-580/2,sh/2-200,580,400,"img/cn1.png", false)
guiSetVisible(gazeta_img,false)


function news_read(numer)
	local ladowanie=guiStaticImageLoadImage(gazeta_img,"img/cn"..tonumber(numer)..".png")
	if (not ladowanie) then
	    outputChatBox("Gazeta jest nieczytelna.")
	    guiSetVisible(gazeta_img,false)
	    return
	end
	guiSetVisible(gazeta_img,not guiGetVisible(gazeta_img))
	if (guiGetVisible(gazeta_img)) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zaczyna czytać gazetę.", 3, 15, true)
	else
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa gazetę.", 3, 15, true)
	end
end