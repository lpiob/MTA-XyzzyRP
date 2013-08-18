TAG_VISIBILITY_DISTANCE = 100
TAG_VISIBILITY_DISTANCE_SQ = TAG_VISIBILITY_DISTANCE*TAG_VISIBILITY_DISTANCE

function initSpraying()
	empty_tex = dxCreateTexture(0,0)
	tag_root = getElementByID("drawtag:tags")
	all_tags = {}
	visible_tags = {}
	initTagPosData()
	initExistingTags()
	tag_stream_thread = coroutine.create(streamTags)
	addEventHandler("onClientElementDataChange",tag_root,updateTagData)
	addEventHandler("onClientElementDestroy",tag_root,clearTagData)
	addEventHandler("onClientElementDataChange",localPlayer,updateTextureForNewTag)
	addEventHandler("onClientPreRender",root,renderTags)
	addEventHandler("onClientPlayerWeaponFire",root,playerSpraying)
end

function initExistingTags()
	local tags = getElementChildren(tag_root)
	for tagnum,tag in ipairs(tags) do
		if getElementData(tag,"visible") then
			pushTagOnSpray(tag,getElementData(tag,"visibility")-1)
			addTagToPosList(tag)
			all_tags[tag] = true
		end
	end
end

function getTagCenterPosition(tag)
	return getElementData(tag,"x"),getElementData(tag,"y"),getElementData(tag,"z")
end

function setTagCenterPosition(tag,x,y,z)
	setElementData(tag,"x",x)
	setElementData(tag,"y",y)
	setElementData(tag,"z",z)
end

function createTagTexture(tag)
	local tex = getElementData(tag,"texture")
	if tex then return end
	local pngdata = getElementData(tag,"pngdata")
	if not pngdata then return end

	tex = dxCreateTexture(pngdata,"dxt1",false,"clamp")
	setElementData(tag,"texture",tex,false)
	return tex
end

function destroyTagTexture(tag)
	local tex = getElementData(tag,"texture")
	if not tex then return end
	destroyElement(tex)
	setElementData(tag,"texture",false,false)
end

function updateTagData(dataname,oldval)
	if dataname == "visible" then
		addTagToPosList(source)
		all_tags[source] = true
		local cx,cy,cz = getCameraMatrix()
		local x,y,z = getTagCenterPosition(source)
		x,y,z = x-cx,y-cy,z-cz
		if x*x+y*y+z*z < TAG_VISIBILITY_DISTANCE_SQ then
			visible_tags[source] = true
			createTagTexture(source)
		end
	elseif dataname == "visibility" and oldval then
		pushTagOnSpray(source,getElementData(source,"visibility")-oldval)
	end
end

function pushTagOnSpray(tag,off)
	local nx,ny,nz = getElementData(tag,"nx"),getElementData(tag,"ny"),getElementData(tag,"nz")
	local nlen = 0.001/math.sqrt(nx*nx+ny*ny+nz*nz)*off
	nx,ny,nz = nx*nlen,ny*nlen,nz*nlen
	local x1,y1,z1 = getElementData(tag,"x1"),getElementData(tag,"y1"),getElementData(tag,"z1")
	local x2,y2,z2 = getElementData(tag,"x2"),getElementData(tag,"y2"),getElementData(tag,"z2")
	x1,y1,z1,x2,y2,z2 = x1+nx,y1+ny,z1+nz,x2+nx,y2+ny,z2+nz
	setElementData(tag,"x1",x1,false)
	setElementData(tag,"y1",y1,false)
	setElementData(tag,"z1",z1,false)
	setElementData(tag,"x2",x2,false)
	setElementData(tag,"y2",y2,false)
	setElementData(tag,"z2",z2,false)
end

function clearTagData()
	all_tags[source] = nil
	visible_tags[source] = nil
	destroyTagTexture(source)
	removeTagFromPosList(source)
end

function renderTags()
	coroutine.resume(tag_stream_thread)
	do
		local x,y,z = getElementPosition(localPlayer)
		dxDrawMaterialLine3D(x,y,z,x,y,z,empty_tex,0,0,0,0,0)
	end
--	outputDebugString("--")
	for tag,visible in pairs(visible_tags) do
