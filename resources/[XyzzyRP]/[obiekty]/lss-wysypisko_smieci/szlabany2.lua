

-- szlaban
--    <object id="wyss1" doublesided="false" model="968" interior="0" dimension="0" posX="853.96398925781" posY="-561.59503173828" posZ="16.840629577637" rotX="0" rotY="0" rotZ="94.589965820313"></object>
--    <object id="wyss2" doublesided="false" model="968" interior="0" dimension="0"  posX="685.11499023438" posY="-654.81872558594" posZ="15.898988723755" rotX="0" rotY="-90" rotZ="0"></object>
--    <object id="wyss3" doublesided="false" model="968" interior="0" dimension="0" posX="637.61804199219" posY="-420.46505737305" posZ="15.898988723755" rotX="0" rotY="0" rotZ="180"></object>


local szlaban=createObject(968,853.96398925781,-561.59503173828,16.84062957,0,-90,94.5899658)

local szlaban_cs=createColSphere(854.35,-565.02,17.11,9)
local szlaban_timer=nil

local function szlaban_opusc()
    local pojazdy=getElementsWithinColShape(szlaban_cs,"player")
    if (#pojazdy>0) then 
        if (isTimer(szlaban_timer)) then killTimer(szlaban_timer) end
        szlaban_timer=setTimer(szlaban_opusc, 5000,1)
	return
    end
    local x,y,z=getElementPosition(szlaban)
    local rx,ry,rz=getElementRotation(szlaban)   
    ry=ry-90
    moveObject(szlaban, 2000, x,y,z,0,ry,0)
end

local function szlaban_podnies()
    local x,y,z=getElementPosition(szlaban)
    local rx,ry,rz=getElementRotation(szlaban)
    if (ry<270 or ry>270) then return end	-- szlaban juz jest podniesiony lub podnosi sie
--    if (ry<270 or ry>270) then return end	-- szlaban juz jest podniesiony lub podnosi sie
    
    moveObject(szlaban, 2000, x,y,z,0,90,0)
    
    if (isTimer(szlaban_timer)) then killTimer(szlaban_timer) end
    szlaban_timer=setTimer(szlaban_opusc, 10000,1)
end

addEventHandler("onColShapeHit", szlaban_cs, function(hitElement,matchingDimension)
    if (getElementType(hitElement)~="player" or not matchingDimension) then return end
	local fi=getElementData(hitElement,"faction:id")
	if (not fi or fi~=4) then return end
	outputDebugString("podnosimy")
    szlaban_podnies()    
    -- bool moveObject ( object theObject, int time,
--                      float targetx, float targety, float targetz, 
--		                      [ float moverx, float movery, float moverz,
--				                        string strEasingType, float fEasingPeriod, float fEasingAmplitude, float fEasingOvershoot ] )
end)