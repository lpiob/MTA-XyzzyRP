-- STOG ITEMID = 44

function menu_oddajZboze()
  local stogi=exports["lss-gui"]:eq_getItemByID(44)
  if not stogi or not stogi.count or stogi.count<1 then 
	outputChatBox("Nie masz żadnego zboża.", 255,0,0)
	return
  end
  triggerServerEvent("skupZboza", resourceRoot, localPlayer)
end