--[[
Kasyno - blackjack

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--


local I=1
local D=65

local ochroniarz1=createPed(163,1899.82,-1674.22,1396.88, 180,false)
setElementInterior(ochroniarz1,I)
setElementDimension(ochroniarz1,D)
setElementData(ochroniarz1, "npc", true)
setElementFrozen(ochroniarz1,true)
local ochroniarz2=createPed(164,1841.31,-1696.33,1392.86, 331,false)
setElementInterior(ochroniarz2,I)
setElementDimension(ochroniarz2,D)
setElementData(ochroniarz2, "npc", true)
setElementFrozen(ochroniarz2,true)
local krupier1=createPed(11,1843.46,-1679.29,1392.47, 52,false)
setElementInterior(krupier1,I)
setElementDimension(krupier1,D)
setElementData(krupier1,"customAction",{label="Zagraj",resource="lss-kasyno",funkcja="menu_blackjack",args={}}) -- todo identyfikator krupiera
setElementData(krupier1, "npc", true)
setElementData(krupier1, "name", "krupier")
setElementFrozen(krupier1,true)
--[[
local krupier2=createPed(171,1125.16,-3.04,1000.68,183.1,false)
setElementInterior(krupier2,I)
setElementDimension(krupier2,D)
setElementData(krupier2, "npc", true)

setElementFrozen(krupier2,true)

local krupier3=createPed(172,1124.97,-0.35,1000.68,5.6,false)
setElementInterior(krupier3,I)
setElementDimension(krupier3,D)
setElementData(krupier3, "npc", true)
setElementFrozen(krupier3,true)

]]--
local barman=createPed(171,1835.38,-1678.03,1392.47, 270,false)
setElementInterior(barman,I)
setElementDimension(barman,D)
setElementData(barman, "npc", true)
setElementFrozen(barman,true)