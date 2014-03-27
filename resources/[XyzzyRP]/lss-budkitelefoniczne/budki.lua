--[[
@author Karer <karer.programmer@gmail.com>
@license Dual GPLv2/MIT
]]--


budki_kasa = {}
budki_kasa_check = {}

function budkikasa(plr)
	if getElementData(plr, "zadzwonilDo") then
		takePlayerMoney(plr, 1)
	end
	
	if getPlayerMoney(plr)<= 0 then
		triggerEvent("onPhoneEnd", getRootElement(), plr)
		killTimer(budki_kasa[plr])
		killTimer(budki_kasa_check[plr])
		setPlayerMoney(plr, 0)
	elseif (not getElementData(plr, "dzwoniDo")) and (not getElementData(plr, "zadzwonilDo")) then
		killTimer(budki_kasa[plr])
		killTimer(budki_kasa_check[plr])
	end
end

function budkikasacheck(plr)
	
	if getPlayerMoney(plr)<= 0 then
		triggerEvent("onPhoneEnd", getRootElement(), plr)
		killTimer(budki_kasa[plr])
		killTimer(budki_kasa_check[plr])
		setPlayerMoney(plr, 0)
	elseif (not getElementData(plr, "dzwoniDo")) and (not getElementData(plr, "zadzwonilDo")) then
		if budki_kasa[plr] and isTimer(budki_kasa[plr]) then
			killTimer(budki_kasa[plr])
		end
		if budki_kasa_check[plr] and isTimer(budki_kasa_check[plr]) then
		killTimer(budki_kasa_check[plr])
		end
	end
end

addEvent("onBudkiWantCall", true)
addEventHandler("onBudkiWantCall", getRootElement(), function(from, to)
	if getPlayerMoney(source)>0 then
		triggerEvent("onPhoneCall", getRootElement(), source, from, to, true)
		budki_kasa[source] = setTimer(budkikasa, 30000, 0, source)
		budki_kasa_check[source] = setTimer(budkikasacheck, 5000, 0, source)
	end
end)