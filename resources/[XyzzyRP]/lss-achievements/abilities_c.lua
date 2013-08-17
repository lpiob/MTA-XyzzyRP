--[[
lss-achievements: osiągniecia

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


local sw,sh = guiGetScreenSize()

local currentlyDisplayedAbility
local ABILITY_DISPLAY_TIME=30000
local abilityDisplayedSince=getTickCount()-ABILITY_DISPLAY_TIME
local abilityValue=0
local abilityDelta=0



local function displayAbility()
	if getTickCount()-abilityDisplayedSince>ABILITY_DISPLAY_TIME then
		currentlyDisplayedAbility=nil
		removeEventHandler("onClientRender", root, displayAbility)
		return
	end

	alpha=1
	if getTickCount()-abilityDisplayedSince<1000 then
		alpha=(getTickCount()-abilityDisplayedSince)/1000
	elseif getTickCount()-abilityDisplayedSince>ABILITY_DISPLAY_TIME-1000 then
		alpha=(ABILITY_DISPLAY_TIME-(getTickCount()-abilityDisplayedSince))/1000
	end


	dxDrawText("Sztuka walki: boks", 622/800*sw-2+1, 140/600*sh-1+1, 762/800*sw+4+1, 180/600*sh+2+1, tocolor(0,0,0,255*alpha), 1, "default-bold")
	dxDrawText("Sztuka walki: boks", 622/800*sw-2, 140/600*sh-1, 762/800*sw+4, 180/600*sh+2, tocolor(255,255,255,255*alpha), 1, "default-bold")
	dxDrawRectangle(622/800*sw-1, 160/600*sh-1, 140/800*sw+2, 20/600*sh+2, tocolor(5,5,5,255*alpha))
	dxDrawRectangle(622/800*sw, 160/600*sh, 140/800*sw, 20/600*sh, tocolor(250,250,250,55*alpha))
	-- mvalue
	if currentlyDisplayedAbility.mvalue and currentlyDisplayedAbility.mvalue>0 then
		dxDrawRectangle(622/800*sw+140/800*sw*(currentlyDisplayedAbility.mvalue/currentlyDisplayedAbility.maxvalue)-1, 160/600*sh, 1, 20/600*sh, tocolor(0,0,0,55*alpha))
	end
	-- value
	dxDrawRectangle(622/800*sw, 160/600*sh, 140/800*sw*(abilityValue/currentlyDisplayedAbility.maxvalue), 20/600*sh, tocolor(255-abilityValue/currentlyDisplayedAbility.maxvalue*255,127+abilityValue/currentlyDisplayedAbility.maxvalue*127,0,155*alpha))
	if abilityDelta>0 then
		dxDrawRectangle(622/800*sw+140/800*sw*(abilityValue/currentlyDisplayedAbility.maxvalue)-1, 160/600*sh+1, 1, 20/600*sh-2, tocolor(abilityValue/currentlyDisplayedAbility.maxvalue*100,255,abilityValue/currentlyDisplayedAbility.maxvalue*100,255*alpha))
	else
		dxDrawRectangle(622/800*sw+140/800*sw*(abilityValue/currentlyDisplayedAbility.maxvalue)-1, 160/600*sh+1, 1, 20/600*sh-2, tocolor(255,abilityValue/currentlyDisplayedAbility.maxvalue*100,abilityValue/currentlyDisplayedAbility.maxvalue*100,255*alpha))
	end
	
end

addEvent("showAbilityValue", true)
addEventHandler("showAbilityValue", resourceRoot, function(ability,new_abilityValue,new_abilityDelta)
	if getTickCount()-abilityDisplayedSince<ABILITY_DISPLAY_TIME then
		removeEventHandler("onClientRender", root, displayAbility)
	end
	abilityValue=new_abilityValue
	abilityDelta=new_abilityDelta
	currentlyDisplayedAbility=ability
	abilityDisplayedSince=getTickCount()
	addEventHandler("onClientRender", root, displayAbility)
end)
