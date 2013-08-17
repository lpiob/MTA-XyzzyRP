-- http://lua-users.org/wiki/DayOfWeekAndDaysInMonthExample

local D=1
local I=1

local dowody_marker=createMarker(1469.26,-1781.94,1162.96-1,"cylinder",1.1)
setElementInterior(dowody_marker, I)
setElementDimension(dowody_marker, D)


local dowody_text=createElement("text")
setElementPosition(dowody_text, 1469.26,-1781.94,1165.96)
setElementData(dowody_text, "text", "Dowody\ntożsamości")
setElementInterior(dowody_text, I)
setElementDimension(dowody_text, D)

local dowody_npc=createPed(57,1467.02,-1781.94,1162.95,270,false)
setElementInterior(dowody_npc, I)
setElementDimension(dowody_npc, D)
setElementData(dowody_npc, "npc", true)
setElementData(dowody_npc, "name", "Urzędnik")


local function wydajDowod(komu)
  if (not isElementWithinMarker(komu, dowody_marker)) then
	return
  end
  local c=getElementData(komu,"character")
  if not c then	-- shouldnt happen
--	outputChatBox("Urzędnik mówi: przykro mi, nie widze Pana w naszej bazie danych", el)
	return
  end

  local query=string.format("SELECT character_id FROM lss_um_dowody WHERE character_id=%d", c.id)
  local dane=exports.DB:pobierzWyniki(query)
  if (dane) then
	outputChatBox("Urzędnik mówi: odebrał Pan już dowód", komu)
	return
  end


  outputChatBox("* Urzędnik podaje Ci dowód", komu)
  exports["lss-core"]:eq_giveItem(komu, 46, 1, tonumber(c.id))
  query=string.format("INSERT INTO lss_um_dowody SET character_id=%d", c.id)
  exports.DB:zapytanie(query)
end



addEventHandler("onMarkerHit", dowody_marker, function(el,md)
  if (getElementType(el)~="player") then return end
  if getElementInterior(el)~=I or getElementDimension(el)~=D then return end
  local c=getElementData(el,"character")
  if not c then	-- shouldnt happen
	outputChatBox("Urzędnik mówi: przykro mi, nie widze Pana w naszej bazie danych", el)
	return
  end
  local query=string.format("SELECT id,rasa,data_urodzenia FROM lss_characters WHERE id=%d", c.id)
  outputDebugString(query)
  local dane=exports.DB:pobierzWyniki(query)
  if (not dane.id) then -- shouldnt happen
	outputChatBox("Urzędnik mówi: przykro mi, nie widze Pana w naszej bazie danych...", el)
	return
  end
  if (not dane.rasa or not dane.data_urodzenia or type(dane.rasa)=="userdata" or type(dane.data_urodzenia)=="userdata") then
	outputChatBox("Urzędnik mówi: przed wydaniem dokumentu tożsamości, proszę o uzupełnienie tego formularza...", el)
	triggerClientEvent(el, "onFormularzDanychDoDowodu", resourceRoot)
	return
  end
  wydajDowod(el)
end)


addEvent("onZapisDanychDowodu", true)
addEventHandler("onZapisDanychDowodu", resourceRoot, function(gracz, wiek, rasa)
  if (not isElementWithinMarker(gracz, dowody_marker)) then
		outputChatBox("(( Chciał(a)byś oddać forularz urzędnikowi, ale nie stoisz już przy okienku! ))", gracz)
		return
  end
  local c=getElementData(gracz,"character")
  if not c then	-- shouldnt happen
--	outputChatBox("Urzędnik mówi: przykro mi, nie widze Pana w naszej bazie danych", el)
	return
  end
  local query=string.format("SELECT id,rasa,data_urodzenia FROM lss_characters WHERE id=%d", c.id)
  outputDebugString(query)
  local dane=exports.DB:pobierzWyniki(query)
  if (not dane.id) then -- shouldnt happen
--	outputChatBox("Urzędnik mówi: przykro mi, nie widze Pana w naszej bazie danych...", el)
	return
  end
  if (not dane.rasa or not dane.data_urodzenia or type(dane.rasa)=="userdata" or type(dane.data_urodzenia)=="userdata") then
	-- zapisujemy dane do bazy danych
	if (rasa==1) then rasa="biala"
	elseif (rasa==2) then rasa="czarna"
	elseif (rasa==3) then rasa="zolta"
	else rasa="nieznana" end
	local rd=math.random(1,360)
	query=string.format("UPDATE lss_characters SET data_urodzenia=NOW() - INTERVAL %d YEAR + INTERVAL %d DAY,rasa='%s' WHERE id=%d LIMIT 1", wiek,rd,exports.DB:esc(rasa), c.id)
	exports.DB:zapytanie(query)
	wydajDowod(gracz)
  end
end)