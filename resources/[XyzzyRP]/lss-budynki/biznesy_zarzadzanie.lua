--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


-- triggerServerEvent("doSaveBusinessData", resourceRoot, localPlayer, edytowany_biznes)
addEvent("doSaveBudynekData", true)
addEventHandler("doSaveBudynekData", resourceRoot, function(plr,budynek)
    if (not budynek or not budynek.id) then 
		outputChatBox("(( Nie udało się zapisać ustawień budynku. ))", plr)
		return 
    end
	if (budynek.linkedContainer and budynek.nowyszyfr and string.len(budynek.nowyszyfr)>3 and string.len(budynek.nowyszyfr)<=7 and tonumber(budynek.nowyszyfr)) then

		local query=string.format("UPDATE lss_containers SET szyfr='%s' WHERE id=%d AND typ='sejf' LIMIT 1", exports.DB:esc(budynek.nowyszyfr), budynek.linkedContainer)
		exports.DB:zapytanie(query)
		outputChatBox("(( Szyfr w sejfie został zmieniony ))", plr)
	end
    -- todo weryfikacja uprawnien
    local query=string.format("UPDATE lss_budynki SET descr2='%s',entryCost=%d,zamkniety=%d WHERE id=%d LIMIT 1", exports.DB:esc(budynek.descr2_orig), budynek.entryCost, budynek.zamkniety, budynek.id)
    exports.DB:zapytanie(query)
--    outputDebugString(query)
    outputChatBox("(( Dane budynku zostały zapisane ))", plr)
    zaladujBudynek(budynek.id)
end)