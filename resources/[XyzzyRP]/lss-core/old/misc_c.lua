addCommandHandler("devmode",function()
	setDevelopmentMode(true)
end)

addCommandHandler("gp",function()
	x,y,z=getElementPosition(localPlayer)
	_,_,a=getElementRotation(localPlayer)
  	p=string.format("%.2f,%.2f,%.2f,%.1f",x,y,z,a)
	setClipboard(p)
	outputChatBox(p)
end)

addEvent("playIntro", true)

function intro_play()
    fadeCamera(false,0)
    local samolot=createVehicle(577,4073.39,-1392.84,157.29,0,0,90.0)
    setElementAlpha(localPlayer,0)
    setElementPosition(localPlayer, 4073.39,-1392.84,157.29)
--    setElementRotation(localPlayer, 0,0,90.0)
--    local pilot=createPed(0,0,0,0,0,false)
    attachElements(localPlayer,samolot,0,-15,20)
    setCameraMatrix(4073.39,-1392.84,157.29, 3523.39,-1392.84,157.29)

    

    fadeCamera(true)		
    setCameraTarget(localPlayer)
    lotsamolotu=setTimer(function()
	local x,y,_=getElementPosition(samolot)
	outputDebugString(tostring(x))
	if (x<1900) then
		fadeCamera(false)
--	elseif (x<1800) then
--		killTimer(lotsamolotu)
--		destroyElement(samolot)
	elseif (x<2100) then
--		outputDebugString("rotating")
		setElementRotation(samolot, 0, (x-2100)/15, 90.0)
		setElementVelocity(samolot, -1,-(2100-x)/250,(2100-x)/350)
	else
		setElementVelocity(samolot, -1,0,0)
	end

	end, 50, 0)
    
    --setCameraTarget(samolot)
    setTimer(function() playSound("audio/karol-sanandreasmiejscetwoichmarzen.ogg")	end, 15000,1)
    setTimer(function()	playSound("audio/karol-wydalesostatniejebanepieniadzezebytuprzyleciec.ogg")		end, 20000,1)
    -- koniec pierwszej sekwencji - po 50*500ms
--    setTimer(function()
--	    destroyElement(samolot)
--	end, 50*500,1)
end

addEvent("playIntro", true)
addEventHandler("playIntro",root, intro_play)

addCommandHandler("intro",intro_play)