--[[
lss-achievements: osiągniecia

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--


-- programowanie w lua to poezja

function addPlayerGP(plr,amount,ach,given_by,notes)
	local user_id=getElementData(plr,"auth:uid")
	if not user_id then return false end

	local character=getElementData(plr,"character")
	if not character or not character.id then return false end

	local gp=tonumber(getElementData(plr,"GP"))
	if not gp then return false end
	gp=gp+tonumber(amount)
	setElementData(plr,"GP", gp)
	if given_by then
		given_by=getElementData(given_by, "auth:uid")
	end
	exports.DB2:zapytanie("INSERT INTO lss_achievements_history SET ts=NOW(),achname=?,user_id=?,character_id=?,amount=?,given_by=?,notes=?",
			ach, user_id, character.id, amount, given_by, notes)
	return true
end

local achievements={
--[[ wzor
    ["nazwa"]={ -- unikalna nazwa, uzywana tylko w kodzie i w bazie danych
		timely=true, -- true/false - czy to ma byc sprawdzne automatycznie co jakis czas
		value=10, -- ile punktow za to (+10gp)
		check=function(plr) -- kod lua sprawdzajacy czy gracz osiagnal osiagniecie
	},
]]--
	["1sthour"]={
		name="Pierwsza godzina na serwerze.",
		descr="Brawo, zapoznaj się koniecznie ze skryptem i forum, znajdź pracę, zostań znanym mafiozą, bądź gangsterem lub działaj przeciwko nim i zostań gliną! +10GP",
		timely=true,
		typ=1,
		value=10,
		timely=true,
		check=function(plr)
			local uid=getElementData(plr,"auth:uid")
			if not uid then return false end
			local r = exports.DB2:pobierzWyniki("select sum(playtime) suma from lss_characters where userid=?", uid)
			if not r or not r.suma then return false end
			if r and tonumber(r.suma) and tonumber(r.suma)>=60 then return true end
			return false
		end
	},
	["1st1000"]={
		name="Pierwszy tysiąc!",
		descr="Zarobiłeś/aś swoje pierwsze 1000 dolarów, gratulację! Wydaj je rozsądnie i z głową. +10GP",
		timely=true,
		typ=2,
		value=10,
		timely=true,
		check=function(plr)
			local uid=getElementData(plr,"auth:uid")
			if not uid then return false end
			-- tylko gotowka w rece
			if getPlayerMoney(plr)>=100000 then return true end
			return false
		end
	},
	["1stcar"]={
		name="Pierwszy pojazd",
		descr="w końcu dorobiłeś/aś się swojego pierwszego pojazdu! Jeździj ostrożnie!. +25GP",
		timely=true,
		chance=25,
		typ=3,
		value=25,
		check=function(plr)
			local character=getElementData(plr,"character")
			if not character or not character.id then return false end
			local r = exports.DB2:pobierzWyniki("select count(id) suma from lss_vehicles where owning_player=?", character.id)
			if not r or not r.suma then return false end
			if r and tonumber(r.suma) and tonumber(r.suma)>=1 then return true end
			return false
		end
	},
	["orgporzadk"]={
		name="Chronić i służyć!",
		descr="od dziś to Twoje motto, jesteś w organizacji porządkowej, pamiętaj o tym i miej to głęboko w sercu. +15GP",
		timely=true,
		chance=15,
		typ=2,
		value=15,
		check=function(plr)
			local character=getElementData(plr,"character")
			if not character or not character.id then return false end
			local r = exports.DB2:pobierzWyniki("select count(*) suma from lss_character_factions where character_id=? and faction_id in (2,4,6,11);", character.id)
			if not r or not r.suma then return false end
			if r and tonumber(r.suma) and tonumber(r.suma)>=1 then return true end
			return false
		end
	},
	["orgprzest"]={
		name="Od dziś jesteś z nami, bracie.",
		descr="Dostałeś/aś się do gangu po wymagającej drodze i wielu cierpniach, od dziś dumnie reprezentuj swoją grupę i nie pozwól jej zhańbić +15GP",
		timely=true,
		chance=15,
		typ=2,
		value=15,
		check=function(plr)
			local character=getElementData(plr,"character")
			if not character or not character.id then return false end
			local r = exports.DB2:pobierzWyniki("select count(*) suma from lss_character_co where character_id=?", character.id)
			if not r or not r.suma then return false end
			if r and tonumber(r.suma) and tonumber(r.suma)>=1 then return true end
			return false
		end
	},
	["biznesmen"]={
		name="Biznesmen, ha!",
		descr="od dziś jesteś sławny jako właściciel biznesu. Pora go rozkręcić i dorobić się na nim! +20GP",
		timely=true,
		chance=15,
		typ=1,
		value=20,
		check=function(plr)
			local character=getElementData(plr,"character")
			if not character or not character.id then return false end
			local r = exports.DB2:pobierzWyniki("select count(*) suma from lss_budynki_owners where character_id=?", character.id)
			if not r or not r.suma then return false end
			if r and tonumber(r.suma) and tonumber(r.suma)>=1 then return true end
			return false
		end
	},
	["bogacz"]={
		name="Bogacz",
		descr="Dorobiłeś się 100 tysięcy, masz szacunek, pokazałeś że masz smykałkę do pieniędzy i dobrze to wykorzystałeś - +50GP",
		timely=true,
		chance=15,
		typ=3,
		value=50,
		check=function(plr)
			local character=getElementData(plr,"character")
			if not character or not character.id then return false end
			local r = exports.DB2:pobierzWyniki("select money+bank_money suma from lss_characters where id=?", character.id)
			if not r or not r.suma then return false end
			if r and tonumber(r.suma) and tonumber(r.suma)>=10000000 then return true end
			return false
		end
	},
	["dom"]={
		name="Lokum.",
		descr="niezłe mieszkanie, Twoje? Tak, od teraz już Twoje, ciesz się, zaproś znajomych, parapetówka to jedyne, czego pragną w Twoim nowym domu. +10GP",
		timely=true,
		chance=15,
		typ=1,
		value=10,
		check=function(plr)
			local character=getElementData(plr,"character")
			if not character or not character.id then return false end
			local r = exports.DB2:pobierzWyniki("select count(*) suma from lss_domy where ownerid=? AND paidTo>NOW()", character.id)
			if not r or not r.suma then return false end
			if r and tonumber(r.suma) and tonumber(r.suma)>=1 then return true end
			return false
		end
	},
	["rower"]={ -- wypozyczony rower
		name="Rowerzysto, uważaj!",
		descr="wypożyczyłeś rower, wsiadaj na niego i udaj się gdziekolwiek... +5GP",
		timely=false,
		typ=1,
		value=5,
		check=function(plr)
			local pojazd=getPedOccupiedVehicle(plr)
			if not pojazd then return false end
			local pm=getElementModel(pojazd)
			if pm==481 or pm==509 or pm==510 then return true end
			return false
		end
	},
	["1stblood"]={
		name="Pierwsza krew",
		descr=" ktoś po raz pierwszy wbił Tobie stan BW (nieprzytomności), udaj się do szpitala i odegraj akcję doznanych przez Ciebie obrażeń +15GP",
		timely=false,
		typ=4,
		value=15,
		check=function(plr)
			return isPedDead(plr)
		end
	},
	["drivlicB"]={
		name="Prawo jazdy kategorii B",
		descr="W końcu otrzymałeś/aś swoje prawo jazdy! Pora rozejrzeć się za pierwszym pojazdem... +15GP",
		timely=true,
		chance=5, -- triggerowane jest recznie przy zdaniu egzaminu
		typ=3,
		value=15,
		check=function(plr)
			local character=getElementData(plr,"character")
			if not character or not character.id then return false end
			local r = exports.DB2:pobierzWyniki("select pjB from lss_characters where id=?", character.id)
			if not r or not r.pjB then return false end
			if r and tonumber(r.pjB) and tonumber(r.pjB)>=1 then return true end
			return false
		end
	},


}

local function getOldAchievements(user_id)
	local r={}
	local dane=exports.DB2:pobierzTabeleWynikow("SELECT distinct achname FROM lss_achievements_history WHERE user_id=?", user_id)
	if not dane then return r end
	for i,v in ipairs(dane) do
		r[v.achname]=true
	end
	return r
end

function checkAchievementForPlayer(plr,ach)
	local user_id=getElementData(plr,"auth:uid")
	if not user_id then return false end
	if not getElementData(plr,"GP") then return end
	local ii=getOldAchievements(user_id)
	if ii[ach] then return end
	if not achievements[ach] then return end
	v=achievements[ach]
	if v.check(plr) then
				if addPlayerGP(plr,v.value,ach) then 
					triggerClientEvent(plr, "showAchievement", resourceRoot, v.typ, v.name, v.descr)
				end
	end
	return

end


local function checkTimelyAchievementsForPlayer(plr)
	local user_id=getElementData(plr,"auth:uid")
	if not user_id then return false end
	if not getElementData(plr,"GP") then return end
	local ii=getOldAchievements(user_id)

	for i,v in pairs(achievements) do
		if v.timely and not ii[i] and (not v.chance or math.random(1,100)<=v.chance) then
			if v.check(plr) then
				if addPlayerGP(plr,v.value,i) then 
					triggerClientEvent(plr, "showAchievement", resourceRoot, v.typ, v.name, v.descr)
					return -- jest jedno? To styknie
				end
			end
		end
	end
end



local function checkTimelyAchievements()
	for i,v in ipairs(getElementsByType("player")) do
		checkTimelyAchievementsForPlayer(v)
	end
end

setTimer(checkTimelyAchievements, 5*60*1000, 0)
setTimer(checkTimelyAchievements, 5000, 1)