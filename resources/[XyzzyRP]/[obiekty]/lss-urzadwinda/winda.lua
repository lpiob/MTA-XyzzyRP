local I=1
local D=1
local aktualne_pietro=1
local winda_w_ruchu=false


local lapaczcs=createColCuboid(1470, -1820, 1129, 40, 40, 1)
setElementInterior(lapaczcs,I)
setElementDimension(lapaczcs,D)

local szybcs=createColCuboid(1480, -1811, 1130, 5, 8, 180)
setElementInterior(szybcs, I)
setElementDimension(szybcs, D)

addEventHandler("onColShapeHit", lapaczcs, function(el,md)
  if (not md) then return end
  if (getElementType(el)~="player") then return end
  setElementPosition(el,1477.16,-1805.72,1132.96)
end,false)

local X,Y=1482.8193359375,-1808.0771484375
local CZAS_NA_PIETRO=10*1000
local winda_stop_time=getTickCount()

local pietra={
    1133.2076416016,
    1163.2076416016,
    1193.2076416016,
    1223.2076416016,
    1253.2076416016,
    1286.2076416016,
}

local queue={true}	-- zatrzymujemy się na pierwszym piętrze

local drzwiNaPietrach={}
for i,v in ipairs(pietra) do
    drzwiNaPietrach[i]={
	createObject(16501, X+3.55,Y+1, v,0,0,90),
	createObject(16501, X-3.55,Y+1, v,0,0,90)
    }
    setElementInterior(drzwiNaPietrach[i][1],I)
    setElementDimension(drzwiNaPietrach[i][1],D)
    setElementInterior(drzwiNaPietrach[i][2],I)
    setElementDimension(drzwiNaPietrach[i][2],D)
end

local function wysokoscNaPietro(z)
--[[ 
	  x								(x-1103)/30 = 
    1133.2076416016,					30/30=1
    1163.2076416016,					60/30=2
    1193.2076416016,					90/30=3
    1223.2076416016,					120/30=4
    1253.2076416016,					150/30=5
    1286.2076416016,					160/30=6
}
]]--
  return math.floor((tonumber(z)-1103)/30)
end



local boks=createObject(14824, X,Y, pietra[1])
setElementInterior(boks,I)
setElementDimension(boks,D)



local keypad=createObject(2922, 0,0,0)
setElementInterior(keypad,I)
setElementDimension(keypad,D)
attachElements(keypad,boks,  -1482.8193359375+1484.525390625, 0, pietra[1]-1133.23731995,0,0,90)
--     <object id="winda_u4" doublesided="true" model="2922" interior="1" dimension="1" posX="1484.58496094" posY="-1808.01489258" posZ="1133.23731995" rotX="0" rotY="0" rotZ="9

local drzwiL=createObject(985,X+5.4,Y+0.7,pietra[1])
--    <object id="winda_u2" doublesided="true" model="985" interior="1" dimension="1" posX="1486.7485351563" posY="-1807.40625" posZ="1133.5249023438" rotX="0" rotY="0" rotZ="0"^                                                                                         
setElementInterior(drzwiL,I)
setElementDimension(drzwiL,D)
--attachElements(drzwiL, boks,4,0.9,-2)

local drzwiR=createObject(986,X-5.4,Y+0.7,pietra[1])
--    <object id="winda_u2" doublesided="true" model="985" interior="1" dimension="1" posX="1486.7485351563" posY="-1807.40625" posZ="1133.5249023438" rotX="0" rotY="0" rotZ="0"^                                                                                         
setElementInterior(drzwiR,I)
setElementDimension(drzwiR,D)
--attachElements(drzwiR, boks,-4,0.9,-2)

local boks2=createObject(14824, 0,0,0)
setElementInterior(boks2,I)
setElementDimension(boks2,D)
attachElements(boks2,boks,  -1482.8193359375+1486.3043212891, 0, pietra[1]-1133.23731995,0,0,90)


local function drzwiWindyOtwarte()
    local x=getElementPosition(drzwiL)
    return (x>(X+4))
end


