--[[
lss-admin: różne funkcje dla admina

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub

]]--


addCommandHandler("reloadskinyg", function(plr,cmd)
  local uid=getElementData(plr,"auth:uid") or 0
  if uid~=1748 then return end -- biedroneczka

	restartResource(getResourceFromName("lss-skiny-co"))
	outputChatBox("Przeladowano zasob lss-skiny-co", plr)
end,false,false)

addCommandHandler("reloadskinyp", function(plr,cmd)
  local uid=getElementData(plr,"auth:uid") or 0
  if uid~=1748 then return end -- biedroneczka

	restartResource(getResourceFromName("lss-skiny-premium"))
	outputChatBox("Przeladowano zasob lss-skiny-premium", plr)
end,false,false)


addCommandHandler("reloadbudynki", function(plr,cmd)
  local uid=getElementData(plr,"auth:uid") or 0
  if uid~=1748 then return end -- biedroneczka
	restartResource(getResourceFromName("lss-budynki"))
	outputChatBox("Przeladowano zasob lss-budynki", plr)
end,false,false)

--[[
addCommandHandler("xzzdoQuakezzx", function(plr,cmd)
--	if not isRCON(plr) then return end
	triggerClientEvent("odtworzDzwiek", root, "trzesienie")
	local cel=root
	for i=1,75 do
		setTimer(triggerClientEvent, i*666, 1, cel, "doQuake", root, (i>15 and math.random(5,15) or i)/10)
	end
end, false,false)
]]--

function cmd_aa(plr,command, ...)
--	local accName = getAccountName ( getPlayerAccount ( v ) )
--	if not accName or not isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
--		return
--	end

	local txt = table.concat( arg, " " )
	
	for i,v in ipairs(getElementsByType("player")) do
		local accName = getAccountName ( getPlayerAccount ( v ) )
		if accName and ( isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) )) then
			outputChatBox("AA> "..getPlayerName(plr).. ": " .. txt, v,155,0,0)
		end
	end
end

addCommandHandler("aa", cmd_aa, true,false)


