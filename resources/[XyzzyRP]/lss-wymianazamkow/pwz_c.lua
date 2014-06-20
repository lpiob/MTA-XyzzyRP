--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

-- punkty wymiany zamkow
local pwz={	
  -- loc={x,y,z,r}, restrict_faction=<id frakcji ktora moze tu zmieniac zamki} 
  { loc={811.58,-579.15,16.32,3.5}, 	restrict_faction=4},
}



for i,v in ipairs(pwz) do
  v.cs=createColSphere(v.loc[1],v.loc[2],v.loc[3],v.loc[4])
  
end

-- gui

local wz={}
wz.win = guiCreateWindow(0.7531,0.3479,0.2109,0.3792,"Wymiana zamków",true)
wz.lbl = guiCreateLabel(0.037,0.1009,0.9185,0.3552,"Aby wymienić zamek w pojeździe, musi przy nim stać jego właściciel. Wymiana kosztuje 4000$",true,wz.win)
wz.cmb=guiCreateComboBox(0.037, 0.50,0.9185, 0.6352, "Pojazd", true, wz.win)
wz.btn=guiCreateButton(0.037, 0.65, 0.9185, 0.3, "Wymień zamki", true, wz.win)
guiLabelSetHorizontalAlign(wz.lbl,"center",true)
guiSetFont(wz.lbl,"default-small")

guiSetVisible(wz.win, false)
