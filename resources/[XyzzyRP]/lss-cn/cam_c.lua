--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--


local wd={}

local tt=getTickCount()-60000

photo_desc=""

wd.win = guiCreateWindow(0.7773,0.3216,0.1758,0.3477,"CNN News",true)
guiWindowSetMovable(wd.win,false)
guiWindowSetSizable(wd.win,false)
wd.memo_opis = guiCreateMemo(0.0611,0.1236,0.8556,0.4981,"",true,wd.win)
wd.btn_wyslij = guiCreateButton(0.05,0.6404,0.8778,0.1536,"Wyślij zdjęcie",true,wd.win)
wd.btn_anuluj = guiCreateButton(0.05,0.8165,0.8778,0.1536,"Anuluj",true,wd.win)



guiSetVisible(wd.win,false)


local photo_memory=dxCreateScreenSource ( 320, 240 )
local renderTarget=dxCreateRenderTarget( 320,240 )


local function watermarkAndUpload()
		dxSetRenderTarget(renderTarget,true)
		dxDrawImage(0,0,320,240, photo_memory)

--		dxDrawRectangle(0,200,40,40,tocolor(255,255,255,255))
--dxSetBlendMode("add")
		dxDrawImage(0,200, 40, 40, "i/tvn24.png")
--dxSetBlendMode("blend")

		dxDrawText(photo_desc, 41+1,200+1, 320+1,240+1,tocolor(0,0,0),1,"default-small",'left','center',false,true)
--		dxDrawText(photo_desc, 41-1,200-1, 320-1,240-1,tocolor(0,0,0),1,"default-small",'left','center',false,true)
		dxDrawText(photo_desc, 41,200, 320,240,tocolor(255,255,255),1,"default-small",'left','center',false,true)
		dxSetRenderTarget()
		local pixels=dxGetTexturePixels(renderTarget)

--	outputChatBox("len " .. string.len(pixels))
		triggerLatentServerEvent("onPlayerTakePhoto",50000,resourceRoot, pixels)
	removeEventHandler("onClientRender", root, watermarkAndUpload)
end

local function showUploadWin()
		guiSetVisible(wd.win,true)
		showCursor(true,true)
end


addEventHandler("onClientPlayerWeaponFire", localPlayer, function(weapon,ammo)

--	if getPlayerName(localPlayer)~="Brian_Looner" then return end
	local fid=getElementData(localPlayer,"faction:id")
	if not fid or tonumber(fid)~=5 then return end
	local rid=getElementData(localPlayer,"faction:rank_id")
	if not rid or tonumber(rid)<3 then return end

    if (weapon==43) then
		if getTickCount()-tt<60000 then
			outputChatBox("Musisz odczekać: " .. math.floor((60000-(getTickCount()-tt))/1000).."s", 255,0,0)
			return
		end
		tt=getTickCount()
        dxUpdateScreenSource( photo_memory )
--		addEventHandler("onClientRender", root, watermarkAndUpload)
		setTimer(showUploadWin, 1500, 1)
    end
end)

addEventHandler("onClientGUIClick", wd.btn_anuluj, function()
	guiSetVisible(wd.win,false)
	showCursor(false)
end, false)

addEventHandler("onClientGUIClick", wd.btn_wyslij, function()
	photo_desc=guiGetText(wd.memo_opis)
	addEventHandler("onClientRender", root, watermarkAndUpload)
	guiSetVisible(wd.win,false)
	showCursor(false)
end, false)




local myShader, myShader_g1

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

		replaceTex("i/off.jpg", "bobobillboard1")
--		replaceTex("i/marmur.jpg", "sam_camo")
--	  sam_camo

	end
)

local lastPhotoChange=getTickCount()-30000

local function changePhoto(to)
	if not to and getTickCount()-lastPhotoChange<30000 then return end
	lastPhotoChange=getTickCount()
	local photos=getElementsByType("photo")

	if not photos or #photos<1 then return end

	if not to then to=photos[math.random(1,#photos)] end

	local pixels=getElementData(to,"pixels")
	local tex=dxCreateTexture(pixels)
	dxSetShaderValue ( myShader_g1, "CUSTOMTEX0", tex );
end

setTimer(changePhoto, 16000, 0)

local function purgeOldPhotos()
	local photos=getElementsByType("photo")

	if not photos or #photos<3 then return end
	for i,v in ipairs(photos) do
		local ts=getElementData(v,"ts")
		if not ts or getTickCount()-ts>5*60*1000 then
			destroyElement(v)
		end
	end
end

setTimer(purgeOldPhotos, 60000, 0)


--	triggerClientEvent("updatePhoto", resourceRoot, pixels)
addEvent("updatePhoto", true)
addEventHandler("updatePhoto", resourceRoot, function(pixels)
--	outputChatBox("rcvd")
	local photo=createElement("photo")
	setElementData(photo,"pixels", pixels)
	setElementData(photo,"ts", getTickCount())
	changePhoto(photo)
--	local tex=dxCreateTexture(pixels)
--	dxSetShaderValue ( myShader_g1, "CUSTOMTEX0", tex );
end)








-- urzad miejski

-- biuro burmistrza
bb=createObject(7901,1485.178,-1786.78,1287.900,0,0,270)
setElementCollisionsEnabled(bb,false)
setElementInterior(bb,1)
setElementDimension(bb,1)
setObjectScale(bb,0.23)



setTimer(triggerServerEvent, math.random(10000,20000), 1, "requestLastPhoto", resourceRoot)
