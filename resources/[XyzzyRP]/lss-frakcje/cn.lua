--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


addEvent("doRefreshNews", true)

local lastWywiadMsg=getTickCount()-30000

local wiadomosci={
--  "Ogłoszenie prywatne: sprzedam broń białą. Kontakt: wysypisko śmieci",
--  "Pilnie poszukiwany kierownik warsztatu samochodowego. Podanie można złożyć u burmistrza!",
--  "Trwa nabór do CNN News - poszukiwany redaktor naczelny. Złóż swoje podanie!" 
}

function announcement()
    if (#wiadomosci<1) then return end
    if (getTickCount()-lastWywiadMsg<30000) then return end
  local rid=math.random(0,#wiadomosci)
  if (rid==0) then
	local pp=exports["lss-weather"].getPrognoza()
	triggerClientEvent(root, "onCNAnnouncement", root, "Prognoza pogody: " .. pp[1].nazwa .. ". Później: " .. pp[2].nazwa .. ".")
  else
    triggerClientEvent(root, "onCNAnnouncement", root, wiadomosci[rid])
  end

  local odstep=30000
  -- 1 = 5*60000
  -- 5 = 30000
  if (#wiadomosci<=5) then
	  odstep=odstep+((5-#wiadomosci)*30000)
  end
  setTimer(announcement, odstep, 1)
end



setTimer(announcement, 5000, 1)


--triggerClientEvent(root, "onCaptionedEvent", root, "", 20, {55,55,0})
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
local function fetchNews()
    local ogloszenia=exports.DB:pobierzWyniki("select tresc from lss_infoboards where id=9")
    if (not ogloszenia) then return end
    wiadomosci=split(ogloszenia.tresc,"\n")
end

addEventHandler("doRefreshNews", resourceRoot, fetchNews)

fetchNews()

addEvent("doPublishWywiadMsg", true)
addEventHandler("doPublishWywiadMsg", root, function(tekst)
    lastWywiadMsg=getTickCount()
    triggerClientEvent(root, "onCNAnnouncement", root, string.gsub(getPlayerName(source),"_", " ")..": " .. tekst, "Wywiad")
end)