--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--

function gaszenie(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
	if (weapon~=42) then return end
	if not hitElement then return end

	if (hitElement and getElementType(hitElement)=="vehicle" and getElementHealth(hitElement)<400 and math.random(1,5)==1) then
	    triggerServerEvent("gaszeniePojazdu", hitElement)
	end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), gaszenie)