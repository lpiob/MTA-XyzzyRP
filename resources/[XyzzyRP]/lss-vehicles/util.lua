
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

-- http://forum.luahub.com/index.php?topic=2646.0
function replaceChar(str,idx,rep)
    local pat="^(" -- start counting at the beginning, and capture the preceding characters
    pat = pat .. ("."):rep(idx-1) -- count idx-1 characters before the one to replace
    pat = pat .. ").(.*)$" -- stop capturing the characters before, exclude the character to be replaced, and capture the trailing chars
    return string.gsub(str,pat,"%1"..rep.."%2") -- replace the pattern by: preceding chars, replacement, trailing chars.
end