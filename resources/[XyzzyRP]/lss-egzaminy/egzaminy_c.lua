--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


local aktualny_egzamin=nil

local w_e={}
w_e.wnd = guiCreateWindow(0.1469,0.1667,0.7344,0.675,"Egzaminy",true)
w_e.btn_zrezygnuj = guiCreateButton(0.0277,0.8395,0.3064,0.1327,"Zrezygnuj",true,w_e.wnd)
w_e.btn_nastepne = guiCreateButton(1-0.0277-0.3064,0.8395,0.3064,0.1327,"Następne",true,w_e.wnd)

w_e.lbl_pytanie=guiCreateLabel(0.0277, 0.1, 1-0.0277*2, 0.3, "Pytanie", true, w_e.wnd)
guiLabelSetHorizontalAlign(w_e.lbl_pytanie, "center", true)
guiLabelSetVerticalAlign(w_e.lbl_pytanie, "center")

w_e.rd_odp1 = guiCreateRadioButton(0.0277,0.4,1-0.0277*2,0.1,"Odpowiedź 1",true,w_e.wnd)
guiSetFont(w_e.rd_odp1, "default-small")
w_e.rd_odp2 = guiCreateRadioButton(0.0277,0.50,1-0.0277*2,0.1,"Odpowiedź 2",true,w_e.wnd)
guiSetFont(w_e.rd_odp2, "default-small")
w_e.rd_odp3 = guiCreateRadioButton(0.0277,0.60,1-0.0277*2,0.1,"Odpowiedź 3",true,w_e.wnd)
guiSetFont(w_e.rd_odp3, "default-small")
w_e.rd_odp4 = guiCreateRadioButton(0.0277,0.70,1-0.0277*2,0.1,"Odpowiedź 4",true,w_e.wnd)
guiSetFont(w_e.rd_odp4, "default-small")

guiSetVisible(w_e.wnd, false)

local w_m={}
w_m.wnd = guiCreateWindow(0.1469,0.1667,0.7344,0.675,"Egzaminy",true)
w_m.btn_przystap = guiCreateButton(0.0277,0.8395,0.3064,0.1327,"Przystąp",true,w_m.wnd)
w_m.lbl_info = guiCreateLabel(0.6, 0.8395, 0.35, 0.1327, "", true, w_m.wnd)
guiLabelSetHorizontalAlign(w_m.lbl_info, "center", true)
guiLabelSetVerticalAlign(w_m.lbl_info, "center")

w_m.grid = guiCreateGridList(0.0298,0.0895,0.9383,0.7191,true,w_m.wnd)
guiGridListSetSelectionMode(w_m.grid,1)
guiGridListSetSortingEnabled(w_m.grid,false)
--w_m.grid_c_kod = guiGridListAddColumn ( w_m.grid, "KOD", 0.15 )
w_m.grid_c_opis = guiGridListAddColumn ( w_m.grid, "Opis", 0.35 )
w_m.grid_c_wazny = guiGridListAddColumn ( w_m.grid, "Ważny", 0.10 )
w_m.grid_c_zdany =  guiGridListAddColumn ( w_m.grid, "Zdany", 0.28 )
w_m.grid_c_koszt =  guiGridListAddColumn ( w_m.grid, "Koszt", 0.18 )

guiSetVisible(w_m.wnd,false)

addEventHandler("onClientMarkerHit", resourceRoot, function(el,md)
  if not md or el~=localPlayer then return end

--  if getPlayerName(localPlayer)~="AFX" and getPlayerName(localPlayer)~="Justice" then
--    outputChatBox("Egzaminy są w trakcie przygotowywania.")
--    return
--  end
  triggerServerEvent("requestEgzaminyInfo", resourceRoot)
  aktualny_egzamin=nil
  guiSetVisible(w_e.wnd, false)
  guiSetVisible(w_m.wnd, true)
  guiGridListClear(w_m.grid)
  guiSetText(w_m.lbl_info,"")
--  showCursor(true, false)
end)

