--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local sw,sh=guiGetScreenSize()
local taxicam=false

local mo_x,mo_y=0,0
local orz=0
local oplata_za_km=12

local lu=getTickCount()
function taryfa(veh)
    local dystans=getElementData(veh,"taxi:dystans") or 0
    local oplata=getElementData(veh,"taxi:oplata") or 0
    if (getTickCount()-lu>250 and getVehicleController(veh)==localPlayer) then
	lu=getTickCount()
	local vx,vy,vz=getElementVelocity(veh)
	local spd=((vx^2 + vy^2 + vz^2)^(0.5)/100)
	if (spd>0) then
	    dystans=dystans+(spd)
	    setElementData(veh, "taxi:dystans", dystans)
	    oplata=dystans*oplata_za_km
	    setElementData(veh, "taxi:oplata", oplata)
	end
	
    end
    dystans=string.format("%.01f", dystans)
    oplata=string.format("%d", oplata)
    return dystans,oplata+10
end

local function czyTaksowka(p)
	local vm=getVehicleModel(p)
	if vm==438 or vm==420 then return true end
	local kierowca=getVehicleController(p)
	if kierowca then
		local taxi=getElementData(p,"taxi")
		if taxi and taxi==kierowca then return true end
	end
	return false
end

function updateCamera ()
	local v=getPedOccupiedVehicle(localPlayer)
	local vm
	if (v) then
		if (czyTaksowka(v)) then
	    	    local dystans,oplata=taryfa(v)
		    dxDrawText(dystans.."km - "..oplata.."$", 0,0,sw,sh,tocolor(255,255,255),1.5,"default-bold","center","top")
		end
	end
	if (not v) then
		if (taxicam) then
			setCameraTarget(localPlayer)
			taxicam=false
		end
		return
	end
	if (getVehicleController(v)==localPlayer) then
		if (taxicam) then
			setCameraTarget(localPlayer)
			taxicam=false
		end
		return
	end
	
	if (vm==438 or vm==420) then
		local x, y, z = getPedBonePosition ( localPlayer, 8 )
		if (not taxicam) then orz=0 taxicam=true end
		local _,_,rz=getElementRotation(localPlayer)
	    local rrz=math.rad(rz+180+orz)

	    local x2= x - (2 * math.sin(-rrz))
	    local y2= y - (2 * math.cos(-rrz))
--		dxDrawText(tostring(mo_x),0,0)
		setCameraMatrix ( x, y, z, x2, y2, z )

	end
end

addEventHandler ( "onClientPreRender", root, updateCamera )

addEventHandler( "onClientCursorMove", getRootElement( ),
    function ( _, _, x, y )
		if (isCursorShowing() or isChatBoxInputActive()) then
			
		else
			mo_x=sw/2-x
			if (mo_x<2) then orz=orz+(mo_x*20/sw) end
			if (mo_x>2) then orz=orz+(mo_x*20/sw) end



		end
    end
)


function menu_taxiResetLicznika(args)
--                   call(getResourceFromName("lss-frakcje"),"menu_taxiResetLicznika",{vehicle=el
    local veh=args.vehicle
    if (not isElement(veh)) then return end
    setElementData(veh,"taxi:oplata",0)
    setElementData(veh,"taxi:dystans",0)
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zeruje taksometr.", 5, 5, true)
end

local taxiBlips={}

local function destroyTaxiBlipForPlayer(plr)
	if taxiBlips[plr] then
		destroyElement(taxiBlips[plr][1])
		taxiBlips[plr]=nil
	end
end
-- exports["lss-frakcje"]:addTaxiRequest(senderElement)
function addTaxiRequest(re)
	if getElementInterior(re)~=0 or getElementDimension(re)~=0 then return end
	destroyTaxiBlipForPlayer(re)

	local x,y,z=getElementPosition(re)
	local blip=createBlip(x,y,z,42)
	taxiBlips[re]={blip, getTickCount()}
end


local function taxiBlipsCleanup()
	for i,v in pairs(taxiBlips) do
		if not isElement(i) or getTickCount()-v[2]>1000*60*5 then
			destroyTaxiBlipForPlayer(i)
		end
	end
end

setTimer(taxiBlipsCleanup, 60000, 0)

addEventHandler("onClientPlayerVehicleEnter",root,function(v)
	destroyTaxiBlipForPlayer(source)
end)
