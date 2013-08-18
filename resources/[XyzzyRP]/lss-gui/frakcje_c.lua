--[[ TEN KOD CZEKA NA MTA 1.3.1

local photo_memory={}
MAX_PHOTOS=3
for i=1,MAX_PHOTOS do
    photo_memory[i]=dxCreateScreenSource ( 320, 240 )
end

local photo_index=1

addEventHandler("onClientPlayerWeaponFire", localPlayer, function(weapon,ammo)
    if (weapon==43) then
        dxUpdateScreenSource( photo_memory[photo_index] )                  -- Capture the current screen output from GTA
	local pixels=dxGetTexturePixels(photo_memory[photo_index])
--	outputChatBox("len " .. string.len(pixels))
	triggerServerEvent("onPlayerTakePhoto",localPlayer, pixels)
        photo_index=photo_index+1
        if (photo_index>MAX_PHOTOS) then photo_index=1 end
    end
end)




]]--
--[[
bindKey("fire","down",function()
    if (getPedWeapon(localPlayer)==43 and getPedTotalAmmo(localPlayer)>0 and (getKeyState("mouse2") or getKeyState("capslock")) then
	outputChatBox(tostring(getCameraViewMode()))
    
    end
end)
]]--
		
		--[[
addEventHandler( "onClientRender", root,
    function()
    for i=1,MAX_PHOTOS do
        dxDrawImage(105*i,200,100,100, photo_memory[i])
    end

    end)
    ]]--
    
