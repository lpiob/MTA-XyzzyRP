--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



drugID = {
	[1]=137,
	[2]=138,
	[3]=139,
	[4]=140,
	[5]=141,
	[6]=142,
	[7]=143,
	[8]=144,
}

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

-- function dystansDo(player,cmd,nick)
	-- local x1,y1,z1 = getElementPosition(player)
	-- local x2,y2,z2 = getElementPosition(getPlayerFromName(nick))
	-- outputChatBox(getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2))
-- end
-- addCommandHandler("dystansdo", dystansDo)


addEvent("setDrugStamina", true)
addEventHandler("setDrugStamina", getRootElement(), function(player, mnoznik, nastale)
	local c=getElementData(player,"character")
	local befStamina = c.stamina
	local stamina = c.stamina
	local stamina = math.round((stamina*mnoznik))
	setPedStat(player, 22, stamina)
    setPedStat(player, 225, stamina)
	if (tonumber(stamina)<250) then
		toggleControl(player,"sprint", false)
    else
    	toggleControl(player,"sprint", true)
    end
	
	if nastale then
		local query=string.format("UPDATE lss_characters SET stamina=%d WHERE id=%d LIMIT 1", stamina, c.id)
		exports.DB2:zapytanie(query)
		c.stamina = stamina
		setElementData(player, "character", c)
	else
		setElementData(player, "staminaBFdrugs", befStamina)
	end
end)

addEvent("setDrugEnergy", true)
addEventHandler("setDrugEnergy", getRootElement(), function(player, mnoznik, nastale)
	local c=getElementData(player,"character")
	local befEnergy = c.energy
	local energy = c.energy
	local energy = math.round((energy*mnoznik))
	setPedStat(player, 23, energy)
    setPedStat(player, 164, energy)
    setPedStat(player, 165, energy)
	if nastale then
		local query=string.format("UPDATE lss_characters SET energy=%d WHERE id=%d LIMIT 1", energy, c.id)
		exports.DB2:zapytanie(query)
		c.energy = energy
		setElementData(player, "character", c)
	else
		setElementData(player, "energyBFdrugs", befEnergy)
	end
end)

addEvent("normalizeDrugEnergy", true)
addEventHandler("normalizeDrugEnergy", getRootElement(), function(player)
	energy = getElementData(player,"energyBFdrugs")
	setPedStat(player, 23, energy)
    setPedStat(player, 164, energy)
    setPedStat(player, 165, energy)
end)

addEvent("normalizeDrugStamina", true)
addEventHandler("normalizeDrugStamina", getRootElement(), function(player)
	stamina = getElementData(player,"staminaBFdrugs")
	setPedStat(player, 22, stamina)
    setPedStat(player, 225, stamina)
end)





addEvent("afkKick",true)
addEventHandler("afkKick", getRootElement(), function(plr)
	kickPlayer(plr, "Zostałeś wyrzucony za AFK")
end)