--moveObject(drzwiR, 5000,0,0.9,-2)

local function otworzDrzwiNaPietrach(ktore)
    for i,v in ipairs(pietra) do
	if (ktore==i) then
	    moveObject(drzwiNaPietrach[i][1], 1500, X+5,Y+1, v)
	    moveObject(drzwiNaPietrach[i][2], 1500, X-5,Y+1, v)
	else
	    moveObject(drzwiNaPietrach[i][1], 1500, X+3.55,Y+1, v)
	    moveObject(drzwiNaPietrach[i][2], 1500, X-3.55,Y+1, v)
	end
    end
end

local function drzwiWindy(stan)
--  if (drzwiWindyOtwarte()==stan) then return 0 end
    if (stan) then
		otworzDrzwiNaPietrach(aktualne_pietro)
		setTimer(function()
        moveObject(drzwiL, 1000, X+5.4,Y+0.7,pietra[aktualne_pietro])
        moveObject(drzwiR, 1000, X-5.4,Y+0.7,pietra[aktualne_pietro])
		end, 500, 1)
    else
	otworzDrzwiNaPietrach(0)
		setTimer(function()
        moveObject(drzwiL, 1000, X+4,Y+0.7,pietra[aktualne_pietro])
        moveObject(drzwiR, 1000, X-4,Y+0.7,pietra[aktualne_pietro])
		end,500,1)
    end
    return 1500
end

local function ruchWindy(pietro)
    if pietro>#pietra then return false end
    if (winda_w_ruchu) then return false end
    if (pietro==aktualne_pietro) then 
	drzwiWindy(true)
	return false 
    end
    winda_w_ruchu=true
    -- zamykamy drzwi
    local odstep=drzwiWindy(false)
    local CZAS=math.abs(pietro-aktualne_pietro)*CZAS_NA_PIETRO
    setTimer(function()
        moveObject(boks, CZAS, X,Y,pietra[pietro])
	moveObject(drzwiL, CZAS, X+4,Y+0.7,pietra[pietro])
	moveObject(drzwiR, CZAS, X-4,Y+0.7,pietra[pietro])
	end, odstep, 1)
    setTimer(function()
	aktualne_pietro=pietro
	local odstep2=drzwiWindy(true)
	setTimer(function()
		winda_w_ruchu=false
		winda_stop_time=getTickCount()
		queue[aktualne_pietro]=nil
	    end, odstep2, 1)
	end, odstep+CZAS, 1)
end

--ruchWindy(2)

--addCommandHandler("rw", function(plr,cmd,pietro)
--    ruchWindy(tonumber(pietro))
--end)


local function processQueue()
	do
		local _,_,z=getElementPosition(boks)
		local pp=wysokoscNaPietro(z)
		local gracze=getElementsWithinColShape(szybcs,"player")
		for i,v in ipairs(gracze) do
		  triggerClientEvent(v, "onWindaPositionUpdate", resourceRoot, pp)
		end
	end

    if (winda_w_ruchu) then return end
    if (getTickCount()-winda_stop_time<7000) then return end
    
    local docelowe_pietro=nil
    if (math.random(1,2)==1) then
        for i=1,#pietra do
		if (queue[i]) then
		    docelowe_pietro=i
		end
        end
    else
        for i=#pietra,1,-1 do
		if (queue[i]) then
		    docelowe_pietro=i
		end
        end
    end
	if (docelowe_pietro) then
      ruchWindy(docelowe_pietro)
	end
end

setTimer(processQueue, 1000, 0)

addCommandHandler("wp", function(plr,cmd,pietro)
    pietro=tonumber(pietro)
    queue[pietro]=true
end)


addEvent("onPlayerRequestWinda", true)
addEventHandler("onPlayerRequestWinda", resourceRoot, function(wysokosc,pietro)
--  outputDebugString("Wysokosc: " .. wysokosc)
  if (not pietro) then 
    pietro=wysokoscNaPietro(wysokosc)
  end
--  outputDebugString("Pietro: " .. pietro)
  queue[pietro]=true
end)