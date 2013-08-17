--[[
lss-admin: nadawanie GP

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


local MINGP=1
local MAXGP=20

local ngpw={}

local GUIEditor_Edit={}
local GUIEditor_Progress={}
ngpw.win = guiCreateWindow(0.2266,0.3568,0.6094,0.3125,"Nadawanie GP",true)
guiWindowSetMovable(ngpw.win,false)
guiWindowSetSizable(ngpw.win,false)
guiSetVisible(ngpw.win,false)
ngpw.lbl1 = guiCreateLabel(0.0208,0.1375,0.2019,0.1083,"Osoba",true,ngpw.win)
guiLabelSetVerticalAlign(ngpw.lbl1,"center")
guiLabelSetHorizontalAlign(ngpw.lbl1,"right",false)
ngpw.cmb_gracz = guiCreateComboBox(0.2468,0.1375,0.7308,0.825,"-wybierz gracza-",true,ngpw.win)
ngpw.lbl2 = guiCreateLabel(0.0208,0.375,0.2019,0.1083,"Powód nadania",true,ngpw.win)
guiLabelSetVerticalAlign(ngpw.lbl2,"center")
guiLabelSetHorizontalAlign(ngpw.lbl2,"right",false)
ngpw.edt_powod = guiCreateEdit(0.2468,0.375,0.7308,0.125,"",true,ngpw.win)
ngpw.lbl3 = guiCreateLabel(0.0224,0.5958,0.2019,0.1083,"Ilość",true,ngpw.win)
guiLabelSetVerticalAlign(ngpw.lbl3,"center")
guiLabelSetHorizontalAlign(ngpw.lbl3,"right",false)
ngpw.scroll_ilosc = guiCreateScrollBar(0.2484,0.6125,0.4888,0.0958,true,true,ngpw.win)
ngpw.lbl4 = guiCreateLabel(0.766,0.6125,0.1971,0.0958,"10",true,ngpw.win)
guiLabelSetVerticalAlign(ngpw.lbl4,"center")
ngpw.btn_nadaj = guiCreateButton(0.024,0.7958,0.4375,0.1583,"Nadaj punkty",true,ngpw.win)
ngpw.btn_anuluj = guiCreateButton(0.5337,0.7958,0.4375,0.1542,"Anuluj",true,ngpw.win)

local function setScrollAmount()
	local pos=guiScrollBarGetScrollPosition(ngpw.scroll_ilosc)
--[[
	0 - MINGP
	pos = x
	100 - MAXGP
]]--
	local amnt=math.ceil(((pos)*MAXGP)/100)
	if amnt<1 then amnt=1 end
	
	guiSetText(ngpw.lbl4, amnt)
	return amnt
end

setScrollAmount()

addEventHandler("onClientGUIScroll",ngpw.scroll_ilosc,setScrollAmount)


ngpw.show=function()
	if not getElementData(localPlayer,"admin:rank") then
		return
	end
	guiSetVisible(ngpw.win,true)
	guiComboBoxClear(ngpw.cmb_gracz)
	for i,v in ipairs(getElementsByType("player")) do
		local c=getElementData(v,"character")
		if c then
			local t=string.format("%d %s %s (%s)", c.id, c.imie, c.nazwisko, getElementData(v,"auth:login"))
			guiComboBoxAddItem(ngpw.cmb_gracz, t)
		end
	end
	showCursor(true)
	guiSetText(ngpw.lbl4,"10")
	guiScrollBarSetScrollPosition(ngpw.scroll_ilosc,50)
end

ngpw.hide=function()
	guiSetVisible(ngpw.win, false)
	showCursor(false)
end

ngpw.nadaj=function()
	local powod=guiGetText(ngpw.edt_powod)
	if string.len(powod)<3 then
		outputChatBox("Podaj powód nadania punktów GP.", 255,0,0)
		return
	end
	-- lokalizujemy gracza
	local sc=guiComboBoxGetSelected(ngpw.cmb_gracz)
	local id_postaci=string.match(guiComboBoxGetItemText(ngpw.cmb_gracz,sc) or "","^%d+")
	if not sc or sc<0 or not id_postaci then
		outputChatBox("Wybierz gracza któremu chcesz nadać punkty.", 255,0,0)
		return
	end
	triggerServerEvent("doNadajGP", resourceRoot, id_postaci, powod, setScrollAmount())
end

addCommandHandler("nadajgp", ngpw.show,false,false)
addEventHandler("onClientGUIClick", ngpw.btn_anuluj, ngpw.hide, false)
addEventHandler("onClientGUIClick", ngpw.btn_nadaj, ngpw.nadaj, false)

addEvent("doHideNadajGPWindows", true)
addEventHandler("doHideNadajGPWindows", resourceRoot, ngpw.hide)