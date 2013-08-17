--[[
	burdel w Pig Pen kolo GS
]]--

local marker=createMarker(1204.9,12.31,1000,"cylinder",1,255,0,0,100)
setElementInterior(marker, 2)
setElementDimension(marker,0)


local zajete=false
local skiny_dziwek = { 63, 64, 87, 92, 138,140, 145,178,199 }

function burdelAkcja(plr,matchingDimension)
	if (not matchingDimension) then return end
	if (zajete) then
--		triggerClientEvent ( plr, "onAnnouncement", plr, "Zajete :-)", 3 )
		outputChatBox("Zajęte...", plr, 255,0,0,true)
		return
	end
	if (getPlayerMoney(plr)<15) then
--		triggerClientEvent ( plr, "onAnnouncement", plr, "5000$ za numerek", 3 )
		outputChatBox("15$ za numerek!", plr, 255,0,0,true)
		return
	end
	setElementFrozen(plr,true)
	toggleAllControls ( plr, false, true, false )
	fadeCamera(plr,false)

	zajete=true
	local dziwka=createPed(skiny_dziwek[math.random(1,#skiny_dziwek)], 1203.74,19.93,1000.92)

	setTimer(function()
		fadeCamera(plr,true)
		setElementInterior(dziwka,2)
		setElementDimension(dziwka,0)
		setElementRotation(dziwka,0,0,185)

		setCameraMatrix(plr,1201.92,13.58,1002.0,1204.03,16.60,1000.92,0,100)
		setElementInterior(plr,2,1204.20,16.89,1000.92)
		setElementDimension(plr,0)
		setElementPosition(plr,1204.20,16.89,1000.92)
		setElementRotation(plr,0,0,155)
		setElementPosition(dziwka, 1203.74,	16.36,1000.92)
		setElementRotation(dziwka, 0,0,322)
		setPedAnimation(plr, "BLOWJOBZ", "BJ_COUCH_START_P",-1,false,false)
		setPedAnimation(dziwka, "BLOWJOBZ", "BJ_COUCH_START_W",-1,false,false)
	end, 1000, 1)

	setTimer(function()
		setPedAnimation(plr, "BLOWJOBZ", "BJ_COUCH_LOOP_P",-1,true,false);
		setPedAnimation(dziwka, "BLOWJOBZ", "BJ_COUCH_LOOP_W",-1,true,false);
		end, 3000,1)

	local odstep=math.random(4000,12000)
	setTimer(function()
		setPedAnimation(plr, "BLOWJOBZ", "BJ_COUCH_END_P", -1, false, false);
		setPedAnimation(dziwka, "BLOWJOBZ", "BJ_COUCH_END_W", -1, false, false);

		end, 7000+odstep,1)

	setTimer(function()
			fadeCamera(plr,false)
		end, 14000+odstep,1)

	setTimer(function()
			destroyElement(dziwka)
			fadeCamera(plr,true)
			setPedAnimation(plr)
			setElementPosition(plr,1204.76,11.13,1000.92)
			setElementRotation(plr,0,0,181)
			setElementFrozen(plr,false)
			toggleAllControls(plr,true)
			setCameraTarget(plr,plr)
			zajete=false
			takePlayerMoney(plr,100)
		end, 14000+odstep+1000,1)
end

addEventHandler( "onMarkerHit", marker, burdelAkcja )

--[[
	programowanie w LUA to poezja
]]--
