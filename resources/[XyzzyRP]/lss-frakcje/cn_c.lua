--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--

local strefy_cn={
    -- x,y,z,r,d,i
    { 435.79,-1149.85,1196.34,100,7,1 }    -- siedziba cn
}

for i,v in ipairs(strefy_cn) do
    v.cs=createColSphere(v[1],v[2],v[3],v[4])
    setElementInterior(v.cs,v[6])
    setElementDimension(v.cs,v[5])
end

local wzasiegu=false

setTimer(function()
  if (getPedOccupiedVehicle(localPlayer)) then 
	wzasiegu=true
	return 
    end
    for i,v in ipairs(strefy_cn) do
	if (isElementWithinColShape(localPlayer, v.cs) and getElementDimension(localPlayer)==v[5] and getElementInterior(localPlayer)==v[6]) then
--	    outputDebugString("w z")
	    wzasiegu=true
	    return
	end
    end
    wzasiegu=false
end, 5000, 0)

-- pasek na dole ekranu

local sw,sh = guiGetScreenSize() 
local ph=math.floor(sh/20)

local rodzaj="Informacje CNN News"
local informacja=""
local informacja_ts=nil

local limit_czasu=30000

function render_cn()
--    if (not wzasiegu) then return end
  if (informacja_ts and getTickCount()-informacja_ts<limit_czasu) then

	local alpha=1
	if (getTickCount()-informacja_ts>(limit_czasu-1000)) then
	  alpha=(limit_czasu-(getTickCount()-informacja_ts))/1000
	end
	
	if (rodzaj~="Wywiad" and getTickCount()-informacja_ts<1000) then
	  alpha=(getTickCount()-informacja_ts)/1000
	end

    for i=0,5 do
      dxDrawRectangle(0, sh-ph+i, sw,ph-i, tocolor(0,0,0,(i+5)*5*alpha))
    end
    dxDrawText(rodzaj, 5, sh-ph, sw, sh,tocolor(255,255,255,200*alpha), 0.75, "default-bold", "left","center")
    local ox=dxGetTextWidth ( "Informacje CNN News", 1, "default-bold" )
    dxDrawText(informacja, 5+15+ox, sh-ph, sw, sh, tocolor(255,255,255,255*alpha), 1, "default", "center", "center")
  end
end

addEventHandler("onClientRender", root, render_cn)

addEvent("onCNAnnouncement",true)
addEventHandler("onCNAnnouncement", resourceRoot, function(txt,lrodzaj)
    rodzaj=lrodzaj or "Informacje CNN News"
  informacja=txt
  informacja_ts=getTickCount()
end)


--[[
addEvent("onCNAnnouncement",true)
addEventHandler("onCNAnnouncement", resourceRoot, function(txt)
  local v=getPedOccupiedVehicle(localPlayer)
  if (not v) then return end
  if (not getVehicleEngineState(v)) then return end
  triggerEvent("onCaptionedEvent", root, "((RADIO)) " .. txt, 20, {55,55,0})
end)

]]--




-- mikrofon!
function mikrofon(msg,mt)
    if (mt~=4) then return end
    if ( getPedWeaponSlot ( localPlayer)~=1) then return end
	local fid=getElementData(localPlayer,"faction:id")
	if not fid or fid~=5 then return end
    local bron=getPedWeapon(localPlayer, 1)
    if (not bron or bron~=2) then return end
--	outputDebugString("m " .. msg .. " - " .. mt)
	-- sprawdzmy jeszcze odleglosc
	local x,y,z=getElementPosition(localPlayer)
	local x2,y2,z2=getElementPosition(source)
	if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)<=5) then
      triggerServerEvent("doPublishWywiadMsg", source, msg)
	end
end

addEvent("onMessageIncome",true)
addEventHandler("onMessageIncome",getRootElement(),mikrofon)