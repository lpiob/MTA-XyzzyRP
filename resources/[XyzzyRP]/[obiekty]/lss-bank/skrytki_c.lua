local D=15
local I=1

local skrytki={
    { 1695.58,254.34,1419.32 },
    { 1697.98,257.63,1419.32 },
    { 1700.19,253.29,1419.32 }
}

for i,v in ipairs(skrytki) do
    v.marker=createMarker(v[1],v[2],v[3],"cylinder", 1, 0,255,0, 50)
    setElementDimension(v.marker, D)
    setElementInterior(v.marker,I)
end

addEventHandler("onClientMarkerHit", resourceRoot, function(el,md)
    if (not md) then return end
    if (el~=localPlayer) then return end
--    outputChatBox("(( skrytki bankowe w przygotowaniu ))")
--    if (getPlayerName(el)=="Shawn_Hanks" or getPlayerName(el)=="Peter_O'Connor" or getPlayerName(el)=="Dozer_Baltaar" or getPlayerName(el)=="Matthew_Trance") then
	exports["lss-pojemniki"]:otworzPojemnik(-1)
--    end
end)

addEventHandler("onClientMarkerLeave", resourceRoot, function(el,md)
--    outputDebugString("a")
--    outputDebugString("b")
    if (el~=localPlayer) then return end

    exports["lss-pojemniki"]:zamknijPojemnik(-1)
end)