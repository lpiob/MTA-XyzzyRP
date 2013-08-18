local uprawy={
	{1771.28,434.25,18.84},
	{1779.52,432.37,18.84},
	{1786.24,432.84,18.84},

	{1504.92,290.80,18.22},
	{1506.74,296.56,18.36},
	{1509.38,302.92,18.50},
	
	{541.82,802.10,433.59},
	{577.25,738.63,377.86},
	{745.37,575.35,137.73},
}



addEvent("onGZbior", true)
addEventHandler("onGZbior", resourceRoot, function(gracz, indeks)
	if (not indeks or not uprawy[indeks]) then return end
	if (not isElement(uprawy[indeks].object)) then return end

	if (not exports["lss-core"]:eq_giveItem(gracz, 34,1)) then
		outputChatBox("Nie masz miejsca w inwentarzu.", gracz, 255,0,0,true)
		return
	end

	destroyElement(uprawy[indeks].object)
--	destroyElement(uprawy[indeks].fobject)
	uprawy[indeks].object=nil
--	uprawy[indeks].fobject=nil
	triggerEvent("broadcastCaptionedEvent", gracz, getPlayerName(gracz) .. " zbiera grzyby.", 5, 15, true)
end)
--triggerServerEvent("onZbior", args.obiekt, localPlayer, args.indeks)


local function respawnUpraw()
	for i,v in ipairs(uprawy) do
		if (not v.object or not isElement(v.object)) then
			-- 823
			local o = 1211

			v.object=createObject(o, v[1], v[2], v[3]-1.45, 0,0,math.random(0,360)) --coordy z /gp
			-- createObject(o, v[1], v[2], v[3]-0.5, 0,0,math.random(0,360))
		--	928, 924, 926
--			v.fobject=createObject(928, v[1], v[2], v[3], 0,0,math.random(0,360))
--			setObjectScale(v.fobject,0.1)
			setElementData(v.object,"customAction",{label="Zbierz",resource="lss-grzyby",funkcja="menu_zbierz",args={obiekt=v.object,indeks=i}})
		end
	end
end


respawnUpraw()
setTimer(respawnUpraw, 21600000, 0)