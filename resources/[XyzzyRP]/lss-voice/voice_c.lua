--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

-- crun playSoundFrontEnd(49),, 34 start                                                                                                                                                                                                                                 
addEventHandler("onClientPlayerVoiceStart", root, function()
	cancelEvent()
--    playSoundFrontEnd(49)
end)

addEventHandler("onClientPlayerVoiceStop", root, function()
	cancelEvent()
--    playSoundFrontEnd(49)
end)