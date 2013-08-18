--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author AFX <afx@pylife.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--



local punkty={
--  umlv={358.30,182.45,1007.38,interior=3,dimension=9}
  szkolalatania={1467.67,-2232.74,2191.89, interior=2, dimension=45},
}

for i,v in pairs(punkty) do
  v.marker=createMarker(v[1],v[2],v[3],"cylinder", 1, 0,0,0,100)
  setElementInterior(v.marker, v.interior)
  setElementDimension(v.marker, v.dimension)
end

--   triggerServerEvent("requestEgzaminyInfo", resourceRoot)
addEvent("requestEgzaminyInfo", true)
addEventHandler("requestEgzaminyInfo", resourceRoot, function()
  local character=getElementData(client, "character")
  if not character then return end
  local dbid=character.id
  if not dbid then return end
  
  local dane=exports.DB2:pobierzTabeleWynikow("select e.kod,e.opis,e.waznosc,e.koszt,eg.ts zdany,eg.ts + INTERVAL e.waznosc DAY>NOW() wazny FROM lss_egzaminy e LEFT JOIN lss_egzaminy_gracze eg ON eg.kod=e.kod AND eg.id_gracza=? WHERE e.active=1", dbid)
  triggerClientEvent(client, "egzaminyInfoResponse", resourceRoot, dane)
end)


--   triggerServerEvent("rozpocznijEgzamin", resourceRoot, kod)
addEvent("rozpocznijEgzamin", true)
addEventHandler("rozpocznijEgzamin", resourceRoot, function(kod)
  -- pobieramy dane egzaminu
  local egzamin=exports.DB2:pobierzWyniki("SELECT * FROM lss_egzaminy WHERE kod=? LIMIT 1", kod)
  if not egzamin or not egzamin.kod then return end

  egzamin.pytania=exports.DB2:pobierzTabeleWynikow("SELECT * FROM lss_egzaminy_pytania WHERE kod=? ORDER BY RAND() LIMIT ?", kod, egzamin.min_pytan or 20)
  if not egzamin.pytania then return end
  if getPlayerMoney(client)<egzamin.koszt then return end
  takePlayerMoney(client,egzamin.koszt)
  triggerClientEvent(client, "rozpocznijEgzamin", resourceRoot, egzamin)
end)

--     triggerServerEvent("egzaminZdany", resourceRoot, aktualny_egzamin.kod)
addEvent("egzaminZdany", true)
addEventHandler("egzaminZdany", resourceRoot, function(kod)
  local character=getElementData(client, "character")
  if not character then return end
  local dbid=character.id

  if not dbid then return end -- snh
  exports.DB2:zapytanie("INSERT INTO lss_egzaminy_gracze SET id_gracza=?,kod=?,ts=NOW() ON DUPLICATE KEY UPDATE ts=NOW()", dbid, kod)
--  if kod=="LOTNICZY-L1" then
--    setElementData(client, "pjL", 1)
--  end
end)