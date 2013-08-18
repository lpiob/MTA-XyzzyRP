--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local I=1
local D=5
local stol=createObject(3383,1550.05187,-1661.9093, 1463.874,0,0,270)
setElementInterior(stol,I)
setElementDimension(stol,D)

setElementData(stol,"customAction",{label="Zdejmij odciski",resource="lss-policja",funkcja="menu_odciski",args={obiekt=stol}})