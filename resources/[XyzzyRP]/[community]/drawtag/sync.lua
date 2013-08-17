local function serializeTag(t)
  -- {visible = true, z2 = 23.790163, z1 = 25.288221, nz = 0, y2 = -1021.775391, nx = 0, ny = -1, y = -1021.850403, x = 1409.386353, y1 = -1021.845398, z = 24.539192, x2 = 1409.424561, pngdata = �PNG  , visibility = 90, x1 = 1409.348145}
  local pola={"z1","z2","nz","y2","nx","ny","y","x","y1","z","x2","pngdata","x1"} -- omijamy visible i visibility
  local tag={  }
  for i,v in ipairs(pola) do
	tag[v]=exports.DB:esc(getElementData(t,v))
  end
  tag.creator=getElementData(t,"creator")
  return tag
end

--[[
addCommandHandler("xxtags", function(plr)
  local zasob=getResourceRootElement(getResourceFromName("drawtag"))
  local elementy=getElementsByType("drawtag:tag", zasob)

  local cnt=0
  for i,v in ipairs(elementy) do
	if (getElementData(v,"visible") and getElementData(v,"pngdata")) then
	  cnt=cnt+1

	  local t=serializeTag(v)

	  -- x,y,z,x1,y1,z1,x2,y2,z2,ny,nx,nz,pngdata
	  -- no kurwa
	  local query=string.format("INSERT INTO lss_tagi (x,y,z,x1,y1,z1,x2,y2,z2,ny,nx,nz,pngdata) values ('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s');", 
		t.x,t.y,t.z,	t.x1,t.y1,t.z1,t.x2,t.y2,t.z2,t.ny,t.nx,t.nz, t.pngdata)
	  exports.DB:zapytanie(query);

	end
  end
  outputDebugString("tagow: " .. cnt)
  
end)
]]--
--[[
addCommandHandler("xxusuntagi", function()
  local zasob=getResourceRootElement(getResourceFromName("drawtag"))
  local elementy=getElementsByType("drawtag:tag", zasob)

  for i,v in ipairs(elementy) do
	destroyElement(v)
  end
end)
]]--

local function unhex(n)
  local out, ch = ""
  local xtrans = {
    ["0"] = 0, ["1"] = 1, ["2"] = 2, ["3"] = 3, ["4"] = 4, ["5"] = 5,
    ["6"] = 6, ["7"] = 7, ["8"] = 8, ["9"] = 9,
    A = 10, B = 11, C = 12, D = 13, E = 14, F = 15,
    a = 10, b = 11, c = 12, d = 13, e = 14, f = 15,
  }
  for c in string.gmatch(n, "[0-9A-Fa-f]") do
    if ch ~= nil then
      out, ch = out .. string.char(ch * 16 + xtrans[c])
    else ch = xtrans[c]; end
  end
  if ch then out = ch * 16 + xtrans[c]; end
  return out
end





local function saveTagToDB(v)
	if (getElementData(v,"visible") and getElementData(v,"pngdata")) then

	  local t=serializeTag(v)
	  -- x,y,z,x1,y1,z1,x2,y2,z2,ny,nx,nz,pngdata
	  -- no kurwa
	  local query=string.format("INSERT INTO lss_tagi (creator,x,y,z,x1,y1,z1,x2,y2,z2,ny,nx,nz,pngdata) values (%d,'%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s');", 
		t.creator or 0,t.x,t.y,t.z,	t.x1,t.y1,t.z1,t.x2,t.y2,t.z2,t.ny,t.nx,t.nz, t.pngdata)
--	  outputDebugString(string.sub(query,0,100))
	  exports.DB:zapytanie(query);
	  return exports.DB:insertID();
	end
	return nil;

end

