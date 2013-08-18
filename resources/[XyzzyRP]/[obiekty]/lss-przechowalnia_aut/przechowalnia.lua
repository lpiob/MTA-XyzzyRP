-- 2877.96,-1820.72,11.16,13.2
-- 2870.71,-1814.30,12.06,40.5
local cs_wydawanie=createColCuboid(2870.7,-1820.3,10,7.2,6,3)

local function pojazdNaParkingu(vid)
  local query=string.format("SELECT 1 FROM lss_vehicles WHERE id=%d AND przechowalnia=1", vid)
  local wynik=exports.DB:pobierzWyniki(query)
  return (wynik and true or false)
end

local function czyStrefaWydawaniaWolna()
  local p=getElementsWithinColShape(cs_wydawanie, "vehicle")
  for i,v in ipairs(p) do
	setElementFrozen(v,false)
  end
  if #p>0 then return false end
  return true
end

-- triggerServerEvent("doOdbiorPojazdu", resourceRoot, localPlayer, kid)
addEvent("doOdbiorPojazdu", true)
addEventHandler("doOdbiorPojazdu", resourceRoot, function(plr, vid)

  if not vid or not tonumber(vid) then
	outputChatBox("* Na wyświetlaczu urządzenia pojawia się napis ERROR", plr)
	return
  end

  if not pojazdNaParkingu(vid) then
	outputChatBox("* Na wyświetlaczu pojawia się informacja: tego pojazdu nie ma na parkingu." ,plr)
	return
  end

  if not czyStrefaWydawaniaWolna() then
	outputChatBox("* Na wyświetlaczu pojawia się informacja: brak miejsca przed bramą. Nie można wydać pojazdu." ,plr)
	return
  end

  takePlayerMoney(plr, 500)

  -- no to jedziemy z koksem!
  local query=string.format("UPDATE lss_vehicles SET przechowalnia=0,frozen=0,loc='2874.10,-1817.74,13.08',rot='0,0,90' WHERE id=%d LIMIT 1", vid)
  exports.DB:zapytanie(query)

  exports["lss-vehicles"]:veh_load(tonumber(vid))
  outputChatBox("* Na wyświetlaczu pojawia się napis: pojazd wydany!", plr)
  triggerClientEvent(plr, "doHideWindows", resourceRoot)
end)

local function czyGraczMozeZostawicPojazd(plr, vid, veh)
  -- 1 nie przyjmujemy pojazdow frakcyjnych
  if (getElementData(veh,"owning_faction")) then
	  return false
  end

  -- 2 policja/sm moze oddac kazdy pojazd
  local fid=getElementData(plr, "faction:id")
  if fid then
	  if tonumber(fid)==2 or tonumber(fid)==4 then
		  return true
	  end
  end

  -- 3. tylko wlasciciel moze oddac pojazd
  local c=getElementData(plr,"character")
  if not c then return false end
  local cid=tonumber(c.id)
  if not cid then return false end
  local query=string.format("SELECT 1 FROM lss_vehicles WHERE id=%d AND owning_player=%d", vid, cid)
  local wynik=exports.DB:pobierzWyniki(query)
  if wynik then return true else return false end
end

local function znajdzPojazd(id)
	for i,v in ipairs(getElementsByType("vehicle")) do
	  local dbid=getElementData(v,"dbid")
	  if dbid and tonumber(dbid)==tonumber(id) then
		    return v
	  end
    end
	return nil
end

-- triggerServerEvent("doZostawieniePojazdu", resourceRoot, localPlayer, kid)
addEvent("doZostawieniePojazdu", true)
addEventHandler("doZostawieniePojazdu", resourceRoot, function(plr, vid)
	vid=tonumber(vid)
	local veh=znajdzPojazd(vid)
	if not veh then
		outputChatBox("* Na wyświetlaczu pojawia się napis: ERROR.", plr)
		return
	end
	if not czyGraczMozeZostawicPojazd(plr,vid, veh) then
		outputChatBox("* Na wyświetlaczu pojawia się napis: pojazd moze oddac tylko wlasciciel lub sm/policja", plr)
		return
	end
	-- zostawiamy
	destroyElement(veh)
	local query=string.format("UPDATE lss_vehicles SET przechowalnia=1 WHERE id=%d", vid)
	exports.DB:zapytanie(query)
	outputChatBox("* Na wyświetlaczu pojawia się napis: pojazd został przyjęty.", plr)
	triggerClientEvent(plr, "doHideWindows", resourceRoot)
end)