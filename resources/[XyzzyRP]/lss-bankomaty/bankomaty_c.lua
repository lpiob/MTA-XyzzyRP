--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


local bankomaty={
--x,y,z, rx, ry, rz, INT, DIM, factionid, biernik 
{1495.26,-1022.28,22.83,0,0,0,0}, -- bank
{1501.37,-1020.80,22.83,0,0,0,0}, -- bank
{1468.19,-1764.12,17.80,0,0,90,0},	-- um
{1690.90,-2237.49,12.54,0,0,0,0}, -- lotnisko
{2039.45,-1447.58,12.54,0,0,270,0},	-- szpital
{1895.33,-1737.05,12.33,0,0,0,0}, -- kasyno
{932.98,-1195.05,17.48,0,0,90,0}, -- straz pozarna
{486.52,-1123.55,84.22,0,0,270,0}, -- cnn news
{2798.42,-1097.33,29.72,0,0,180,0}, -- departament turystyki
{2421.29,-2681.73,12.66,0,0,270,0}, -- import

{1251.68,325.03,18.76,0,0,157,0}, -- montgomery
{198.34,-62.45,0.58,0,0,0,0}, -- blueberry
{2274.06,-76.55,25.58,0,0,0,0}, -- palamino creek


--frakcyjne

{1548.07,-1675.52,1463.47-1,0,0,0,1,5,2,biernik="policji"}, --komisariat LSPD
{2027.21,-1393.47,1275.07-1,0,0,360,1,8,6,biernik="szpitala"}, --szpital LSMC
{1489.04,-1794.41,1132.96-1,0,0,180,1,1,1,biernik="urzędu miasta"}, --urząd miasta
{449.02,-1124.23,1196.34-1,0,0,360,1,7,5,biernik="redakcji CNN"}, --CNN
{801.03,-513.32,1206.88-1,0,0,180,1,10,4,biernik="służb miejskich"}, --sluzby miejskie
{924.74,-1281.04,1440.93-1,0,0,90,1,26,11,biernik="straży pożarnej"}, --straz pozarna LSFD
{1313.32,-1098.53,1441.53-1,0,0,0,1,21,17,biernik="sądu"}, --sąd
{1215.38,-1436.30,2177.18-1,0,0,90,1,40,22,biernik="służb specjalnych"}, --sluzby specjalne (swat,crash)
{2815.22,-1095.55,1593.71-1,0,0,180,1,51,35,biernik="departamentu turystyki"}, --departament turystki
{2431.93,-2667.13,2035.17-1,0,0,180,2,3,10,biernik="import"}, --import pojazdow


--[[
{2192.6635742188, 2713.3317871094, 9.8203125, 0.0, 0.0, 270.0, 0},				-- spinybed LV
{1480.4816894531, 2171.3081054688, 10.0234375, 0.0, 0.0, 90.0, 0},				-- redsands west
{2557.185546875, 1772.2393798828, 10.031209945679, 0.0, 0.0, 90.0, 0},			-- starfish casino lv
{2564.8251953125, 1051.5998535156, 9.8203125, 0.0, 0.0, 270.0, 0},				-- come-a-lot
{1971.5268554688, 712.67303466797, 9.8197803497314, 0.0, 0.0, 0.0, 0},
{1353.1154785156, 1158.0219726563, 9.8203125, 0.0, 0.0, 90.0, 0},
{2256.5534667969, 1795.3287353516, 9.8203125, 0.0, 0.0, 270.0, 0},
{2173.728515625, 1410.8937988281, 10.0625, 0.0, 0.0, 270.0, 0},
{1931.3721923828, 1368.1392822266, 8.2578125, 0.0, 0.0, 90.0, 0},
{2311.00, -17.32, 25.74,	0.0, 0.0,	180.0, 0},		-- bankomat w banku
{2313.55, -17.32, 25.74,	0.0,	0.0,180.0,0},		-- drugi bankomat w banku
{1250.9910888672, 242.38471984863, 18.5546875, 0.0, 0.0, 156.0, 0},
{666.99114990234, -552.08044433594, 15.3359375, 0.0, 0.0, 180.0, 0},
{170.33477783203, -186.32015991211, 0.58472061157227, 0.0, 0.0, 180.0, 0},
{2204.7214355469, -1151.3322753906, 24.747364044189, 0.0, 0.0, 0.0, 0},
{1738.6976318359, -1327.0853271484, 12.545146942139, 0.0, 0.0, 270.0, 0},
{1015.1317749023, -1303.2105712891, 12.546875, 0.0, 0.0, 270.0, 0},
{514.27410888672, -1611.4864501953, 15.386782646179, 0.0, 0.0, 90.0, 0},
{1135.0554199219, -1630.5491943359, 12.819604873657, 0.0, 0.0, 176.0, 0},
{1807.16015625, -1568.8347167969, 12.470972061157, 0.0, 0.0, 40.0, 0},
{2479.6682128906, -1757.8579101563, 12.546875, 0.0, 0.0, 180.0, 0},
{1680.4873046875, -2335.353515625, 12.546875, 0.0, 0.0, 180.0, 0},
{-2156.0866699219, -2444.9357910156, 29.625, 0.0, 0.0, 145.0, 0},
{-2626.2238769531, 48.929767608643, 3.3359375, 0.0, 0.0, 0.0, 0},
{-2626.1892089844, 631.04772949219, 13.453125, 0.0, 0.0, 0.0, 0},
{-1695.0743408203, 1336.3724365234, 6.1796875, 0.0, 0.0, 227.0, 0},
{-1990.6309814453, 744.99035644531, 44.437515258789, 0.0, 0.0, 315.0, 0},
{-1980.7810058594, 134.08068847656, 26.6875, 0.0, 0.0, 270.0, 0},
{-1379.8724365234, -355.13671875, 13.1484375, 0.0, 0.0, 190.0, 0},
{-2529.85546875, -624.77935791016, 131.75575256348, 0.0, 0.0, 180.0, 0},
{-2442.4858398438, 2320.5112304688, 3.984375, 0.0, 0.0, 180.0, 0},
{-1479.5334472656, 2642.5952148438, 57.787948608398, 0.0, 0.0, 0.0, 0},
{414.52542114258, 2533.9692382813, 15.560947418213, 0.0, 0.0, 0.0, 0},
{-80.593231201172, 1178.0502929688, 18.7421875, 0.0, 0.0, 90.0, 0},
{-833.80749511719, 1506.6776123047, 18.938480377197, 0.0, 0.0, 270.0}
]]--
}

