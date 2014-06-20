--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

-- STOG ITEMID = 44

local CENA_SKUPU=math.random(2,3)

local CONTAINER_ID=1837

local ped=createPed(159,373.60,-2072.84,8.02,213.2, false)
setElementFrozen(ped, true)
setElementData(ped, "npc", true)
setElementData(ped, "name", "pracownik magazynu")
setElementData(ped,"customAction",{label="Sprzedaj ryby",resource="lss-wedkarstwo",funkcja="menu_oddajRyby",args={}})
local cs=createColSphere(373.60,-2072.84,8.02,2)

addEventHandler("onColShapeHit", cs, function(he,md)
  if (getElementType(he)=="player") then
	outputChatBox("Pracownik mówi: Aktualna cena skupu: " .. CENA_SKUPU .. " za rybę", he)
	outputChatBox("(( PPM na pracowniku aby sprzedać ))", he)
  end
end)




addEvent("skupRyb",true)
addEventHandler("skupRyb", resourceRoot, function(plr)
  local ryby=exports["lss-core"]:eq_getItem(plr, 8)
  if (not ryby) then return end
  if (not ryby.count or ryby.count<1) then return end

  exports["lss-admin"]:outputLog(string.format("Gracz %s sprzedaje %d surowych ryb w skupie", getPlayerName(plr), ryby.count))
  if (ryby.count>=200) then
    triggerEvent("banMe", plr, "bug-using (#2)")
    return
  end

  exports["lss-core"]:eq_takeItem(plr, 8)	-- zabieramy
  givePlayerMoney(plr, tonumber(ryby.count)*CENA_SKUPU)
  exports["lss-pojemniki"]:insertItemToContainer(CONTAINER_ID, 44, tonumber(ryby.count))
  outputChatBox("(( Oddano " .. ryby.count .. " ryb za " .. tostring(tonumber(ryby.count)*CENA_SKUPU) .. "$ ))", plr)

end)