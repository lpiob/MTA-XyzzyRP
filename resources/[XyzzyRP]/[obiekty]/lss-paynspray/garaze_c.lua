
garaze_win = guiCreateWindow(0.7766,0.3042,0.1766,0.5167,"Lakiernia",true)
garaze_lbl = guiCreateLabel(0.0885,0.1169,0.7965,0.1935,"Tylko dla pracowników warsztatu!",true,garaze_win)
guiLabelSetHorizontalAlign(garaze_lbl, "center", true)
garaze_btnup = guiCreateButton(0.1062,0.3508,0.7788,0.2702,"Otwórz",true,garaze_win)
garaze_btndown = guiCreateButton(0.115,0.7016,0.7699,0.2702,"Zamknij",true,garaze_win)


guiSetVisible(garaze_win, false)

--

local aktywny_garaz=nil

local panele_garazy={
-- x,y,z, id garazu

    { 2072.01,-1828.77,13.55,8},    
--    { 2070.98,-1828.33,13.55,8},
	{ 2070.98,-1834.32,13.55,8 }


    }
    
for i,v in ipairs(panele_garazy) do
    v.cs=createColSphere(v[1],v[2],v[3],0.5)
    setElementData(v.cs,"garaz:panel", true, false)
end

local function findGarazID(el)
    for i,v in ipairs(panele_garazy) do
	if v.cs==el then return i end
    end
    return nil
end

addEventHandler("onClientColShapeHit", resourceRoot, function(el, md)
    if (not md) then return end
    if (el~=localPlayer) then return end
    if (not getElementData(source,"garaz:panel")) then return end
    aktywny_garaz=findGarazID(source)
    if (aktywny_garaz) then
        guiSetVisible(garaze_win, true)
    else -- nie powinno sie zdarzyc
	guiSetVisible(garaze_win, false)
    end
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(el, md)
    if (not md) then return end
    if (el~=localPlayer) then return end
    if (not getElementData(source,"garaz:panel")) then return end
    aktywny_garaz=nil
    guiSetVisible(garaze_win, false)
end)


function garazeSteruj()

    if (not aktywny_garaz) then return end	-- nie powinno sie zdarzyc
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wciska guzik przy panelu.", 5, 10, true)
	triggerServerEvent("setPedAnimation", localPlayer, "CRIB", "CRIB_Use_Switch", -1, false, false, true, false)
    local cf=getElementData(localPlayer, "faction:name")
    if (not cf or cf~="Warsztat I") then return end
    local stan=false	-- 1==gora
    if (source==garaze_btnup) then
	stan=true
    end
    triggerServerEvent("setGarageOpen", root, panele_garazy[aktywny_garaz][4], stan)

end

addEventHandler("onClientGUIClick", garaze_btnup, garazeSteruj,false)
addEventHandler("onClientGUIClick", garaze_btndown, garazeSteruj,false)