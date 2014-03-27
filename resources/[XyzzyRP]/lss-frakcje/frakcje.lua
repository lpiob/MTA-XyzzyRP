--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--

-- Compatibility: Lua-5.1
function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end



local function fetchPlayerFactionMembershipData(characterid, factionid)
    local query=string.format("SELECT f.name faction_name,cf.skin,cf.rank rank_id,fr.name rank_name FROM lss_character_factions cf JOIN lss_faction_ranks fr ON fr.faction_id=cf.faction_id AND fr.rank_id=cf.rank JOIN lss_faction f ON f.id=cf.faction_id WHERE cf.character_id=%d AND cf.faction_id=%d LIMIT 1", characterid, factionid);
    return exports.DB:pobierzWyniki(query)
    
end

function checkPlayerFactionMembershipData(factionid)
    local character=getElementData(source,"character")
    if (not character or not character.id) then
	-- nie powinno sie wydarzyc
	outputDebugString("lss-faction, zadanie checkPlayerFactionMembershipData dla gracza bez postaci, nie powinno sie wydarzyc")
	return
    end
    local wynik=fetchPlayerFactionMembershipData(character.id, factionid)
    triggerClientEvent(source, "onServerReturnsFactionMembershipData", resourceRoot, wynik)
end

addEvent("onPlayerRequestFactionMembershipData", true)
addEventHandler("onPlayerRequestFactionMembershipData", root, checkPlayerFactionMembershipData)