--		outputDebugString("aaa")
		local x1,y1,z1 = getElementData(tag,"x1"),getElementData(tag,"y1"),getElementData(tag,"z1")
		local x2,y2,z2 = getElementData(tag,"x2"),getElementData(tag,"y2"),getElementData(tag,"z2")
		local nx,ny,nz = getElementData(tag,"nx"),getElementData(tag,"ny"),getElementData(tag,"nz")
		local tex = getElementData(tag,"texture")
		if (not tex) then
		  tex=createTagTexture(tag)
		end
		if (tex) then
		  dxDrawMaterialLine3D(x1,y1,z1,x2,y2,z2,tex,1.5,tocolor(255,255,255,128),x1+nx,y1+ny,z1+nz)
		end
	end
end

function streamTags()
	while true do
		local updated = 0
		local cx,cy,cz = getCameraMatrix()
		for tag,exists in pairs(all_tags) do
			local x,y,z = getTagCenterPosition(tag)
			x,y,z = x-cx,y-cy,z-cz
			local dist = x*x+y*y+z*z
			if visible_tags[tag] then
				if dist > TAG_VISIBILITY_DISTANCE_SQ then
					visible_tags[tag] = nil
					destroyTagTexture(tag)
				end
			else
				if dist <= TAG_VISIBILITY_DISTANCE_SQ then
					visible_tags[tag] = true
					createTagTexture(tag)
				end
			end
			updated = updated+1
			if updated == 64 then
				coroutine.yield()
				updated = 0
				cx,cy,cz = getCameraMatrix()
			end
		end
		coroutine.yield()
	end
end

function sprayNewTag(x,y,z,x1,y1,z1,x2,y2,z2,nx,ny,nz)
	local tag = getElementData(localPlayer,"drawtag:tag")
	if not tag then return end
	setTagCenterPosition(tag,x,y,z)
	setElementData(tag,"x1",x1)
	setElementData(tag,"y1",y1)
	setElementData(tag,"z1",z1)
	setElementData(tag,"x2",x2)
	setElementData(tag,"y2",y2)
	setElementData(tag,"z2",z2)
	setElementData(tag,"nx",nx)
	setElementData(tag,"ny",ny)
	setElementData(tag,"nz",nz)
	setElementData(tag,"visible",true)
	setElementData(tag,"visibility",1)
	setElementData(localPlayer,"drawtag:tag",false)
end

function updateTextureForNewTag(dataname,oldval)
	if dataname ~= "drawtag:tag" then return end
	updateTagTexture()
end

function playerSpraying(weapon,ammo,inclip,hitx,hity,hitz,hitel)
	if weapon ~= 41 then return end
	local spraymode = getElementData(source,"drawtag:spraymode")
	if not spraymode or spraymode=="none" then return end
	local mx,my,mz = getPedWeaponMuzzlePosition(source)
	hitx,hity,hitz = hitx-mx,hity-my,hitz-mz
	local hdist = 2/math.sqrt(hitx*hitx+hity*hity+hitz*hitz)
	hitx,hity,hitz = mx+hitx*hdist,my+hity*hdist,mz+hitz*hdist
	local wall,x0,y0,z0,hitel,zx,zy,zz = processLineOfSight(mx,my,mz,hitx,hity,hitz,true,false,false,true,false,false,false,false)
	if not wall then return end
	local spraymode_draw = spraymode == "draw"
	local tag = getNearestTag(x0,y0,z0)
	if tag then
		local visibility = getElementData(tag,"visibility")
