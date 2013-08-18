local ITEMID_SMIEC=9
local ITEMID_KWIT=13

--
local skiny_smieciarzy={ 15, 16, 27, 44, 50, 71, 78, 79, 161 }
local powitania= {
	"Proszę położyć smieci na wadze!",
	"Ay! Jakieś śmieci do oddania?",
	"Uszanowanie dla człowieka pracy!"
}
local skupy={
	-- x,y,z,kąt	- pozycja peda
	{ 693.03,-663.92,16.41,265.4},
	{ 860.15,-550.31,19.07,6.6 },
	{ 614.81,-428.53,19.00,61.9 }
}

for i,v in ipairs(skupy) do
	v.ped=createPed( skiny_smieciarzy[math.random(1,#skiny_smieciarzy)], v[1], v[2], v[3], v[4], false)
	setElementFrozen(v.ped, true)
	setElementData(v.ped, "npc", true)
	setElementData(v.ped, "name", "pracownik wysypiska")
	v.cs=createColSphere( v[1], v[2], v[3], 5)
	setElementData(v.cs,"skup", true, false)
end

for i,v in ipairs(getElementsByType("object", resourceRoot)) do
    if getElementModel(v)==11090 then
	setElementData(v,"customAction",{label="Wysyp śmieci",resource="lss-wysypisko_smieci",funkcja="menu_wysypSmieci",args={obiekt=v}})
    end
end

function skupPowitanie(el, md)
	if (getElementType(el)~="player" or not md) then return end
	if (not getElementData(source,"skup")) then return end
	outputChatBox("Pracownik wysypiska mówi: "..powitania[math.random(1,#powitania)], el)
end

addEventHandler("onColShapeHit", resourceRoot, skupPowitanie)



addEvent("onWymianaSmieci", true)
addEventHandler("onWymianaSmieci", root, function(ilosc)
    if (not exports["lss-core"]:eq_takeItem(source,ITEMID_SMIEC,ilosc)) then 
	-- ten komunikat jest dla zmyly, ta sytuacja nie powinna sie wydarzyc
	outputChatBox("Te śmieci nie nadają się do skupu!", source)
	return 
    end

    exports["lss-admin"]:outputLog(string.format("Gracz %s sprzedaje %d smieci w skupie", getPlayerName(source), ilosc))
    if (ilosc>=700) then
      triggerEvent("banMe", plr, "bug-using (#2)")
      return
    end


    local kasa=math.floor(tonumber(ilosc)/10)
    if kasa<1 then return end
    exports["lss-core"]:eq_giveItem(source, ITEMID_KWIT, kasa)
	exports["lss-pojemniki"]:insertItemToContainer(1728, ITEMID_SMIEC, ilosc) -- magazyn ze smieciami
    outputChatBox("Pracownik wysypiska mówi: proszę udać się z kwitem do urzędu miasta po odbiór gotówki.", source)
end)