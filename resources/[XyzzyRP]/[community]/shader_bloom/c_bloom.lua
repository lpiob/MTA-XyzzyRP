--
-- c_bloom.lua
--

local scx, scy = guiGetScreenSize()

-----------------------------------------------------------------------------------
-- Le settings
-----------------------------------------------------------------------------------
Settings = {}
Settings.var = {}
Settings.var.cutoff = 0.08
Settings.var.power = 1.88
Settings.var.bloom = 2.0
Settings.var.blendR = 204
Settings.var.blendG = 153
Settings.var.blendB = 130
Settings.var.blendA = 140


----------------------------------------------------------------
-- onClientResourceStart
----------------------------------------------------------------
addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		-- Version check
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end

		-- Create things
        myScreenSource = dxCreateScreenSource( scx/2, scy/2 )

        blurHShader,tecName = dxCreateShader( "blurH.fx" )
		outputDebugString( "blurHShader is using technique " .. tostring(tecName) )

        blurVShader,tecName = dxCreateShader( "blurV.fx" )
		outputDebugString( "blurVShader is using technique " .. tostring(tecName) )

        brightPassShader,tecName = dxCreateShader( "brightPass.fx" )
		outputDebugString( "brightPassShader is using technique " .. tostring(tecName) )

        addBlendShader,tecName = dxCreateShader( "addBlend.fx" )
		outputDebugString( "addBlendShader is using technique " .. tostring(tecName) )

		-- Check everything is ok
		bAllValid = myScreenSource and blurHShader and blurVShader and brightPassShader and addBlendShader

		if not bAllValid then
			outputChatBox( "Could not create some things. Please use debugscript 3" )
		end
	end
)


-----------------------------------------------------------------------------------
-- onClientHUDRender
-----------------------------------------------------------------------------------
addEventHandler( "onClientHUDRender", root,
    function()
		if not Settings.var then
			return
		end
        if bAllValid then
			if not uo_sb then return end
			-- Reset render target pool
			RTPool.frameStart()

			-- Update screen
			dxUpdateScreenSource( myScreenSource )

			-- Start with screen
			local current = myScreenSource

			-- Apply all the effects, bouncing from one render target to another
			current = applyBrightPass( current, Settings.var.cutoff, Settings.var.power )
			current = applyDownsample( current )
			current = applyDownsample( current )
			current = applyGBlurH( current, Settings.var.bloom )
			current = applyGBlurV( current, Settings.var.bloom )

			-- When we're done, turn the render target back to default
			dxSetRenderTarget()

			-- Mix result onto the screen using 'add' rather than 'alpha blend'
			if current then
				dxSetShaderValue( addBlendShader, "TEX0", current )
				local col = tocolor(Settings.var.blendR, Settings.var.blendG, Settings.var.blendB, Settings.var.blendA)
				dxDrawImage( 0, 0, scx, scy, addBlendShader, 0,0,0, col )
			end
        end
    end
)


-----------------------------------------------------------------------------------
-- Apply the different stages
-----------------------------------------------------------------------------------
function applyDownsample( Src, amount )
	if not Src then return nil end
	amount = amount or 2
	local mx,my = dxGetMaterialSize( Src )
	mx = mx / amount
	my = my / amount
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT )
	dxDrawImage( 0, 0, mx, my, Src )
	return newRT
end

function applyGBlurH( Src, bloom )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurHShader, "TEX0", Src )
	dxSetShaderValue( blurHShader, "TEX0SIZE", mx,my )
	dxSetShaderValue( blurHShader, "BLOOM", bloom )
	dxDrawImage( 0, 0, mx, my, blurHShader )
	return newRT
end

function applyGBlurV( Src, bloom )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurVShader, "TEX0", Src )
	dxSetShaderValue( blurVShader, "TEX0SIZE", mx,my )
	dxSetShaderValue( blurVShader, "BLOOM", bloom )
	dxDrawImage( 0, 0, mx,my, blurVShader )
	return newRT
end

function applyBrightPass( Src, cutoff, power )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( brightPassShader, "TEX0", Src )
	dxSetShaderValue( brightPassShader, "CUTOFF", cutoff )
	dxSetShaderValue( brightPassShader, "POWER", power )
	dxDrawImage( 0, 0, mx,my, brightPassShader )
	return newRT
end


-----------------------------------------------------------------------------------
-- Pool of render targets
-----------------------------------------------------------------------------------
RTPool = {}
RTPool.list = {}

function RTPool.frameStart()
	for rt,info in pairs(RTPool.list) do
		info.bInUse = false
	end
end

function RTPool.GetUnused( mx, my )
	-- Find unused existing
	for rt,info in pairs(RTPool.list) do
		if not info.bInUse and info.mx == mx and info.my == my then
			info.bInUse = true
			return rt
		end
	end
	-- Add new
	local rt = dxCreateRenderTarget( mx, my )
	if rt then
		outputDebugString( "creating new RT " .. tostring(mx) .. " x " .. tostring(mx) )
		RTPool.list[rt] = { bInUse = true, mx = mx, my = my }
	end
	return rt
end


addEventHandler ("onClientElementDataChange", localPlayer, function(dataName, oldValue)
	if (dataName~="uo_sb") then return end
	uo_sb = getElementData(localPlayer, "uo_sb")
end)