addEvent("egzaminyInfoResponse", true)
addEventHandler("egzaminyInfoResponse", resourceRoot, function(dane)
  guiGridListClear(w_m.grid)
  for i,v in ipairs(dane) do
    local row=guiGridListAddRow(w_m.grid)
    guiGridListSetItemText(w_m.grid, row, 1, v.kod, true, false)
    row = guiGridListAddRow(w_m.grid)
    guiGridListSetItemText(w_m.grid, row, 1, v.opis, false, false)
    guiGridListSetItemData(w_m.grid, row, 1, v.kod)
    guiGridListSetItemText(w_m.grid, row, 2, v.waznosc.."d", false, false)
    guiGridListSetItemText(w_m.grid, row, 4, string.format("%.02f", v.koszt/100), false, false)
    guiGridListSetItemData(w_m.grid, row, 4, v.koszt)
    if (not v.zdany) then
      guiGridListSetItemText(w_m.grid, row, 3, v.zdany or "-", false, false)
    elseif (v.wazny) then
      guiGridListSetItemText(w_m.grid, row, 3, v.zdany or "-", false, false)
      guiGridListSetItemData(w_m.grid, row, 3, true)
    else
      guiGridListSetItemText(w_m.grid, row, 3, v.zdany .. "(nieważny)", false, false)
    end

  end
end)

addEventHandler("onClientMarkerLeave", resourceRoot, function(el,md)
  if el~=localPlayer then return end
  guiSetVisible(w_m.wnd, false)
--  showCursor(false)
end)

addEventHandler("onClientGUIClick", w_m.btn_przystap, function()
  selectedRow= guiGridListGetSelectedItem ( w_m.grid) or -1
  if (selectedRow<0) then
    return
  end
  guiSetText(w_m.lbl_info,"")
  local kod=guiGridListGetItemData(w_m.grid, selectedRow, 1)
  if not kod then return end
  local koszt=guiGridListGetItemData(w_m.grid, selectedRow, 4)
  local wazny=guiGridListGetItemData(w_m.grid, selectedRow, 3)
  if wazny then
    guiSetText(w_m.lbl_info,"Nie musisz zdawać jeszcze tego egzaminu - jest jeszcze ważny.")
    return
  end
  if koszt>getPlayerMoney() then
    guiSetText(w_m.lbl_info,"Nie stać Cię na ten egzamin.")
    return
  end

  triggerServerEvent("rozpocznijEgzamin", resourceRoot, kod)
end, false)


--   triggerClientEvent(client, "rozpocznijEgzamin", resourceRoot, egzamin)

local egzamin_pytanie=0

