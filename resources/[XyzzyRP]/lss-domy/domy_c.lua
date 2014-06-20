--[[
Domy do wynajecia
   
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2010-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



local a_dom=nil
local wd={}

wd.win = guiCreateWindow(0.7773,0.3216,0.1758,0.3477,"Dom",true)
guiWindowSetMovable(wd.win,false)
guiWindowSetSizable(wd.win,false)
wd.lbl_opis = guiCreateLabel(0.0611,0.1236,0.8556,0.4981,"Opis",true,wd.win)
guiLabelSetVerticalAlign(wd.lbl_opis,"center")
guiLabelSetHorizontalAlign(wd.lbl_opis,"center",false)
wd.btn_wejdzzobacz = guiCreateButton(0.05,0.6404,0.8778,0.1536,"Zobacz dom",true,wd.win)
wd.btn_kupopcje = guiCreateButton(0.05,0.8165,0.8778,0.1536,"Kup dom",true,wd.win)

guiSetVisible(wd.win,false)


local od={}

od.win = guiCreateWindow(0.25,0.2708,0.4707,0.5013,"Opcje domu",true)
guiWindowSetMovable(od.win,false)
guiWindowSetSizable(od.win,false)
od.tabpanel = guiCreateTabPanel(0.0187,0.0805,0.9585,0.7818,true,od.win)
od.tab_oplacanie = guiCreateTab("Opłacanie domu",od.tabpanel)
od.lbl_oplacanie = guiCreateLabel(0.026,0.0686,0.9524,0.2455,"Koszt wynajęcia domu na okres x dni wynosi y$", true, od.tab_oplacanie)
guiLabelSetVerticalAlign(od.lbl_oplacanie,"center")
guiLabelSetHorizontalAlign(od.lbl_oplacanie,"center",false)
od.btn_oplac = guiCreateButton(0.7208,0.3466,0.2359,0.1408,"Opłać",true,od.tab_oplacanie)
od.btn_oplac2 = guiCreateButton(0.7186,0.5307,0.2359,0.1408,"Potwierdzam",true,od.tab_oplacanie)
od.lbl4 = guiCreateLabel(0.026,0.5271,0.6688,0.1336,"Koszt respektu: 5555",true,od.tab_oplacanie)
guiLabelSetVerticalAlign(od.lbl4,"center")
guiLabelSetHorizontalAlign(od.lbl4,"right",false)
od.lbl5 = guiCreateLabel(0.026,0.7437,0.9372,0.1949,"-",true,od.tab_oplacanie) -- adres domu
guiLabelSetVerticalAlign(od.lbl5,"center")
guiLabelSetHorizontalAlign(od.lbl5,"center",false)
od.tab_opcje = guiCreateTab("Opcje domu",od.tabpanel)
od.btn_zamknijdom = guiCreateButton(0.026,0.0903,0.4307,0.2202,"Zamknij dom",true,od.tab_opcje)
od.btn_otworzdom = guiCreateButton(0.5346,0.0975,0.4307,0.2202,"Otwórz dom",true,od.tab_opcje)
od.btn_bezdmon = guiCreateButton(0.026,0.4007,0.4307,0.2202," ",true,od.tab_opcje)
od.btn_bezdmoff = guiCreateButton(0.5346,0.4043,0.4307,0.2202," ",true,od.tab_opcje)

od.btn_zamknij = guiCreateButton(0.6992,0.8935,0.278,0.0831,"Zamknij",true,od.win)

guiSetVisible(od.win,false)


local function schowajOknaDomu()
	if guiGetVisible(wd.win) or guiGetVisible(od.win) then
		guiSetVisible(wd.win,false)
		guiSetVisible(od.win,false)
--		showCursor(false)
	end
end

local function getPlayerDBID(plr)
	local c=getElementData(plr,"character")
	if not c then return nil end
	return tonumber(c.id)
end


local function pokazOknoDomu(dom)
	guiSetVisible(wd.win, true)
--	showCursor(true,false)
--	toggleControl("fire", false)
	setPedWeaponSlot(localPlayer, 0)
	guiSetText(wd.lbl_opis,dom.descr.."\n\n"..(dom.owner_nick or "do wynajęcia"))
	local dbid=getPlayerDBID(localPlayer)

	if dom.ownerid then
		guiSetText(wd.btn_wejdzzobacz, "Wejdź")

		if dbid and dom.ownerid==dbid then
			guiSetVisible(wd.btn_kupopcje, true)
			guiSetText(wd.btn_kupopcje, "Opcje")

			guiSetEnabled(od.tab_opcje, true)
		else
			guiSetVisible(wd.btn_kupopcje, false)
			guiSetEnabled(od.tab_opcje, false)
		end
		
	else
		guiSetText(wd.btn_wejdzzobacz, "Zobacz dom")
		guiSetText(wd.btn_kupopcje, "Kup dom")
		guiSetVisible(wd.btn_kupopcje, true)
		guiSetEnabled(od.tab_opcje, false)

	end
	guiSetSelectedTab(od.tabpanel, od.tab_oplacanie)
	guiSetText(od.lbl4, "")
	guiSetVisible(od.btn_oplac,false)
	guiSetVisible(od.btn_oplac2, false)
	local t="Dom można wynająć w urzędzie. ID domu:"..dom.id
	if dom.ownerid and dom.paidTo then
		t=t.."\n"..string.format("Dom jest opłacony do %s (%d dni).", dom.paidTo, dom.paidTo_dni)
	end
	guiSetText(od.lbl_oplacanie, t)
	guiSetText(od.win, "Opcje domu " .. dom.id)
	local reklama=string.format("Zaoszczędź %s$ i opłać dom na 30 dni za pomocą jednego SMSa.\nAby to zrobić, wejdź na stronę http://lss-rp.pl/domy/%d\nZa pomocą płatności SMS dom może być opłacony na dowolny okres czasu.", ((dom.koszt/100)*2)*30, dom.id)
--	local reklama=""
	guiSetText(od.lbl5, reklama)

	guiSetEnabled(od.btn_bezdmon,false)
	guiSetEnabled(od.btn_bezdmoff,false)
	if dom.zamkniety then
		guiSetEnabled(od.btn_zamknijdom,false)
		guiSetEnabled(od.btn_otworzdom,true)
	else
		guiSetEnabled(od.btn_zamknijdom,true)
		guiSetEnabled(od.btn_otworzdom,false)
	end
end

addEventHandler("onClientColShapeHit", resourceRoot, function(el,md)
	if el~=localPlayer or not md then return end
	local dom=getElementData(source,"dom")
	if not dom then return end
--	if getPlayerName(localPlayer)=="KOZ.Zyrafa" or getPlayerName(localPlayer)=="BP.Zuzanna" then
		a_dom=dom
		pokazOknoDomu(dom)
--	end
--	outputChatBox("Domy w trakcie przygotowywania.")
end)

local function domWejscie()
--[[
		["dimension"]=interior_dimension,
		["interior"]=interiory[v.interiorid].interior,
		["interior_loc"]=interiory[v.interiorid].entrance })
]]--
	if not a_dom then return end
	local dbid=getPlayerDBID(localPlayer)
	if not a_dom.ownerid then	-- dom jest do kupienia, wpuszczamy gracza zeby zobaczyl
		ad=a_dom
		playSound("audio/wejscie-"..tostring(a_dom.id%5+1)..".ogg")
		triggerServerEvent("moveMeTo", resourceRoot, a_dom.interior_loc[1], a_dom.interior_loc[2], a_dom.interior_loc[3], a_dom.interior, a_dom.dimension)
		setTimer(function(d,p)
			if (getElementDimension(localPlayer)==d) then
--				setElementInterior(localPlayer, 0)
--				setElementDimension(localPlayer, 0)
--				setElementPosition(localPlayer, unpack(p))
				triggerServerEvent("moveMeTo", resourceRoot, p[1], p[2], p[3], 0,0)
--				setPedRotation(localPlayer, p[4])
			end
		end, 30000,1,ad.dimension, ad.exit_loc)
	elseif not a_dom.zamkniety or a_dom.ownerid==dbid then
		playSound("audio/wejscie-"..tostring(a_dom.id%5+1)..".ogg")
		triggerServerEvent("moveMeTo", resourceRoot, a_dom.interior_loc[1], a_dom.interior_loc[2], a_dom.interior_loc[3], a_dom.interior, a_dom.dimension)
