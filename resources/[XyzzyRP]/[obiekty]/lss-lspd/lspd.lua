
local ciec=createPed(61,1543.96,-1631.63,13.38,341.2,false)
setElementData(ciec, "npc", true)
setElementFrozen(ciec,true)

-- szlaban
--<object id="szlaban" doublesided="false" model="968" interior="0" dimension="0" posX="1544.69140625" posY="-1630.8270263672" posZ="13.070028305054"
local szlaban=createObject(968,1544.69140625,-1630.8270262672,13.070028,0,90,90)

local szlaban_cs=createColSphere(1544.77,-1627.63,13.38,10)
local szlaban_timer=nil

setElementData(szlaban,"customAction",{label="Otwórz",resource="lss-lspd",funkcja="menu_szlaban",args={src=szlaban}})
setElementData(ciec,"customAction",{label="Poproś o otwarcie",resource="lss-lspd",funkcja="menu_szlaban",args={src=ciec}})

function szlaban_opusc()
    local pojazdy=getElementsWithinColShape(szlaban_cs,"vehicle")
    if (#pojazdy>0) then 
        if (isTimer(szlaban_timer)) then killTimer(szlaban_timer) end
        szlaban_timer=setTimer(szlaban_opusc, 5000,1)
	return
    end
    local x,y,z=getElementPosition(szlaban)
    local rx,ry,rz=getElementRotation(szlaban)   
    ry=90-ry
    moveObject(szlaban, 2000, x,y,z,0,ry,0)
end

function szlaban_podnies()
    local x,y,z=getElementPosition(szlaban)
    local rx,ry,rz=getElementRotation(szlaban)
    if (ry<90 or ry>90) then return end	-- szlaban juz jest podniesiony lub podnosi sie
    
    moveObject(szlaban, 2000, x,y,z,0,-90,0)
    
    if (isTimer(szlaban_timer)) then killTimer(szlaban_timer) end
    szlaban_timer=setTimer(szlaban_opusc, 10000,1)
end

addEvent("onSzlabanOtwarcieRequest", true)
addEventHandler("onSzlabanOtwarcieRequest", resourceRoot, szlaban_podnies)
--[[
addEventHandler("onColShapeHit", szlaban_cs, function(hitElement,matchingDimension)
    if (getElementType(hitElement)~="vehicle" or not matchingDimension) then return end
    local vm=getElementModel(hitElement)
    if (vm~=596) then return end
    szlaban_podnies()    
    -- bool moveObject ( object theObject, int time,
--                      float targetx, float targety, float targetz, 
--		                      [ float moverx, float movery, float moverz,
--				                        string strEasingType, float fEasingPeriod, float fEasingAmplitude, float fEasingOvershoot ] )
end)
]]--