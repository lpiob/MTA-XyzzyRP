

local myShader

local function replaceTex(image,texture)
		myShader_g1, tec_g1 = dxCreateShader ( "shader-simple.fx" )
		local myTexture_g1 = dxCreateTexture ( image );
		dxSetShaderValue ( myShader_g1, "CUSTOMTEX0", myTexture_g1 );
		if myShader_g1 then
			engineApplyShaderToWorldTexture ( myShader_g1, texture )
		end
end


addEventHandler( "onClientResourceStart", resourceRoot,
	function()


		-- Version check
		if getVersion ().sortable < "1.1.0" then
			return
		end


		-- heat_03

		replaceTex("i/komis.jpg", "heat_04")
--		replaceTex("i/marmur.jpg", "sam_camo")
--	  sam_camo

	end
)

