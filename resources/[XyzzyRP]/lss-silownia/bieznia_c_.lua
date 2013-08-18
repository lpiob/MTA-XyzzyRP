--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local bieznie={
  -- pozycja biezni: x,y,z,rz,i,d
  -- plaza
--  {661.61,-1864.04,4.46,0,0,0},
--  {664.61,-1864.04,4.46,0,0,0},
  -- silownia w dzilenicy grove street
  {2443.44,-1686.41,1408.74,270,1,24},
  {2443.44,-1689.17,1408.74,270,1,24},

  -- silownia w dzielnicy ganton
  {2240.49,-1709.21,1999.71,0,2,15},  
  {2242.64,-1709.21,1999.71,0,2,15},
  
  -- silownia w dzielnicy richman
  {787.23,-1030.38,1999.71,270,2,21},
  {787.23,-1028.85,1999.71,270,2,21},
  
  -- silownia w montgomery
  {1312.09,380.99,2199.66,180,2,22},
  {1306.85,386.79,2199.66,90,2,22}, 

	-- silownia w wiezieniu
  {2708.63,-2749.76,6.1901,179,0,35},
  {2706.31,-2749.75,6.1901,180,0,35},


}

for i,v in ipairs(bieznie) do
  v.obiekt=createObject(2627,v[1],v[2],v[3],0,0,v[4])
  setElementInterior(v.obiekt, v[5])
  setElementDimension(v.obiekt, v[6])
  
  setElementData(v.obiekt,"customAction",{label="Skorzystaj",resource="lss-silownia",funkcja="menu_bieznia",args={indeks=i}})
end



--[[ staty
165: ENERGY
225: UNDERWATER_STAMINA

]]--

local treadvalue=0
treadmill_win = guiCreateWindow(0.6906,0.4208,0.2937,0.2042,"Bieżnia",true)
treadmill_progress1 = guiCreateProgressBar(0.0798,0.1981,0.8351,0.2007,true,treadmill_win)
treadmill_progress2 = guiCreateProgressBar(0.0798,0.6781,0.8351,0.2007,true,treadmill_win)
treadmill_progress3 = guiCreateProgressBar(0.0798,0.4341,0.8351,0.2007,true,treadmill_win)
guiSetVisible(treadmill_win,false)


--createObject(2627,664.25,-1864.37,4.46,0,0,90)

local treadenergy=50
local treadmill_active=false
function treadkey()
--  outputDebugString("S")
  if (not treadmill_active) then
	unbindKey("space","down",treadkey)
	return
  end
  treadenergy=treadenergy+(getPedStat(localPlayer, 225)+500)/500
  if (treadenergy>100) then treadenergy=100 end
  treadvalue=treadvalue+(treadenergy/25)
end

local function treadprogress()
    guiProgressBarSetProgress(treadmill_progress1, getPedStat(localPlayer, 225)/999*100)
    guiProgressBarSetProgress(treadmill_progress2, treadenergy)
    guiProgressBarSetProgress(treadmill_progress3, treadvalue/10)
end

local function tread_off()
	treadmill_active=false
	guiSetVisible(treadmill_win,false)

end



local function tread_loop()
	if (not treadmill_active) then tread_off() return end
    local old_treadenergy=treadenergy
    treadenergy=treadenergy-(1100-getPedStat(localPlayer, 225))/400
    if (treadenergy<0) then
	treadenergy=0
    end
    treadvalue=treadvalue+(treadenergy/100)
--  outputDebugString(tostring(treadvalue))
    if (treadvalue>1000) then
	triggerServerEvent("onTreadProgress", localPlayer)
	treadvalue=0
    end

    treadprogress()
    local a1,a2=getPedAnimation(localPlayer)
