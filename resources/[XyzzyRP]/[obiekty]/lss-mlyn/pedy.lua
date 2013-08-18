CENA_SKUPU=math.random(8,11)

local ped=createPed( 159,-58.52,86.32,3.12,211.9, false)
setElementFrozen(ped, true)
setElementData(ped, "npc", true)
setElementData(ped, "name", "pracownik młynu")
setElementData(ped,"customAction",{label="Oddaj zboże",resource="lss-mlyn",funkcja="menu_oddajZboze",args={}})
local cs=createColSphere(-58.13,85.74,3.12,2)

addEventHandler("onColShapeHit", cs, function(he,md)
  if (getElementType(he)=="player") then
	outputChatBox("Pracownik mówi: Aktualna cena skupu zboża: " .. CENA_SKUPU .. "$ za stóg", he)
	outputChatBox("(( PPM na pracowniku aby sprzedać ))", he)
  end
end)

