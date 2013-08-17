local function getVehicleByID(id)
	id=tonumber(id)
	for i,v in ipairs(getElementsByType("vehicle")) do
		local dbid=tonumber(getElementData(v,"dbid"))
		if dbid and dbid==id then
			return v
		end
	end
	return nil
end

-- triggerServerEvent("doStartTaxiJob", resourceRoot, klucz)
addEvent("doStartTaxiJob", true)
addEventHandler("doStartTaxiJob", resourceRoot, function(klucz)
	-- szukamy pojazdu na mapie
	local pojazd=getVehicleByID(klucz)
	if not pojazd then
		outputChatBox("(( Nie odnaleziono na mapie podanego pojazdu ))", client)
		return
	end
	
	-- sprawdzamy czy pojazd jest zolty
	local cr,cg,cb=getVehicleColor(pojazd, true)

	outputDebugString(cr.."-"..cg.."--"..cb)
	if (cr>165 and cr<265) and (cg>92 and cg<192) and (cb<66) then
		-- mozemy jechac z koksem
		exports["lss-core"]:eq_takeItem(client, 35)	-- pager
		exports["lss-core"]:eq_giveItem(client,35,1)
		setElementData(pojazd, "taxi", client)
		setElementData(client, "faction:id", 7)
		setElementData(client, "faction:name", "Taxi")
		setElementData(client, "faction:rank", "Taksowkarz")
		setElementData(client, "faction:rank_id", 1)
		outputChatBox("(( Rozpocząłeś służbę we frakcji taxi, będziesz otrzymywał zgłoszenia na pager. ))", client)
		outputChatBox("Sekretarka mówi: miłej pracy!", client)

	else
		outputChatBox("Sekretarka mówi: pojazd musi być koloru żółtego.", client)
	end
end)