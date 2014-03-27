--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



addEvent("syncPlayerWeapons", true)
addEventHandler("syncPlayerWeapons", root, function(bronie, slot)
	takeAllWeapons(source)
	if (bronie and #bronie>0) then
		for i,v in ipairs(bronie) do
            if (v[2]<0) then
              toggleControl(source, "fire", false)
            elseif not getElementData(source,"kary:blokada_bicia") then
              toggleControl(source, "fire", true)
            end
            v[2]=math.abs(v[2])
			giveWeapon(source, v[1], v[2])
	--		outputDebugString("Daje " .. getPlayerName(source) .. " bron " .. v[1] .. " ilosc " .. v[2])
		end
	end
	if (slot) then
		setPedWeaponSlot(source, slot)
	end
end)



addEvent("onKevlarDefense", true)
addEventHandler("onKevlarDefense", root, function(player)
	local wytrzymalosc = getElementData(player, "kamizelkaPD:wytrzymalosc")
	
	if wytrzymalosc <= 0 then --zabieramy calkowicie
		exports["lss-core"]:eq_takeItem(player, 151, 1, wytrzymalosc)
		triggerEvent("broadcastCaptionedEvent", player, "Kamizelka LSPD rozpada się", 4, 8, true)
		exports["bone_attach"]:detachElementFromBone(getElementData(player, "kamizelkaPD"))
		destroyElement(getElementData(player, "kamizelkaPD"))
		removeElementData(player,"kamizelkaPD")
		removeElementData(player,"kamizelkaPD:wytrzymalosc")
	else
		exports["lss-core"]:eq_takeItem(player, 151, 1, wytrzymalosc)
		exports["lss-core"]:eq_giveItem(player, 151, 1, wytrzymalosc-10)
		setElementData(player, "kamizelkaPD:wytrzymalosc", wytrzymalosc-10)
	end
	
end)