--  outputDebugString(a1 .. " " .. a2)
    if (not a1 or a1~="gymnasium") then 
	tread_off()
	setPedAnimation(localPlayer)
	return
    end
    if (treadenergy==0 or old_treadenergy==100) then
		triggerServerEvent("setPedAnimation", localPlayer, "GYMNASIUM", "gym_tread_falloff",-1,false,false)
		setTimer(triggerServerEvent, 1500, 1, "setPedAnimation", localPlayer)
		tread_off()
		return
	elseif (a2=="gym_tread_geton") then
        triggerServerEvent("setPedAnimation", localPlayer, "GYMNASIUM", "gym_tread_walk",-1,true,false)
	elseif (treadenergy<50) then
		if (a2~="gym_tread_walk") then
          triggerServerEvent("setPedAnimation", localPlayer, "GYMNASIUM", "gym_tread_walk",-1,true,false)
		end
	elseif (treadenergy<75) then
		if (a2~="gym_tread_jog") then
          triggerServerEvent("setPedAnimation", localPlayer, "GYMNASIUM", "gym_tread_jog",-1,true,false)
		end
	else 
		if (a2~="gym_tread_sprint") then	triggerServerEvent("setPedAnimation", localPlayer, "GYMNASIUM", "gym_tread_sprint",-1,true,false) end
    end
	
    if (treadmill_active) then
	setTimer(tread_loop, 500, 1)
    end
end
--[[
addCommandHandler("Xr", function()
    setElementPosition(localPlayer, 665.66,-1864.38,5.45)
    setElementRotation(localPlayer, 0,0,90)
    setPedAnimation(localPlayer, "GYMNASIUM", "gym_tread_geton",-1,false,false)
    treadmill_active=true
    treadenergy=50
    treadprogress()
    guiSetVisible(treadmill_win,true)
    setTimer(tread_loop, 2500, 1)
    --setPedAnimation(localPlayer, "GYMNASIUM", "gym_bike_fast",-1,true,false)
end)
]]--

local function isTreadInUse(i)
    local gracze=getElementsByType("player", root, true)
    local rrz=math.rad(bieznie[i][4]+180)
    local x2= bieznie[i][1] + (2 * math.sin(-rrz))
    local y2= bieznie[i][2] + (2 * math.cos(-rrz))
    
    for i,v in ipairs(gracze) do
	if (v~=localPlayer) then
		local x,y,z=getElementPosition(v)
--outputDebugString(string.format("%d %d %d <> %d %d %d", x,y,z, x2,y2,bieznie[i][3]))
		if (getDistanceBetweenPoints3D(x,y,z,x2,y2,bieznie[i][3])<1.5) then
		    return true
		end
	end
    end
    return false
end

function menu_bieznia(args)
  local i=args.indeks
  
  local x,y,z=getElementPosition(localPlayer)
  if (getDistanceBetweenPoints3D(x,y,z,bieznie[i][1],bieznie[i][2],bieznie[i][3])>5) then
    outputChatBox("Podejdź bliżej.", 255,0,0)
    return
  end
  if (isTreadInUse(i)) then
    outputChatBox("Ta bieżnia nie jest obecnie wolna.", 255,0,0)
    return
    
  end
  
  
  if (treadmill_active) then
	treadmill_active=false
	triggerServerEvent("setPedAnimation", localPlayer, "GYMNASIUM", "gym_tread_getoff",-1,false,false,false,false)
	setTimer(triggerServerEvent, 1500, 1, "setPedAnimation", localPlayer)
	return
  end

  -- obliczamy pozycje za bieznia
    local rrz=math.rad(bieznie[i][4]+180)
    local x2= bieznie[i][1] + (2 * math.sin(-rrz))
    local y2= bieznie[i][2] + (2 * math.cos(-rrz))
	setElementPosition(localPlayer, x2,y2,bieznie[i][3]+1)
	setElementRotation(localPlayer, 0,0,bieznie[i][4])
    triggerServerEvent("setPedAnimation" , localPlayer, "GYMNASIUM", "gym_tread_geton",-1,false,false)
    treadmill_active=true
    treadenergy=50
	treadvalue=0
    treadprogress()
    guiSetVisible(treadmill_win,true)
    setTimer(tread_loop, 2500, 1)

  bindKey("space","down",treadkey)

end