--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local warns=0

local lx,ly,lz=0,0,0        -- polozenie
local rx,ry,rz=0,0,0        -- obrot

local function afkcheck()
        if (getElementData(localPlayer,"admin:rank") or 0)==1 then return end
--        if not (getElementData(localPlayer, "kary:blokada_aj") and getElementData(localPlayer, "kary:blokada_aj")>0) then return end
        if getCameraTarget()~=localPlayer and not getPedOccupiedVehicle(localPlayer) then return end

        local _,_,_,tarx,tary,tarz = getCameraMatrix()

        if (true) then --sprawdzamy, czy kamera sie obrocila
                clX = tarx
                clY = tary
                clZ = tarz
                local nx,ny,nz=getElementPosition(localPlayer)
                nx,ny,nz=math.floor(nx/10),math.floor(ny/10),math.floor(nz/10)
                local nrx,nry,nrz=getElementRotation(localPlayer)
                nrx,nry,nrz=math.floor(nrx/10),math.floor(nry/7),math.floor(nrz/10)
                if (nx==lx and ny==ly and nz==lz) or (nrx==rx and nry==ry and nrz==rz) then        -- brak zmiany pozycji przez minute OR brak zmiany rotacji
                        warns=warns+1
                elseif (warns>0) then
                        warns=warns-2
                        if (warns<0) then warns=0 end
                        lx,ly,lz=nx,ny,nz
                        rx,ry,rz=nrx,nry,nrz
                        return
                end

                lx,ly,lz=nx,ny,nz
                rx,ry,rz=nrx,nry,nrz

                setElementData(localPlayer, "afk", warns)
--                if (warns>9) and (getElementData(localPlayer, "kary:blokada_aj") and getElementData(localPlayer, "kary:blokada_aj")>0) then
                if (warns>10) then
                        triggerEvent("onPlayerWarningReceived",localPlayer,"Rusz się, albo dostaniesz kicka za AFK.")
                end
--                if (warns>4) and (getElementData(localPlayer, "kary:blokada_aj") and getElementData(localPlayer, "kary:blokada_aj")>0) then        -- 5 minut
                if (warns>15) then

                        triggerServerEvent("afkKick", getRootElement(), localPlayer)
                        end
--                outputChatBox("Ostrzezen: " .. warns)
        end
end



addEventHandler("onClientResourceStart",resourceRoot, function()
        lx,ly,lz=getElementPosition(localPlayer)
        rx,ry,rz=getElementRotation(localPlayer)
        lx=math.floor(lx/3)
        ly=math.floor(ly/3)
        lz=math.floor(lz/3)
        local _,_,_,tarx,tary,tarz = getCameraMatrix()
        clX = tarx
        clY = tary
        clZ = tarz
        lastDetectorTick = getTickCount()
        afktimer = setTimer ( afkcheck, 60000, 0)
        setElementData(localPlayer,"afk",0)
end)


addEventHandler("onClientCursorMove",getRootElement(), function()
        if (afktimer and (getTickCount()-lastDetectorTick >= 1000)) then
                lastDetectorTick = getTickCount()
                killTimer(afktimer)
                warns=0
                setElementData(localPlayer, "afk", false)
                afktimer = setTimer(afkcheck, 60000, 0)
        end
end)

addEventHandler("onClientClick",getRootElement(), function()
        if (afktimer and (getTickCount()-lastDetectorTick >= 1000)) then
                lastDetectorTick = getTickCount()
                killTimer(afktimer)
                warns=0
                setElementData(localPlayer, "afk", false)
                afktimer = setTimer(afkcheck, 60000, 0)
        end
end)

addEventHandler("onClientClick", getRootElement(), function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, el)
        if not el then return end
        if (getElementType(el)~="player") then return end
        if not getElementData(el, "afk") then return end
        if getElementData(el, "afk")==0 then return end
        if state ~= "down" then return end
        outputChatBox("(( Gracz jest AFK od "..getElementData(el, "afk").." minut ))")
end)

addEventHandler("onClientKey",getRootElement(), function()
        if (afktimer and (getTickCount()-lastDetectorTick >= 1000)) then
                lastDetectorTick = getTickCount()
                killTimer(afktimer)
                warns=0
                setElementData(localPlayer, "afk", false)
                afktimer = setTimer(afkcheck, 60000, 0)
        end
end)

local cccnt=0
local function cc_check()
  cccnt=cccnt+1
  if cccnt>15 then
    triggerServerEvent("banMe", localPlayer, "bug-using (#1)")
    removeEventHandler("onClientGUIClick", root, cc_check)
  end

end
addEventHandler("onClientGUIClick", root, cc_check)

setTimer(function()
  cccnt=0
end, 1000, 0)