local D=0
local I=0

--local marker=createMarker(532.94,-1922.14,7.96-1,"cylinder",1,255,0,255,255)
--setElementInterior(marker,I)
--setElementDimension(marker,D)


local playingAudio=nil

local function playNewAudio(audio)
	
	if playingAudio and isElement(playingAudio) then
		destroyElement(playingAudio)
	end
--	setElementData(scena,"audio", { "http://91.121.92.167:9150",903.6,2506.3,1954.41,1, 12, 40, 110} )                                                                           
	playingAudio=playSound3D(audio[1],audio[2],audio[3],audio[4],true)
	setElementInterior(playingAudio,audio[5])
	setElementDimension(playingAudio,audio[6])
	setSoundMinDistance(playingAudio,audio[7])
	setSoundMaxDistance(playingAudio,audio[8])
end

addEventHandler("onClientColShapeHit", resourceRoot, function(el,md)
	if el~=localPlayer or not md then return end
	local audio=getElementData(source,"audio")
	if not audio then return end
	playNewAudio(audio)
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(el,md)
	if el~=localPlayer then return end
	if not getElementData(source,"audio") then return end
	if playingAudio and isElement(playingAudio) then
		destroyElement(playingAudio)
	end
end)
addEventHandler("onClientElementDataChange", resourceRoot, function(dataName)
	if dataName~="audio" then return end
	if getElementType(source)~="colshape" then return end
	if not isElementWithinColShape(localPlayer, source) then return end
	if getElementDimension(localPlayer)~=getElementDimension(source) then return end
	if getElementInterior(localPlayer)~=getElementInterior(source) then return end
	playNewAudio(getElementData(source,"audio"))
end)

--[[
local naglosnienie=playSound3D("http://91.121.92.167:9150",903.6,2506.3,1954.41,true)
setElementInterior(naglosnienie,I)
setElementDimension(naglosnienie,D)
setSoundMinDistance(naglosnienie,40)
setSoundMaxDistance(naglosnienie,110)
]]--

-- scena
-- 918.60,2498.27,1960.13,351.0
-- 917.83,2484.91,1960.13,187.4


--local scena_panel=createColSphere(532.94,-1922.14,7.96,1)
--setElementDimension(scena_panel, D)
--setElementInterior(scena_panel, I)

GUIEditor_Window = {}
GUIEditor_Button = {}
GUIEditor_Edit = {}
GUIEditor_CMB = {}


local radia={
	{nazwa="Heavy Metal", url="http://91.121.157.133:5150"},
	{nazwa="Ballady Rockowe", url="http://188.165.20.29:6250"},		
	{nazwa="Disco-polo", url="http://91.121.92.167:9150"},
	{nazwa="Biesiada Œl¹ska", url="http://91.121.89.153:4350"},
	{nazwa="Ludowa", url="http://91.121.157.138:4950"},
	{nazwa="Radio-Baby", url="http://188.165.20.29:9650"},
	{nazwa="Szanty", url="http://188.165.20.29:5450"},				
	{nazwa="¯ydowska rodzinka", url="http://91.121.77.187:2650"},
	{nazwa="Oriental", url="http://188.165.21.29:3500"},
	{nazwa="Dubstep", url="http://listen.di.fm/public2/dubstep.pls"},
}

GUIEditor_Window = guiCreateWindow(0.2688,0.6167,0.5138,0.1967,"Pokój techniczny",true)
guiWindowSetSizable(GUIEditor_Window,false)
GUIEditor_CMB = guiCreateComboBox(0.0365,0.2881,0.674,1.5712,"(( zmiana strumienia ))",true,GUIEditor_Window)

for i,v in ipairs(radia) do
	guiComboBoxAddItem(GUIEditor_CMB, v.nazwa)
end
GUIEditor_Button = guiCreateButton(0.7299,0.2966,0.2409,0.2712,"Zmieñ",true,GUIEditor_Window)
guiSetVisible(GUIEditor_Window, false)

local function playerAllowed(plr)
    local c=getElementData(plr,"character")
    if not c then return false end
    local fid=getElementData(plr,"faction:id")
    if not fid then return false end
    if tonumber(fid)~=1 then return false end -- sm
    local rid=getElementData(plr,"faction:rank_id")
    if not rid then return false end
    if tonumber(rid)<4 then return false end
    return true
end

addEventHandler("onClientColShapeHit", scena_panel, function(el,md)
	if el~=localPlayer or not md then return end
	guiSetVisible(GUIEditor_Window, true)
	showCursor(true,false)
end)

addEventHandler("onClientColShapeLeave", scena_panel, function(el,md)
	if el~=localPlayer then return end
	guiSetVisible(GUIEditor_Window, false)
	showCursor(false)
end)

