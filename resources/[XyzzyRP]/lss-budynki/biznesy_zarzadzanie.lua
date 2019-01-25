--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


-- triggerServerEvent("doSaveBusinessData", resourceRoot, localPlayer, edytowany_biznes)
addEvent("doSaveBudynekData", true)
addEventHandler("doSaveBudynekData", resourceRoot, function(plr,budynek)
    if (not budynek or not budynek.id) then 
      outputChatBox("(( Nie udało się zapisać ustawień budynku. ))", plr)
      return 
    end
    local character = getElementData(plr, "character")
    if not character or not character.id then
      outputChatBox("(( Nie możesz korzystać z budynków będąc niezalogowanym. ))", plr)
      return
    end
    local currentOwner = exports["DB2"]:pobierzWyniki("SELECT character_id FROM lss_budynki_owners WHERE budynek_id = ? AND character_id = ?", budynek.id, character.id)
    if not currentOwner or not currentOwner.character_id then
      outputChatBox("(( Nie możesz edytować tego budynku. ))", plr)
      return
    end
    if (budynek.linkedContainer and budynek.nowyszyfr and string.len(budynek.nowyszyfr)>3 and string.len(budynek.nowyszyfr)<=7 and tonumber(budynek.nowyszyfr)) then
      local query=string.format("UPDATE lss_containers SET szyfr='%s' WHERE id=%d AND typ='sejf' LIMIT 1", exports.DB:esc(budynek.nowyszyfr), budynek.linkedContainer)
      exports.DB:zapytanie(query)
      outputChatBox("(( Szyfr w sejfie został zmieniony ))", plr)
    end
    local query=string.format("UPDATE lss_budynki SET descr2='%s',entryCost=%d,zamkniety=%d WHERE id=%d LIMIT 1", exports.DB:esc(budynek.descr2_orig), budynek.entryCost, budynek.zamkniety, budynek.id)
    exports.DB:zapytanie(query)
--    outputDebugString(query)
    outputChatBox("(( Dane budynku zostały zapisane ))", plr)
    zaladujBudynek(budynek.id)
end)
