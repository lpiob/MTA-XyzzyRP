--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--



addEvent("setPedAnimation", true)
addEventHandler("setPedAnimation", root, function(block,anim,time,loop,updatePosition,interruptable, freezeLastFrame)
-- triggerServerEvent("setPedAnimation", localPlayer, "SWORD", "sword_block", -1, false, false, true,true)
	if (time==nil) then time=-1 end
	if (loop==nil) then loop=true end
	if (updatePosition==nil) then updatePosition=true end
	if (interruptable==nil) then interruptable=true end
	if (freezeLastFrame==nil) then freezeLastFrame=true end
--	bool setPedAnimation ( ped thePed [, string block=nil, string anim=nil, int time=-1, bool loop=true, bool updatePosition=true, bool interruptable=true, bool freezeLastFrame = true] )
	if getElementData(source, "blockSettingAnimation") then return false end
	if getElementData(source, "menu_usiadz") then detachElements(source, getElementData(source, "menu_usiadz"))  end
	setPedAnimation(source, block, anim, time, loop, updatePosition, interruptable, freezeLastFrame)

end)

for k,v in ipairs(getElementsByType("player")) do
	setElementData(v, "animStartPos", false)
	setElementCollisionsEnabled(v,true)
end



addEvent("setElementCollisionsEnabledAnim", true)
addEventHandler("setElementCollisionsEnabledAnim", root, function(state)
	-- setElementCollisionsEnabled(source,state)
	-- triggerClientEvent("setElementCollisionsEnabledAnimC", getRootElement(), source, state)
end)

addEvent("setPedAnimationProgress", true)
addEventHandler("setPedAnimationProgress", root, function(anim,progress)
--    setPedAnimationProgress(source, anim, progress)	-- crash http://bugs.mtasa.com/view.php?id=7068#bugnotes
    triggerClientEvent(root, "setPedAnimationProgress", source, anim, progress)
end)

addCommandHandler("sex1",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end

	setPedAnimation ( plr, "sex", "sex_1_cum_p", -1, true, false )
end)

addCommandHandler("sex2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end

	setPedAnimation ( plr, "sex", "sex_1_cum_w", -1, true, false )
end)


addCommandHandler("dzwonisz",function(plr,cmd)
--[[
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
]]--
	setPedAnimation( plr, "ped", "phone_in", -1, false, false, false, true)
--	setPedAnimation ( plr, "ped", "handsup", -1, false, false )
end)


-- animacje zaimportowane z BestPlay i wykonane przez wujka <wube@bestplay.pl>

addCommandHandler("rece",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "handsup", -1, false, false )
end)

addCommandHandler("taichi",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "PARK", "Tai_Chi_Loop", -1, true, false )
end)

addCommandHandler("predator",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "BSKTBALL", "BBALL_def_loop", -1, true, false )
end)

addCommandHandler("podkrecasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "BAR", "Barserve_glass", -1, false, false )
end)

addCommandHandler("podsluchujesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "BAR", "Barserve_order", -1, false, false )
end)

addCommandHandler("pijesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "BAR", "dnk_stndM_loop", -1, true, false )
end)


addCommandHandler("taniec",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CHAINSAW", "CSAW_Hit_2", -1, true, true )
end)

addCommandHandler("taniec2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "SKATE", "skate_idle", -1, true, false )
end)

addCommandHandler("taniec3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "STRIP", "strip_B", -1, true, false )
end)

addCommandHandler("taniec4",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "DANCING", "dance_loop", -1, true, false )
end)

addCommandHandler("taniec5",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "DANCING", "DAN_Down_A", -1, true, false )
end)

addCommandHandler("taniec6",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "STRIP", "strip_G", -1, true, false )
end)

addCommandHandler("taniec7",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "STRIP", "STR_C2", -1, true, false )
end)

addCommandHandler("taniec8",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "DANCING", "dnce_M_b", -1, true, false )
end)

addCommandHandler("taniec9",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "DANCING", "DAN_Loop_A", -1, true, false )
end)

addCommandHandler("taniec10",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "DANCING", "dnce_M_d", -1, true, false )
end)

addCommandHandler("taniec11",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "STRIP", "strip_D", -1, true, false )
end)

addCommandHandler("taniec12",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "STRIP", "strip_E", -1, true, false )
end)

