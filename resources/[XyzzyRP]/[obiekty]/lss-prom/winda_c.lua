
garaze_win = guiCreateWindow(0.7766,0.3042,0.1766,0.5167,"Winda towarowa",true)
garaze_lbl = guiCreateLabel(0.0885,0.1169,0.7965,0.1935,"Obsluga tylko przez wykwalifikowany personel.",true,garaze_win)
guiLabelSetHorizontalAlign(garaze_lbl, "center", true)
garaze_btnup = guiCreateButton(0.1062,0.3508,0.7788,0.2702,"Góra",true,garaze_win)
garaze_btndown = guiCreateButton(0.115,0.7016,0.7699,0.2702,"Dół",true,garaze_win)

guiSetVisible(garaze_win, false)
--

local panele_garazy={
    { 2664.05,-2713.48-10.8,12.84+5.4453001022339,352.8 },
	{2663.96,-2730.97-10.8,12.83+5.4453001022339,182.6},
	{2664.02,-2731.08-10.8,5.83+5.4453001022339,173.6},
	{2664.18,-2713.46-10.8,5.84+5.4453001022339,8.4},
    }
    
for i,v in ipairs(panele_garazy) do
    v.cs=createColSphere(v[1],v[2],v[3],0.5)
    setElementData(v.cs,"winda:panel", true, false)
end

local function windaCzynna()
  local winda=getElementByID("winda_w_porcie")
  if (not winda) then return false end -- nie powinno sie zdarzyc
  if getElementAlpha(winda)<255 then return false end -- winda nie jest widoczna bo statek jeszcze nie przyplynal
  return true
end

addEventHandler("onClientColShapeHit", resourceRoot, function(el, md)
    if (not md) then return end
    if (el~=localPlayer) then return end
    if (not getElementData(source,"winda:panel")) then return end
	if not windaCzynna() then return end
    guiSetVisible(garaze_win, true)
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(el, md)
    if (not md) then return end
    if (el~=localPlayer) then return end
    if (not getElementData(source,"winda:panel")) then return end
    guiSetVisible(garaze_win, false)
end)


function garazeSteruj()
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wciska guzik przy panelu.", 5, 10, true)
	triggerServerEvent("setPedAnimation", localPlayer, "CRIB", "CRIB_Use_Switch", -1, false, false, true, false)

    local stan=false	-- 1==gora
    if (source==garaze_btnup) then
  	stan=true
    end
    triggerServerEvent("poruszWinda", resourceRoot, stan)

end

addEventHandler("onClientGUIClick", garaze_btnup, garazeSteruj,false)
addEventHandler("onClientGUIClick", garaze_btndown, garazeSteruj,false)