--		if (visibility==90) then
--			playSound("audio/sprayshake.ogg")
--		end
		if visibility == 90 and spraymode_draw then return end
		visibility = spraymode_draw and visibility+1 or visibility-1
		local sync = source == localPlayer and visibility%10 == 0
		setElementData(tag,"visibility",visibility,sync)
	elseif source == localPlayer and can_spray and spraymode_draw then
		local zlen = 1/math.sqrt(zx*zx+zy*zy+zz*zz)
		local xx,xy,xz
		local yx,yy,yz
		do
			local w,h = guiGetScreenSize()
			w,h = w*0.5,h*0.5
			local x1,y1,z1 = getWorldFromScreenPosition(w,h,1)
			local cux,cuy,cuz = getWorldFromScreenPosition(w,0,1)
			cux,cuy,cuz = cux-x1,cuy-y1,cuz-z1
			xx,xy,xz = zy*cuz-zz*cuy,zz*cux-zx*cuz,zx*cuy-zy*cux
			yx,yy,yz = xy*zz-xz*zy,xz*zx-xx*zz,xx*zy-xy*zx
		end
		local xlen = 0.75/math.sqrt(xx*xx+xy*xy+xz*xz)
		local ylen = 0.75/math.sqrt(yx*yx+yy*yy+yz*yz)
		xx,xy,xz = xx*xlen,xy*xlen,xz*xlen
		yx,yy,yz = yx*ylen,yy*ylen,yz*ylen
		do
			local cx,cy,cz = mx+zx,my+zy,mz+zz
			local bx,by,bz = x0-zx*0.01,y0-zy*0.01,z0-zz*0.01
			if isLineOfSightClear(cx,cy,cz,bx+xx+yx,by+xy+yy,bz+xz+yz,true,false,false,true,false,true,false) then return end
			if isLineOfSightClear(cx,cy,cz,bx+xx-yx,by+xy-yy,bz+xz-yz,true,false,false,true,false,true,false) then return end
			if isLineOfSightClear(cx,cy,cz,bx-xx+yx,by-xy+yy,bz-xz+yz,true,false,false,true,false,true,false) then return end
			if isLineOfSightClear(cx,cy,cz,bx-xx-yx,by-xy-yy,bz-xz-yz,true,false,false,true,false,true,false) then return end
			local fx,fy,fz = x0+zx*0.01,y0+zy*0.01,z0+zz*0.01
			if not isLineOfSightClear(cx,cy,cz,fx+xx+yx,fy+xy+yy,fz+xz+yz,true,false,false,true,false,true,false) then return end
			if not isLineOfSightClear(cx,cy,cz,fx+xx-yx,fy+xy-yy,fz+xz-yz,true,false,false,true,false,true,false) then return end
			if not isLineOfSightClear(cx,cy,cz,fx-xx+yx,fy-xy+yy,fz-xz+yz,true,false,false,true,false,true,false) then return end
			if not isLineOfSightClear(cx,cy,cz,fx-xx-yx,fy-xy-yy,fz-xz-yz,true,false,false,true,false,true,false) then return end
		end
		local off1 = -zlen*0.005
		local off2 = -zlen*0.075
		local x1,y1,z1 = x0+zx*off1+yx,y0+zy*off1+yy,z0+zz*off1+yz
		local x2,y2,z2 = x0+zx*off2-yx,y0+zy*off2-yy,z0+zz*off2-yz
		sprayNewTag(x0,y0,z0,x1,y1,z1,x2,y2,z2,zx,zy,zz)
	end
end

----------------------------------------

function initTagPosData()
	tag_pos_list = {}
end

function addTagToPosList(tag)
	local x,y,z = getTagCenterPosition(tag)
	x,y,z = math.floor(x*0.2),math.floor(y*0.2),math.floor(z*0.2)
	if not tag_pos_list[z] then tag_pos_list[z] = {} end
	if not tag_pos_list[z][y] then tag_pos_list[z][y] = {} end
	if not tag_pos_list[z][y][x] then tag_pos_list[z][y][x] = {} end
	tag_pos_list[z][y][x][tag] = true
end

function removeTagFromPosList(tag)
	if not getElementData(tag,"visible") then return end
	local x,y,z = getTagCenterPosition(tag)
	x,y,z = math.floor(x*0.2),math.floor(y*0.2),math.floor(z*0.2)
	if not tag_pos_list[z] then return end
	if not tag_pos_list[z][y] then return end
	if not tag_pos_list[z][y][x] then return end
	tag_pos_list[z][y][x][tag] = nil
end

function getNearestTag(x,y,z)
	local nearest_dist,nearest_tag = 2.25
	local cx,cy,cz = math.floor(x*0.2),math.floor(y*0.2),math.floor(z*0.2)
	for oz = -1,1 do
		local plane = tag_pos_list[cz+oz]
		if plane then
			for oy = -1,1 do
				local line = plane[cy+oy]
				if line then
					for ox = -1,1 do
						local cube = line[cx+ox]
						if cube then
							for tag,exists in pairs(cube) do
								local dx,dy,dz = getTagCenterPosition(tag)
								dx,dy,dz = dx-x,dy-y,dz-z
								local this_dist = dx*dx+dy*dy+dz*dz
								if this_dist < nearest_dist then
									nearest_tag = tag
									nearest_dist = this_dist
								end
							end
						end
					end
				end
			end
		end
	end
	return nearest_tag
end

----------------------------------

function getPlayerSprayMode(player)
	return getElementData(player,"drawtag:spraymode") or "none"
end

