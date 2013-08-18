local pojazdy={
-- model, x,y,z, rx,ry,rz
-- buffallo
{402,523.47,-1290.16,17.12,0,0,0.5},
-- flash
{565,529.39,-1290.57,16.90,0,0,358.8},
-- premier
{426,535.23,-1290.15,17.00,0,0,356.7},
-- phoeanix
{603,540.84,-1290.70,17.05,0,0,355.4},
-- sultan
{560,546.59,-1290.85,17.00,0,0,357.9},
-- washington
{421,551.76,-1290.76,17.08,0,0,357.3},
-- uranus
{558,556.91,-1291.23,16.85,0,0,10.0},
--zr-350
{477,567.20,-1288.41,17.04,0,0,101.2},
--super gt
{506,565.80,-1281.07,16.98,0,0,101.2}

-- po przeksztalceniu ta tablica bedzie wygladac tak:
-- {model,x,y,z,rx,ry,rz,text3d_nazwa=,text3d_opis=, dostepny=}
}

for i,v in ipairs(pojazdy) do
    -- sprawdzamy czy jest miejsce na zespawnowanie tego pojazdu
    local cs=createColSphere(v[2],v[3],v[4],3.5)
    local cs_pojazdy=getElementsWithinColShape(cs,"vehicle")
    destroyElement(cs)
    if (not cs_pojazdy or #cs_pojazdy<1) then
    
        pojazdy[i].veh=createVehicle(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
        local handling=getVehicleHandling(pojazdy[i].veh)
    
        pojazdy[i].text3d_opis=createElement("text")
        setElementPosition(pojazdy[i].text3d_opis,v[2],v[3],v[4]+1.5)
    
        pojazdy[i].text3d_nazwa=createElement("text")
        setElementPosition(pojazdy[i].text3d_nazwa,v[2],v[3],v[4]+2.5)
    
        setElementData(pojazdy[i].text3d_nazwa,"text",getVehicleName ( pojazdy[i].veh) )
        setElementData(pojazdy[i].text3d_nazwa,"scale",2.0)
        setElementData(pojazdy[i].text3d_opis,"text",tostring(handling.monetary*3).."$".."\n"..handling.driveType)
   
    
        setVehicleLocked(pojazdy[i].veh,true)
        setVehicleOverrideLights(pojazdy[i].veh,1)
        setVehicleDamageProof(pojazdy[i].veh,true)
        setElementFrozen(pojazdy[i].veh,true)
    
        pojazdy[i].dostepny=true
    
        setElementData(pojazdy[i].veh,"customAction",{label="Kup",resource="lss-salonsamochodowy",funkcja="menu_zakupAuta",args={model=v[1],indeks=i}})
    end
end


addEvent("onZakupAuta", true)
addEventHandler("onZakupAuta", root, function(model,i)
    if (not pojazdy[i].dostepny) then	-- ktos w miedzyczasie wykupil pojazd
	return
    end
    if (not exports["lss-core"]:eq_playerHasFreeSpace(source)) then
	outputChatBox("Nie masz miejsca w inwentarzu.", source, 255,0,0,true)
	return
    end

    -- weryfikujemy ilosc gotowki
    local handling=getOriginalHandling(model)
    if (getPlayerMoney(source)<handling.monetary*3) then
	-- triggerEvent("onCaptionedEvent", resourceRoot, txt_brakkasy[math.random(1,#txt_brakkasy)], 4)
	-- nie pokazujemy komunikatu bo to zrobil zasob kliencki
	return
    end
    takePlayerMoney(source,handling.monetary*3)
    destroyElement(pojazdy[i].text3d_nazwa)
    destroyElement(pojazdy[i].text3d_opis)
    destroyElement(pojazdy[i].veh)
    local dbid,vehicle=exports["lss-vehicles"]:createVehicleEx(pojazdy[i][1],pojazdy[i][2],pojazdy[i][3],pojazdy[i][4],pojazdy[i][5],pojazdy[i][6],pojazdy[i][7])
    if (not dbid) then
	outputDebugString("Nie udalo sie utworzyc pojazdu!")
	return
    end
    local character=getElementData(source,"character")
    exports["lss-vehicles"]:assignVehicleToOwner(vehicle,character.id)
    exports["lss-core"]:eq_giveItem(source, 6,2,tonumber(dbid))

    

end)