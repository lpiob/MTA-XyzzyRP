--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--



--  triggerServerEvent("saveGraphicOptions", resourceRoot, localPlayer, uo_sb)                                                                                
addEvent("saveGraphicOptions", true)
addEventHandler("saveGraphicOptions", resourceRoot, function(plr, uo_sb, uo_sw, uo_cp, uo_det, uo_bw,uo_hdr,uo_nig)
  local uid=getElementData(plr, "auth:uid")
  if (not uid) then return end

  uo_sb=uo_sb and 1 or 0
  uo_sw=uo_sw and 1 or 0
  uo_cp=uo_cp and 1 or 0
  uo_det=uo_det and 1 or 0
  uo_bw=uo_bw and 1 or 0
  uo_hdr=uo_hdr and 1 or 0
  uo_nig=uo_nig and 1 or 0
  local query=string.format("UPDATE lss_users SET uo_sb=%d,uo_sw=%d,uo_cp=%d,uo_det=%d,uo_bw=%d,uo_hdr=%d,uo_nig=%d WHERE id=%d", uo_sb, uo_sw, uo_cp, uo_det, uo_bw, uo_hdr, uo_nig, uid)
  exports.DB:zapytanie(query)
--  outputChatBox("(( Ustawienia zostały zapisane. ))" ,plr)
end)