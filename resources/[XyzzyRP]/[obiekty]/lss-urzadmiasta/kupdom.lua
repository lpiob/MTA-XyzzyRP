-- rejestracja pojazdow

local D=1
local I=1

--local rp_marker=createMarker(1469.22,-1802.14,1162.06,"cylinder",1)
--setElementInterior(rp_marker, I)
--setElementDimension(rp_marker, D)


local rp_text=createElement("text")
setElementPosition(rp_text, 1469.26,-1779.97,1195.96)
setElementData(rp_text, "text", "Kupno\ndomów")
setElementInterior(rp_text, I)
setElementDimension(rp_text, D)

local rp_npc=createPed(57,1467.03,-1779.97,1195.96,270,false)
setElementInterior(rp_npc, I)
setElementDimension(rp_npc, D)
setElementData(rp_npc, "npc", true)
setElementData(rp_npc, "name", "Urzędnik")

addEvent("onUmDomyWantInfo", true)
addEventHandler("onUmDomyWantInfo", getRootElement(), function(id)
	local data = exports.DB2:pobierzWyniki("SELECT d.id,d.descr,d.vwi,d.drzwi,d.punkt_wyjscia,d.interiorid,d.ownerid,concat(c.imie,' ',c.nazwisko) owner_nick,d.zamkniety,d.koszt,d.paidTo,datediff(d.paidTo,now()) paidTo_dni FROM lss_domy d LEFT JOIN lss_characters c ON c.id=d.ownerid WHERE d.active=1 and d.id=?;",id)
	triggerClientEvent(source, "onUmDomyWantInfoCompleted", getRootElement(), data)
end)