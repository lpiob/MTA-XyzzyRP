--[[
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



addEvent("onPlazaRunCompleted",true)
addEventHandler("onPlazaRunCompleted", root, function(ilosc)	-- zwiekszamy graczowi staminę o 1
    local c=getElementData(source,"character")
    if (not c) then return end -- shouldn't happen
    local stamina=tonumber(c.stamina) or 0
    stamina=stamina+ilosc
    if (stamina>999) then stamina=999 end
    c.stamina=stamina
    setElementData(source, "character", c)
    -- zapisujemy informacje do bazy danych
    local query=string.format("UPDATE lss_characters SET stamina=%d WHERE id=%d LIMIT 1", stamina, c.id)
    exports.DB:zapytanie(query)
    -- aktualizujemy statystyki peda
    -- 22 225
    setPedStat(source, 22, stamina)
    setPedStat(source, 225, stamina)
    outputChatBox("(( Twoja stamina: " .. stamina .."/999 ))", source)

    if (tonumber(stamina)<250) then
	toggleControl(source,"sprint", false)
    else
    	toggleControl(source,"sprint", true)
    end
    

end)

addEvent("onPlazaRunCompletedDOG",true)
addEventHandler("onPlazaRunCompletedDOG", root, function()	-- zwiekszamy graczowi staminę o 1
   local pies = getElementData(source, "player:dog")
   --zwiekszamy stamine
   dog = getElementData(pies, "dog")
   dog.stamina = dog.stamina+1
   setElementData(pies, "dog", dog)
   local c = getElementData(source, "character")
   local query = string.format("UPDATE lss_petsystem SET stamina=stamina+1 WHERE char_id=%d LIMIT 1", c.id)
   exports.DB2:zapytanie(query)
   outputChatBox("(( Twój pies wygląda na bardziej wysportowanego! ))", source)
 
end)