--[[
cpny

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


local tankowany_pojazd=nil

local CENA_ZA_LITR=10

local dystrybutory={
   { x=202.74,y=-141.2,z=1,rozmiar=2},	-- blueberry
   { x=202.74,y=-148.9,z=1,rozmiar=2},	-- blueberry
  -- warsztat idlewood
  { x=1941.37, y=-1768.96, z=13, rozmiar=2}, 
  { x=1941.37, y=-1776.10, z=13, rozmiar=2}, 
  -- east beach (obok stadionu forum)
  { x=2664.56, y=-1638.83, z=9.7, rozmiar=2},
  { x=2664.56, y=-1646.03, z=9.7, rozmiar=2},
  -- palomino creek
  { x=2263.73, y=31.46, z=25.23, rozmiar=2},
  { x=2263.73, y=24.08, z=25.23, rozmiar=2},
  -- temple/mulholland
  { x=1007.73, y=-936.02, z=41.95, rozmiar=2},
  { x=1000.67, y=-937.02, z=41.95, rozmiar=2},
  -- montgomery
  { x=1379.70, y=460.96, z=18.97, rozmiar=2},
  { x=1384.06, y=458.96, z=18.97, rozmiar=2},
  -- red county warsztat II
  { x=685.51, y=-131.61, z=24.5, rozmiar=2},
  -- lotnisko
  { x=1439.46, y=-2435.60, z=13.55, rozmiar=14},
--[[  -- ganton
  { x=2301.17, y=-1791.98, z=13, rozmiar=3}, 
  { x=2291.59, y=-1792.60, z=13, rozmiar=3},  --]]
	-- port (dla statkow)
  { x=2548.63, y=-2629.60, z=0, rozmiar=3},

}


---

local nieTankowalne={
  [509]=true,	-- 3x rowery
  [510]=true,
  [481]=true,  
}


local function pojazdTankowalny(veh)
  if (not isElement(veh)) then return false end
  if (getElementType(veh)~="vehicle") then return false end
  if (not getElementData(veh, "dbid")) then return false end
  if (not getElementData(veh, "paliwo")) then return false end
  local vm=getElementModel(veh)
  if nieTankowalne[vm] then return false end
  local typSilnika=getVehicleHandling(veh).engineType
  if (typSilnika=="electric") then return false end
  return true
end



---





for i,v in ipairs(dystrybutory) do
  v.cs=createColSphere(v.x,v.y,v.z,v.rozmiar)

end

local function znajdzPojazd(cs)
  local pojazdy=getElementsByType("vehicle",root,true)
  if (not pojazdy or #pojazdy<1) then return nil end
  local x,y,z=getElementPosition(localPlayer)
  local najblizszy=nil
  local last_dist=nil
  for i,v in ipairs(pojazdy) do
	  if (pojazdTankowalny(v)) then
		  local x2,y2,z2=getElementPosition(v)
		  local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
		  if (dist<4 and (not last_dist or dist<last_dist)) then
			last_dist=dist
			najblizszy=v
		  end
	  end
  end
  return najblizszy
end


tw_win = guiCreateWindow(0.6906,0.4208,0.2937,0.4042,"Stacja paliw",true)
tw_lbl_pojazd = guiCreateLabel(0.0851,0.1500,0.8351,0.1500, "Pojazd", true, tw_win)
tw_lbl_cena = guiCreateLabel(0.0851,0.3000,0.8351,0.1500, "Koszt", true, tw_win)
guiLabelSetVerticalAlign(tw_lbl_cena, "center")
tw_lbl_cena2 = guiCreateLabel(0.0851,0.3000,0.8351,0.1500, string.format("%d",CENA_ZA_LITR).."$/L", true, tw_win)
guiLabelSetHorizontalAlign(tw_lbl_cena2, "right")
guiLabelSetVerticalAlign(tw_lbl_cena2, "center")
guiSetFont(tw_lbl_cena2, "default-bold-small")


tw_prg=guiCreateProgressBar(0.0851,0.4500, 0.8351, 0.1500, true, tw_win)
--tw_progress1 = guiCreateProgressBar(0.0798,0.1781,0.8351,0.1507,true,tw_win)
--tw_progress2 = guiCreateProgressBar(0.0798,0.3562,0.8351,0.1507,true,tw_win)
tw_btn = guiCreateButton(0.0851,0.7133,0.8298,0.15,"Tankuj",true,tw_win)

guiSetVisible(tw_win,false)

local function findKanister(plr)
	local eq = getElementData(plr,"EQ")
	EQ={}
    
    for i=1,28 do
	EQ[i]={}
	EQ[i].itemid=tonumber(table.remove(eq,1))
	EQ[i].count=tonumber(table.remove(eq,1))
	EQ[i].subtype=tonumber(table.remove(eq,1))
    end
	
	for k,v in ipairs(EQ) do
		if v.itemid==161 or v.itemid==162 then
			if v.itemid==161 and (v.subtype>=0) and (v.subtype<5) then
				return v
			elseif v.itemid==162 and (v.subtype>=0) and (v.subtype<10) then
				return v
			end
		end
	end
	return false
end

addEventHandler("onClientColShapeHit", resourceRoot, function(el,md)
  if (el~=localPlayer or not md) then return end
  if (isPedInVehicle(localPlayer)) then return end
  tankowany_pojazd=znajdzPojazd(source)
  if (not tankowany_pojazd) then
	guiSetText(tw_lbl_pojazd,"-")
	guiSetEnabled(tw_btn, false)
  else
	local dbid=getElementData(tankowany_pojazd, "dbid")
	guiSetText(tw_lbl_pojazd,getVehicleName(tankowany_pojazd) .. " ["..(dbid or "-").."]")
	local paliwo,bak=unpack(getElementData(tankowany_pojazd, "paliwo"))
	guiProgressBarSetProgress(tw_prg, paliwo/bak*100)
	if (paliwo>=bak) then
		guiSetEnabled(tw_btn, false)
	else
		guiSetEnabled(tw_btn, true)
	end

  end
  guiSetVisible(tw_win,true)
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(el,md)
  if (el~=localPlayer or not md) then return end
  guiSetVisible(tw_win,false)
  tankowany_pojazd=nil
end)

addEventHandler("onClientGUIClick", tw_btn, function()
  if (not tankowany_pojazd) then return end
--outputChatBox("(( Tankowanie w trakcie przygotowywania. ))")

  if (getPlayerMoney(localPlayer)<CENA_ZA_LITR) then
	outputChatBox("(( Nie stać Cię na to. ))")
	return
  end

  local paliwo,bak=unpack(getElementData(tankowany_pojazd, "paliwo"))
  paliwo=paliwo+1
    if (paliwo>bak) then paliwo=bak 
  else
	takePlayerMoney(CENA_ZA_LITR)
    triggerServerEvent("takePlayerMoney", localPlayer, CENA_ZA_LITR)
  end
  setElementData(tankowany_pojazd,"paliwo", {paliwo,bak})
  guiProgressBarSetProgress(tw_prg, paliwo/bak*100)
end,false)