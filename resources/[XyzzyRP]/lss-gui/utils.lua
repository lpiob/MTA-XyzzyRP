-- credits: Aibo@#mta.scripting@irc.gtanet.com
function simple_table_compare(t1,t2) local i = 1 while i <= math.max(#t1, #t2) do if t1[i] ~= t2[i] then return false end i = i + 1 end return true end

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

function findRotation(startX, startY, targetX, targetY)	-- Doomed-Space-Marine
	local t = -math.deg(math.atan2(targetX - startX, targetY - startY))
	
	if t < 0 then
		t = t + 360
	end
	
	return t
end

