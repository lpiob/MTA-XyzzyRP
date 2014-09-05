--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--



function cmd_admins(plr)
  local supporterzy={}
  local admini={}
  for i,v in ipairs(getElementsByType("player")) do
	if (isAdmin(v)) then
	  local t
	  local login=getElementData(v,"auth:login")
	  if (login) then
		t=login.."("..getElementData(v,"id")..")"
--[[
		if (getElementData(v,"pmoff")) then
			t=login.."(-)"
		else
			t=login.."("..getElementData(v,"id")..")"
		end
]]--
		table.insert(admini,t)
	  end

	elseif (isSupport(v)) then
	  local t
	  local login=getElementData(v,"auth:login")
	  if (login) then
		t=login.."("..getElementData(v,"id")..")"
--[[
		if (getElementData(v,"pmoff")) then
			t=login.."(-)"
		else
			t=login.."("..getElementData(v,"id")..")"
		end
]]--

		table.insert(supporterzy,t)
	  end
	end
  end
  outputChatBox("RCONi:", plr, 100,0,0)
  if (#admini>0) then
    outputChatBox("  " .. table.concat(admini,", "), plr)
  else
	outputChatBox("  brak", plr)
  end

  outputChatBox("Moderatorzy:", plr, 100,100,255)
  if (#supporterzy>0) then
    outputChatBox("  " .. table.concat(supporterzy,", "), plr)
  else
	outputChatBox("  brak", plr)
  end
end
addCommandHandler("admins", cmd_admins, false, false)

local function outputChatBoxSplitted(text, target, c1,c2,c3, ca)
  if (string.len(text)<128) then
    outputChatBox(text, target, c1,c2,c3,ca)
	return
  end
  local t=""
  for i,v in string.gmatch(text,"(.)") do
	  if (string.len(t)>0 and string.len(t)+string.len(i)>=128) then
			outputChatBox(t, target, c1,c2,c3,ca)
			t=" "
	  end
	  t=t..i
  end
  if (string.len(t)>0 and t~=" ") then
		outputChatBox(t, target, c1,c2,c3,ca)
  end
  
end

addCommandHandler("losowanie",function(player,cmd,yes,no)
	if (not yes) or (not no) then outputChatBox("(( /losowanie [JEZELI TAK] [JEZELI NIE] ))",player) return end
	local rand = math.random(1,2)
	if rand==1 then --yes
		message = yes
	else--no
		message = no
	end
		local character = getElementData(player,"character")
		if (not character) then
			outputChatBox("Najpierw dołącz do gry", player, 255, 0, 0,true)
			return
		end
		local x,y,z   = getElementPosition(player)
		exports["lss-admin"]:gameView_add("IC " .. character.imie .. " " .. character.nazwisko .. "/"..getPlayerID(player)..": /do - /losowanie " .. message)
        local strefa  = createColSphere(x,y,z,30)
        local gracze  = getElementsWithinColShape(strefa, "player")
		
		for i,v in ipairs(gracze) do
			if (getElementInterior(v)==getElementInterior(player) and getElementDimension(v)==getElementDimension(player)) then
				outputChatBoxSplitted( " * " .. message .. " #A0A0A0((" .. character.imie .. " " .. character.nazwisko .. " - /losowanie))", v, 0x41, 0x69, 0xE1, true)
				triggerClientEvent(v, "onCaptionedEvent", root, message, 10)
				for i2,v2 in ipairs(getElementsByType("player")) do
					if (getCameraTarget(v2)==v and v~=v2) then
						triggerClientEvent(v2, "onCaptionedEvent", root, message, 10)
						outputChatBoxSplitted( " * " .. message .. " #A0A0A0((" .. character.imie .. " " .. character.nazwisko .. " - /losowanie))", v2, 0x41,  0x69, 0xE1, true) -- aqq
					end
				end
			end
        end
        destroyElement(strefa)
	
end)