function startPlayerFactionDuty(factionid)
    local character=getElementData(source,"character")
    if (not character or not character.id) then
	-- nie powinno sie wydarzyc
	outputDebugString("lss-faction, zadanie startPlayerFactionDuty dla gracza bez postaci, nie powinno sie wydarzyc")
	return
    end
    local dane=fetchPlayerFactionMembershipData(character.id, factionid)
    if (not dane) then return end	-- gracz nie jest czlonkiem frakcji, nie powinno sie wydarzyc
    local query=string.format("UPDATE lss_character_factions SET lastduty=NOW() WHERE character_id=%d AND faction_id=%d LIMIT 1", character.id, factionid)
    exports.DB:zapytanie(query)
    setElementData(source, "faction:id", factionid)
    setElementData(source, "faction:name", dane.faction_name)
    setElementData(source, "faction:rank", dane.rank_name)
    setElementData(source, "faction:rank_id", tonumber(dane.rank_id))
    if (dane.skin and type(dane.skin)~="userdata" and tonumber(dane.skin)>0) then
	setElementModel(source, dane.skin)
    end
    outputChatBox("Rozpoczynasz pracę we frakcji: " .. dane.faction_name, source)
    -- przedmioty frakcyjne
    
    if (factionid==1) then	-- urzad miasta
	exports["lss-core"]:eq_takeItem(source, 50)	-- klucze urzedu miasta
	exports["lss-core"]:eq_giveItem(source,50,1)
    elseif (factionid==2) then	-- policja 	-- 7 pda 11 klucze
	exports["lss-core"]:eq_takeItem(source, 35)	-- pager
	exports["lss-core"]:eq_giveItem(source,35,1)

	exports["lss-core"]:eq_takeItem(source, 7)	-- pda
	exports["lss-core"]:eq_giveItem(source,7,1)
	if (tonumber(dane.rank_id)>1) then
		exports["lss-core"]:eq_takeItem(source, 11)	-- klucze policji
		exports["lss-core"]:eq_giveItem(source,11,1)
	end

	exports["lss-core"]:eq_takeItem(source, 41)	-- krotkofalowka
	exports["lss-core"]:eq_giveItem(source,41,1)
	
	--skill
	local rank = tonumber(dane.rank_id)
	if (rank>=1 and rank<=3) then --poor
		setPedStat(source, 71, 0)
		setPedStat(source, 72, 0)
		setPedStat(source, 73, 0)
		setPedStat(source, 74, 0)
		setPedStat(source, 75, 0)
		setPedStat(source, 76, 0)
		setPedStat(source, 77, 0)
		setPedStat(source, 78, 0)
		setPedStat(source, 79, 0)
	elseif (rank>=4 and rank <=6) then
		setPedStat(source, 71, 200)
		setPedStat(source, 72, 200)
		setPedStat(source, 73, 200)
		setPedStat(source, 74, 200)
		setPedStat(source, 75, 50)
		setPedStat(source, 76, 250)
		setPedStat(source, 77, 200)
		setPedStat(source, 78, 200)
		setPedStat(source, 79, 300)
	elseif (rank>=7 and rank <=9) then
		setPedStat(source, 71, 999)
		setPedStat(source, 72, 999)
		setPedStat(source, 73, 999)
		setPedStat(source, 74, 999)
		setPedStat(source, 75, 999)
		setPedStat(source, 76, 999)
		setPedStat(source, 77, 999)
		setPedStat(source, 78, 999)
		setPedStat(source, 79, 999)
	end

    elseif (factionid==3) then
	exports["lss-core"]:eq_takeItem(source, 14)	-- klucze Warsztat I
	exports["lss-core"]:eq_giveItem(source,14,1)
	elseif (factionid==4) then -- sluzby miejskie
	exports["lss-core"]:eq_takeItem(source, 35)	-- pager
	exports["lss-core"]:eq_giveItem(source,35,1)
	exports["lss-core"]:eq_takeItem(source, 4)	-- mapa
	exports["lss-core"]:eq_giveItem(source,4,1)
	exports["lss-core"]:eq_takeItem(source, 7)	-- pda
	exports["lss-core"]:eq_giveItem(source,7,1)
	exports["lss-core"]:eq_takeItem(source, 12)	-- klucze sm
	exports["lss-core"]:eq_giveItem(source,12,1)
	exports["lss-core"]:eq_takeItem(source, 41)	-- krotkofalowka
	exports["lss-core"]:eq_giveItem(source,41,1)
    elseif (factionid==5) then -- cnn news
	exports["lss-core"]:eq_takeItem(source, 35)	-- pager
	exports["lss-core"]:eq_giveItem(source,35,1)
	exports["lss-core"]:eq_takeItem(source, 41)	-- krotkofalowka
	exports["lss-core"]:eq_giveItem(source,41,1)
	exports["lss-core"]:eq_takeItem(source, 49)	-- klucze cnn news
	exports["lss-core"]:eq_giveItem(source,49,1)	
    elseif (factionid==6) then
	exports["lss-core"]:eq_takeItem(source, 35)	-- pager
	exports["lss-core"]:eq_giveItem(source,35,1)
	exports["lss-core"]:eq_takeItem(source, 29)	-- klucze medykow
	exports["lss-core"]:eq_giveItem(source,29,1)
	exports["lss-core"]:eq_takeItem(source, 41)	-- krotkofalowka
	exports["lss-core"]:eq_giveItem(source,41,1)

