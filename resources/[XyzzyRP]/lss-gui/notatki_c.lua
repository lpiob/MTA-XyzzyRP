--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local nw={}

nw.win = guiCreateWindow(0.2537,0.1533,0.5013,0.6467,"Kartka papieru",true)
nw.memo = guiCreateMemo(0.0299,0.0773,0.9426,0.7912,"",true,nw.win)
nw.btn_schowaj = guiCreateButton(0.0299,0.8814,0.4339,0.0954,"Schowaj",true,nw.win)
nw.btn_utworz = guiCreateButton(0.5387,0.8814,0.4339,0.0954,"Utwórz notatkę",true,nw.win)

guiSetVisible(nw.win, false)

function notatka_pokaz(id)
  outputChatBox("(( Notatki w przygotowaniu ))")
end

addEventHandler("onClientGUIClick", nw.btn_schowaj, function()

end,false)