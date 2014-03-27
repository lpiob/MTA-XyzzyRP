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


function stripColors(text)
	return string.gsub(text,"#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]","")
end

function shuffle(t)
  local n = #t
    while n >= 2 do
        -- n is now the last pertinent index
        local k = math.random(n) -- 1 <= k <= n
        -- Quick swap
        t[n], t[k] = t[k], t[n]
        n = n - 1
      end
    return t
end

function isAdmin(plr)
	local accName = getAccountName ( getPlayerAccount ( plr ) )
	if accName and isObjectInACLGroup ("user."..accName, aclGetGroup ( "Administrator" ) ) then
	  return true
	end
	return false
end

function isInvisibleAdmin(plr)
	local accName = getAccountName ( getPlayerAccount ( plr ) )
	if accName and isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) and not isObjectInACLGroup ("user."..accName, aclGetGroup ( "Administrator" ) ) then
	  return true
	end
	return false
end




function isSupport(plr)
	local accName = getAccountName ( getPlayerAccount ( plr ) )
	if accName and isObjectInACLGroup ("user."..accName, aclGetGroup ( "Support" ) ) then
	  return true
	end
	return false
end
