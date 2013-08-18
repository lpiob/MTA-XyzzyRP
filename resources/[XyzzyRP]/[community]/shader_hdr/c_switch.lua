addEventHandler ("onClientElementDataChange", localPlayer, function(dataName, oldValue)
	if (dataName~="uo_hdr") then return end
	if getElementData(localPlayer, "uo_hdr") then
		enableContrast()
	else
		disableContrast()
	end
end)