for i,v in ipairs(bankomaty) do
--[[
		CreateDynamicObject(2618, DATA_ATM[i][X], DATA_ATM[i][Y], DATA_ATM[i][Z], DATA_ATM[i][rX], DATA_ATM[i][rY], DATA_ATM[i][rZ]);
		ATMS[i][eatm_mapicon]=CreateDynamicMapIcon(DATA_ATM[i][X], DATA_ATM[i][Y], DATA_ATM[i][Z], 52, 6, 0, DATA_ATM[i][atmInterior], -1, 300.0);
		Streamer_SetIntData(STREAMER_TYPE_MAP_ICON, ATMS[i][eatm_mapicon], E_STREAMER_STYLE, 2);
//		Streamer_SetIntData(STREAMER_TYPE_MAP_ICON, ATMS[i][eatm_mapicon], E_STREAMER_SIZE, random(10));	// testy!
		ATMS[i][eatm_cp]=CreateDynamicCP(DATA_ATM[i][X], DATA_ATM[i][Y], DATA_ATM[i][Z], 1.3, 0,DATA_ATM[i][atmInterior],-1,15.0);
]]--
	v.obiekt=createObject(2618,v[1],v[2],v[3],v[4],v[5],v[6])
	setElementInterior(v.obiekt,v[7] or 0)
	setElementDimension(v.obiekt,v[8] or 0)
	