--    elseif (factionid==7) then -- taxi
--	exports["lss-core"]:eq_takeItem(source, 35)	-- pager
--	exports["lss-core"]:eq_giveItem(source,35,1)
--	exports["lss-core"]:eq_takeItem(source, 26)	-- klucze taxi
--	exports["lss-core"]:eq_giveItem(source, 26,1)
    elseif (factionid==8) then -- nauka jazdy 1
	exports["lss-core"]:eq_takeItem(source, 20)	-- klucze nauki jazdy 1
	exports["lss-core"]:eq_giveItem(source,20,1)
    elseif (factionid==9) then -- kurierzy
	exports["lss-core"]:eq_takeItem(source, 51)	-- klucze kurierow
	exports["lss-core"]:eq_giveItem(source,51,1)
	elseif (factionid==11) then
	exports["lss-core"]:eq_takeItem(source, 39)	--klucze fd
	exports["lss-core"]:eq_giveItem(source,39,1)
	exports["lss-core"]:eq_takeItem(source, 35)	-- pager
	exports["lss-core"]:eq_giveItem(source,35,1)
	exports["lss-core"]:eq_takeItem(source, 41)	-- krotkofalowka
	exports["lss-core"]:eq_giveItem(source,41,1)
    elseif (factionid==12) then -- Warsztat II
	exports["lss-core"]:eq_takeItem(source, 52)	-- klucze Warsztat II
	exports["lss-core"]:eq_giveItem(source,52,1)
    elseif (factionid==13) then -- Warsztat III
	exports["lss-core"]:eq_takeItem(source, 53)	-- klucze Warsztat III
	exports["lss-core"]:eq_giveItem(source,53,1)
    elseif (factionid==15) then -- ochrona
	exports["lss-core"]:eq_takeItem(source, 57)	-- klucze ochrony
	exports["lss-core"]:eq_giveItem(source,57,1)	
    elseif (factionid==16) then -- nauka jazdy 2
	exports["lss-core"]:eq_takeItem(source, 56)	-- klucze nauki jazdy 2
	exports["lss-core"]:eq_giveItem(source,56,1)
    elseif (factionid==18) then -- Warsztat IV
	exports["lss-core"]:eq_takeItem(source, 54)	-- klucze warsztat IV
	exports["lss-core"]:eq_giveItem(source,54,1)	
    elseif (factionid==19) then -- Warsztat V
	exports["lss-core"]:eq_takeItem(source, 55)	-- klucze warsztat V
	exports["lss-core"]:eq_giveItem(source,55,1)
    elseif (factionid==10) then -- import
	exports["lss-core"]:eq_takeItem(source, 62)	-- klucze importu
	exports["lss-core"]:eq_giveItem(source,62,1)
	exports["lss-core"]:eq_takeItem(source, 7)	-- pda
	exports["lss-core"]:eq_giveItem(source,7,1)
    elseif (factionid==14) then -- kopalnia
	exports["lss-core"]:eq_takeItem(source, 75)	-- klucze gornikow
	exports["lss-core"]:eq_giveItem(source,75,1)
    elseif (factionid==17) then -- sad rejonowy
	exports["lss-core"]:eq_takeItem(source, 77)	-- klucze sądu rejonowego
	exports["lss-core"]:eq_giveItem(source,77,1)
	exports["lss-core"]:eq_takeItem(source, 41)	-- krotkofalowka
	exports["lss-core"]:eq_giveItem(source,41,1)
    elseif (factionid==20) then -- sluzby wiezienne
	exports["lss-core"]:eq_takeItem(source, 78)	-- klucze służb więziennych
	exports["lss-core"]:eq_giveItem(source,78,1)
	exports["lss-core"]:eq_takeItem(source, 41)	-- krotkofalowka
	exports["lss-core"]:eq_giveItem(source,41,1)
    elseif (factionid==22) then --sluzby specjalne
	exports["lss-core"]:eq_takeItem(source, 80)	-- klucze służb specjalnych
	exports["lss-core"]:eq_giveItem(source,80,1)
	exports["lss-core"]:eq_takeItem(source, 35)	-- pager
	exports["lss-core"]:eq_giveItem(source,35,1)
	exports["lss-core"]:eq_takeItem(source, 7)	-- pda
	exports["lss-core"]:eq_giveItem(source,7,1)
	exports["lss-core"]:eq_takeItem(source, 41)	-- krotkofalowka
	exports["lss-core"]:eq_giveItem(source,41,1)
	local rank = tonumber(dane.rank_id)
	if (rank>=1 and rank<=3) then --poor
		setPedStat(source, 71, 0)
		setPedStat(source, 72, 0)
		setPedStat(source, 73, 0)
		setPedStat(source, 74, 0)
		setPedStat(source, 75, 0)
		setPedStat(source, 76, 0)
		setPedStat(source, 77, 0)
		setPedStat(source, 78, 0)
		setPedStat(source, 79, 0)
	elseif (rank>=4 and rank <=5) then
		setPedStat(source, 71, 200)
		setPedStat(source, 72, 200)
		setPedStat(source, 73, 200)
		setPedStat(source, 74, 200)
		setPedStat(source, 75, 50)
		setPedStat(source, 76, 250)
		setPedStat(source, 77, 200)
		setPedStat(source, 78, 200)
		setPedStat(source, 79, 300)
	elseif (rank>=6 and rank <=7) then
		setPedStat(source, 71, 999)
		setPedStat(source, 72, 999)
		setPedStat(source, 73, 999)
		setPedStat(source, 74, 999)
		setPedStat(source, 75, 999)
		setPedStat(source, 76, 999)
		setPedStat(source, 77, 999)
		setPedStat(source, 78, 999)
		setPedStat(source, 79, 999)
	end
    elseif (factionid==23) then -- prywatna przychodnia
	exports["lss-core"]:eq_takeItem(source, 92)	-- klucze prywatnej przychodni lekarskiej
	exports["lss-core"]:eq_giveItem(source,92,1)
    elseif (factionid==21) then --sluzby koscielne
	exports["lss-core"]:eq_takeItem(source, 101)	-- klucze sluzb koscielnych
	exports["lss-core"]:eq_giveItem(source,101,1)	
	elseif (factionid==24) then -- tartak
		exports["lss-core"]:eq_takeItem(source, 103)	-- klucze tartaku
		exports["lss-core"]:eq_giveItem(source,103,1)
    elseif (factionid==25) then --szkola lotnicza
	exports["lss-core"]:eq_takeItem(source, 106)	-- klucze szkoly lotniczej
	exports["lss-core"]:eq_giveItem(source,106,1)
    elseif (factionid==26) then --Usługi gastonomiczne - Sklep 'na rogu' I
	exports["lss-core"]:eq_takeItem(source, 117)	-- klucze
	exports["lss-core"]:eq_giveItem(source,117,1)
    elseif (factionid==27) then --Usługi gastonomiczne - Sklep Spożywczy 'Strug' II
	exports["lss-core"]:eq_takeItem(source, 118)	-- klucze
	exports["lss-core"]:eq_giveItem(source,118,1)
    elseif (factionid==28) then --Usługi gastonomiczne - Knajpka 'na molo' III
	exports["lss-core"]:eq_takeItem(source, 119)	-- klucze
	exports["lss-core"]:eq_giveItem(source,119,1)	
    elseif (factionid==29) then --Usługi gastonomiczne - Restauracja 'The Well Stacked Pizza' IV
	exports["lss-core"]:eq_takeItem(source, 120)	-- klucze
	exports["lss-core"]:eq_giveItem(source,120,1)
    elseif (factionid==30) then --Usługi gastonomiczne - Restauracja Hot-Food V
	exports["lss-core"]:eq_takeItem(source, 121)	-- klucze
	exports["lss-core"]:eq_giveItem(source,121,1)
    elseif (factionid==31) then --Usługi gastonomiczne - Market 'Prima' VI
	exports["lss-core"]:eq_takeItem(source, 122)	-- klucze
	exports["lss-core"]:eq_giveItem(source,122,1)
    elseif (factionid==32) then --Usługi gastonomiczne - Market 'Super Sam' VII
	exports["lss-core"]:eq_takeItem(source, 123)	-- klucze
	exports["lss-core"]:eq_giveItem(source,123,1)
    elseif (factionid==33) then --Usługi gastonomiczne - Kawiarnia 'pod sceną' VIII
	exports["lss-core"]:eq_takeItem(source, 124)	-- klucze
	exports["lss-core"]:eq_giveItem(source,124,1)
    elseif (factionid==34) then --Usługi gastonomiczne - Knajpa 'Paszcza Wieloryba' IX
	exports["lss-core"]:eq_takeItem(source, 125)	-- klucze
	exports["lss-core"]:eq_giveItem(source,125,1)
    elseif (factionid==35) then --Departament Turystyki
	exports["lss-core"]:eq_takeItem(source, 126)	-- klucze
	exports["lss-core"]:eq_giveItem(source,126,1)
	exports["lss-core"]:eq_takeItem(source, 35)	-- pager
	exports["lss-core"]:eq_giveItem(source,35,1)
	exports["lss-core"]:eq_takeItem(source, 41)	-- krotkofalowka
	exports["lss-core"]:eq_giveItem(source,41,1)
    elseif (factionid==36) then --Usługi gastonomiczne - Knajpa 'Isaura' X
	exports["lss-core"]:eq_takeItem(source, 127)	-- klucze
	exports["lss-core"]:eq_giveItem(source,127,1)
    elseif (factionid==37) then --Usługi gastonomiczne - Market 'Łubin' XI
	exports["lss-core"]:eq_takeItem(source, 128)	-- klucze
	exports["lss-core"]:eq_giveItem(source,128,1)
    elseif (factionid==38) then --Usługi gastonomiczne - Restauracja 'Przy skarpie' XII
	exports["lss-core"]:eq_takeItem(source, 129)	-- klucze
	exports["lss-core"]:eq_giveItem(source,129,1)
    elseif (factionid==39) then --Usługi gastonomiczne - Knajpa 'Diabelski mlyn' XIII
	exports["lss-core"]:eq_takeItem(source, 149)	-- klucze
	exports["lss-core"]:eq_giveItem(source,149,1)
    elseif (factionid==40) then --Klub Miasta Los Santos
	exports["lss-core"]:eq_takeItem(source, 163)	-- klucze
	exports["lss-core"]:eq_giveItem(source,163,1)





    end
