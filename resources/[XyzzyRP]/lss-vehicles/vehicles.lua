--[[
system pojazdow

@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



--[[
function createSpecialVehicle(veh)
	if (getElementModel(veh)==578) then	-- dft
		local o1=createObject(2893,0,0,0)
		setElementDoubleSided(o1,true)
		attachElements(o1,veh, 1.5,2.3,0.1,0,90,16.5,0)

		local o2=createObject(2893,0,0,0)
		setElementDoubleSided(o2,true)
		attachElements(o2,veh, -1.5,2.3,0.1,0,270,-16.5,0)


		local o3=createObject(2937,0,0,0)
		attachElements(o3,veh, -0.8,-6.8,-0.8,25)

		local o4=createObject(2937,0,0,0)
		attachElements(o4,veh, 0.8,-6.8,-0.8,25)

	end
end
]]--




local function veh_create(v)
--	outputDebugString("Tworzenie " .. v.id)
	v.loc=split(v.loc,",")
	v.rot=split(v.rot,",")
	local pojazd=createVehicle(v.model, v.loc[1],v.loc[2],v.loc[3],v.rot[1],v.rot[2],v.rot[3],v.tablica .. string.format("%06s",v.id)) -- tablica nie dziala?
	
	if getElementModel(pojazd)==439 then setVehicleVariant(pojazd, 1, 255) end
	if getElementModel(pojazd)==555 then setVehicleVariant(pojazd, 0, 255) end
	
	if (tonumber(v.d)>0) then
	  setElementDimension(pojazd, tonumber(v.d))
	end
	if (tonumber(v.i)>0) then
	  setElementInterior(pojazd, tonumber(v.i))
	end
	
	if (v.special and type(v.special)=="string" and string.len(v.special)>1) then
	    setElementData(pojazd,"special",v.special)
	end


	setVehicleDamageProof(pojazd, true)
	v.hp=tonumber(v.hp)
	if (v.hp<301) then v.hp=301 end
	setElementHealth(pojazd,v.hp)
	setElementData(pojazd,"dbid",v.id)

	
	
	setElementData(pojazd,"paliwo", { tonumber(v.paliwo) or 25, tonumber(v.bak) or 25})

	if (tonumber(v.hp)>0 and tonumber(v.model)~=510 and tonumber(v.model)~=509 and tonumber(v.model)~=481) then
		setVehicleLocked(pojazd, tonumber(v.locked)>0)
		setElementFrozen(pojazd, tonumber(v.frozen)>0)
	end

	if (v.headlightcolor and type(v.headlightcolor)=="string") then
		v.headlightcolor=split(v.headlightcolor,",")
--		srun setVehicleHeadLightColor(getPedOccupiedVehicle(getPlayerFromName("Shawn_Hanks")), 100,255,255)
		setVehicleHeadLightColor(pojazd, tonumber(v.headlightcolor[1]) or 255, tonumber(v.headlightcolor[2]) or 255 , tonumber(v.headlightcolor[3]) or 255)
	end

	if (v.owning_faction and (type(v.owning_faction)=="string" or type(v.owning_faction)=="number")) then
	    setElementData(pojazd, "owning_faction", tonumber(v.owning_faction))
	end
	if (v.owning_co and (type(v.owning_co)=="string" or type(v.owning_co)=="number")) then
	    setElementData(pojazd, "owning_co", tonumber(v.owning_co))
	end

	if (v.fprint1) then	setElementData(pojazd,"fingerprint:1", v.fprint1 or "-")	end
	if (v.fprint2) then	setElementData(pojazd,"fingerprint:2", v.fprint2 or "-")	end
	if (v.fprint3) then	setElementData(pojazd,"fingerprint:3", v.fprint3 or "-")	end
	if (v.fprint4) then	setElementData(pojazd,"fingerprint:4", v.fprint4 or "-")	end
	if (v.fprint5) then	setElementData(pojazd,"fingerprint:5", v.fprint5 or "-")	end
	if (v.cb and tonumber(v.cb)>0) then
	    setElementData(pojazd,"cb", true)
	end
	if (v.kogut and tonumber(v.kogut)>0) then
	    setElementData(pojazd,"kogut", true)
	end

	if (v.neony and tonumber(v.neony)>0) then
	    setElementData(pojazd,"neony", tonumber(v.neony))
	end


	if (v.damageproof and tonumber(v.damageproof)==1) then
		setElementData(pojazd,"damageproof", true)
	end


	if (v.gps and tonumber(v.gps)>0) then
		setElementData(pojazd,"gps", true, false)
	end
	
	setElementData(pojazd,"przebieg", tonumber(v.przebieg) or 0)
	v.wheelstates=split(v.wheelstates,",")
	setVehicleWheelStates(pojazd, unpack(v.wheelstates))
	if (v.panelstates~="0,0,0,0,0,0,0") then
    	v.panelstates=split(v.panelstates,",")
		for i,v in ipairs(v.panelstates) do
		  setVehiclePanelState(pojazd,i-1, tonumber(v))
		end
	else
    	v.panelstates=split(v.panelstates,",")
	end
	if (v.upgrades and type(v.upgrades)=="string") then
		v.upgrades=split(v.upgrades,",")
		for i,v in ipairs(v.upgrades) do
			addVehicleUpgrade(pojazd, tonumber(v))
		end
	end

	if (v.opis and type(v.opis)=="string") then
	    setElementData(pojazd,"opis", v.opis)
	end
	
	setVehicleColor ( pojazd, math.floor(v.c1/65536), math.floor(v.c1/256%256), v.c1%256, math.floor(v.c2/65536), math.floor(v.c2/256%256), v.c2%256, math.floor(v.c3/65536), math.floor(v.c3/256%256), v.c3%256, math.floor(v.c4/65536), math.floor(v.c4/256%256), v.c4%256)
	setVehicleEngineState ( pojazd, false )
end

function veh_reload(id)
    if (not id) then return end
    -- reload bez save!
    for i,v in ipairs(getElementsByType("vehicle")) do
	local dbid=getElementData(v,"dbid")
	if dbid and tonumber(dbid)==tonumber(id) then

			local zneony=getElementData(v,"zneony")
			if (zneony and type(zneony)=="table") then
				destroyElement(zneony[1])
				destroyElement(zneony[2])
			end


	    destroyElement(v)
	end
    end
    veh_load(id)
end

function veh_load(id)
    local pojazd=exports.DB:pobierzWyniki("select id,przebieg,model,loc,d,i,rot,locked,frozen,tablica,hp,fprint1,fprint2,fprint3,fprint4,fprint5,owning_faction,owning_co,c1,c2,c3,c4,headlightcolor,cb,gps,kogut,neony,upgrades,wheelstates,panelstates,opis,paliwo,bak,special,damageproof from lss_vehicles WHERE przechowalnia=0 AND id="..tonumber(id))
	if pojazd and pojazd.id then
	    veh_create(pojazd)
	end
end

function veh_init()
    local pojazdy=exports.DB:pobierzTabeleWynikow("select id,przebieg,model,loc,d,i,rot,locked,frozen,tablica,hp,fprint1,fprint2,fprint3,fprint4,fprint5,owning_faction,owning_co,c1,c2,c3,c4,headlightcolor,cb,gps,kogut,neony,upgrades,wheelstates,panelstates,opis,paliwo,bak,special,damageproof from lss_vehicles WHERE przechowalnia=0")
    for i,v in ipairs(pojazdy) do
	veh_create(v)
--[[
	if (tonumber(v.model)==578) then
		createSpecialVehicle(pojazd)
	end
]]--
    end
end

-- zapisujemy stan pojazdu do bazy danych
function veh_save(vehicle)
    local dbid=getElementData(vehicle, "dbid")
    if (not dbid) then
	return
    end
    local x,y,z=getElementPosition(vehicle)
    local rx,ry,rz=getElementRotation(vehicle)
    local hp=getElementHealth(vehicle)
    local fp1=getElementData(vehicle,"fingerprint:1")	    if (not fp1 or type(fp1)~="string") then fp1="-" end
    local fp2=getElementData(vehicle,"fingerprint:2")	    if (not fp1 or type(fp2)~="string") then fp2="-" end
    local fp3=getElementData(vehicle,"fingerprint:3")	    if (not fp1 or type(fp3)~="string") then fp3="-" end
    local fp4=getElementData(vehicle,"fingerprint:4")	    if (not fp1 or type(fp4)~="string") then fp4="-" end
    local fp5=getElementData(vehicle,"fingerprint:5")	    if (not fp1 or type(fp5)~="string") then fp5="-" end
	local pp=getElementData(vehicle,"paliwo")
	local paliwo=25
	local bak=25
	if (pp) then 
		paliwo=tonumber(pp[1]) or 25
		bak=tonumber(pp[2]) or 25
	end
    local wheelstates=table.concat({getVehicleWheelStates(vehicle)},",")
	local panelstates={}
	for i=0,6 do
	  table.insert(panelstates, getVehiclePanelState(vehicle,i))
	end
	panelstates=table.concat(panelstates,",")
	local przebieg=getElementData(vehicle,"przebieg") or 0
	local locked=isVehicleLocked(vehicle) and 1 or 0
	local frozen= isElementFrozen(vehicle) and 1 or 0
	local vm=getElementModel(vehicle)
	if (vm==510 or vm==509 or vm==481) then	-- rowery
		locked=0
		frozen=0
	end
	local c11,c12,c13, c21,c22,c23, c31,c32,c33, c41,c42,c43 = getVehicleColor(vehicle,true)
	local opis=getElementData(vehicle,"opis")
	if (opis and string.len(opis)>=3) then
	    opis='"' .. exports.DB:esc(opis) .. '"'
	else
	    opis="NULL"
	end
	local vehUpgrades=getVehicleUpgrades(vehicle)
	if not vehUpgrades then vehUpgrades={} end
	local upgrades=exports.DB:esc(table.concat(vehUpgrades,","))

    local query=string.format("UPDATE lss_vehicles SET przebieg='%.2f',upgrades='%s',loc='%.2f,%.2f,%.2f',rot='%.2f,%.2f,%.2f',hp=%d,locked=%d,frozen=%d,fprint1='%s',fprint2='%s',fprint3='%s',fprint4='%s',fprint5='%s',c1=%d,c2=%d,c3=%d,c4=%d,wheelstates='%s',panelstates='%s',opis=%s,paliwo=%.3f,bak=%d WHERE id=%d LIMIT 1",
	przebieg,upgrades,x,y,z,rx,ry,rz,hp,locked, frozen,
	exports.DB:esc(fp1), exports.DB:esc(fp2), exports.DB:esc(fp3), exports.DB:esc(fp4), exports.DB:esc(fp5),
	c13+c12*256+c11*256*256, c23+c22*256+c21*256*256, c33+c32*256+c31*256*256, c43+c42*256+c41*256*256, 
	exports.DB:esc(wheelstates), exports.DB:esc(panelstates), 
	opis,
	paliwo,bak,
	dbid)
    exports.DB:zapytanie(query)
end

function veh_saveall()
    local pojazdy=getElementsByType("vehicle",resourceRoot)
    for i,v in ipairs(pojazdy) do
	veh_save(v)
    end
end

function createVehicleEx(model,x,y,z,rx,ry,rz)
    local pojazd=createVehicle(model, x,y,z,rx,ry,rz) -- tablica nie dziala?
    setVehicleDamageProof(pojazd, true)
    local query=string.format("INSERT INTO lss_vehicles SET created=NOW(),model=%d,loc='%.2f,%.2f,%.2f',rot='%.2f,%.2f,%.2f',locked=1", model, x,y,z,rx,ry,rz)
    exports.DB:zapytanie(query)
    local dbid=exports.DB:insertID()
    setVehicleLocked(pojazd,true)
    if (dbid and dbid>0) then
	setElementData(pojazd,"dbid",dbid)
	setElementData(pojazd,"paliwo", { 0.5, 25})
	setElementData(pojazd,"przebieg", math.random(1,50)/10)
	return dbid,pojazd
    else
	return false
    end
end

function unregisterVehicle(dbid)
	if not dbid then return false end
	local query=string.format("DELETE FROM lss_vehicles WHERE id=%d LIMIT 1", dbid)
	exports.DB:zapytanie(query)
	return true
end

function assignVehicleToOwner(vehicle,owning_player,owning_faction)
    if (not vehicle or not isElement(vehicle)) then return end
    local dbid=getElementData(vehicle,"dbid")
    if (not dbid) then return end
    
    if (owning_faction) then
	exports.DB:zapytanie(string.format("UPDATE lss_vehicles SET owning_faction=%d WHERE id=%d LIMIT 1", owning_faction, dbid))
	setElementData(vehicle,"owning_faction", tonumber(owning_faction))
    elseif (getElementData(vehicle,"owning_faction")) then
    	exports.DB:zapytanie(string.format("UPDATE lss_vehicles SET owning_faction=NULL WHERE id=%d LIMIT 1", dbid))
	removeElementData(vehicle,"owning_faction")
    end
    if (owning_player) then
	exports.DB:zapytanie(string.format("UPDATE lss_vehicles SET owning_player=%d WHERE id=%d LIMIT 1", owning_player, dbid))
    else
    	exports.DB:zapytanie(string.format("UPDATE lss_vehicles SET owning_player=NULL WHERE id=%d LIMIT 1", dbid))
    end
    
end

addEventHandler("onResourceStart",resourceRoot, veh_init)
addEventHandler("onResourceStop",resourceRoot, veh_saveall)

addEventHandler("onVehicleEnter", resourceRoot, function(plr,seat)
	local vm=getElementModel(source)
	if (vm==481 or vm==509 or vm==510) then return end	-- rowery
	if (seat~=0) then return end
	setVehicleEngineState ( source, false )
    end)

addEventHandler("onVehicleExit", resourceRoot, function(plr,seat)
	if (seat==0) then
	    setVehicleEngineState ( source, false )
	    setVehicleOverrideLights(source, 1)
	end


	
	veh_save(source)
    end)
    
function e_setVehicleLocked(state)
    setVehicleLocked(source,state)
    if (state) then
	for i=0,5 do
	    setVehicleDoorOpenRatio(source,i,0,1000)
	end
    end
    veh_save(source)
end
addEvent("setVehicleLocked", true)
addEventHandler("setVehicleLocked", resourceRoot, e_setVehicleLocked)


function e_setVehicleDoorOpenRatio(door, ratio, time)
    setVehicleDoorOpenRatio(source,door,ratio, time or 1000)
end
addEvent("setVehicleDoorOpenRatio", true)
addEventHandler("setVehicleDoorOpenRatio", resourceRoot, e_setVehicleDoorOpenRatio)

addEvent("setVehicleEngineState", true)
addEventHandler("setVehicleEngineState", resourceRoot, function(state) 
	if (state) then
	    local pp=getElementData(source,"paliwo")
	    if (pp and pp[2] and pp[2]>0) then
			local paliwo,bak=unpack(pp)
			if (paliwo<0.01) then
				local kierowca=getVehicleController(source)
				if (kierowca) then
				  setTimer(	triggerEvent, 500, 1, "broadcastCaptionedEvent", kierowca, "Silnik pojazdu nie może odpalić.", 5, 5, true)
				end
				return false
			end
		end

	end
    setVehicleEngineState(source,state) 
end)

addEvent("setVehicleFrozen", true)
addEventHandler("setVehicleFrozen", resourceRoot, function(state)
	-- jezeli pojazd ma przyczepe, to najpierw zamrazamy tylko ją!
	local przyczepa=getVehicleTowedByVehicle(source)
	if przyczepa and state then
		detachTrailerFromVehicle(source, przyczepa)
		setElementFrozen(przyczepa,state)
		return
	end

	-- w przeciwnym wypadku wszystko normalnie
	setElementFrozen(source,state)
end)

-- todo spedycja
--[[
addEventHandler("onTrailerAttach", resourceRoot, function(pojazd)
-- 	setElementFrozen(source, false)
	local kierowca=getVehicleController(pojazd)
	if kierowca then
		setElementSyncer( source, kierowca)	nie dziala
	end
end)
]]--

addEventHandler("onTrailerDetach", resourceRoot, function()
--	setElementData(source,"lastDetach", math.floor(getTickCount()/1000),false) todo
	veh_save(source)
end)




addEvent("setVehicleOverrideLights", true)
addEventHandler("setVehicleOverrideLights", resourceRoot, function(state)
    setVehicleOverrideLights(source, state)
	local przyczepa=getVehicleTowedByVehicle(source)
	if przyczepa then
		setVehicleOverrideLights(przyczepa,state)
	end

end)


addEventHandler("onVehicleDamage", resourceRoot, function(loss)
	local hp=getElementHealth(source)
	if (hp<5) then
		setElementFrozen(source,false)
	end
end)

local function silaGraczyWPoblizuPojazdu(element)
    local x,y,z=getElementPosition(element)
    local sumaSily=0
    local cs=createColSphere(x,y,z,7)
    local gracze=getElementsWithinColShape(cs)
    destroyElement(cs)
    for i,gracz in ipairs(gracze) do
	local c=getElementData(gracz,"character")
	if (c and c.energy) then
	    sumaSily=sumaSily+tonumber(c.energy)
	end
    end
    return sumaSily
end

addEvent("flipVehicle", true)
addEventHandler("flipVehicle", root, function(plr)
    if (getElementType(source)~="vehicle") then return end
    
    sila=silaGraczyWPoblizuPojazdu(source)
    if (sila<800) then
	outputChatBox("(( Osoby w pobliżu pojazdu nie posiadają odpowiednio dużej siły aby go obrócić. ))", plr)
	outputChatBox("(( Dostepne: " .. sila .. ", wymagane: 800 ))", plr)
	triggerEvent("broadcastCaptionedEvent", plr, "Osoby w pobliżu bezskutecznie próbują odwrócić pojazd na koła.", 5, 15, true)
	return
    end
    
    local _,_,z = getElementRotation(source)
    setElementRotation(source, 0,0,z)
    triggerEvent("broadcastCaptionedEvent", plr, "Osoby w pobliżu pojazdu odwracają go na koła.", 5, 15, true)
end)


local plOffsets={
  [405]={-0.5,-0.1,0.76},	-- sentinel
  [426]={-0.5, -0.1, 0.88},	-- premier
  [525]={0, -0.5, 1.3},	-- holownik
  [554]={0, 0, 1.1},	-- yosemite
  [560]={-0.5, 0, 0.85},	-- sultan
  [426]={-0.5, 0, 0.85},	-- premier
  [574]={0, 0.45, 1.27},	-- sweeper
  [578]={-0.7, 3.5, 1.4},	-- laweta
  [602]={-0.4, -0.3, 0.73},	-- alpha
  [552]={0, 0.6, 1.39},	-- Utility Van
  [579]={-0.4, -0.1, 1.28},	-- huntley
  [408]={-0.4, 2.7, 1.05},	-- smieciarka
  [486]={0, -1.45, 1.45},	-- dozer
--  [541]={-0.4, -0.2, 0.66},	-- bullet
  
}

-- triggerServerEvent("toggleVehiclePL", vehicle)
addEvent("toggleVehiclePL", true)
addEventHandler("toggleVehiclePL", root, function(plr)
  local kogut=getElementData(source,"kogut")
  if (type(kogut)=="userdata" and getElementType(kogut)=="object") then
	destroyElement(kogut)
	setElementData(source,"kogut", true)
--	triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " zdejmuje koguta z dachu pojazdu.", 5, 25, true)
	triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " odłącza kogut z pojazdu.", 5, 25, true)	
	removeVehicleSirens(source)
  else
	local m = getElementModel(source)
	if not plOffsets[m] then
		outputChatBox("(( zakładanie koguta na ten model pojazdu nie jest oprogramowane, zglos to administracji ))", plr)
		return
	end
	kogut=createObject(3964,0,0,0)
	setElementData(source,"kogut", kogut)
	attachElements(kogut,source,unpack(plOffsets[m]))
--    triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " zakłada koguta na dach pojazdu.", 5, 25, true)
    triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " załącza kogut w pojeździe.", 5, 25, true)
	addVehicleSirens(source, 1, 2, true, true, true)
  end