--	v.mapicon=createBlip(v[1],v[2],v[3], 52, 2, 255,255,255,255, -1000, 300)
	v.mapicon=createBlip(v[1],v[2],v[3], 0, 1, 5,255,5,255, -1000, 300)
	setElementInterior(v.mapicon,v[7] or 0)
	setElementDimension(v.mapicon,v[8] or 0)
	
	v.cs=createColSphere(v[1],v[2],v[3]+1, 1)
	setElementInterior(v.cs,v[7] or 0)
	setElementDimension(v.cs,v[8] or 0)
	
	if v[9] then setElementData(v.cs, "bankomat:frakcyjny", v[9]) end
	if v.biernik then setElementData(v.cs, "bankomat:frakcyjny-biernik", v.biernik) end
end


local bw={}
bw.win = guiCreateWindow(0.7236,0.3398,0.2314,0.5,"Bankomat",true)
guiWindowSetMovable(bw.win,false)
guiWindowSetSizable(bw.win,false)
bw.lbl1 = guiCreateLabel(0.0633,0.0997,0.903,0.1571,"Stan konta:\n0$",true,bw.win)
guiLabelSetVerticalAlign(bw.lbl1,"center")
guiLabelSetHorizontalAlign(bw.lbl1,"center",false)
bw.lbl2 = guiCreateLabel(0.0759,0.2734,0.8861,0.0695,"Wpłata ───────────────────────",true,bw.win)
bw.edt1 = guiCreateEdit(0.0675,0.3385,0.8608,0.0859,"0",true,bw.win)
bw.btn_wplac = guiCreateButton(0.0717,0.4427,0.8608,0.0911,"Wpłać",true,bw.win)

bw.lbl3 = guiCreateLabel(0.0759,0.5626,0.8861,0.0695,"Wypłata ".."───────────────────────",true,bw.win)
bw.edt2 = guiCreateEdit(0.0675,0.6276,0.8608,0.0859,"0",true,bw.win)
bw.btn_wyplac = guiCreateButton(0.0717,0.7344,0.8608,0.0911,"Wypłać",true,bw.win)

bw.btn_zamknij = guiCreateButton(0.0717,0.888,0.8608,0.0859,"Zamknij",true,bw.win)





guiSetVisible(bw.win, false)



addEventHandler("onClientColShapeHit", resourceRoot, function(el,md)
	if not md or el~=localPlayer then return end
--	outputChatBox("Bankomat pokazuje napis: AWARIA.")
--	if getPlayerName(localPlayer)=="Carolynn_Trench" or getPlayerName(localPlayer)=="Bob_Euler" then
		
		
		guiSetVisible(bw.win, true)
		guiSetEnabled(bw.btn_wyplac, false)
		guiSetEnabled(bw.btn_wplac, false)
		guiSetText(bw.lbl1,"Trwa otwieranie konta bankowego...")
		triggerServerEvent("onPlayerRequestATMInfo", resourceRoot)
--showCursor(true,true)
		guiSetInputMode("no_binds_when_editing")
		if getElementData(source, "bankomat:frakcyjny") then 
			guiSetText(bw.win, "Wpłatomat frakcyjny") 
			guiSetText(bw.lbl2, "Wpłata na konto "..getElementData(source, "bankomat:frakcyjny-biernik"))
			guiSetVisible(bw.btn_wyplac, false)
			setElementData(bw.win, "bankomat:frakcyjny", getElementData(source, "bankomat:frakcyjny"))
			guiSetText(bw.lbl3, "Tytułem:")
			guiSetPosition(bw.btn_wplac, 0.0717,0.75, true)
			setTimer(guiSetText,100,1,bw.edt2, "")
		else
			guiSetText(bw.win, "Bankomat") 
			guiSetText(bw.lbl2, "Wpłata ───────────────────────")
			guiSetText(bw.lbl3, "Wypłata ───────────────────────")
			guiSetVisible(bw.btn_wyplac, true)
			guiSetPosition(bw.btn_wplac, 0.0717,0.4427, true)
		end
--	end
end)

