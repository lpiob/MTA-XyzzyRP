addEventHandler ("onClientElementDataChange", localPlayer, function(dataName, oldValue)
	if (dataName~="uo_det") then return end
	
	if getElementData(localPlayer, "uo_det") then
		enableDetail()
	else
		disableDetail()
	end
end)