local function pokazNastepnePytanie()
  -- sprawdzamy ostatnia odpowiedz
  if egzamin_pytanie>0 then
    local odpw=aktualny_egzamin.pytania[egzamin_pytanie].odpw
    if odpw==1 and guiRadioButtonGetSelected(w_e.rd_odp1) then
      aktualny_egzamin.prawidlowych_odpowiedzi=(aktualny_egzamin.prawidlowych_odpowiedzi or 0)+1
    elseif odpw==2 and guiRadioButtonGetSelected(w_e.rd_odp2) then
      aktualny_egzamin.prawidlowych_odpowiedzi=(aktualny_egzamin.prawidlowych_odpowiedzi or 0)+1
    elseif odpw==3 and guiRadioButtonGetSelected(w_e.rd_odp3) then
      aktualny_egzamin.prawidlowych_odpowiedzi=(aktualny_egzamin.prawidlowych_odpowiedzi or 0)+1
    elseif odpw==4 and guiRadioButtonGetSelected(w_e.rd_odp4) then
      aktualny_egzamin.prawidlowych_odpowiedzi=(aktualny_egzamin.prawidlowych_odpowiedzi or 0)+1
    end
  end

  -- pokazujemy nastepne pytanie
  egzamin_pytanie=egzamin_pytanie+1

  if egzamin_pytanie>#aktualny_egzamin.pytania then
      koniecEgzaminu()
      return
  end



  guiSetText(w_e.wnd, string.format("Pytanie %d z %d", egzamin_pytanie, #aktualny_egzamin.pytania))
  guiSetText(w_e.lbl_pytanie, aktualny_egzamin.pytania[egzamin_pytanie].pytanie)
  
  guiSetText(w_e.rd_odp1, aktualny_egzamin.pytania[egzamin_pytanie].odp1)
  guiSetText(w_e.rd_odp2, aktualny_egzamin.pytania[egzamin_pytanie].odp2)
  if aktualny_egzamin.pytania[egzamin_pytanie].odp3 then
    guiSetText(w_e.rd_odp3, aktualny_egzamin.pytania[egzamin_pytanie].odp3)
    guiSetVisible(w_e.rd_odp3, true)
  else
    guiSetVisible(w_e.rd_odp3, false)
  end
  if aktualny_egzamin.pytania[egzamin_pytanie].odp4 then
    guiSetText(w_e.rd_odp4, aktualny_egzamin.pytania[egzamin_pytanie].odp4)
    guiSetVisible(w_e.rd_odp4, true)
  else
    guiSetVisible(w_e.rd_odp4, false)
  end
  guiRadioButtonSetSelected(w_e.rd_odp1, false)
  guiRadioButtonSetSelected(w_e.rd_odp2, false)
  guiRadioButtonSetSelected(w_e.rd_odp3, false)
  guiRadioButtonSetSelected(w_e.rd_odp4, false)
end

function koniecEgzaminu()
  if aktualny_egzamin.prawidlowych_odpowiedzi>=aktualny_egzamin.min_odpowiedzi then
    triggerServerEvent("egzaminZdany", resourceRoot, aktualny_egzamin.kod)
  end

  guiSetVisible(w_e.rd_odp1, false)
  guiSetVisible(w_e.rd_odp2, false)
  guiSetVisible(w_e.rd_odp3, false)
  guiSetVisible(w_e.rd_odp4, false)

  guiSetText(w_e.lbl_pytanie, string.format("Koniec pytań!\nUdzielono prawidłowej odpowiedzi na %d z %d pytań. Do zdania egzaminu wymagana jest prawidłowa odpowiedź na %d pytań.\n\n%s",
        aktualny_egzamin.prawidlowych_odpowiedzi, #aktualny_egzamin.pytania, aktualny_egzamin.min_odpowiedzi, 
        aktualny_egzamin.prawidlowych_odpowiedzi>=aktualny_egzamin.min_odpowiedzi and "ZDAŁEŚ/AŚ" or "NIE ZDAŁEŚ/AŚ"))
  -- aktualny_egzamin.prawidlowych_odpowiedzi=

  guiSetVisible(w_e.btn_nastepne, false)
  guiSetText(w_e.btn_zrezygnuj, "Zamknij")
end

addEvent("rozpocznijEgzamin", true)
addEventHandler("rozpocznijEgzamin", resourceRoot, function(egzamin)
  aktualny_egzamin=egzamin
  egzamin_pytanie=0
  guiSetVisible(w_m.wnd, false)
  guiSetVisible(w_e.wnd, true)

  guiSetVisible(w_e.rd_odp1, true)
  guiSetVisible(w_e.rd_odp2, true)
  guiSetVisible(w_e.rd_odp3, true)
  guiSetVisible(w_e.rd_odp4, true)
  guiSetVisible(w_e.btn_nastepne, true)

  guiSetText(w_e.btn_zrezygnuj, "Zrezygnuj")
  pokazNastepnePytanie()
--  showCursor(false)
--  showCursor(true,true)
end)

addEventHandler("onClientGUIClick", w_e.btn_zrezygnuj, function()
  guiSetVisible(w_m.wnd, false)
  guiSetVisible(w_e.wnd, false)
--  showCursor(false)
end, false)


addEventHandler("onClientGUIClick", w_e.btn_nastepne, function()
  pokazNastepnePytanie()
end, false)