addCommandHandler("taniec13",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "STRIP", "STR_Loop_A", -1, true, false )
end)

addCommandHandler("taniec14",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "STRIP", "STR_Loop_B", -1, true, false )
end)

addCommandHandler("taniec15",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "FINALE", "FIN_Cop1_Stomp", -1, true, false )
end)

addCommandHandler("taniec16",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "DANCING", "dnce_M_a", -1, true, false )
end)

addCommandHandler("taniec17",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GFUNK", "Dance_G10", -1, true, false )
end)

addCommandHandler("taniec18",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GFUNK", "Dance_G11", -1, true, false )
end)

addCommandHandler("taniec19",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GFUNK", "Dance_G12", -1, true, false )
end)

addCommandHandler("taniec20",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "RUNNINGMAN", "Dance_B1", -1, true, false )
end)

addCommandHandler("palisz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "LOWRIDER", "M_smklean_loop", -1, true, false )
end)

addCommandHandler("lezysz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "BEACH", "Lay_Bac_Loop", -1, true, false )
end)

addCommandHandler("lezysz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CRACK", "crckidle2", -1, true, false )
end)

addCommandHandler("lezysz3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CRACK", "crckidle4", -1, true, false )
end)

addCommandHandler("lezysz4",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "BEACH", "ParkSit_W_loop", -1, false, false )
end)

addCommandHandler("lezysz5",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "BEACH", "SitnWait_loop_W", -1, true, false )
end)

addCommandHandler("siedzisz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "BEACH", "ParkSit_M_loop", -1, true, false )
end)

addCommandHandler("siedzisz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "INT_OFFICE", "OFF_Sit_Idle_Loop", -1, true, false )
end)

addCommandHandler("siedzisz3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "JST_BUISNESS", "girl_02", -1, false, false )
end)

addCommandHandler("klekasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CAMERA", "camstnd_to_camcrch", -1, false, false )
end)

addCommandHandler("klekasz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "COP_AMBIENT", "Copbrowse_nod", -1, true, false )
end)

addCommandHandler("czekasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "COP_AMBIENT", "Coplook_loop", -1, true, false )
end)

addCommandHandler("akrobata",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "DAM_JUMP", "DAM_Dive_Loop", -1, false, false )
end)

addCommandHandler("msza",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "DEALER", "DEALER_IDLE", -1, true, false )
end)

addCommandHandler("msza2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GRAVEYARD", "mrnM_loop", -1, false, false )
end)

addCommandHandler("znakkrzyza",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GANGS", "hndshkcb", -1, true, false )
end)

addCommandHandler("rzygasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "FOOD", "EAT_Vomit_P", -1, true, false )
end)

addCommandHandler("jesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "FOOD", "EAT_Burger", -1, true, false )
end)

addCommandHandler("cpun1",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GANGS", "drnkbr_prtl", -1, true, false )
end)

addCommandHandler("cpun2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GANGS", "smkcig_prtl", -1, true, false )
end)

addCommandHandler("cpun3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CRACK", "Bbalbat_Idle_01", -1, true, false )
end)

addCommandHandler("cpun4",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CRACK", "Bbalbat_Idle_02", -1, true, false )
end)

addCommandHandler("witasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GANGS", "hndshkba", -1, true, false )
end)

addCommandHandler("rozmawiasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GANGS", "prtial_gngtlkH", -1, true, false )
end)

addCommandHandler("rozmawiasz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GANGS", "prtial_gngtlkG", -1, true, false )
end)

addCommandHandler("rozmawiasz3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GANGS", "prtial_gngtlkD", -1, true, false )
end)

addCommandHandler("nerwowy",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GHANDS", "gsign2", -1, true, false )
end)

addCommandHandler("piszesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "INT_OFFICE", "OFF_Sit_Type_Loop", -1, true, false )
end)

addCommandHandler("gay",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "WOMAN_walksexy", -1, true, true )
end)

addCommandHandler("gay2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "WOMAN_walkpro", -1, true, true )
end)

addCommandHandler("gay3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "WOMAN_runsexy", -1, true, true )
end)

addCommandHandler("wreczasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "KISSING", "gift_give", -1, false, false )
end)

addCommandHandler("machasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "KISSING", "gfwave2", -1, true, false )
end)

