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

nw.win = guiCreateWindow(353,201,334,348,"Notes",false)
nw.memo = guiCreateMemo(10,31,313,273,"",false,nw.win)
nw.btn_anuluj = guiCreateButton(10,313,136,26,"Anuluj",false,nw.win)
nw.btn_utworz = guiCreateButton(188,313,136,26,"Utwórz notatkę",false,nw.win)

guiSetVisible(nw.win, false)



addEventHandler("onClientGUIClick", nw.btn_anuluj, function()
	guiSetVisible(nw.win, false)
end, false)

addEventHandler("onClientGUIClick", nw.btn_utworz, function()
	if not exports["lss-gui"]:eq_getFreeIndex() then
		outputChatBox("(( Nie masz miejsca w inwentarzu ))")
		return
	end
	local text=guiGetText(nw.memo)
	if exports["lss-gui"]:eq_takeItem(47,1,0) then
		triggerServerEvent("createNote", resourceRoot, localPlayer, text)
		guiSetVisible(nw.win, false)
	else
		outputChatBox("Nie posiadasz kartek w notesie!")
		guiSetVisible(nw.win, false)
		return
	end
end, false)

function notatka_stworz()
	if (not exports["lss-gui"]:eq_getItemByID(47,0)) then
		outputChatBox("Nie posiadasz kartek w notesie!")
		guiSetVisible(nw.win, false)
		return
	end
	guiSetVisible(nw.win, true)
	guiSetText(nw.memo, "")
	guiSetInputMode("no_binds_when_editing")
end


local nr={}

nr.win = guiCreateWindow(353,201,334,348,"Notes",false)
nr.memo = guiCreateMemo(10,31,313,273,"",false,nr.win)
guiMemoSetReadOnly(nr.memo, true)

nr.btn_zamknij = guiCreateButton(188,313,136,26,"Schowaj",false,nr.win)

guiSetVisible(nr.win, false)


addEventHandler("onClientGUIClick", nr.btn_zamknij, function()
	guiSetVisible(nr.win, false)

end, false)

function notatka_pokaz(id)
	guiSetVisible(nr.win, true)
	guiSetText(nr.memo, "")

	triggerServerEvent("readNote", resourceRoot, localPlayer, id)
end

-- triggerClientEvent(plr, "fillNote", resourceRoot, tresc)
addEvent("fillNote", true)
addEventHandler("fillNote", resourceRoot, function(tresc)
	guiSetText(nr.memo, tresc)
end)