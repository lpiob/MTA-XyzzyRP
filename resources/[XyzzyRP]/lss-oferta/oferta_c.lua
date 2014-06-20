--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local oferta_with=nil
local oferta_timer=nil

local oa={}
oa.win = guiCreateWindow(0.7437,0.4087,0.2281,0.2146,"Oferta/usługa",true)
oa.btn = guiCreateButton(0.1096,0.6893,0.7877,0.2233,"Zgoda",true,oa.win)
oa.lbl = guiCreateLabel(0.1096,0.2233,0.7877,0.3689,"Shawn Hanks chce z Tobą handlować",true,oa.win)
guiLabelSetHorizontalAlign(oa.lbl,"center",true)

guiSetVisible(oa.win,false)




addEventHandler ("onClientGUIClick", oa.btn, function()
    guiSetVisible(oa.win,false)
    triggerServerEvent("onOfertaRequestAllowed", resourceRoot,oferta_with)
end, false)


local ow={}
ow.win = guiCreateWindow(0.2788,0.285,0.4,0.5333,"Oferta",true)
guiSetVisible(ow.win,false)
guiWindowSetSizable(ow.win,false)
ow.lbl_desc = guiCreateLabel(0.0344,0.0844,0.925,0.1688,"Oferujesz usługę w ramach pracy w",true,ow.win)
guiLabelSetVerticalAlign(ow.lbl_desc,"center")
guiLabelSetHorizontalAlign(ow.lbl_desc,"center",true)
ow.lbl2 = guiCreateLabel(0.0281,0.2594,0.4063,0.0844,"Przedmiot usługi:",true,ow.win)
ow.memo_przedmiot = guiCreateMemo(0.0313,0.3562,0.9312,0.2062,"",true,ow.win)
ow.lbl3 = guiCreateLabel(0.0344,0.5938,0.3469,0.0844,"Wartość:",true,ow.win)
ow.scr_kwota = guiCreateScrollBar(0.0375,0.6906,0.625,0.0938,true,true,ow.win)
ow.lbl_kwota = guiCreateLabel(0.7031,0.6938,0.2313,0.0875,"$100",true,ow.win)
guiLabelSetVerticalAlign(ow.lbl_kwota,"center")
guiLabelSetHorizontalAlign(ow.lbl_kwota,"center",false)
ow.chk_zgoda1 = guiCreateCheckBox(0.0437,0.8562,0.2656,0.0812,"Zgoda",false,true,ow.win)
ow.chk_zgoda2 = guiCreateCheckBox(0.375,0.8562,0.2844,0.0812,"Zgoda",false,true,ow.win)
guiCheckBoxSetSelected(ow.chk_zgoda2,true)
ow.btn_anuluj = guiCreateButton(0.6625,0.85,0.3094,0.1094,"Anuluj",true,ow.win)


-- call(getResourceFromName("lss-oferta"),"menu_oferta",{with=el})
function menu_oferta(args)
	if (getPlayerName(localPlayer)~="Bob_Euler") then 
		outputChatBox("(( Kod oferowania usług w trakcie przygotowywania. ))")
		return
	end
    local with=args.with

    if (not with or not isElement(with) or getElementType(with)~="player") then	-- nie powinno sie zdarzyc
	outputDebugString("menu_oferta wywolane z obiektem ktory nie jest graczem - nie powinno sie zdarzyc")
	return false
    end

    local x1,y1,z1=getElementPosition(localPlayer)
    local x2,y2,z2=getElementPosition(with)
    if (getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)>5) then
		outputChatBox("Musisz podejść bliżej aby dokonać transakcji.", 255,0,0,true)
		return false
    end

    triggerServerEvent("onOfertaRequest", resourceRoot, with)
    return true

end

-- onOfertaRequestAllowance
addEvent("onOfertaRequestAllowance", true)
addEventHandler("onOfertaRequestAllowance", root, function()
	if guiGetVisible(ow.win) or guiGetVisible(oa.win) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " handluje z kimś.", 5, 5, false)
	end
	if isTimer(oferta_timer) then killTimer(oferta_timer) end
	guiSetVisible(oa.win,true)
	guiSetText(oa.lbl, getPlayerName(source) .. " chce Ci coś zaoferować.")
	oferta_with=source
	oferta_timer=setTimer(function()
		guiSetVisible(oa.win,false)
	end, 10000, 1)
end)