addCommandHandler("walisz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "PAULNMAC", "wank_loop", -1, true, false )
end)

addCommandHandler("walisz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "MISC", "Scratchballs_01", -1, true, false )
end)

addCommandHandler("sikasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "PAULNMAC", "Piss_loop", -1, true, false )
end)

addCommandHandler("pijany",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "WALK_drunk", -1, true, true )
end)

addCommandHandler("pijany2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "PAULNMAC", "PnM_Loop_A", -1, true, false )
end)

addCommandHandler("pijany3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "PAULNMAC", "PnM_Argue2_A", -1, true, false )
end)

addCommandHandler("rapujesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "SCRATCHING", "scmid_l", -1, true, false )
end)

addCommandHandler("rapujesz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "SCRATCHING", "scdldlp", -1, true, false )
end)

addCommandHandler("rapujesz3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "Flowers", "Flower_Hit", -1, true, false )
end)

addCommandHandler("rapujesz4",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "RAPPING", "RAP_C_Loop", -1, true, false )
end)

addCommandHandler("rapujesz5",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "RAPPING", "RAP_B_Loop", -1, true, false )
end)

addCommandHandler("rapujesz6",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "SCRATCHING", "scdrdlp", -1, true, false )
end)

addCommandHandler("rapujesz7",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "SCRATCHING", "scdrulp", -1, true, false )
end)

addCommandHandler("rapujesz8",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "RAPPING", "RAP_A_Loop", -1, true, false )
end)
--[[
addCommandHandler("rolki",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "SKATE", "skate_run", -1, true, true )
end)

addCommandHandler("rolki2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "SKATE", "skate_sprint", -1, true, true )
end)
--]]
addCommandHandler("umierasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "FLOOR_hit_f", -1, false, false )
end)

addCommandHandler("umierasz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "FLOOR_hit", -1, false, false )
end)

addCommandHandler("bijesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "BASEBALL", "Bat_M", -1, true, false )
end)

addCommandHandler("bijesz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "RIOT", "RIOT_PUNCHES", -1, true, false )
end)

addCommandHandler("bijesz3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "FIGHT_B", "FightB_M", -1, true, false )
end)

addCommandHandler("bijesz4",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "MISC", "bitchslap", -1, true, false )
end)

addCommandHandler("bijesz5",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "BIKE_elbowR", -1, true, false )
end)

addCommandHandler("wolasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "RYDER", "RYD_Beckon_01", -1, true, false )
end)

addCommandHandler("wolasz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "POLICE", "CopTraf_Come", -1, true, false )
end)

addCommandHandler("wolasz3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "RYDER", "RYD_Beckon_02", -1, true, false )
end)

addCommandHandler("zatrzymujesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "POLICE", "CopTraf_Stop", -1, true, false )
end)

addCommandHandler("wskazujesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "SHOP", "ROB_Loop", -1, true, false )
end)

addCommandHandler("rozgladasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ON_LOOKERS", "lkaround_loop", -1, true, false )
end)

addCommandHandler("krzyczysz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ON_LOOKERS", "shout_in", -1, true, false )
end)

addCommandHandler("fuckyou",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "RIOT", "RIOT_FUKU", -1, true, false )
end)

addCommandHandler("tchorz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "cower", -1, false, false )
end)

addCommandHandler("kopiesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GANGS", "shake_carK", -1, true, false )
end)

addCommandHandler("kopiesz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "FIGHT_D", "FightD_G", -1, true, false )
end)

addCommandHandler("kopiesz3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "FIGHT_C", "FightC_3", -1, false )
end)

addCommandHandler("wywazasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GANGS", "shake_carSH", -1, true, false )
end)

addCommandHandler("wywazasz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "POLICE", "Door_Kick", -1, true, false )
end)

addCommandHandler("kieszen",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GANGS", "leanIDLE", -1, true, false )
end)

addCommandHandler("celujesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "ARRESTgun", -1, false, false )
end)

addCommandHandler("kichasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "VENDING", "vend_eat1_P", -1, true, false )
end)

addCommandHandler("pocalunek",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "BD_FIRE", "Grlfrd_Kiss_03", -1, true, false )
end)

addCommandHandler("taxi",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "MISC", "Hiker_Pose", -1, false, false )
end)

