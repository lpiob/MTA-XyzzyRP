--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--

addEvent("doZastrzyk",true)
addEventHandler("doZastrzyk", resourceRoot, function(kto, komu, typ)
	if (typ==1) then	-- morfina
		local hp=getElementHealth(komu)
		hp=hp+25
		if (hp>100) then hp=100 end
		setElementHealth(komu, hp)
		setElementData(komu,"bwEndTime", 0)
		local rt=math.random(1,3)
		if (rt==1) then
		    triggerEvent("broadcastCaptionedEvent", kto, getPlayerName(kto) .. " robi "..getPlayerName(komu).." zastrzyk z morfiny.", 5, 15, true)
		elseif (rt==2) then
		    triggerEvent("broadcastCaptionedEvent", kto, getPlayerName(komu) .. " dostaje zastrzyk z morfiny od "..getPlayerName(kto), 5, 15, true)
		elseif (rt==3) then
		    triggerEvent("broadcastCaptionedEvent", kto, getPlayerName(kto) .. " wstrzykuje morfinę "..getPlayerName(komu), 5, 15, true)
		end
    elseif (typ==2) then -- pavulon
	
	setElementFrozen(komu,true)
	local ar=math.random(1,3)
	if (ar==1) then
		setPedAnimation( komu, "CRACK", "crckdeth1", -1, false )
	elseif ar==2 then
		setPedAnimation( komu, "CRACK", "crckdeth2", -1, true, false )
	elseif ar==3 then
		setPedAnimation( komu, "CRACK", "crckidle3", -1, true, false )
	end

	setTimer(function()
		if (not isElement(komu)) then return end
		setElementFrozen(komu, false)
		setPedAnimation(komu)
		end, 3*60000, 1)
	local rt=math.random(1,3)
	if (rt==1) then
	    triggerEvent("broadcastCaptionedEvent", kto, getPlayerName(kto) .. " robi "..getPlayerName(komu).." zastrzyk z pavulonu.", 5, 15, true)
	elseif (rt==2) then
	    triggerEvent("broadcastCaptionedEvent", kto, getPlayerName(komu) .. " dostaje zastrzyk z pavulony od "..getPlayerName(kto), 5, 15, true)
	elseif (rt==3) then
	    triggerEvent("broadcastCaptionedEvent", kto, getPlayerName(kto) .. " wstrzykuje pavulon "..getPlayerName(komu), 5, 15, true)
	end
	
	local hp=getElementHealth(komu)
	hp=hp-10
	if (hp<1) then hp=1 end
	setElementHealth(komu, hp)
    
    end
end)