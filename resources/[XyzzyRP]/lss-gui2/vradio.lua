--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- triggerServerEvent("syncRadiostation", resourceRoot, wyslijDo, st)
addEvent("syncRadiostation", true)
addEventHandler("syncRadiostation", resourceRoot, function(cele,st)

	for i,v in ipairs(cele) do
		triggerClientEvent(v,"switchRadiostation", resourceRoot, st)
	end
end)