addCommandHandler("taxi2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "MISC", "Hiker_Pose_L", -1, false, false )
end)

addCommandHandler("noga",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "SHOP", "SHP_Jump_Glide", -1, false, false )
end)

addCommandHandler("pozegnanie",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "BD_FIRE", "BD_Panic_03", -1, true, false )
end)

addCommandHandler("cud",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CARRY", "crry_prtial", -1, true, false )
end)

addCommandHandler("cud2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ON_LOOKERS", "Pointup_loop", -1, false, false )
end)

addCommandHandler("delirium",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CRACK", "crckdeth1", -1, false )
end)

addCommandHandler("delirium2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CRACK", "crckdeth2", -1, true, false )
end)

addCommandHandler("delirium3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CRACK", "crckidle3", -1, true, false )
end)

addCommandHandler("delirium4",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CHAINSAW", "csaw_part", -1, true, false )
end)

addCommandHandler("delirium5",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CASINO", "Roulette_loop", -1, true, false )
end)

addCommandHandler("naprawiasz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CAR", "flag_drop", -1, true, false )
end)

addCommandHandler("naprawiasz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CAR", "Fixn_Car_Loop", -1, true, false )
end)

addCommandHandler("placzesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GRAVEYARD", "mrnF_loop", -1, true, false )
end)

addCommandHandler("kibicujesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "RIOT", "RIOT_ANGRY_B", -1, true, false )
end)

addCommandHandler("kibicujesz2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ON_LOOKERS", "wave_loop", -1, true, false )
end)

addCommandHandler("bioenergoterapeuta",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "WUZI", "Wuzi_Greet_Wuzi", -1, true, false )
end)

addCommandHandler("meteorolog",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "WUZI", "Wuzi_grnd_chk", -1, true, false )
end)

addCommandHandler("klepiesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "SWEET", "sweet_ass_slap", -1, true, false )
end)

addCommandHandler("cierpisz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "SWEET", "Sweet_injuredloop", -1, true, false )
end)

addCommandHandler("cierpisz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "SWEET", "Sweet_injuredloop", -1, true, false )
end)

addCommandHandler("starzec",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "WALK_shuffle", -1, true, true )
end)

addCommandHandler("starzec2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "WOMAN_walkfatold", -1, true, true )
end)

addCommandHandler("starzec3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "ped", "WOMAN_walkshop", -1, true, true )
end)

addCommandHandler("reanimujesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "MEDIC", "CPR", -1, false, false )
end)

addCommandHandler("myjesz",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CASINO", "dealone", -1, true, false )
end)

addCommandHandler("zadowolony",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CASINO", "manwind", -1, true, false )
end)

addCommandHandler("zadowolony2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CASINO", "manwinb", -1, true, false )
end)

addCommandHandler("zalamany",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "CASINO", "Roulette_lose", -1, true, false )
end)

addCommandHandler("zmeczony",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "FAT", "IDLE_tired", -1, true, false )
end)

addCommandHandler("ochnie",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "MISC", "plyr_shkhead", -1, true, false )
end)

addCommandHandler("cwaniak1",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GHANDS", "gsign1", -1, true, false )
end)

addCommandHandler("cwaniak2",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GHANDS", "gsign1LH", -1, true, false )
end)

addCommandHandler("cwaniak3",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GHANDS", "gsign2", -1, true, false )
end)

addCommandHandler("cwaniak4",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GHANDS", "gsign2LH", -1, true, false )
end)

addCommandHandler("cwaniak5",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GHANDS", "gsign3", -1, true, false )
end)

addCommandHandler("cwaniak6",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GHANDS", "gsign3LH", -1, true, false )
end)

addCommandHandler("cwaniak7",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GHANDS", "gsign4", -1, true, false )
end)

addCommandHandler("cwaniak8",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GHANDS", "gsign4LH", -1, true, false )
end)


addCommandHandler("cwaniak9",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GHANDS", "gsign5", -1, true, false )
end)

addCommandHandler("cwaniak10",function(plr,cmd)
	if (isPedInVehicle(plr)) then
		outputChatBox("Najpierw wysiadz z pojazdu", plr)
		return
	end
	setPedAnimation ( plr, "GHANDS", "gsign5LH", -1, true, false )
end)
