--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



mapa_visible=false
--[[
function mapRender()
    if (mapa_visible) then
        dxDrawImage(-800,-800,1600,1649,"img/lossantos_map.jpg")
    else
        dxDrawImage(0,0,0,0,"img/lossantos_map.jpg",0,0,0,tocolor(255,255,255),true)
    end
end
]]--

function mapaToggle()
    mapa_visible=not mapa_visible
end
bindKey("F11","up",mapaToggle)

--addEventHandler ( "onClientRender", root, mapRender )