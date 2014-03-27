--[[
@author RootKiller <rootkiller.programmer@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local licence=[[

==============================================================================
LSS-RP (c) RootKiller <rootkiller.programmer@gmail.com>
Wszelkie prawa zastrzezone. Nie masz praw uzywac tego kodu bez mojej zgody.

2012-

]]

addEventHandler("onResourceStart", resourceRoot, function()
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"character") and isPedDead(v) then

			local x,y,z = getElementPosition(v)
			local character = getElementData(v, "character")
			spawnPlayer(v, x, y, z, 0, character.co_skin and tonumber(character.co_skin) or tonumber(character.skin), getElementInterior(v), getElementDimension(v))
			setElementHealth(v, 50)
			setCameraTarget(v,v)

		end
	end
end)
-- nazwa = onPlayerFinishBW
-- opis = event wykonywany po zakończeniu bw.
-- argumenty = null
-- source = gracz
addEvent("onPlayerFinshBW", true)
addEventHandler("onPlayerFinshBW", getRootElement(),
	function()
		local x,y,z = getElementPosition(source)
		local character = getElementData(source, "character")
		exports["lss-achievements"]:checkAchievementForPlayer(source,"1stblood")
		
		
		spawnPlayer(source, x, y, z, 0, character.co_skin and tonumber(character.co_skin) or tonumber(character.skin), getElementInterior(source), getElementDimension(source))
		setElementHealth(source, 1)
--		setElementModel(source, character.skin)
	end
)

-- W realnym świecie jeśli dostaniesz w łeb to też giniesz odrazu.;)
addEventHandler("onPlayerDamage", getRootElement(),
	function ( attacker, weapon, bodypart, loss )
		if ( bodypart == 9 ) then 
			killPed ( source, attacker, weapon, bodypart )
		end
	end
)