end

addEvent("onPlayerStartFactionDuty", true)
addEventHandler("onPlayerStartFactionDuty", root, startPlayerFactionDuty)

function finishPlayerFactionDuty(factionid,plr)
	if not plr and source then plr=source end
    removeElementData(plr, "faction:id")
    removeElementData(plr, "faction:name")
    removeElementData(plr, "faction:rank")
    removeElementData(plr, "faction:rank_id")
    outputChatBox("Kończysz pracę we frakcji.", plr)
    -- przedmioty frakcyjne
	if (factionid==1) then
		exports["lss-core"]:eq_takeItem(plr, 50)	-- klucze urzad miasta	
    elseif (factionid==2) then	-- policja 	-- 7 pda 11 klucze
		exports["lss-core"]:eq_takeItem(plr, 7)	-- pda
		exports["lss-core"]:eq_takeItem(plr, 11)	-- klucze policji
		exports["lss-core"]:eq_takeItem(plr, 41)	-- krotkofalowka
    elseif (factionid==3) then
        exports["lss-core"]:eq_takeItem(plr, 14)	-- klucze Warsztat I
	elseif (factionid==4) then
		exports["lss-core"]:eq_takeItem(plr, 7)	-- pda
		exports["lss-core"]:eq_takeItem(plr, 12)	-- klucze sm
		exports["lss-core"]:eq_takeItem(plr, 35)	-- pager
		exports["lss-core"]:eq_takeItem(plr, 41)	-- krotkofalowka
	elseif (factionid==5) then
		exports["lss-core"]:eq_takeItem(plr, 35)	-- pager
		exports["lss-core"]:eq_takeItem(plr, 41)	-- krotkofalowka
		exports["lss-core"]:eq_takeItem(plr, 49)	-- klucze cnn news		
	elseif (factionid==6) then
		exports["lss-core"]:eq_takeItem(plr, 29)	-- klucze medykow
		exports["lss-core"]:eq_takeItem(plr, 41)	-- krotkofalowka
		exports["lss-core"]:eq_takeItem(plr, 35)	-- pager
