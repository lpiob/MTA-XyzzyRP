--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local laweczki={
  -- x,y,z,a,d,i
--  { 2437.16,-1681.85,1409.68,270,24,1 },
--  { 2436.23,-1676.67,1409.68,0, 24,1 },
-- silownia w dzielnicy grove street
    {2435.80615234,-1688.25109863,1409.77599335,0,24,1},
    {2433.36816406,-1688.19256592,1409.77599335,0,24,1},

-- silownia w dzielnicy ganton
    {2246.89,-1712.61,2000.78,270,15,2},
	
-- silownia w dzielnicy richman
    {780.52,-1039.38,2000.78,180,21,2},
    {783.06,-1039.38,2000.78,180,21,2},
	
-- silownia w montgomery
    {1311.51,396.19,2200.78,0,22,2},
    {1315.74,396.19,2200.78,0,22,2},
	
-- silownia na plazy
--    {660.21,-1869.74,5.55,90,0,0}

-- silownia w wiezieniu
	{ 2707.79,-2728.22,7.19,0,35,0},

}

for i,v in ipairs(laweczki) do
--  v.laweczka=createObject(2629, v[1], v[2], v[3]-1,0,0,v[4])
  v.laweczka=createObject(2629, v[1], v[2], v[3]-1,0,0,v[4])
  setElementDimension(v.laweczka, v[5])
  setElementInterior(v.laweczka, v[6])


  v.sztanga=createObject(2913, 0, 0, 0, 0,0,0)
  setElementDimension(v.sztanga, v[5])
  setElementInterior(v.sztanga, v[6])
  attachElements(v.sztanga, v.laweczka, -0.45,0.55,1, 0, 90,0)

  setElementData(v.laweczka,"customAction",{label="Skorzystaj",resource="lss-silownia",funkcja="menu_laweczka",args=v})
end

addEvent("onPlayerHangSztanga", true)
addEventHandler("onPlayerHangSztanga", resourceRoot, function(lawka,plr)
  exports.bone_attach:detachElementFromBone(source)
  detachElements(source)
  attachElements(source, lawka, -0.45,0.55,1, 0, 90,0)
end)

addEvent("onPlayerPickSztanga", true)
addEventHandler("onPlayerPickSztanga", resourceRoot, function(plr)
  detachElements(source)
--  attachElements(source, plr)
  exports.bone_attach:attachElementToBone(source,plr,11,-0.1,0,0.15,0,80,0)--bone,x,y,z,rx,ry,rz)
--  exports.bone_attach:attachElementToBone(source,plr,11,0,0,0.15,0,90)--bone,x,y,z,rx,ry,rz)
end)