local function closeATMWin()
	if guiGetVisible(bw.win) then
		guiSetVisible(bw.win, false)
--showCursor(false)
	end
end

addEventHandler("onClientGUIClick", bw.btn_zamknij, closeATMWin, false)
addEventHandler("onClientColShapeLeave", resourceRoot, function(el,md)
	if el~=localPlayer then return end
	closeATMWin()
end)

-- triggerClientEvent(client,"doFillATMInfo", resourceRoot, true, sr.bank_money)
addEvent("doFillATMInfo", true)
addEventHandler("doFillATMInfo", resourceRoot, function(success, balance)
	if not success then
		guiSetText(bw.lbl1,"Musisz być zarejestrowanym graczem aby skorzystać z bankomatu.")
		return
	end
	guiSetText(bw.lbl1,"Stan Twojego konta:".."\n".. balance.."$")
	setElementData(bw.win, "balance", tonumber(balance))
	guiSetText(bw.edt2,100 > balance and balance or 100)
	if balance>0 then
		guiSetEnabled(bw.btn_wyplac, true)
	end

	guiSetText(bw.edt1,balance)
	guiSetEnabled(bw.btn_wplac, true)
end)

addEventHandler("onClientPlayerSpawn", localPlayer, closeATMWin)


addEventHandler("onClientGUIClick", bw.btn_wplac, function()
	local kwota=tonumber(guiGetText(bw.edt1))

	if not kwota or kwota<=0 or kwota%1 ~= 0 then
--		triggerEvent("onAnnouncement3", root, "Nieprawidłowa kwota wpłaty.", 4)
		outputChatBox("Nieprawidłowa kwota wpłaty!", 255,0,0)
		return
	end
	
	if guiGetVisible(bw.btn_wyplac) then --normalna wplata
	
		if kwota>getPlayerMoney() then
			outputChatBox("Nie masz tyle gotówki!", 255,0,0)
			return
		end
		
		closeATMWin()
		triggerServerEvent("doATMOperation", resourceRoot, kwota)
	else
		local balance = getElementData(bw.win, "balance")
		if kwota>balance then
			outputChatBox("Nie masz tyle gotówki na koncie bankowym!", 255,0,0)
			return
		end
		
		local frakcja = getElementData(bw.win, "bankomat:frakcyjny")
		local tytul = guiGetText(bw.edt2)
		if (string.len(tytul) < 5) or (string.len(tytul) > 30) then outputChatBox("Zbyt długi/krótki powód!", 255,0,0) return end
		closeATMWin()
		triggerServerEvent("doATMOperationFraction", resourceRoot, kwota, frakcja, tytul)
	end

end, false)

addEventHandler("onClientGUIClick", bw.btn_wyplac, function()
    if not tonumber(guiGetText(bw.edt2)) then return end
	local kwota=tonumber(guiGetText(bw.edt2))
	if not kwota or kwota<=0 or kwota%1 ~= 0 then
--		triggerEvent("onAnnouncement3", root, "Nieprawidłowa kwota wypłaty.", 4)
		outputChatBox("Nieprawidłowa kwota wpłaty!", 255,0,0)
		return
	end
	if getPlayerMoney()+kwota>99999999 then
--		triggerEvent("onAnnouncement3", root, "Nie możesz mieć tyle gotówki przy sobie.", 4)
		outputChatBox("Maksymalna ilość gotówki którą możesz mieć przy sobie to 999999.99$", 255,0,0)
		return
	end
	closeATMWin()
	triggerServerEvent("doATMOperation", resourceRoot, -kwota)

end, false)
