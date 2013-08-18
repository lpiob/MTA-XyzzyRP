--[[
system pojazdow: odciski palcow

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



function registerFingerPrint(el1, el2)
	local character=getElementData(el2,"character")
	if (not character or not character.fingerprint) then return false end	-- nie powinno sie wydarzyc, moze tu dopisac kicka?
	-- todo sprawdzanie posiadania rekawiczek przez gracza

	-- psucie fingerprintu "alamakota" => "a?am?ko??"
	for i=1,math.random(1,8) do
	    character.fingerprint=replaceChar(character.fingerprint,math.random(2,#character.fingerprint-1),"?")
	end
	
	-- rejestracja fingerprintu na losowej pozycji
	setElementData(el1, "fingerprint:"..tostring(math.random(1,5)), character.fingerprint)
	return true
end


addEventHandler("onVehicleExit", resourceRoot, function(player)
	registerFingerPrint(source,player)
    end)


addEventHandler("onVehicleEnter", resourceRoot, function(player)
	registerFingerPrint(source,player)
    end)
