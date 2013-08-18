--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



laweczka_win = guiCreateWindow(0.6906,0.4208,0.2937,0.2042,"Ławeczka",true)
laweczka_progress1 = guiCreateProgressBar(0.0798,0.1981,0.8351,0.2007,true,laweczka_win)
laweczka_progress2 = guiCreateProgressBar(0.0798,0.6781,0.8351,0.2007,true,laweczka_win)
laweczka_progress3 = guiCreateProgressBar(0.0798,0.4341,0.8351,0.2007,true,laweczka_win)
guiSetVisible(laweczka_win,false)


local laweczka_active=false
local laweczka_value=0
local laweczka_energy=0

local function laweczka_finish()
  if (laweczka_active) then
     triggerServerEvent("onPlayerHangSztanga", laweczka_active.sztanga, laweczka_active.laweczka, localPlayer)
  end
  laweczka_active=false
  guiSetVisible(laweczka_win,false)

end

local function laweczka_update()
    guiProgressBarSetProgress(laweczka_progress1, getPedStat(localPlayer, 164)/999*100)
    guiProgressBarSetProgress(laweczka_progress2, laweczka_energy)
    guiProgressBarSetProgress(laweczka_progress3, laweczka_value/10)

end

local lku=getTickCount()

function laweczkakey()
  if (not laweczka_active) then
	unbindKey("space","down",laweczkakey)
	return
  end
  if (getTickCount()-lku<100) then
	return
  end
  lku=getTickCount()
  laweczka_energy=laweczka_energy+(getPedStat(localPlayer, 164)+500)/100
  if (laweczka_energy>100) then laweczka_energy=100 end
  if (laweczka_energy==100) then 
    laweczka_value=laweczka_value+100-(getPedStat(localPlayer, 164)/999*80)
    triggerServerEvent("setPedAnimation", localPlayer, "benchpress", "gym_bp_up_B", -1, false, false)
    laweczka_energy=0
  end
--  laweczka_value=laweczka_value+(laweczka_energy/25)
end


local function laweczka_loop()
  local a1,a2=getPedAnimation(localPlayer)
  if (not laweczka_active or not a1 or a1~="benchpress") then
	laweczka_finish()
	return
  end
    laweczka_energy=laweczka_energy-1
    if (laweczka_energy<0) then laweczka_energy=0 end
    triggerServerEvent("setPedAnimationProgress", localPlayer, "gym_bp_up_B", laweczka_energy/100)
  laweczka_update()
    if (laweczka_value>1000) then
	
	triggerServerEvent("onLaweczkaProgress", localPlayer)
	laweczka_value=0
    end

  setTimer(laweczka_loop, 100, 1)
end

local function isLaweczkaInUse(i)
    local gracze=getElementsByType("player", root, true)
    local rrz=math.rad(i[4]+180)
    local x2= i[1] + (2 * math.sin(-rrz))
    local y2= i[2] + (2 * math.cos(-rrz))
    
    for i2,v in ipairs(gracze) do
	if (v~=localPlayer) then
		local x,y,z=getElementPosition(v)
--outputDebugString(string.format("%d %d %d <> %d %d %d", x,y,z, x2,y2,bieznie[i][3]))
		if (getDistanceBetweenPoints3D(x,y,z,x2,y2,i[3])<2) then
		    return true
		end
	end
    end
    return false
end


function menu_laweczka(args)
--  outputChatBox("(( Laweczka w przygotowaniu, skorzystaj z bieżni. ))")
--  if (getPlayerName(localPlayer)~="Shawn_Hanks" and getPlayerName(localPlayer)~="Peter_O'Connor") then return end


  local x,y,z=getElementPosition(localPlayer)
  if (getDistanceBetweenPoints3D(x,y,z,args[1],args[2],args[3])>5) then
    outputChatBox("Podejdź bliżej.", 255,0,0)
    return
  end


  if (laweczka_active) then
    triggerServerEvent("setPedAnimation", localPlayer, "benchpress", "gym_bp_getoff", -1, false, false, false, false)
    local lw=laweczka_active
    laweczka_active=nil    
    setTimer(triggerServerEvent, 2000, 1, "onPlayerHangSztanga", lw.sztanga, lw.laweczka, localPlayer)
    laweczka_finish()

    return
  end
  if (isLaweczkaInUse(args)) then
    outputChatBox("Ta ławeczka jest obecnie zajęta.", 255,0,0)
    return
  end
  laweczka_active=args
  -- obliczamy pozycje za bieznia
  local rrz=math.rad(args[4]+180)
  local x2= args[1] + (1 * math.sin(-rrz))
  local y2= args[2] + (1 * math.cos(-rrz))
  setElementPosition(localPlayer, x2,y2,args[3])
    setElementRotation(localPlayer, 0,0,args[4])
--  triggerServerEvent("setPedAnimation" , localPlayer, "GYMNASIUM", "gym_tread_geton",-1,false,false)
  triggerServerEvent("setPedAnimation", localPlayer, "benchpress", "gym_bp_geton", -1, false, false)
  setTimer(function()
	local a1=getPedAnimation(localPlayer)
	if (a1~="benchpress") then return end	-- gracz wcisnal enter w trakcie siadania
	triggerServerEvent("onPlayerPickSztanga", args.sztanga, localPlayer)
	laweczka_value=0
	laweczka_energy=0
	laweczka_loop()
	bindKey("space","down",laweczkakey)
	guiSetVisible(laweczka_win,true)
  end, 3900, 1)
  setTimer(function()
    local a1=getPedAnimation(localPlayer)
    if (a1~="benchpress") then return end	-- gracz wcisnal enter w trakcie siadania

    triggerServerEvent("setPedAnimation", localPlayer, "benchpress", "gym_bp_up_B", -1, false, false)
  end, 5000, 1)

end