local mc_lu=getTickCount()-10000
addEventHandler("onClientGUIClick", GUIEditor_Button, function()
	local item=guiComboBoxGetSelected(GUIEditor_CMB)
	if not item or item<1 then return end
	if getTickCount()-mc_lu<10000 then
		outputChatBox("(( Musisz odczekaæ 10 sekund ))", true)
		return
	end
	mc_lu=getTickCount()
	strumien=radia[item+1].url
	strumien_opis= guiComboBoxGetItemText(GUIEditor_CMB, item)

	triggerServerEvent("doChangeAudio", resourceRoot, localPlayer, strumien, strumien_opis)
end, false)



local artysta1=createPed(231,528.80,-1902.71,7.96, 0,false)
setElementDimension(artysta1,D)
setElementInterior(artysta1,I)
setElementFrozen(artysta1, true)
setElementData(artysta1, "npc", true)
--setPedAnimation ( artysta1, "STRIP", "strip_G", -1, true, false )
setPedAnimation ( artysta1, "SKATE", "skate_idle", -1, true, false )

local artysta2=createPed(231,532.12,-1902.79,7.96, 0,false)
setElementDimension(artysta2,D)
setElementInterior(artysta2,I)
setElementFrozen(artysta2, true)
setElementData(artysta2, "npc", true)
setPedAnimation ( artysta2, "SKATE", "skate_idle", -1, true, false )


local chor1=createPed(69,515.98,-1919.19,7.96,270,false)
setElementDimension(chor1,D)
setElementInterior(chor1,I)
setElementFrozen(chor1, true)
setElementData(chor1, "npc", true)
setPedAnimation ( chor1, "ON_LOOKERS", "shout_in", -1, true, false )

local chor2=createPed(56,516.01,-1920.28,7.96,263,false)
setElementDimension(chor2,D)
setElementInterior(chor2,I)
setElementFrozen(chor2, true)
setElementData(chor2, "npc", true)
setPedAnimation ( chor2, "ON_LOOKERS", "shout_in", -1, true, false )

local chor3=createPed(93,515.94,-1921.58,7.96,270,false)
setElementDimension(chor3,D)
setElementInterior(chor3,I)
setElementFrozen(chor3, true)
setElementData(chor3, "npc", true)
setPedAnimation ( chor3, "ON_LOOKERS", "shout_in", -1, true, false )

local chor4=createPed(54,516.07,-1922.92,7.96,279,false)
setElementDimension(chor4,D)
setElementInterior(chor4,I)
setElementFrozen(chor4, true)
setElementData(chor4, "npc", true)
setPedAnimation ( chor4, "ON_LOOKERS", "shout_in", -1, true, false )

local chor5=createPed(89,515.92,-1924.24,7.96,260,false)
setElementDimension(chor5,D)
setElementInterior(chor5,I)
setElementFrozen(chor5, true)
setElementData(chor5, "npc", true)
setPedAnimation ( chor5, "ON_LOOKERS", "shout_in", -1, true, false )

local chor6=createPed(234,515.86,-1925.81,7.96,290,false)
setElementDimension(chor6,D)
setElementInterior(chor6,I)
setElementFrozen(chor6, true)
setElementData(chor6, "npc", true)
setPedAnimation ( chor6, "ON_LOOKERS", "shout_in", -1, true, false )


local tancerz1=createPed(108,553.15,-1917.59,7.96,90,false)
setElementDimension(tancerz1,D)
setElementInterior(tancerz1,I)
setElementFrozen(tancerz1, true)
setElementData(tancerz1, "npc", true)
setPedAnimation ( tancerz1, "FINALE", "FIN_Cop1_Stomp", -1, true, false )

local tancerz2=createPed(214,530.66,-1915.11,7.96,0,false)
setElementDimension(tancerz2,D)
setElementInterior(tancerz2,I)
setElementFrozen(tancerz2, true)
setElementData(tancerz2, "npc", true)
setPedAnimation ( tancerz2, "STRIP", "STR_C2", -1, true, false )

local tancerz3=createPed(214,529.73,-1917.95,7.96,0,false)
setElementDimension(tancerz3,D)
setElementInterior(tancerz3,I)
setElementFrozen(tancerz3, true)
setElementData(tancerz3, "npc", true)
setPedAnimation ( tancerz3, "STRIP", "STR_C2", -1, true, false )

local tancerz4=createPed(214,532.34,-1917.91,7.96,0,false)
setElementDimension(tancerz4,D)
setElementInterior(tancerz4,I)
setElementFrozen(tancerz4, true)
setElementData(tancerz4, "npc", true)
setPedAnimation ( tancerz4, "STRIP", "STR_C2", -1, true, false )

local raper1=createPed(28,523.42,-1926.60,7.96,0,false)
setElementDimension(raper1,D)
setElementInterior(raper1,I)
setElementFrozen(raper1, true)
setElementData(raper1, "npc", true)
setPedAnimation ( raper1, "RAPPING", "RAP_C_Loop", -1, true, false )

local raper2=createPed(29,543.38,-1923.82,7.96,0,false)
setElementDimension(raper2,D)
setElementInterior(raper2,I)
setElementFrozen(raper2, true)
setElementData(raper2, "npc", true)
setPedAnimation ( raper2, "SCRATCHING", "scmid_l", -1, true, false )
