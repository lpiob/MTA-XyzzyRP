-- 1279 2891. 
-- 1575-1580

local WORLDITEMS_LIMIT=300

local function createItem(i)
  -- nulle
  if (type(i.fprint)=="userdata") then i.fprint=nil end
  if (type(i.subtype)=="userdata") then i.subtype=nil end

  i.x,i.y,i.z,i.interior,i.dimension=tonumber(i.x),tonumber(i.y),tonumber(i.z),tonumber(i.interior),tonumber(i.dimension)

  local o=createObject(1575,i.x,i.y,i.z)
  setElementInterior(o,i.interior)
  setElementDimension(o,i.dimension)
  setElementID(o, "o_"..i.id)
  
  i.id=tonumber(i.id)
  i.x,i.y,i.z,i.interior,i.dimension=nil,nil,nil,nil,nil
  setElementData(o, "item:data", i)

end

local function loadWorldItems()
  local query="select wi.id,wi.itemid,i.name itemname,wi.count,wi.subtype,wi.x,wi.y,wi.z,wi.interior,wi.dimension,wi.fprint FROM lss_worlditems wi JOIN lss_items i ON i.id=wi.itemid";
  local przedmioty=exports.DB:pobierzTabeleWynikow(query)
  outputDebugString("WI: ".. #przedmioty .. " przedmiotow")
  for i,v in ipairs(przedmioty) do
	createItem(v)
  end
end


loadWorldItems()