end)

local nlOffsets={
	[411]={-1,0,-0.6},	-- infernus
	[470]={-1,0,-0.4},	-- patriot
	[541]={-0.9,0,-0.4},	-- bulelt
	[549]={-0.9,0,-0.4},	-- tampa
	[587]={-1,0,-0.5},	-- euros
}

local nlIDX={
	3962,2113,1784,2054,2428,2352
}

addEvent("toggleVehicleNL", true)
addEventHandler("toggleVehicleNL", root, function(plr)
  local rodzajneonu=tonumber(getElementData(source,"neony"))
  if not rodzajneonu then return end
  local zneony=getElementData(source,"zneony")
  if (zneony and type(zneony)=="table") then
	destroyElement(zneony[1])
	destroyElement(zneony[2])
	removeElementData(source,"zneony")

	triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " wciska przycisk przy kokpicie.", 5, 5, true)

  else
	local m = getElementModel(source)
	local of
	if not nlOffsets[m] then
		of={-1,0,-0.5}
	else
		of=nlOffsets[m]
	end
	neon1=createObject(nlIDX[rodzajneonu] or 3962,0,0,0)
	neon2=createObject(nlIDX[rodzajneonu] or 3962,0,0,0)
	setElementData(source,"zneony", {neon1, neon2})
	attachElements(neon1,source,of[1],of[2],of[3])
	attachElements(neon2,source,-of[1],of[2],of[3])
    triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " wciska przycisk przy kokpicie.", 5, 25, true)
  end
end)

addEvent("toggleVehicleRoof", true)
addEventHandler("toggleVehicleRoof", root, function(plr)
	local v1,v2 = getVehicleVariant(source)
	local engine = getVehicleEngineState(source)
	if getElementModel(source)==555 then --windsor
		if (v1==0) then --jest
			setVehicleVariant(source, 1, 255)
			triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " otwiera dach.", 5, 5, true)
		elseif (v1==1) then --nie ma
			setVehicleVariant(source, 0, 255)
			triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " zamyka dach.", 5, 5, true)
		end
	elseif getElementModel(source)==439 then --stallion
		if (v1==1) then --jest
			setVehicleVariant(source, 2, 255)
			triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " otwiera dach.", 5, 5, true)
		elseif (v1==2) then --nie ma
			setVehicleVariant(source, 1, 255)
			triggerEvent("broadcastCaptionedEvent", plr, getPlayerName(plr) .. " zamyka dach.", 5, 5, true)
		end
	end
	setTimer(function(veh,engine) 
		if not engine then
			setVehicleEngineState(veh,false)
		end
	end, 100, 1, source,engine)
end)