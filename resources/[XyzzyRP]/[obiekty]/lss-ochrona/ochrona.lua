local ochrona=createObject(968,2188.490234375,-1766.1884765625,13.137217826843,180,270,0) -- szlaban przy szpitalu

local ochrona_cs=createColSphere(1997.05,-1445.40,13.56,4)
local ochrona_timer=nil

setElementData(ochrona,"customAction",{label="Otwórz",resource="lss-ochrona",funkcja="menu_ochrona",args={src=ochrona}})

function ochrona_opusc()
    local pojazdy=getElementsWithinColShape(ochrona_cs,"vehicle")
    if (#pojazdy>0) then 
        if (isTimer(ochrona_timer)) then killTimer(ochrona_timer) end
        ochrona_timer=setTimer(ochrona_opusc, 5000,1)
	return
    end
    local x,y,z=getElementPosition(ochrona)
    local rx,ry,rz=getElementRotation(ochrona)   
    ry=270-ry
    moveObject(ochrona, 2000, x,y,z,0,ry,0)
end

function ochrona_podnies()
    local x,y,z=getElementPosition(ochrona)
    local rx,ry,rz=getElementRotation(ochrona)
    if (ry<270 or ry>270) then return end	-- ochrona juz jest podniesiony lub podnosi sie
    
    moveObject(ochrona, 2000, x,y,z,0,-90,0)
    
    if (isTimer(ochrona_timer)) then killTimer(ochrona_timer) end
    ochrona_timer=setTimer(ochrona_opusc, 10000,1)
end

addEvent("onOchronaOtwarcieRequest", true)
addEventHandler("onOchronaOtwarcieRequest", resourceRoot, ochrona_podnies)