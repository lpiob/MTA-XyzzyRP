--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



setTimer(function()
    local ilosc=#getElementsByType("player") or 0
    local query=string.format("insert into lss_currentstats set name='online_players',value_i=%d ON DUPLICATE KEY UPDATE value_i=%d", ilosc, ilosc)
    exports.DB:zapytanie(query)
end, 31000, 0)

setTimer(function()
	local dane={}
	local gracze=getElementsByType("player")
	for i,v in ipairs(gracze) do
	  local c=getElementData(v,"character")
	  if c then
		table.insert(dane, { tonumber(c.id), c.imie.." "..c.nazwisko, c.skin, getElementData(v,"auth:uid"), (getElementData(v,"premium") and 1 or 0), getElementData(v,"auth:login") })
	  end
	end
	dane=exports.DB:esc(toJSON(dane))
    local query=string.format("insert into lss_currentstats set name='online_players',value_t='%s' ON DUPLICATE KEY UPDATE value_t='%s'", dane, dane)
    exports.DB:zapytanie(query)

end, 53000, 0)