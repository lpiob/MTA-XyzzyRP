--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--

function sprayfinish(plr)
  if (not plr or not isElement(plr)) then return end -- zdarza sie gdy tag jest wczytany wprost z bazy danych
  outputDebugString("a")
  if (not getElementData(plr,"character")) then return end
  local x,y,z=getElementPosition(plr)
  local cs=createColSphere(x,y,z,30)
  setElementInterior(cs, getElementInterior(plr))
  local nearbyPlayers=getElementsWithinColShape(cs,"player")
  destroyElement(cs)
--  outputDebugString("Graczy w poblizu: " .. #nearbyPlayers)
  for i,v in ipairs(nearbyPlayers) do
	if (v~=plr and getElementDimension(v)==getElementDimension(plr)) then
		local c=getElementData(v,"character")
		if c then
			if not c.ab_spray then c.ab_spray=0 end
			if (math.random(1,2)==1 and tonumber(c.ab_spray)<100) then
				c.ab_spray=tonumber(c.ab_spray)+1

				
				setElementData(v,"character", c)
				outputChatBox("(( Umiejętność malowania sprayem: " .. c.ab_spray .. "/100 ))", v)
				outputDebugString(getPlayerName(v).." uczy sie malowac")
				if (c.ab_spray==50) then
					outputChatBox("(( Potrafisz już malować sprayem po ścianach. ))", v)
				end
			end
		end
	end
  end
end

addEventHandler("drawtag:onTagFinishSpray", root, sprayfinish)
addEventHandler("drawtag:onTagFinishErase", root, sprayfinish)