function cmd_a(plr,command, ...)
--	local accName = getAccountName ( getPlayerAccount ( v ) )
--	if not accName or not isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
--		return
--	end

	local txt = table.concat( arg, " " )
	
	for i,v in ipairs(getElementsByType("player")) do
		local accName = getAccountName ( getPlayerAccount ( v ) )
		if accName and (isObjectInACLGroup ("user."..accName, aclGetGroup ( "Administrator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) )) then
			outputChatBox("A> "..getAdminName(plr).. ": " .. txt, v,255,0,0)
		end
	end
end

addCommandHandler("a", cmd_a, true,false)

function cmd_s(plr,command, ...)
--	local accName = getAccountName ( getPlayerAccount ( v ) )
--	if not accName or not isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
--		return
--	end

	local txt = table.concat( arg, " " )
	
	for i,v in ipairs(getElementsByType("player")) do
		local accName = getAccountName ( getPlayerAccount ( v ) )
		if accName and (isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Support" ) )) then
			outputChatBox("S> "..getAdminName(plr).. ": " .. txt, v,0,255,50,true)
		end
	end
end


addCommandHandler("s", cmd_s, true,false)

addCommandHandler("bwoff", function(plr,cmd)
    for i,v in ipairs(getElementsByType("player")) do
	setElementData(v,"bwEndTime", 0)
    end
end,true,false)



function cmd_int(plr,command, nbr )
	if (not nbr) then
		outputChatBox("Uzyj: /int <id>", plr)
		return
	end
	local int = exports["lss-core"]:getInterior(tonumber(nbr))
	if (not int) then
		outputChatBox("Nie odnaleziono interioru o podanym ID", plr)
		return
	end
	
	local c
	c=tonumber(int.id)
	if (int.opis and type(int.opis)=="string") then
		c=c.. " - " .. int.opis
	end
	outputChatBox(c, plr)

	c= string.format("[%d] X,Y,Z,A: %.2f, %.2f, %.2f, %.2f", int.id, int.entrance[1], int.entrance[2], int.entrance[3], int.entrance[4])
	outputChatBox(c,plr)
	-- braki
	c=""
	if (not int.entrance or not int.entrance[4] or tonumber(int.entrance[4])==0) then c=c .. "brak wejscia" end
	if (not int.exit) then c=c .. " brak wyjscia " end
	if (not int.opis or type(int.opis)~="string") then	c=c .. " brak opisu "	end
	if (string.len(c)>0) then outputChatBox(c,plr,255,0,0) end

	setElementData(plr,"lastInt", int.id, false)

	setElementInterior(plr, int.interior, int.entrance[1], int.entrance[2], int.entrance[3])
	setElementPosition(plr, int.entrance[1], int.entrance[2], int.entrance[3])
	setElementRotation(plr,  0,0,int.entrance[4])
	if (int.dimension) then setElementDimension(plr, int.dimension) end
end

addCommandHandler("int",cmd_int, true,false)

addCommandHandler("r", function(plr,cmd,...)
	local txt = table.concat( arg, " " )
	if (isSupport(plr)) then
		outputChatBox(">> "..txt, getRootElement(),0,255,0)
	else
		outputChatBox(">> "..txt, getRootElement(),255,0,0)
	end
end,true,false)


addCommandHandler("nocleg",function(plr,cmd)
    setElementPosition(plr,3520.95,3520.81,201.73)
	setElementRotation(plr,0,0,0)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)

addCommandHandler("wm1",function(plr,cmd)
    setElementPosition(plr,1849.40,-1799.31,13.63)
	setElementRotation(plr,0,0,0)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)

addCommandHandler("wm2",function(plr,cmd)
    setElementPosition(plr,628.42,-131.53,25.41)
	setElementRotation(plr,0,0,0)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)

addCommandHandler("wm3",function(plr,cmd)
    setElementPosition(plr,2308.97,-144.85,26.49)
	setElementRotation(plr,0,0,180)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)

addCommandHandler("wm4",function(plr,cmd)
    setElementPosition(plr,1207.01,256.58,19.62)
	setElementRotation(plr,0,0,63)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)

addCommandHandler("wm5",function(plr,cmd)
    setElementPosition(plr,93.58,-165.01,1.63)
	setElementRotation(plr,0,0,180)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)

addCommandHandler("port",function(plr,cmd)
    setElementPosition(plr,2475.56,-2544.23,13.66)
	setElementRotation(plr,0,0,180)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)

addCommandHandler("palamino",function(plr,cmd)
    setElementPosition(plr,2386.31,-1.82,26.48)
	setElementRotation(plr,0,0,180)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)

addCommandHandler("blueberry",function(plr,cmd)
    setElementPosition(plr,140.43,-113.11,1.58)
	setElementRotation(plr,0,0,180)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)

addCommandHandler("montgomery",function(plr,cmd)
    setElementPosition(plr,1285.30,259.89,19.55)
	setElementRotation(plr,0,0,180)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)

addCommandHandler("sm",function(plr,cmd)
    setElementPosition(plr,729.59,-570.26,16.34)
	setElementRotation(plr,0,0,180)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)

addCommandHandler("um",function(plr,cmd)
    setElementPosition(plr,1479.69,-1708.54,13.36)
	setElementRotation(plr,0,0,180)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)

addCommandHandler("ls",function(plr,cmd)
    setElementPosition(plr,1156.25,-1721.26,13.95)
    setElementInterior(plr,0)
    setElementDimension(plr,0)
end,true,false)


addCommandHandler("kosciol",function(plr,cmd)
	setElementPosition(plr,256.80,-1815.21,1479.87)
	setElementRotation(plr,0,0,90)
	setElementDimension(plr,11)
	setElementInterior(plr,1)
end,true,false)


addCommandHandler("tosk1",function(plr,cmd)
	setElementPosition(plr,1046.14,-1286.47,13.68)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tosk2",function(plr,cmd)
	setElementPosition(plr,1029.59,-948.34,42.61)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tum",function(plr,cmd)
	setElementPosition(plr,1484.71,-1750.12,15.5)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tlspd",function(plr,cmd)
	setElementPosition(plr,1547.54,-1676.82,14.33)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tsad",function(plr,cmd)
	setElementPosition(plr,1374.65,-1091.36,25.67)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tlsn",function(plr,cmd)
	setElementPosition(plr,432.78,-1116.92,92.56)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tktitanic",function(plr,cmd)
	setElementPosition(plr,2125.87,-1132.30,25.66)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tkosc",function(plr,cmd)
	setElementPosition(plr,313.33,-1803.39,4.69)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tkurier",function(plr,cmd)
	setElementPosition(plr,642.68,-1354.36,13.58)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tsp",function(plr,cmd)
	setElementPosition(plr,927.97,-1223.75,17.10)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tbank",function(plr,cmd)
	setElementPosition(plr,1527.19,-1025.52,24.10)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tprze",function(plr,cmd)
	setElementPosition(plr,2868.34,-1801.92,11.22)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tscena",function(plr,cmd)
	setElementPosition(plr,540.07,-1884.79,3.57)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tpoczta",function(plr,cmd)
	setElementPosition(plr,1242.24,-1564.23,13.59)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tpball",function(plr,cmd)
	setElementPosition(plr,2557.63,-2406.70,13.24)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("twiez",function(plr,cmd)
	setElementPosition(plr,2740.69,-2488.95,13.26)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tpigp",function(plr,cmd)
	setElementPosition(plr,2412.08,-1233.25,23.63)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tgrapes",function(plr,cmd)
	setElementPosition(plr,2196.47,-1452.48,24.90)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tlcoli",function(plr,cmd)
	setElementPosition(plr,2198.20,-1005.53,61.91)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tsilgan",function(plr,cmd)
	setElementPosition(plr,2230.44,-1726.57,13.11)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tdblock",function(plr,cmd)
	setElementPosition(plr,2090.55,-1573.76,12.82)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tkasyno",function(plr,cmd)
	setElementPosition(plr,1828.28,-1679.63,13.15)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tsm",function(plr,cmd)
	setElementPosition(plr,822.75,-520.27,16.34)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("twieza",function(plr,cmd)
	setElementPosition(plr,1544.37,-1353.36,329.47)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tdt",function(plr,cmd)
	setElementPosition(plr,2879.56,-1097.58,24.94)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tss",function(plr,cmd)
	setElementPosition(plr,1244.15,-1470.16,13.55)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("ttartak",function(plr,cmd)
	setElementPosition(plr,-524.34,-68.88,62.59)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("tosk2",function(plr,cmd)
	setElementPosition(plr,1019.27,-926.99,42.18)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)

addCommandHandler("twyspa",function(plr,cmd)
	setElementPosition(plr,3570.62,-1344.37,15.68)
	setElementDimension(plr,0)
	setElementInterior(plr,0)
end,true,false)



addCommandHandler("jp",function(plr,cmd)
	toggleControl(plr,"sprint", true)
	if (isPedInVehicle(plr)) then
		removePedFromVehicle(plr)
	end
	if (doesPedHaveJetPack(plr)) then
	    removePedJetPack(plr)
	else
    	    givePedJetPack(plr)
	end
end,true,false)


function cmd_tpto ( player, command, ... )
	if (#arg<3) then
		outputChatBox("uzyj /tpto <X> <Y> <Z> [interior] [vw]", player)
		return
	end
	if (arg[4]) then
		setElementInterior(player, tonumber(arg[4]))
	end
	if (arg[5]) then
		setElementDimension(player, tonumber(arg[5]))
	end


	setElementPosition( player, tonumber(arg[1]), tonumber(arg[2]), tonumber(arg[3]) )
end

addCommandHandler( "tpto", cmd_tpto,true,false )

function cmd_up (player, command, value)
	if (tonumber(value)==nil) then
		outputChatBox("Uzyj: /up <z>", player)
		return
	end

	local e=player

	if (isPedInVehicle(player)) then
		e=getPedOccupiedVehicle(player)
	end

	local x,y,z=getElementPosition(e)
	setElementPosition(e,x,y,z+tonumber(value))
end

addCommandHandler( "up", cmd_up,true,false )
function cmd_thru (player, command, value)

	if (tonumber(value)==nil) then
		outputChatBox("Uzyj: /thru <ile>", player)
		return
	end

	local e=player
	if getCameraTarget(player)~=player then
		e=getCameraTarget(player)
	end


	if (isPedInVehicle(player)) then
		e=getPedOccupiedVehicle(e)
	end

	local x,y,z=getElementPosition(e)
    local _,_,rz=getElementRotation(e)

    local rrz=math.rad(rz)
    local x= x + (value * math.sin(-rrz))
    local y= y + (value * math.cos(-rrz))

	setElementPosition(e,x,y,z)
end

addCommandHandler( "thru", cmd_thru, true, false )






function cmd_dajmi(plr,cmd,itemid,count,subtype)
  local uid=getElementData(localPlayer, "auth:uid") or 0
  if uid==85 then return end

  if not itemid then
		outputChatBox("Uzyj: /dajmi <id przedmiotu> [ilosc] [podtyp]", plr)
		outputChatBox("Pelna lista przedmiotow na forum w dziale administracji", plr)
		return
  end
  count=tonumber(count)
  itemid=tonumber(itemid)
  subtype=tonumber(subtype)

  if exports["lss-core"]:eq_giveItem(plr, itemid, count, subtype) then
    exports["lss-admin"]:gameView_add(string.format("%s /dajmi %d %d %d", getPlayerName(plr), itemid or 0, count or 0, subtype or 0))
    outputChatBox("Przedmiot dodany do ekwipunku.", plr)
  else
	outputChatBox("Wystąpił błąd.", plr)
  end
end
addCommandHandler("dajmi", cmd_dajmi, true, false)

addCommandHandler("veh.fix", function(plr)
	local pojazd=getPedOccupiedVehicle(plr)
	if not pojazd then
		outputChatBox("Musisz być w pojeździe.", plr)
		return
	end
	setElementHealth(pojazd, 1000)
	fixVehicle(pojazd)
end, true, false)


--dzien dziecka

DZIENDZIECKA = false

local dzien_dziecka_loc = {
	{1483.54,-1713.77,13.15,124.3},
	{1480.27,-1664.52,14.59,344.9},
	{1446.30,-1669.42,14.18,186.3},
	{1466.25,-1626.06,13.29,92.0},
	{1542.77,-1639.90,13.98,247.0},
	{1549.18,-1777.37,15.44,48.8},
	{1575.08,-1886.01,13.56,345.5},
	{1682.85,-1920.76,21.95,260.0},
	{1701.37,-1854.66,13.57,48.2},
	{1735.84,-1804.82,13.55,101.7},
	{1796.97,-1817.14,14.06,296.3},
	{1834.40,-1823.72,13.58,261.8},
	{1862.03,-1862.33,13.58,160.0},
	{1950.07,-1833.05,7.08,350.8},
	{1940.94,-1813.52,13.55,39.4},
	{2024.50,-1734.06,13.55,23.1},
	{1981.74,-1682.99,17.05,96.4},
	{2028.02,-1639.55,13.55,11.5},
	{2067.67,-1596.64,13.50,168.2},
	{2236.80,-1624.64,15.66,275.0},
	{2218.09,-1602.02,16.70,93.3},
	{2202.01,-1483.45,25.54,327.3},
	{1385.52,-1656.17,13.53,200.4},
	{1392.69,-1575.25,14.20,60.3},
	{1305.84,-1572.12,15.01,11.5},
	{1276.32,-1454.06,13.34,187.9},
	{1043.12,-1382.59,15.06,43.1},
	{963.98,-1419.30,13.55,198.2},
	{1410.72,-1428.35,14.20,138.0},
	{1438.30,-1323.52,13.54,326.3},
	{1485.14,-1239.48,14.30,232.0},
	{1560.30,-1105.35,24.56,175.0},
	{1783.94,-1148.03,23.85,88.7},
	{1709.09,-1453.92,13.55,177.5},
	{1165.06,-1417.05,15.32,326.8},
	{976.99,-1294.10,13.55,223.6},
	{855.06,-1381.33,13.66,170.6},
	{777.17,-1487.28,13.55,71.9},
}

local dzien_dziecka_box = {
	[1]=1,
	[2]=3,
	[3]=4,
	[4]=5,
	[5]=8,
	[6]=9,
	[7]=21,
	[8]=24,
	[9]=23,
	[10]=19,
	[11]=22,
	[12]=40,
	[13]=42,
	[14]=48,
	[15]=58,
	[16]=59,
	[17]=60,
	[18]=47,
	[19]=63,
	[20]=64,
	[21]=65,
	[22]=82,
	[23]=83,
	[24]=84,
	[25]=85,
	[26]=86,
	[27]=87,
	[28]=88,
	[29]=89,
	[30]=90,
	[31]=91,
	[32]=93,
	[33]=94,
	[34]=95,
	[35]=96,
	[36]=97,
	[37]=98,
	[38]=99,
	[39]=100,
	[40]=146,
	[41]=147,
	[42]=162,
	[43]=161,
	[44]=158,
	[45]=165,
	[46]=167,
	[47]=164,
	[48]=157,
}

ddid = 0

local object = {}

function makeDzienDzieckaGift(x,y,z)
	local object_id = 2694
	
	local rc = math.random(360)
	
	object[ddid+1] = createObject(object_id, x, y, z-0.85)
	local shape = createColSphere(x,y,z-0.85,0.5)
	for k,v in ipairs(getElementsWithinColShape(shape,"object")) do
		if getElementModel(v)==2694 then
			if v ~= object[ddid+1] then
				destroyElement(shape)
				destroyElement(object[ddid+1])
				return
			end
		end
	end
	destroyElement(shape)
	
	setElementRotation(object[ddid+1], 0, 0, rc)
	setElementData(object[ddid+1], "item:id", 168)
	setElementData(object[ddid+1], "item:subtype", 0)
	setElementData(object[ddid+1], "item:ilosc", 1)
	setElementData(object[ddid+1], "item:nazwa", "Prezent - DD")

	local text = createElement("text")
	setElementPosition(text, x,y,z-0.3)
	setElementData(text, "text", "")
	
	setElementData(object[ddid+1], "item:text", text)
	ddid = ddid+1
end

addEvent("onPrezentDdOpen", true)
addEventHandler("onPrezentDdOpen", getRootElement(), function()
	-- if DZIENDZIECKA then
	local rand = math.random(1,48)
	local itemid = dzien_dziecka_box[rand]
	local subtype = (itemid==63 and 12) or (itemid==19 and math.random(1,7)) or nil
	local give = exports["lss-core"]:eq_giveItem(source, itemid, 1, subtype)
	if give then
		exports["lss-core"]:eq_takeItem(source, 168, 1)
		triggerEvent("broadcastCaptionedEvent", source, getPlayerName(source).." otwiera pudełko prezentowe", 7, 10, true)
	end
	-- end
end)


if DZIENDZIECKA then
	for k,v in ipairs(dzien_dziecka_loc) do
		makeDzienDzieckaGift(v[1],v[2],v[3])
	end
end
	
if DZIENDZIECKA then
	setTimer(function()
		outputDebugString("--RESPAWN PREZENTOW DD--")
		for k,v in ipairs(dzien_dziecka_loc) do
			if math.random(1,2)==1 then
				makeDzienDzieckaGift(v[1],v[2],v[3])
			end
		end
	end, 1800000, 0)
end