--[[
		setElementInterior(localPlayer, a_dom.interior)
		setElementDimension(localPlayer, a_dom.dimension)
		setElementPosition(localPlayer, unpack(a_dom.interior_loc))
]]--

	elseif a_dom.zamkniety then
		playSound("audio/zamkniete-"..tostring(a_dom.id%2+1)..".ogg")
		triggerEvent("onAnnouncement3",root,"Zamknięte", 3)
	end
end
addEventHandler("onClientGUIClick", wd.btn_wejdzzobacz, domWejscie, false)

local function domOpcje()
	guiSetVisible(od.win, true)
end

addEventHandler("onClientGUIClick", wd.btn_kupopcje, domOpcje, false)


addEventHandler("onClientColShapeLeave", resourceRoot, function(el,md)
	if el~=localPlayer then return end
	schowajOknaDomu()
	a_dom=nil
end)

addEventHandler("onClientPlayerSpawn", localPlayer, schowajOknaDomu)
-- triggerClientEvent(client, "doHideHouseWindows", resourceRoot)
addEvent("doHideHouseWindows", true)
addEventHandler("doHideHouseWindows", resourceRoot, schowajOknaDomu)


--- opcje domu
addEventHandler("onClientGUIClick", od.btn_zamknij, schowajOknaDomu, false)

