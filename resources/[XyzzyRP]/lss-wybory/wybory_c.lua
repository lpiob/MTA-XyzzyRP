--[[
Okazjonalnie uzywany zasob do przeprowadzania demokratycznych wyborów

@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local aw={}
local kandydaci={
  "Gregor Torri",
  "Christopher McDonough",
  "Maximilian Thompson",
  "Salvatore Angoretti"
}

aw.win = guiCreateWindow(0.2475,0.3267,0.5275,0.415,"Arkusz wyborczy",true)
aw.lbl1 = guiCreateLabel(0.0237,0.1165,0.9313,0.1365,"Drugie demokratyczne wybory burmistrza Los Santos",true,aw.win)
guiLabelSetHorizontalAlign(aw.lbl1,"center",false)
aw.lbl2 = guiCreateLabel(0.0284,0.253,0.9384,0.1446,"Dokładna charakterystyka kandydatów i programy wyborcze dostępne są w internecie pod adresem http://lss-rp.pl/l/wybory",true,aw.win)
guiLabelSetHorizontalAlign(aw.lbl2,"center",true)
aw.lbl3 = guiCreateLabel(0.0332,0.5181,0.2867,0.1205,"Oddaje swój głos na:",true,aw.win)
aw.combo_kandydat = guiCreateComboBox(0.3365,0.506,0.6327,0.9004,"wybierz",true,aw.win)
aw.btn_zrezygnuj = guiCreateButton(0.0379,0.7631,0.41,0.1847,"Zrezygnuj",true,aw.win)
aw.btn_oddajglos = guiCreateButton(0.545,0.7631,0.41,0.1847,"Oddaj głos",true,aw.win)

for i,v in ipairs(kandydaci) do
  guiComboBoxAddItem(aw.combo_kandydat, v)
end


guiSetVisible(aw.win, false)

addEvent("onKartaDoGlosowania", true)
addEventHandler("onKartaDoGlosowania", resourceRoot, function()
  guiSetVisible(aw.win, true)
end)

addEventHandler("onClientGUIClick", aw.btn_zrezygnuj, function()
  guiSetVisible(aw.win, false)
  triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " odchodzi od urny nie wrzucając karty.", 5, 15, true)
end)

addEventHandler("onClientGUIClick", aw.btn_oddajglos, function()
  local glos=guiComboBoxGetSelected(aw.combo_kandydat)
  if (not glos or glos<0) then
	  outputChatBox("(( Wybierz kandydata z listy! ))")
	  return
  end
  guiSetVisible(aw.win, false)
  triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wrzuca kartę do urny.", 5, 15, true)
  triggerServerEvent("onWyboryRegisterVote", resourceRoot, localPlayer, glos)
end)