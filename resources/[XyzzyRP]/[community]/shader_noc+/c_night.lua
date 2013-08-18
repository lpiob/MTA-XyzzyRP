--[[
************************************
* MTA REALISTIC NIGHT SHADER
************************************
*
* @author		Jesseunit
* @link			http://jsiau.site11.com
* @info			An uncompiled script, hooray.
* @version		1.0
]]--

local maxDarkness = 0.15 -- [1] = lightest || [0] = darkest
local speed = 0.1
-- local speed = 1

-- Default variables you shouldn't alter.
local b = 1
local shaderList = {}
local fading = false

-- Feel free to add more removables.
local removables = {
	'tx*',
	'coronastar',
	'shad_exp*',
	'radar*',
	'*icon',
	'font*',
	'lampost_16clr',
	'headlight',
	'vehiclegeneric256'
}

function night_init()
	if getVersion ().sortable < '1.1.0' then
		return false
	end

	testShader, tec = dxCreateShader('night.fx')
end

function night_check()
	local hours, minutes = getTime()
	if hours >= 5 and hours < 12 then
		fading = false
	elseif hours >= 12 and hours < 15 then
		fading = false
	elseif hours >= 15 and hours < 21 then
		fading = false
	elseif hours >= 21 and hours < 5 then
		fading = false
	else
		fading = true
	end
end

function night_render()
	local int, dim = getElementInterior(localPlayer), getElementDimension(localPlayer)
	if fading then
		if b > maxDarkness then
			b = b - speed
		elseif b <= maxDarkness then
			b = maxDarkness
		end
	else
		if b < 1.0 then
			b = b + speed
		elseif b >= 1.0 then
			b = 1.0
		end
	end
	for _,shader in ipairs(shaderList) do
		if int == 0 and dim == 0 then
			dxSetShaderValue(shader, 'NIGHT', b, b, b)
		else
			dxSetShaderValue(shader, 'NIGHT', 1.0, 1.0, 1.0)
		end
	end
end



function initNight()
	
	for c=65,96 do
			clone = dxCreateShader('night.fx')
			engineApplyShaderToWorldTexture(clone, string.format('%c*', c + 32))
			for i,v in pairs(removables) do
				engineRemoveShaderFromWorldTexture(clone, v)
--				engineApplyShaderToWorldTexture(clone, v)
			end
			table.insert(shaderList, clone)
	end
	addEventHandler('onClientHUDRender', root, night_render)
	nightTimer = setTimer(night_check, 1000, 0)
end

addEventHandler ("onClientElementDataChange", localPlayer, function(dataName, oldValue)
	if (dataName~="uo_nig") then return end
	if getElementData(localPlayer, "uo_nig") then
		initNight()
	else
		shaderList = {}
		for c=65,96 do
			engineRemoveShaderFromWorldTexture(clone, string.format('%c*', c + 32))
			for i,v in pairs(removables) do
				engineApplyShaderToWorldTexture(clone, v)
			end
		end
		killTimer(nightTimer)
		removeEventHandler('onClientHUDRender', root, night_render)
	end
end)

night_init()