local txt_brakkasy={
    "Fajnie jest sobie pomarzyć, nie stać Cię na ten pojazd.",
    "Nie stać Cię na ten pojazd.",
    "Nie masz wystarczającej ilości gotówki."
}

function menu_zakupAuta(argumenty)
    -- zakomentowac jesli bedzie zmieniana cena pojazdu w handlingu!
    local handling=getOriginalHandling(argumenty.model)
    if (getPlayerMoney(localPlayer)<handling.monetary*3) then
	triggerEvent("onCaptionedEvent", root, txt_brakkasy[math.random(1,#txt_brakkasy)], 4)
	return
    end
    triggerServerEvent("onZakupAuta", localPlayer, argumenty.model, argumenty.indeks)
end