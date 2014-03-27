--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- triggerServerEvent("onOfertaRequest", resourceRoot, with)
addEvent("onOfertaRequest", true)
addEventHandler("onOfertaRequest", resourceRoot, function(with)
	triggerClientEvent(with, "onOfertaRequestAllowance", client)
end)

-- triggerServerEvent("onOfertaRequestAllowed", resourceRoot,oferta_with)
addEvent("onOfertaRequestAllowed", true)
addEventHandler("onOfertaRequestAllowed", resourceRoot, function(with)
	triggerClientEvent(with, "openOfertaWindow", client)
	triggerClientEvent(client, "openOfertaWindow", with)
end)