--	elseif (factionid==7) then -- taxi
--		exports["lss-core"]:eq_takeItem(plr, 26)	-- taxi
--		exports["lss-core"]:eq_takeItem(plr, 35)	-- taxi
	elseif (factionid==8) then -- nauka jazdy
	exports["lss-core"]:eq_takeItem(plr, 20)	-- klucze nauki jazdy 1
	elseif (factionid==9) then
		exports["lss-core"]:eq_takeItem(plr, 51)	-- klucze kurierow
	elseif (factionid==11) then
		exports["lss-core"]:eq_takeItem(plr, 41)	-- krotkofalowka
		exports["lss-core"]:eq_takeItem(plr, 35)	-- pager
		exports["lss-core"]:eq_takeItem(plr, 39)	-- klucze fd
	elseif (factionid==12) then
		exports["lss-core"]:eq_takeItem(plr, 52)	-- klucze Warsztat II
	elseif (factionid==13) then
		exports["lss-core"]:eq_takeItem(plr, 53)	-- klucze Warsztat III
	elseif (factionid==15) then
		exports["lss-core"]:eq_takeItem(plr, 57)	-- klucze ochrony
	elseif (factionid==16) then
		exports["lss-core"]:eq_takeItem(plr, 56)	-- klucze nauki jazdy 2		
	elseif (factionid==18) then
		exports["lss-core"]:eq_takeItem(plr, 54)	-- klucze Warsztat IV
	elseif (factionid==19) then
		exports["lss-core"]:eq_takeItem(plr, 55)	-- klucze Warsztat V
	elseif (factionid==10) then
		exports["lss-core"]:eq_takeItem(plr, 62)	-- klucze importu
		exports["lss-core"]:eq_takeItem(plr, 7)	-- pda
	elseif (factionid==14) then
		exports["lss-core"]:eq_takeItem(plr, 75)	-- klucze gornikow
	elseif (factionid==17) then
		exports["lss-core"]:eq_takeItem(plr, 77)	-- klucze sadu rejonowego
		exports["lss-core"]:eq_takeItem(plr, 41)	-- krotkofalowka
    elseif (factionid==20) then
		exports["lss-core"]:eq_takeItem(plr, 78)	-- klucze służb więziennych
		exports["lss-core"]:eq_takeItem(plr, 41)	-- krotkofalowka
	elseif (factionid==22) then
	exports["lss-core"]:eq_takeItem(source, 80)	-- klucze służb specjalnych
	exports["lss-core"]:eq_takeItem(source, 35)	-- pager
	exports["lss-core"]:eq_takeItem(source, 7)	-- pda
	exports["lss-core"]:eq_takeItem(source, 41)	-- krotkofalowka
	elseif (factionid==23) then
		exports["lss-core"]:eq_takeItem(plr, 92)	-- klucze prywatnej przychodni lekarskiej
	elseif (factionid==21) then
		exports["lss-core"]:eq_takeItem(plr, 101)	-- klucze służb koscielnych
	elseif (factionid==24) then -- tartak
		exports["lss-core"]:eq_takeItem(source, 103)	-- klucze tartaku
	elseif (factionid==25) then
		exports["lss-core"]:eq_takeItem(plr, 106)	-- klucze szkoly lotniczej
	elseif (factionid==26) then
		exports["lss-core"]:eq_takeItem(plr, 117)	-- Usługi gastonomiczne - Sklep 'na rogu' I
	elseif (factionid==27) then
		exports["lss-core"]:eq_takeItem(plr, 118)	-- Usługi gastonomiczne - Sklep Spożywczy 'Strug' II
	elseif (factionid==28) then
		exports["lss-core"]:eq_takeItem(plr, 119)	-- Usługi gastonomiczne - Knajpka 'na molo' III
	elseif (factionid==29) then
		exports["lss-core"]:eq_takeItem(plr, 120)	-- Usługi gastonomiczne - Restauracja 'The Well Stacked Pizza' IV
	elseif (factionid==30) then
		exports["lss-core"]:eq_takeItem(plr, 121)	-- Usługi gastonomiczne - Restauracja Hot-Food V
	elseif (factionid==31) then
		exports["lss-core"]:eq_takeItem(plr, 122)	-- Usługi gastonomiczne - Market 'Prima' VI
	elseif (factionid==32) then
		exports["lss-core"]:eq_takeItem(plr, 123)	-- Usługi gastonomiczne - Market 'Super Sam' VII
	elseif (factionid==33) then
		exports["lss-core"]:eq_takeItem(plr, 124)	-- Usługi gastonomiczne - Kawiarnia 'pod sceną' VIII
	elseif (factionid==34) then
		exports["lss-core"]:eq_takeItem(plr, 125)	-- Usługi gastonomiczne - Knajpa 'Paszcza Wieloryba' IX
	elseif (factionid==35) then
		exports["lss-core"]:eq_takeItem(plr, 126)	-- Departament Turystyki
	exports["lss-core"]:eq_takeItem(source, 35)	-- pager
	exports["lss-core"]:eq_takeItem(source, 41)	-- krotkofalowka
	elseif (factionid==36) then
		exports["lss-core"]:eq_takeItem(plr, 127)	-- Usługi gastonomiczne - Market 'Łubin' X
	elseif (factionid==37) then
		exports["lss-core"]:eq_takeItem(plr, 128)	-- Usługi gastonomiczne - Knajpa 'Isaura' XI
	elseif (factionid==38) then
		exports["lss-core"]:eq_takeItem(plr, 129)	-- Usługi gastonomiczne - Restauracja 'Przy skarpie' XII
	elseif (factionid==39) then
		exports["lss-core"]:eq_takeItem(plr, 149)	-- Usługi gastonomiczne - Knajpa 'Diabelski mlyn' XIII
	elseif (factionid==40) then
		exports["lss-core"]:eq_takeItem(plr, 163)	-- Klub Miasta Los Santos
		

    end
	exports["lss-core"]:eq_takeItem(plr, 35)	-- pager

    local c=getElementData(plr,"character")
    setElementModel(plr, c.skin)
