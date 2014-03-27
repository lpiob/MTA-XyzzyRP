--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local function processHunger()
	if (getElementData(localPlayer, "kary:blokada_aj") or 0)>0 then return end -- w aj nie spada
	local character=getElementData(localPlayer, "character")
	if not character or not tonumber(character.satiation) or not tonumber(character.energy) or not tonumber(character.stamina) then return end

	-- ((1001-stamina)+(energy))/400
	-- 100 , 100 => (901+100)/200=5
	-- 100,  900 => (901+900)/200=9
	-- 300,  300 => 3
	-- 999, 999 => 9
	-- 999, 100 => 5
	-- przecietna wartosc: 2, spadnie z 100 do 0 po 6 godzinach
	local subv=math.floor(((1001-character.stamina)+(character.energy))/400)
	character.satiation=math.max(character.satiation-subv,0)
	setElementData(localPlayer, "character", character)
	outputDebugString("Obniżam nasycenie o " .. subv)
end


setTimer(processHunger, 1000*60*10, 0) -- co 10 minut

local function processHealth()
	if (getElementData(localPlayer, "kary:blokada_aj") or 0)>0 then return end -- w aj nie spada
	if isPlayerDead(localPlayer) then return end

	if getElementHealth(localPlayer)>=90 then return end -- powyzej 90 nie leczymy

	local character=getElementData(localPlayer, "character")
	if not character or not tonumber(character.satiation) then return end
	local hp=getElementHealth(localPlayer)
	if tonumber(character.satiation)<10 then
		hp=math.max(hp-1,1)
		setElementHealth(localPlayer, hp)
--	elseif tonumber(character.satiation)>50 then
--		hp=math.min(100, hp+1)
--		setElementHealth(localPlayer, hp)
	end

end
setTimer(processHealth, 1000*60, 0) -- co minute
