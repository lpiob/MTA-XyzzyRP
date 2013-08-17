local I=1
local D=30

local ped=createPed(38,1263.24,-1554.74,1381.83,268.0,false)
--setElementCollisionsEnabled(ped,false)
--setElementRotation(ped,0,0,180)
setElementFrozen(ped,true)
setElementData(ped,"npc",true)
setElementData(ped,"name","Urzędniczka")

setElementInterior(ped, I)
setElementDimension(ped, D)
--setPedAnimation ( ped, "INT_OFFICE", "OFF_Sit_Idle_Loop", -1, true, false )


local ped2=createPed(12,1263.24,-1550.25,1381.83,272.4,false)
--setElementCollisionsEnabled(ped2,false)
--setElementRotation(ped2,0,0,180)
setElementFrozen(ped2,true)
setElementData(ped2,"npc",true)
setElementData(ped2,"name","Urzędniczka")

setElementInterior(ped2, I)
setElementDimension(ped2, D)
--setPedAnimation ( ped2, "INT_OFFICE", "OFF_Sit_Idle_Loop", -1, true, false )

-- ped nie ma kolizji wiec nie mozna w niego kliknac
--local krzeslo=createObject(13007, 1669.3183, 252.9404,1421.102)
--setElementDimension(krzeslo, D)
--setElementInterior(krzeslo, I)

setElementData(ped,"customAction",{label="Odbierz listy",resource="lss-poczta",funkcja="menu_odbierzListy",args={}})

function menu_odbierzListy()
    triggerServerEvent("doPlayerPickupMail", resourceRoot, localPlayer)
end