
function menu_brama(argumenty)
--    if (not exports["lss-gui"]:eq_getItemByID(14)) then
--		outputChatBox("Nie masz klucza do bramy.", 255,0,0,true)
--		return
--    end

    triggerServerEvent("onWarsztat1BramaToggleRequest", resourceRoot, localPlayer)	-- pi
end




-- gui od podnosnikow

podnosniki_win = guiCreateWindow(0.7766,0.3042,0.1766,0.5167,"Podnoœnik",true)
podnosniki_lbl = guiCreateLabel(0.0885,0.1169,0.7965,0.1935,"Tylko dla pracowników warsztatu!",true,podnosniki_win)
guiLabelSetHorizontalAlign(podnosniki_lbl, "center", true)
podnosniki_btnup = guiCreateButton(0.1062,0.3508,0.7788,0.2702,"Góra",true,podnosniki_win)
podnosniki_btndown = guiCreateButton(0.115,0.7016,0.7699,0.2702,"Dó³",true,podnosniki_win)


guiSetVisible(podnosniki_win, false)

--

local aktywny_panel=nil

local panele_podnosnikow={
    { 1854.39,-1785.68,13.63},	-- podnosnik nr 1 maly
    { 1900.76,-1785.79,13.63},  -- podnosnik nr 2 duzy
    -- kolejnosc jest kluczowa
    }
    
for i,v in ipairs(panele_podnosnikow) do
    v.cs=createColSphere(v[1],v[2],v[3],0.5)
    setElementData(v.cs,"warsztat:panel", true, false)
end

local function findPanelID(el)
    for i,v in ipairs(panele_podnosnikow) do
	if v.cs==el then return i end
    end
    return nil
end

addEventHandler("onClientColShapeHit", resourceRoot, function(el, md)
    if (not md) then return end
    if (el~=localPlayer) then return end
    if (not getElementData(source,"warsztat:panel")) then return end
    aktywny_panel=findPanelID(source)
    if (aktywny_panel) then
        guiSetVisible(podnosniki_win, true)
    else -- nie powinno sie zdarzyc
	guiSetVisible(podnosniki_win, false)
    end
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(el, md)
    if (not md) then return end
    if (el~=localPlayer) then return end
    if (not getElementData(source,"warsztat:panel")) then return end
    aktywny_panel=nil
    guiSetVisible(podnosniki_win, false)
end)


function podnosnikiSteruj()
    if (not aktywny_panel) then return end	-- nie powinno sie zdarzyc
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wciska guzik przy panelu.", 5, 10, true)
    local cf=getElementData(localPlayer, "faction:name")
    if (not cf or cf~="Warsztat I") then return end
    local stan=0	-- 1==gora
    if (source==podnosniki_btnup) then
	stan=1
    end
    triggerServerEvent("onWarsztatPodnosnikSterowanie", resourceRoot, aktywny_panel, stan)

end

addEventHandler("onClientGUIClick", podnosniki_btnup, podnosnikiSteruj,false)
addEventHandler("onClientGUIClick", podnosniki_btndown, podnosnikiSteruj,false)