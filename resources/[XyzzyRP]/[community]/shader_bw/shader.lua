local screenWidth, screenHeight = guiGetScreenSize()
local myScreenSource = dxCreateScreenSource(screenWidth, screenHeight)
local flickerStrength = 10
local blurStrength = 0.001 
local noiseStrength = 0.001


addEventHandler("onClientResourceStart", resourceRoot,
function()
    if getVersion ().sortable < "1.1.0" then
        return
    else
        createShader()
    end
end)

addEventHandler ("onClientElementDataChange", localPlayer, function(dataName, oldValue)
	if (dataName~="uo_bw") then return end
	uo_bw = getElementData(localPlayer, "uo_bw")
	if uo_bw then addEventHandler("onClientPreRender", root, updateShader) else removeEventHandler("onClientPreRender", root, updateShader) end
end)


function createShader()     
    oldFilmShader, oldFilmTec = dxCreateShader("shaders/old_film.fx")
end


function updateShader()
    
    upDateScreenSource()

    if (oldFilmShader) then
        local flickering = math.random(100 - flickerStrength, 100)/100
        dxSetShaderValue(oldFilmShader, "ScreenSource", myScreenSource);
        dxSetShaderValue(oldFilmShader, "Flickering", flickering);
        dxSetShaderValue(oldFilmShader, "Blurring", blurStrength);
        dxSetShaderValue(oldFilmShader, "Noise", noiseStrength);
        dxDrawImage(0, 0, screenWidth, screenHeight, oldFilmShader)
    end
end


function upDateScreenSource()
    dxUpdateScreenSource(myScreenSource)
end