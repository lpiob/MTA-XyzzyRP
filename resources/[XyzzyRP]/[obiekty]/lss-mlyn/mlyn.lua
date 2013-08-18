CONTAINER_ID=729

function attachRotationAdjusted ( from, to )
    local frPosX, frPosY, frPosZ = getElementPosition( from )
    local frRotX, frRotY, frRotZ = getElementRotation( from )
    local toPosX, toPosY, toPosZ = getElementPosition( to )
    local toRotX, toRotY, toRotZ = getElementRotation( to )
    local offsetPosX = frPosX - toPosX
    local offsetPosY = frPosY - toPosY
    local offsetPosZ = frPosZ - toPosZ
    local offsetRotX = frRotX - toRotX
    local offsetRotY = frRotY - toRotY
    local offsetRotZ = frRotZ - toRotZ
 
    offsetPosX, offsetPosY, offsetPosZ = applyInverseRotation ( offsetPosX, offsetPosY, offsetPosZ, toRotX, toRotY, toRotZ )
 
    attachElements( from, to, offsetPosX, offsetPosY, offsetPosZ, offsetRotX, offsetRotY, offsetRotZ )
end
 
 
function applyInverseRotation ( x,y,z, rx,ry,rz )
    local DEG2RAD = (math.pi * 2) / 360
    rx = rx * DEG2RAD
    ry = ry * DEG2RAD
    rz = rz * DEG2RAD
 
    local tempY = y
    y =  math.cos ( rx ) * tempY + math.sin ( rx ) * z
    z = -math.sin ( rx ) * tempY + math.cos ( rx ) * z
 
    local tempX = x
    x =  math.cos ( ry ) * tempX - math.sin ( ry ) * z
    z =  math.sin ( ry ) * tempX + math.cos ( ry ) * z
 
    tempX = x
    x =  math.cos ( rz ) * tempX + math.sin ( rz ) * y
    y = -math.sin ( rz ) * tempX + math.cos ( rz ) * y
 
    return x, y, z
end

local plank=createObject(2937, -51.96,108.93,22.83,90,90,0)
local plank2=createObject(2937, -51.96,108.93,22.83,90,91,91)
setObjectScale(plank, 10.0)
setObjectScale(plank2, 10.0)
attachRotationAdjusted(plank2,plank)


local function rotatePlank()
  moveObject(plank, 50000, -51.96,108.93,22.83, 360*5)
  setTimer(rotatePlank, 50000, 1)
end
rotatePlank()
--local obrecz=createObject(6298, -59, 82, 8,0,0,69)
--setObjectScale(obrecz, 0.6)
-- 2937
--moveObject(obrecz, 10000, -59,82,8, 360,0,0)