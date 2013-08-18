--
-- c_water.lua
--

addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		-- Version check
		if getVersion ().sortable < "1.1.0" then
			return
		end

		-- Create shader
		myShader, tec = dxCreateShader ( "water.fx" )
	end
)



function initWaterShader()
	local textureVol = dxCreateTexture ( "images/smallnoise3d.dds" );
	local textureCube = dxCreateTexture ( "images/cube_env256.dds" );
	dxSetShaderValue ( myShader, "sRandomTexture", textureVol );
	dxSetShaderValue ( myShader, "sReflectionTexture", textureCube );
	engineApplyShaderToWorldTexture ( myShader, "waterclear256" )
	setTimer(	function()
		if myShader then
		local r,g,b,a = getWaterColor()
			dxSetShaderValue ( myShader, "sWaterColor", r/255, g/255, b/255, a/255 );
		end
	end,100,0 )
end

addEventHandler ("onClientElementDataChange", localPlayer, function(dataName, oldValue)
	if (dataName~="uo_sw") then return end
	
	if getElementData(localPlayer, "uo_sw") then
		initWaterShader()
	else
		engineRemoveShaderFromWorldTexture(myShader, "waterclear256")
	end
end)