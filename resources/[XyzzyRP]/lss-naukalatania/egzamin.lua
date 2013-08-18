--[[
@author AFX <afx@pylife.pl>
@author RacheT <rachet@pylife.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local D=0
local I=0

local ped=createPed(0, 415.21,2537.13,19.15,171.8)
setElementFrozen(ped, true)
setElementData(ped, "name", "Egzaminator")
setElementDimension(ped, D)
setElementInterior(ped, I)
addPedClothes(ped, "hoodyAblue", "hoodyA", 0)
addPedClothes(ped, "tracktrwhstr", "tracktr", 2)
addPedClothes(ped, "sneakerbincblk", "sneaker", 3)
addPedClothes(ped, "glasses01", "glasses01", 15)
addPedClothes(ped, "capblk", "cap", 16)
--[[
setElementData(ped,"text", {
  "Proszę pamietać o trzymaniu się prawej krawędzi jezdni.",
  "W terenie zabudowanym nie wolno przekraczać prędkości 50km/h.",
  "Proszę jeździć ostrożnie i nie uszkodzić pojazdu!",
  "Proszę pamiętać o regułach drogowych!",
  "Proszę dowieźć mnie w całości z powrotem.",
  "{RANDOMGOSSIP}",
})
]]--


local cp={

  -- pozycje z /gp moga byc piesze albo z pojazdu albo z /jp - to bez roznicy
  -- argument text="" okresla ze instruktor w tym momencie cos powie
  -- argument musidotykaziemii=true mowi sam za siebie
  -- argument lotniczy=true zmienia typ markera z checkpointa na pierscien
  {2016.14,-2455.79,13.94,180.3, text="Proszę upewnić się że pas jest wolny i wjechać na niego", musidotykacziemii=true},
  {2006.59,-2485.20,13.93,94.1,text="Proszę rozpędzić samolot, ale oderwać się dopiero za następnym punktem.", musidotykacziemii=true},
  {1913.05,-2488.24,13.93,90.0,text="Proszę oderwać się od ziemii", musidotykacziemii=true},
  {1817.47,-2488.30,19.87,90.0,text="Proszę utrzymywać tempo wznoszenia się", lotniczy=true},
  {1636.43,-2491.55,44.42,87.6, lotniczy=true},
  {1415.52,-2493.50,62.77,87.7, lotniczy=true},
  {1204.99,-2440.94,66.27,57.9, lotniczy=true},
  {1032.66,-2203.44,87.51,18.9, lotniczy=true},
  {965.64,-1831.93,109.45,1.2, lotniczy=true},
  {1027.45,-1461.60,125.14,345.1, lotniczy=true},
  {1032.94,-975.20,166.93,3.1, lotniczy=true},
  {1053.92,-667.89,181.50,327.0, lotniczy=true},
  {1292.36,-575.58,211.07,271.1, lotniczy=true},
  {1669.70,-674.41,204.46,254.3, lotniczy=true},
  {2017.48,-753.56,212.80,259.4, lotniczy=true},
  {2579.75,-887.51,169.18,251.1, lotniczy=true},
  {2809.31,-1055.04,140.04,209.8, lotniczy=true},
  {2902.73,-1550.48,129.20,180.3, lotniczy=true},
  {2876.26,-2084.57,98.50,159.8, lotniczy=true},
  {2720.11,-2293.11,110.68,137.8,text="Proszę przygotować się do lądowania", lotniczy=true},-- widac l
  {2467.89,-2475.45,108.17,103.5, lotniczy=true},
  {2123.49,-2488.39,33.71,86.2, lotniczy=true},
  {1778.73,-2487.33,13.96,92.9, musidotykaziemii=true, text="Proszę powoli zjechać z pasa."},
  {1717.26,-2487.33,13.98,92.8, musidotykacziemii=true},
  {1678.33,-2454.98,13.94,358.5, musidotykacziemii=true},

  }

--[[
for idx,e in ipairs(cp) do
  local marker=createMarker(e[1],e[2],e[3],e.lotniczy and "ring" or "checkpoint", 4, 255,0,255,200,getPlayerFromName("Bob_Euler"))
  if cp[idx+1] then
    e=cp[idx+1]
    setMarkerTarget(marker, e[1], e[2], e[3])
  end

end
]]--


local startMarker=createMarker(1501.29,-2220.05,2191.99,"cylinder", 1, 255,0,0,155)
setElementInterior(startMarker,2)
setElementDimension(startMarker, 45)


local function showNextCP(plr)
  local idx=getElementData(plr,"egzaminL_postep")
  local e=cp[idx]
  if not e then
    egzaminKoniec(plr,true)
    return
  end
  local marker=createMarker(e[1],e[2],e[3],e.lotniczy and "ring" or "checkpoint", 4, 255,0,0,200,plr)
  setElementData(plr,"egzaminL_marker", marker)

  if cp[idx+1] then
    e=cp[idx+1]
    setMarkerTarget(marker, e[1], e[2], e[3])
  end

  

  if isElement(marker) then
--    triggerClientEvent(plr, "setTarget", marker)
  end
end

addEventHandler("onMarkerHit", resourceRoot, function(el,md)

  if not isElement(el) or not md or getElementType(el)~="player" then return end

  if getMarkerType(source)=="cylinder" then 
    if (getElementData(el,"pjL") or 0)>0 then
      outputChatBox("Posiadasz już prawo lotnicze.", el)
      return
    end
    egzaminStart(el)
    return 
  end

  if not isElementVisibleTo(source, el) then return end

  local postep=getElementData(el, "egzaminL_postep")
  if not postep then return end -- nie powinno sie wydarzyc

  if not cp[postep] then return end
  if cp[postep].musidotykacziemii then  -- sprawdzamy czy pojazd dotyka ziemii
    local pojazd=getElementData(el,"egzaminL_vehicle")
    if not pojazd then return end
    if not pojazd or not isVehicleOnGround(pojazd) then
      outputChatBox("Oderwałeś koła od ziemii i oblałeś/aś egzamin!", el, 255,0,0)
      egzaminKoniec(el,false)
      return
    end
  end

  playSoundFrontEnd(el,12)
  destroyElement(source)



  if cp[postep].text then
    outputChatBox("Egzaminator mówi: " .. cp[postep].text, el, 255,255,100)
  end


  postep=postep+1
  setElementData(el,"egzaminL_postep", postep)
  showNextCP(el)
end)

function egzaminStart(plr)
--  if not exports["pl-core"]:isAdmin(plr) and getPlayerName(plr)~="JetroN" and getPlayerName(plr)~="kawi55" and getPlayerName(plr)~="Szczechu" then return false end
  local character=getElementData(plr,"character")
  if not character then return false end
  local dbid=character.id
  if not dbid then return false end
  local egzamin=exports.DB2:pobierzWyniki("select eg.ts+INTERVAL e.waznosc DAY>NOW() wazny from lss_egzaminy_gracze eg JOIN lss_egzaminy e ON e.kod=eg.kod WHERE eg.kod=? AND eg.id_gracza=?", "LOTNICZY-L1", dbid)
  if not egzamin or not egzamin.wazny or egzamin.wazny~=1 then
      outputChatBox("* Aby podejść do egzaminu praktycznego musisz zdać egzamin teoretyczny L1", plr, 255,0,0)
      return false
  end

  
--  outputDebugString("el1")
  local cs=createColSphere(2012.71,-2429.87,13.55,5)
  local el=#getElementsWithinColShape(cs)
  destroyElement(cs)
  if el>0 then
    outputChatBox("Egzamin nie może się rozpocząć - coś blokuje wyjazd z lotniska.", plr)
    return false
  end
  setElementInterior(plr,0)
  setElementDimension(plr,0)
  local pojazd=createVehicle(593,2016.02,-2431.96,13.94,0,0,180.3) -- dodo
  setElementData(pojazd,"przebieg", math.random(10000,20000))
  setElementData(pojazd,"paliwo", {1.5,1.5})
  setVehicleColor(pojazd, 255,255,255)
  setElementData(pojazd, "opis", "Egzamin lotniczy")
  setElementDimension(plr,0)
  setElementInterior(plr,0)
  warpPedIntoVehicle(plr, pojazd)

  local ped=createPed(0, -227.71,2724.53,62.69,323.3)
  setElementFrozen(ped, true)
  setElementData(ped, "name", "Egzaminator")
  addPedClothes(ped, "hoodyAblue", "hoodyA", 0)
  addPedClothes(ped, "tracktrwhstr", "tracktr", 2)
  addPedClothes(ped, "sneakerbincblk", "sneaker", 3)
  addPedClothes(ped, "glasses01", "glasses01", 15)
  addPedClothes(ped, "capblk", "cap", 16)
  warpPedIntoVehicle(ped,pojazd, 1)

  setElementData(plr,"egzaminL_postep", 1)
  setElementData(plr,"egzaminL_vehicle", pojazd)
  setElementData(plr,"egzaminL_ped", ped)
  showNextCP(plr)
  return true
end

function egzaminKoniec(plr,udany)
  local pojazd=getElementData(plr,"egzaminL_vehicle")
  if not pojazd then return end -- nie powinno sie wydarzyc

  if udany then
    local paliwo=getElementData(pojazd,"paliwo")
    outputDebugString("paliwo po egzaminie" .. paliwo[1])
  end

  removePedFromVehicle(plr)

  destroyElement(pojazd)
  removeElementData(plr,"egzaminL_vehicle")

  if getElementData(plr,"egzaminL_ped") then
    if isElement(getElementData(plr,"egzaminL_ped")) then
      destroyElement(getElementData(plr,"egzaminL_ped"))
    end
    removeElementData(plr,"egzaminL_ped")
  end
  if getElementData(plr,"egzaminL_marker") and isElement(getElementData(plr,"egzaminL_marker")) then
    destroyElement(getElementData(plr,"egzaminL_marker"))

  end
  removeElementData(plr,"egzaminL_marker")


  setElementDimension(plr,0)
  setElementInterior(plr,0)
  setElementPosition(plr,1447.93,-2287.25,13.55)
  if udany then
    outputChatBox("Gratulacje! Zdales egzamin!", plr)
    setElementData(plr,"pjL", 1)
    exports.DB2:zapytanie("UPDATE lss_character set pjL=1 WHERE id=?", getElementData(plr,"character").id)
  end
end

addEventHandler("onVehicleDamage", resourceRoot, function(loss)
  local kierowca=getVehicleController(source)
  if not kierowca then return end
  local pp=getElementData(kierowca, "egzaminL_vehicle")
  if not pp or pp~=source then return end 

  if loss>5 then
    outputChatBox("Uszkodziłeś pojazd! Koniec egzaminu!", kierowca, 255,0,0)
--    fadeCamera(kierowca, false)
--    setTimer(function(kierowca)
      egzaminKoniec(kierowca,false)
--      fadeCamera(kierowca, true)
--    end, 2000, 1, kierowca)
  end
end)
addEventHandler("onPlayerWasted", root, function()
  local pp=getElementData(source, "egzaminL_vehicle")
  if not pp then return end
  destroyElement(pp)
  if getElementData(source,"egzaminL_ped") then
    destroyElement(getElementData(source,"egzaminL_ped"))
  end
  if getElementData(source,"egzaminL_marker") and isElement(getElementData(source,"egzaminL_marker")) then
    destroyElement(getElementData(source,"egzaminL_marker"))
  end

end)

addEventHandler("onPlayerQuit", root, function()
  local pp=getElementData(source, "egzaminL_vehicle")
  if not pp then return end
  destroyElement(pp)
  if getElementData(source,"egzaminL_ped") then
    destroyElement(getElementData(source,"egzaminL_ped"))
  end
  if getElementData(source,"egzaminL_marker") and isElement(getElementData(source,"egzaminL_marker")) then
    destroyElement(getElementData(source,"egzaminL_marker"))
  end
end)

addEventHandler("onVehicleStartExit", resourceRoot, function()
  cancelEvent()
end)

