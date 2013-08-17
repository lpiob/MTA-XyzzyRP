-- STOG ITEMID = 44



addEvent("skupZboza",true)
addEventHandler("skupZboza", resourceRoot, function(plr)
  local stogi=exports["lss-core"]:eq_getItem(plr, 44)
  if (not stogi) then return end
  if (not stogi.count or stogi.count<1) then return end
  exports["lss-core"]:eq_takeItem(plr, 44)	-- zabieramy
  givePlayerMoney(plr, tonumber(stogi.count)*CENA_SKUPU)
  exports["lss-pojemniki"]:insertItemToContainer(CONTAINER_ID, 44, tonumber(stogi.count))
  outputChatBox("(( Oddano " .. stogi.count .. " stogów za " .. string.format("$%d",(tonumber(stogi.count)*CENA_SKUPU)) .. " ))", plr)

end)