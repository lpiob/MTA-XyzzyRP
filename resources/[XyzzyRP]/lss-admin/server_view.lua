--[[
lss-admin: raporty oraz podgląd logów

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub

]]--


local text_display=textCreateDisplay()
local gameView= textCreateTextItem ( "", 0.01, 0.3, "medium", 255,255,255,255,1,"left","top",255)
local reportView=textCreateTextItem( "", 0.99, 0.7, "low", 255,255,255,255,1,"right","top",255)
--textitem textCreateTextItem ( string text, float x, float y, [string priority, int red = 255, int green = 0, int blue = 0, int alpha = 255, float scale = 1, string alignX = "left", string alignY = "top", int shadowAlpha = 0] )

textDisplayAddText ( text_display, gameView )
textDisplayAddText ( text_display, reportView )

local gameView_contents={ "Zasób lss-admin został zrestartowany" }
local reportView_contents={}

local time = getRealTime()

local tn=string.format("%04d%02d%02d%02d%02d%02d-%02d.txt", time.year+1900, time.month, time.monthday, time.hour, time.minute, time.second, math.random(1,99))

local fh=fileCreate("logi/"..tn)
--fileClose(fh)

function outputLog(text)
  if (text and fh) then
	local time = getRealTime()
	local ts=string.format("%04d%02d%02d%02d%02d%02d> ", time.year+1900, time.month, time.monthday, time.hour, time.minute, time.second)
    fileWrite(fh, ts..text.."\n")
	fileFlush(fh)
  end
end

outputLog("Logowanie rozpoczęte")


for i,v in ipairs(getElementsByType("player")) do
	local accName = getAccountName ( getPlayerAccount ( v ) )
	if accName and (isObjectInACLGroup ("user."..accName, aclGetGroup ( "Support" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) )) then
	  textDisplayAddObserver ( text_display, v )
	end
end


function refresh_td()
  local tresc=table.concat(gameView_contents,"\n")
  textItemSetText ( gameView, tresc )
  local tt={}
  for i,v in ipairs(reportView_contents) do
	  if (v[1]) then
		  table.insert(tt,v[1])
	  end
  end
  tresc=table.concat(tt,"\n")
  textItemSetText ( reportView, tresc )
end


function gameView_add(text)
  outputLog(text)
  table.insert(gameView_contents,text)
  if (#gameView_contents>10) then
	table.remove(gameView_contents,1)
  end
  refresh_td()
end

function reportView_remove(id)
  for i=#reportView_contents,1,-1 do --in ipairs(reportView_contents) do
	if (reportView_contents[i][2] and reportView_contents[i][2]==id) then
	  table.remove(reportView_contents,i)
	end
  end
end

function reportView_add(text,id)
    if (string.len(text)>0) then
      outputLog("RAPORT " .. text)
    end
  table.insert(reportView_contents,{text,id})
  if (#reportView_contents>10) then
	table.remove(reportView_contents,1)
  end
  refresh_td()
end

--setTimer(function()
--    reportView_add("")
--end, 5*60000,0)


addEventHandler("onPlayerQuit", root, function()
  local id=getElementData(source,"id")
  if (id and tonumber(id)) then
	reportView_remove(tonumber(id))
  end
end)

addEventHandler("onPlayerLogin", root,  function()
	local accName = getAccountName ( getPlayerAccount ( source ) )
	if accName and isObjectInACLGroup ("user."..accName, aclGetGroup ( "Support" ) ) then
	  textDisplayAddObserver ( text_display, source )
	  gameView_add("### " .. accName .. " zalogował/a się.")
	  setElementData(source,"admin:rank",1)
	elseif accName and isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
	  textDisplayAddObserver ( text_display, source )
	end

end)

addEventHandler("onPlayerLogout", root,  function(acc)
  accName=getAccountName( acc )
  if (textDisplayIsObserver(text_display, source)) then
	  textDisplayRemoveObserver ( text_display, source )
--	  gameView_add("### " .. accName .. " wylogował/a się.")
	  removeElementData(source,"admin:rank")
  end
end)

addCommandHandler("ucho", function(plr,cmd)
  if (textDisplayIsObserver(text_display, plr)) then
	  textDisplayRemoveObserver ( text_display, plr )
  else
	  textDisplayAddObserver ( text_display, plr )
  end
end,true,false)


refresh_td()