-- addEventHandler("onClientGUIClick", od.btn_oplac, function()
	-- local ilosc_dni=tonumber(guiGetText(od.edt_iloscdni))
	-- if not ilosc_dni or ilosc_dni<1 then
		-- guiSetText(od.lbl4,"Podano nieprawidłową wartość.")
		-- return
	-- end
	-- if (a_dom.paidTo_dni or 0)+ilosc_dni>14 then
		-- guiSetText(od.lbl4,"Dom może być opłacony na maksymalnie 14 dni.")
		-- return
	-- end
	
	-- local dbid=getPlayerDBID(localPlayer)
	-- if not dbid then
		-- guiSetText(od.lbl4,"Tylko zarejestrowani gracze mogą kupować domy.")
		-- return
	-- end
	-- local gotowka=getPlayerMoney(localPlayer)
	-- local koszt=ilosc_dni*a_dom.koszt
	-- if koszt>gotowka then
		-- guiSetText(od.lbl4,string.format("Koszt wynajęcia domu na %d dni\nwynosi %d$. Nie masz go tyle!", ilosc_dni,koszt))
		-- return
	-- end

	-- guiSetEnabled(od.edt_iloscdni, false)
	-- guiSetVisible(od.btn_oplac, false)
	-- guiSetVisible(od.btn_oplac2,true)
	-- guiSetText(od.lbl4,string.format("Koszt wynajęcia domu na %d dni wynosi %.02f$.\nKliknij potwierdź jeśli jesteś pewny/a zakupu.", ilosc_dni,koszt/100))
	
-- end, false)


-- addEventHandler("onClientGUIClick", od.btn_oplac2, function()
	-- local ilosc_dni=tonumber(guiGetText(od.edt_iloscdni))

	-- if not ilosc_dni or ilosc_dni<1 then return end
	-- local dbid=getPlayerDBID(localPlayer)
	-- if not dbid then return end
	-- local gotowka=getPlayerMoney(localPlayer)
	-- local koszt=ilosc_dni*a_dom.koszt
	-- if koszt>gotowka then return end
	
	-- guiSetVisible(od.btn_oplac2, false)
	-- triggerServerEvent("onHousePaymentRequest", resourceRoot, a_dom.id, ilosc_dni)
-- end,false)


addEventHandler("onClientGUIClick", od.btn_otworzdom, function()
	if not a_dom then return end

	local dbid=getPlayerDBID(localPlayer)
	if not dbid then return end

	if dbid~=a_dom.ownerid then return end

	triggerServerEvent("onHouseChangeOptions", resourceRoot, a_dom.id, "zamkniety", false)
end,false)

addEventHandler("onClientGUIClick", od.btn_zamknijdom, function()
	if not a_dom then return end

	local dbid=getPlayerDBID(localPlayer)
	if not dbid then return end

	if dbid~=a_dom.ownerid then return end

	triggerServerEvent("onHouseChangeOptions", resourceRoot, a_dom.id, "zamkniety", true)
end,false)