local function destroyTagsOverLimit(cid,ab_spray)
  local limits="3,3"
  if (ab_spray>=99) then
	limits="7,3"
  elseif (ab_spray>90) then
	limits="6,3"
  elseif (ab_spray>=85) then
	limits="5,3"
  elseif (ab_spray>=75) then
	limits="4,3"
  end
  local query=string.format("select id from lss_tagi where creator=%d ORDER BY ts DESC LIMIT %s;", cid, limits)
  local stareid=exports.DB:pobierzTabeleWynikow(query)
  local id_do_usuniecia={}
  if (#stareid>0) then
	for _,v in ipairs(stareid) do
		local tid="tag:"..v.id
		table.insert(id_do_usuniecia, tonumber(v.id))
		local tag=getElementByID(tid)
		if (tag) then
			destroyElement(tag)
		end
	end
	query=string.format("DELETE FROM lss_tagi WHERE creator=%d AND id IN (%s)", cid, table.concat(id_do_usuniecia, ","))
	exports.DB:zapytanie(query)
  end
end

-- rejestracja tagu w bazie danych!
addEvent("drawtag:onTagFinishSpray", true)
addEventHandler("drawtag:onTagFinishSpray",root,function(player)
	if (player) then
		outputDebugString(getPlayerName(player).." finished spraying a tag.")
		local c=getElementData(player,"character")
		if not c then
			destroyElement(source)
			return
		end
		setElementData(source, "creator", tonumber(c.id),false)
		local dbid=saveTagToDB(source)
		destroyTagsOverLimit(tonumber(c.id),tonumber(c.ab_spray) or 50)
		removeElementData(source, "ts")

		if (not dbid) then
			destroyElement(source)
			return
		end
		playSoundFrontEnd(player,3)
		setElementID(source, "tag:"..dbid)
	end
end)

local function getTagID(tag)
  local id=getElementID(tag)
  if (not id) then return nil end
  return tonumber(string.sub(id,5))
end

-- usuwanie tagu z bazy danych
addEvent("drawtag:onTagFinishErase", true)
addEventHandler("drawtag:onTagFinishErase",root,function(player)
	if (player) then
		local tid=getTagID(source)
		if not tid then return end
		local query=string.format("DELETE FROM lss_tagi WHERE id=%d LIMIT 1", tid)
		exports.DB:zapytanie(query)
	end
end)


-- wczytywanie tagow przy starcie zasobu
addEventHandler("onResourceStart", resourceRoot, function()
  local eroot=getElementsByType("drawtag:tags", resourceRoot)
  eroot=eroot[1]
  if (not eroot or not isElement(eroot)) then
	outputDebugString("wczytanie tagow z bazy danych nie powiodlo sie - brak eroot")
	return
  end
  -- usuwamy stare tagi
  exports.DB:zapytanie("DELETE FROM lss_tagi WHERE datediff(NOW(),ts)>=7")
  -- pobieramy tagi
  local tagi=exports.DB:pobierzTabeleWynikow("SELECT id,x,y,z,x1,y1,z1,x2,y2,z2,ny,nx,nz,HEX(pngdata) pngdata from lss_tagi");
  outputDebugString("Tagow w bazie: " .. #tagi)
  for i,v in ipairs(tagi) do
	v.pngdata=unhex(v.pngdata)
--	outputChatBox("id: " .. v.id.. " md5 " .. md5(v.pngdata),plr)

	local tag=createElement("drawtag:tag")
	setElementParent(tag, eroot)
	local pola={"z1","z2","nz","y2","nx","ny","y","x","y1","z","x2","x1"}
	for _,pole in ipairs(pola) do
	  setElementData(tag, pole, tonumber(v[pole]))
	end
	setElementData(tag,"pngdata", v.pngdata)
	setElementData(tag,"visibility", 90)
	setElementData(tag,"visible", true)
	setElementID(tag, "tag:"..v.id)
  end
end)


-- usuwanie niedokonczonych tagow
addEvent("drawtag:onTagStartSpray", true)

addEventHandler("drawtag:onTagStartSpray",root,function()
  setElementData(source,"ts", getTickCount(), false)
end)

local function purgeUnfinishedTags()
  local tagi=getElementsByType("drawtag:tag", resourceRoot)
  for i,v in ipairs(tagi) do
	local ts=getElementData(v,"ts")
	if (ts and getTickCount()-tonumber(ts)>1000*60*2) then
		destroyElement(v)
--		outputDebugString("Removing unfinished tag")
	end
  end
end

setTimer(purgeUnfinishedTags, 1000*60*3, 0)