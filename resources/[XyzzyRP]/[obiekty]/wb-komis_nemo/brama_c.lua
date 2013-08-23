function menu_brama()
	local c=getElementData(localPlayer,"character")
	if not c or not c.id then return end
	-- @todo w tym miejscu uzywane bylo sztywne przypisanie bramy do konkretnych graczy
	-- @todo zmienic na wlasciwe ID postaci lub zmienic na mechanizm sprawdzajacy uprawnienia
	-- @todo w bazie danych
	if true or (tonumber(c.id)~=13743 and tonumber(c.id)~=12861) then
		outputChatBox("Nie masz klucza do bramy.", 255,0,0,true)
		return
	end
	triggerServerEvent("onBramaToggleRequest", resourceRoot)
end