end

addEvent("onPlayerFinishFactionDuty", true)
addEventHandler("onPlayerFinishFactionDuty", root, finishPlayerFactionDuty)

-------------------- rozliczanie czasu pracy we frakcji

local function naliczanieCzasu()
    for i,p in ipairs(getElementsByType("player")) do
	local c=getElementData(p,"character")
	if (c and c.id) then
	    local fid=getElementData(p,"faction:id")
	    if (fid and tonumber(fid)>0) then
			local query=string.format("UPDATE lss_character_factions SET dutytime=dutytime+3,totalduty=totalduty+3 WHERE faction_id=%d and character_id=%d LIMIT 1", fid, c.id)
			exports.DB:zapytanie(query)
			-- sprawdzanie afk
			local afk=getElementData(p,"afk")
			if afk and tonumber(afk) and tonumber(afk)>=15 then
				outputChatBox("(( Jesteś AFK, w związku z czym zostajesz zdjęty/-a ze służby. ))", p)
				finishPlayerFactionDuty(fid,p)
			end
	    end
	end
    end
    setTimer(naliczanieCzasu, 3*60000, 1)
end

setTimer(naliczanieCzasu, math.random(10000,12000), 1)


-- skrzynki pocztowe

do
    local skrzynki=exports.DB:pobierzTabeleWynikow("SELECT id,postbox FROM lss_faction WHERE postbox IS NOT NULL")
    for i,v in ipairs(skrzynki) do
	local p=split(v.postbox,",")
	local skrzynka=createObject(1291, tonumber(p[1]), tonumber(p[2]), tonumber(p[3])-0.5, 0,0, tonumber(p[4])+180)
	-- exports["lss-poczta"]:dostarczListy(dom.ownerid)
	setElementData(skrzynka,"customAction",{label="Wrzuć list", resource="lss-poczta", funkcja="dostarczListy", args={skrzynka=-tonumber(v.id)}})
    end
end