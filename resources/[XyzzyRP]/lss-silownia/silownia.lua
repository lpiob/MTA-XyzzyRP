--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



addEvent("onTreadProgress",true)
addEventHandler("onTreadProgress", root, function()	-- zwiekszamy graczowi staminę o 1
    local c=getElementData(source,"character")
    if (not c) then return end -- shouldn't happen
    local stamina=tonumber(c.stamina) or 0
    stamina=stamina+1
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


addEvent("onLaweczkaProgress",true)
addEventHandler("onLaweczkaProgress", root, function()	-- zwiekszamy graczowi staminę o 1
    local c=getElementData(source,"character")
    if (not c) then return end -- shouldn't happen
    local energy=tonumber(c.energy) or 0
    energy=energy+1
    if (energy>999) then energy=999 end
    c.energy=energy
    setElementData(source, "character", c)
    -- zapisujemy informacje do bazy danych
    local query=string.format("UPDATE lss_characters SET energy=%d WHERE id=%d LIMIT 1", energy, c.id)
    exports.DB:zapytanie(query)
    -- aktualizujemy statystyki peda
    -- 22 225
    setPedStat(source, 23, energy)
    setPedStat(source, 164, energy)
    setPedStat(source, 165, energy)

    outputChatBox("(( Twoja energia/siła: " .. energy .."/999 ))", source)
end)