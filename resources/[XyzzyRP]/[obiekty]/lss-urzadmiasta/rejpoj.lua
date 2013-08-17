-- rejestracja pojazdow

local D=1
local I=1

--local rp_marker=createMarker(1469.22,-1802.14,1162.06,"cylinder",1)
--setElementInterior(rp_marker, I)
--setElementDimension(rp_marker, D)


local rp_text=createElement("text")
setElementPosition(rp_text, 1469.23,-1798.99,1165.96)
setElementData(rp_text, "text", "Rejestacja\npojazdów")
setElementInterior(rp_text, I)
setElementDimension(rp_text, D)

local rp_npc=createPed(57,1467.02,-1798.99,1162.95,270,false)
setElementInterior(rp_npc, I)
setElementDimension(rp_npc, D)
setElementData(rp_npc, "npc", true)
setElementData(rp_npc, "name", "Urzędnik")

addEvent("rejestrujPojazd", true)
addEventHandler("rejestrujPojazd", resourceRoot, function(plr,pojazd)

--    if (getPlayerName(plr)~="Shawn_Hanks") then return end
    if (getPlayerMoney(plr)<200) then
	outputChatBox("Urzędnik mówi: nie stać Pana/ią na rejestrację tego pojazdu", plr)
	return
    end
    local c=getElementData(plr, "character")
    if not c then return end

    local danepojazdu=exports.DB:pobierzWyniki(string.format("select owning_player,owning_faction from lss_vehicles where id=%d", pojazd))
    if not danepojazdu then
	outputChatBox("Urzędnik mówi: z naszych zapisów wynika, że ten pojazd został oddany do utylizacji.", plr)
	return
    end
    if danepojazdu.owning_faction and type(danepojazdu.owning_faction)~="userdata" then
	outputChatBox("Urzędnik mówi: ten pojazd jest własnością organizacji publicznej/firmy, nie ma możliwości jego przerejestrowania w okienku.", plr)
	outputChatBox(" Proszę zgłosić się w tej sprawie do burmistrza.", plr)
	return
    end
    if danepojazdu.owning_player and type(danepojazdu.owning_player)~="userdata" then
	if (tonumber(danepojazdu.owning_player)==tonumber(c.id)) then
	    outputChatBox("Urzędnik mówi: ten pojazd jest już Pana/i własnością.", plr)
	    return
	end
	outputChatBox("Urzędnik mówi: ten pojazd jest już właśnością innej osoby.", plr)
	return
    end
    
    takePlayerMoney(plr,200)
    setTimer(function()
        triggerEvent("broadcastCaptionedEvent", plr, "Urzędnik chowa dokumenty do szuflady.", 5, 15, true)
    end, 500, 1)
    
    local query=string.format("UPDATE lss_vehicles SET owning_player=%d WHERE id=%d", c.id, pojazd)
    exports.DB:zapytanie(query)
    outputChatBox("Urzędnik mówi: pojazd został zarejestrowany na Pana/i osobę.", plr)
    
end)