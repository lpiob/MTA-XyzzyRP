local I=4
local D=18
local bramka_cs=createColSphere(295.14,-78.82,1001.52,1)
setElementInterior(bramka_cs,I)
setElementDimension(bramka_cs,D)
local bramka2_cs=createColSphere(285.94,-85.72,1001.52,2)
setElementInterior(bramka2_cs,I)
setElementDimension(bramka2_cs,D)


addEventHandler("onClientColShapeHit", bramka_cs, function(el,md)

    if el~=localPlayer then return end
    if not md then return end

    local rz=getPedRotation(localPlayer)
--    if (rz<180) then        -- ped wychodzi
        if (exports["lss-gui"]:eq_getItemByID(152) or exports["lss-gui"]:eq_getItemByID(153) or exports["lss-gui"]:eq_getItemByID(135) or exports["lss-gui"]:eq_getItemByID(113)) then        -- gracz posiada pistolet szkoleniowy
                exports["lss-gui"]:eq_takeItem(113)	--karabin szkoleniowy
                exports["lss-gui"]:eq_takeItem(135)	--amunicja do karabinu szkoleniowego
				exports["lss-gui"]:eq_takeItem(152)	--pistolet szkoleniowy
                exports["lss-gui"]:eq_takeItem(153)	--amunicja do pistoletu szkoleniowego
                triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " oddaje broń ochroniarzowi.", 5, 5, true)
                playSoundFrontEnd(5)
--        end
    end
end)

addEventHandler("onClientColShapeHit", bramka2_cs, function(el,md)

    if el~=localPlayer then return end
    if not md then return end

    local rz=getPedRotation(localPlayer)
--    if (rz<180) then        -- ped wychodzi
        if (exports["lss-gui"]:eq_getItemByID(152) or exports["lss-gui"]:eq_getItemByID(153) or exports["lss-gui"]:eq_getItemByID(135) or exports["lss-gui"]:eq_getItemByID(113)) then        -- gracz posiada pistolet szkoleniowy
                exports["lss-gui"]:eq_takeItem(113)	--karabin szkoleniowy
                exports["lss-gui"]:eq_takeItem(135)	--amunicja do karabinu szkoleniowego
				exports["lss-gui"]:eq_takeItem(152)	--pistolet szkoleniowy
                exports["lss-gui"]:eq_takeItem(153)	--amunicja do pistoletu szkoleniowego
                triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " oddaje broń ochroniarzowi.", 5, 5, true)
                playSoundFrontEnd(5)
--        end
    end
end)

addEventHandler("onClientColShapeLeave", bramka2_cs, function(el,md)
    if el~=localPlayer then return end


    local rz=getPedRotation(localPlayer)
--    if (rz<180) then        -- ped wychodzi
        if (exports["lss-gui"]:eq_getItemByID(152) or exports["lss-gui"]:eq_getItemByID(153) or exports["lss-gui"]:eq_getItemByID(135) or exports["lss-gui"]:eq_getItemByID(113)) then        -- gracz posiada pistolet szkoleniowy
                exports["lss-gui"]:eq_takeItem(113)	--karabin szkoleniowy
                exports["lss-gui"]:eq_takeItem(135)	--amunicja do karabinu szkoleniowego
				exports["lss-gui"]:eq_takeItem(152)	--pistolet szkoleniowy
                exports["lss-gui"]:eq_takeItem(153)	--amunicja do pistoletu szkoleniowego
                triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " oddaje broń ochroniarzowi.", 5, 5, true)
                playSoundFrontEnd(5)
--        end
    end
end)