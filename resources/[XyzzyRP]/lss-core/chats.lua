--[[
@author Lukasz Biegaj <wielebny@lss-rp.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
]]--



local function getCharacterName(plr)
	local character=getElementData(plr,"character")
	if not character then return "Nieznana osoba" end
	local zamaskowany=getElementData(plr,"zamaskowany")
	if zamaskowany then
		return "Zamaskowana osoba"
	end
	return character.imie.." "..character.nazwisko
end


local ooc_enabled=false


function toggleOOC()
	ooc_enabled=not ooc_enabled
	return ooc_enabled
end




function drunkFilter(msg, level)
	-- nie wjechalem tylem w zatoczke
--	outputDebugString("df")
	local slowa={}
	for v in msg:gmatch("%S+") do table.insert(slowa,v) end
	for i=1,level do
		local i1=math.random(1,#slowa)
		local i2=math.random(1,#slowa)
		if (i1~=i2) then
			slowa[i1],slowa[i2]= slowa[i2], slowa[i1]
		end
	end
	return table.concat(slowa," ")
end

local function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

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

local function chat_me(plr, msg)
		local character=getElementData(plr,"character")
		local characterName=getCharacterName(plr)
		exports["lss-admin"]:gameView_add("IC " .. character.imie .. " " .. character.nazwisko .. "/"..getPlayerID(plr)..": /me " .. msg)
        local x,y,z=getElementPosition(plr)
        local strefa=createColSphere(x,y,z,30)
        local gracze=getElementsWithinColShape(strefa, "player")
        for i,v in ipairs(gracze) do
		if (getElementInterior(v)==getElementInterior(plr) and getElementDimension(v)==getElementDimension(plr)) then
			if not getElementData(v,"hud:removeclouds") then
        	    triggerClientEvent(v, "onCaptionedEvent",root,characterName .. " " .. msg,4)
				outputChatBoxSplitted( " * " .. characterName .. " " .. msg, v, 0x41, 0x69, 0xE1,true)
			end
		    for i2,v2 in ipairs(getElementsByType("player")) do
			if (getCameraTarget(v2)==v and v~=v2) then
				if not getElementData(v2,"hud:removeclouds") then
					triggerClientEvent(v2, "onCaptionedEvent",root,characterName .. " " .. msg,4)
					outputChatBoxSplitted( " * " .. characterName .. " " .. msg, v2, 0x41, 0x69, 0xE1,true)
				end
			end
		    end

		end
        end
        destroyElement(strefa)     
end

local chat_replacements={
	[":D"] = { "uśmiecha się", "uśmiecha się szeroko"},
	[":%-D"] = { "uśmiecha się", "uśmiecha się szeroko"},
	[":>"] = { "uśmiecha się złowieszczo", "wykrzywia usta w dzikim uśmiechu"},
	[":/"] = { "krzywi się." },
	[":%("] = { "smuci się.", "wygląda na zasmuconego."},
	[":%)"] = { "uśmiecha się.", "robi pogodną minę." },
	[":%-%("] = { "smuci się.", "wygląda na zasmuconego."},
	[":%-%)"] = { "uśmiecha się.", "robi pogodną minę." },
	[":o"] = { "otwiera usta ze zdziwienia.", "robi zdziwioną minę.", "wygląda na zdziwionego." },
}

local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function filterEmoticons(plr,text)
	local done=false	
	for i,v in pairs(chat_replacements) do
		text,repl=string.gsub(text,i,"")
		if repl and repl>0 and not done then
			setTimer(chat_me, 500, 1, plr,v[math.random(1,#v)])
			done=true
		end
	end


	return text
end


addEvent("pedHasNotBlockingTalkAnimationS", true)
addEventHandler("pedHasNotBlockingTalkAnimationS", getRootElement(), function(plr)
	setPedAnimation(plr, "GANGS", "prtial_gngtlkH", 1, false, true, false)
	setTimer(setPedAnimation, 6000, 1, plr, "ped", "phone_in")
	setTimer(setPedAnimation, 6050, 1, plr)
end)


function chat_ic(msg,msgtype)
    if (not source or not isElement(source)) then return end
    local character=getElementData(source,"character")
    if (not character) then
	outputChatBox("Najpierw dołącz do gry", source, 255,0,0,true)
	cancelEvent()
	return
    end
    if (isPedDead(source)) then
	outputChatBox("Jesteś martwy/a, nie możesz rozmawiać.", source ,255,0,0,true)
	cancelEvent()
	return
    end
    cancelEvent()
	local characterName=getCharacterName(source)
	if talkTimer and isTimer(talkTimer) then killTimer(talkTimer) end
--	outputDebugString("C " .. msgtype .. " " .. character.imie .. " " .. character.nazwisko .. ": " .. msg)
    if (msgtype==0) then	-- tekst wpisany po wcisnieciu t
		msg=trim(filterEmoticons(source,firstToUpper(stripColors(msg))))
		if string.len(msg)<1 then
			return
		end
		local drunkLevel=getElementData(source,"drunkLevel")
--		outputDebugString(character.imie .. drunkLevel)
		if (drunkLevel and tonumber(drunkLevel)>1 and (not getElementData(source,"colorLevel")) ) then
			msg=drunkFilter(msg, drunkLevel)
		end
		exports["lss-admin"]:gameView_add("IC " .. character.imie .. " " .. character.nazwisko .. "/"..getPlayerID(source)..": " .. msg)
        local x,y,z=getElementPosition(source)
        local strefa=createColSphere(x,y,z,50)
        local gracze=getElementsWithinColShape(strefa, "player")
		local telefontalk = (getElementData(source, "zadzwonilDo") or getElementData(source, "odebralOd")) or false
		if telefontalk then outputChatBoxSplitted("#FFF705Głos z telefonu (mężczyzna):#FFFFFF " .. msg, telefontalk, 255, 255, 255, true) end
		
		if (not telefontalk) then 
			triggerClientEvent("hasPedBlockingTalkAnimationC", getRootElement(), source)
		end
		
		
        for i,v in ipairs(gracze) do
		if (getElementInterior(v)==getElementInterior(source) and getElementDimension(v)==getElementDimension(source)) then
        	    triggerClientEvent(v, "onMessageIncome",source,msg,4)
		    local x2,y2=getElementPosition(v)
		    if (getDistanceBetweenPoints2D(x,y,x2,y2)<=10) then
				
				if telefontalk then
					outputChatBoxSplitted( characterName .. " mówi (do telefonu): " .. msg, v, 255, 255, 255, true)
				else
					outputChatBoxSplitted( characterName .. " mówi: " .. msg, v, 255, 255, 255, true)
				end
				
				for i2,v2 in ipairs(getElementsByType("player")) do
					if (getCameraTarget(v2)==v and v~=v2) then
						if telefontalk then
							outputChatBoxSplitted( characterName .. " mówi (do telefonu): " .. msg, v2, 255, 255, 255, true)
						else
							outputChatBoxSplitted( characterName .. " mówi: " .. msg, v2, 255, 255, 255, true)
						end
					end
				end
			
		    end
		end
        end
        destroyElement(strefa)    
    elseif (msgtype==1) then	-- /me
		msg=trim(filterEmoticons(source,stripColors(msg)))
		if string.len(msg)<1 then
			return
		end
		chat_me(source, msg)

	elseif (msgtype==2) then	-- teamsay
	  -- xhejn, nie dziala jak gracz nie jest w teamie. pojebane
--[[
	  if (not eq_getItem(source,41)) then	-- krotkofalowka
		outputChatBox("Nie masz przy sobie krótkofalówki.", source)
		return
	  end
	  local fid=getElementData(source, "faction:id")
	  if (not fid) then 
		outputChatBox("Krótkofalówka nie działa.", source)
		return 
	  end
	  fid=tonumber(fid)
	  
	  if (fid==2 or fid==6 or fid==11) then	-- policja, medycy, straz pozarna
		triggerClientEvent(root, "onFactionChat", resourceRoot, source, fid, msg)
	  end
]]--
	end
	

end
addEventHandler("onPlayerChat", root, chat_ic)
addEvent("onPlayerExtendedChat", true)
addEventHandler("onPlayerExtendedChat",root, chat_ic)



function cmd_chatY(plr, cmd, ...)
	local msg=table.concat( arg, " " )
	  if (not eq_getItem(plr,41)) then	-- krotkofalowka
		outputChatBox("Nie masz przy sobie krótkofalówki.", plr)
		return
	  end
	  local fid=getElementData(plr, "faction:id")
	  if (not fid) then 
		outputChatBox("Krótkofalówka nie działa.", plr)
		return 
	  end
	  fid=tonumber(fid)
	  
--	  if (fid==2 or fid==6 or fid==11) then	-- policja, medycy, straz pozarna
--		outputDebugString("OFC " .. getPlayerName(plr) .. " fid: " .. fid .. " msg: " .. msg)
		
		exports["lss-admin"]:gameView_add("KF"..fid .. " " .. getPlayerName(plr) .. "/"..getPlayerID(plr).. ": " .. msg)
		triggerClientEvent(root, "onFactionChat", resourceRoot, plr, fid, msg)
--	  end

	  local character=getElementData(plr, "character")
      local x,y,z=getElementPosition(plr)
      local strefa=createColSphere(x,y,z,50)
      local gracze=getElementsWithinColShape(strefa, "player")
	  setPedAnimation ( plr, "ped", "phone_talk", 2100, false, false )
	  setTimer(setPedAnimation, 2100, 1, plr, false)
      for i,v in ipairs(gracze) do
	  if (getElementInterior(v)==getElementInterior(plr) and getElementDimension(v)==getElementDimension(plr) and v~=plr) then
      	    triggerClientEvent(v, "onMessageIncome",plr,msg,4)
			playSoundFrontEnd(v,49)
		    local x2,y2=getElementPosition(v)
		    if (getDistanceBetweenPoints2D(x,y,x2,y2)<=10) then
			outputChatBox( character.imie .. " " .. character.nazwisko .. " mówi do krótkofalówki: " .. msg, v, 255, 255, 255, true)
			for i2,v2 in ipairs(getElementsByType("player")) do
			    if (getCameraTarget(v2)==v and v~=v2) then
			        outputChatBox( character.imie .. " " .. character.nazwisko .. " mówi do krótkofalówki: " .. msg, v2, 255, 255, 255, true)
			    end
			end
	  		end
	  end
      end
      destroyElement(strefa)    


end

addCommandHandler("Krotkofalowka", cmd_chatY, false, false)


function cmd_chatU(plr, cmd, ...)
	local msg=table.concat( arg, " " )
	  if (not eq_getItem(plr,41)) then	-- krotkofalowka
		outputChatBox("Nie masz przy sobie krótkofalówki.", plr)
		return
	  end
	  local fid=getElementData(plr, "faction:id")
	  if (not fid) then 
		outputChatBox("Krótkofalówka nie działa.", plr)
		return 
	  end
	  fid=tonumber(fid)
	  if (fid~=2 and fid~=6 and fid~=11 and fid~=22) then
		outputChatBox("Twoja krotkofalowka milczy.", plr)
		return
	  end
	  
--	  if (fid==2 or fid==6 or fid==11) then	-- policja, medycy, straz pozarna
--		outputDebugString("OFC " .. getPlayerName(plr) .. " fid: " .. fid .. " msg: " .. msg)
		exports["lss-admin"]:gameView_add("KF(U) " .. getPlayerName(plr) .. "/"..getPlayerID(plr)..": " .. msg)
		triggerClientEvent(root, "onPublicFactionChat", resourceRoot, plr, msg)
--	  end

	  local character=getElementData(plr, "character")
      local x,y,z=getElementPosition(plr)
      local strefa=createColSphere(x,y,z,50)
      local gracze=getElementsWithinColShape(strefa, "player")
	  
      for i,v in ipairs(gracze) do
	  if (getElementInterior(v)==getElementInterior(plr) and getElementDimension(v)==getElementDimension(plr) and v~=plr) then
      	    triggerClientEvent(v, "onMessageIncome",plr,msg,4)
			playSoundFrontEnd(v,49)
		    local x2,y2=getElementPosition(v)
		    if (getDistanceBetweenPoints2D(x,y,x2,y2)<=10) then
			outputChatBox( character.imie .. " " .. character.nazwisko .. " mówi do krótkofalówki: " .. msg, v, 255, 255, 255, true)
			for i2,v2 in ipairs(getElementsByType("player")) do
			    if (getCameraTarget(v2)==v and v~=v2) then
			        outputChatBox( character.imie .. " " .. character.nazwisko .. " mówi do krótkofalówki: " .. msg, v2, 255, 255, 255, true)
			    end
			end
	  		end
	  end
      end
      destroyElement(strefa)    


end

addCommandHandler("Radio", cmd_chatU, false, false)

function cmd_chatB(plr,cmd,...)
    local username=getElementData(plr,"auth:login")
    if (not username) then
	outputChatBox("Musisz byc zalogowany aby skorzystac z czatu OOC",plr,255,0,0,true)
	return
    end
	local character=getElementData(plr,"character")
	if (not character) then return end

    local blokada_ooc=getElementData(plr,"kary:blokada_ooc")
    if (blokada_ooc) then
	outputChatBox("Nie możesz skorzystać z czatu OOC, posiadasz blokadę do: " .. tostring(blokada_ooc), plr, 255,0,0,true)
	return
    end


    local message=table.concat( arg, " " )
	
	if message == "off" then
		if getElementData(plr,"chatb:state") == false then
			setElementData(plr,"chatb:state", true)
			outputChatBox("Czat OOC bliskiego zasięgu został aktywowany ponownie", plr, 0, 255, 0)
		else
			setElementData(plr,"chatb:state", false)
			outputChatBox("Czat OOC bliskiego zasięgu został dezaktywowany", plr, 0, 255, 0)
		end
		return 
	end
	
	if getElementData(plr,"chatb:state") == false then
		outputChatBox("Aktualnie posiadasz wyłączony czat OOC bliskiego zasięgu, aby go włączyć wpisz komendę /b off", plr, 255, 0, 0)
		return
	end

	if ninjaban(message) then
		outputChatBox( "B> #909090" .. getPlayerID(plr) .. " " .. character.imie .. " " .. character.nazwisko .. ": #FFFFFF" .. stripColors(message), plr, 200,255,0, true)
		exports["lss-admin"]:gameView_add("B NINJABAN! " .. character.imie .. " " .. character.nazwisko .. "/"..getPlayerID(plr)..": " .. message)
		return
	end


	local x,y,z=getElementPosition(plr)
	local strefa=createColSphere(x,y,z,15)
	local gracze=getElementsWithinColShape(strefa, "player")
	for i,v in ipairs(gracze) do
		if getElementDimension(v)==getElementDimension(plr) and getElementData(v,"chatb:state") then
		outputChatBox( "B> #909090" .. getPlayerID(plr) .. " " .. character.imie .. " " .. character.nazwisko .. ": #FFFFFF" .. stripColors(message), v, 200,255,0, true)
		for i2,v2 in ipairs(getElementsByType("player")) do
		    if (getCameraTarget(v2)==v and v~=v2) then
				if getElementData(v2,"chatb:state") then
					outputChatBox( "B> #909090" .. getPlayerID(plr) .. " " .. character.imie .. " " .. character.nazwisko .. ": #FFFFFF" .. stripColors(message), v2, 255, 255, 255, true)
				end
		    end
		end
		end

	end
--	outputDebugString("B " .. getPlayerName(plr) .. ": " .. message)
	exports["lss-admin"]:gameView_add("B " .. character.imie .. " " .. character.nazwisko .. "/"..getPlayerID(plr)..": " .. message)
	destroyElement(strefa)

end

function cmd_chatOOC(plr,cmd,...)
    local username=getElementData(plr,"auth:login")
    if (not username) then
	outputChatBox("Musisz byc zalogowany aby skorzystac z czatu OOC",plr,255,0,0,true)
	return
    end

	if (not ooc_enabled and not isAdmin(plr) and not isInvisibleAdmin(plr)) then
		outputChatBox("Czat OOC został wyłączony przez administratora.", plr, 255,0,0,true)
		return
	end

	local blokada_ooc=getElementData(plr,"kary:blokada_ooc")

	if (blokada_ooc) then
		outputChatBox("Nie możesz skorzystać z czatu OOC, posiadasz blokadę do: " .. tostring(blokada_ooc), plr, 255,0,0,true)
		return
	end

    local message=table.concat( arg, " " )
	if isInvisibleAdmin(plr) then
		outputChatBox( "OOC> #909090Administrator zdalny: #FFFFFF" .. stripColors(message), getRootElement(), 255,255,0, true)
	else
		outputChatBox( "OOC> #909090" .. getPlayerID(plr) .. " " .. username .. ": #FFFFFF" .. stripColors(message), getRootElement(), 255,255,0, true)
	end
end
addCommandHandler("ooc",cmd_chatOOC,false,false)
addCommandHandler("b",cmd_chatB,false,false)

addCommandHandler("do", 
	function(player, command, ...)
		if #arg == 0 then
			outputChatBox("Wpisz: /do <akcja>", player)
			return
		end
	
	    local character = getElementData(player,"character")
		if (not character) then
			outputChatBox("Najpierw dołącz do gry", player, 255, 0, 0,true)
			return
		end
	
		local message = table.concat(arg, " ")
		local x,y,z   = getElementPosition(player)
		exports["lss-admin"]:gameView_add("IC " .. character.imie .. " " .. character.nazwisko .. "/"..getPlayerID(player)..": /do " .. message)
        local strefa  = createColSphere(x,y,z,30)
        local gracze  = getElementsWithinColShape(strefa, "player")
		
		for i,v in ipairs(gracze) do
			if (getElementInterior(v)==getElementInterior(player) and getElementDimension(v)==getElementDimension(player)) then
				outputChatBoxSplitted( " * " .. message .. " #A0A0A0((" .. character.imie .. " " .. character.nazwisko .. "))", v, 0x41, 0x69, 0xE1, true)
				if not getElementData(v,"hud:removeclouds") then
					triggerClientEvent(v, "onCaptionedEvent", root, message, 10)
				end
				for i2,v2 in ipairs(getElementsByType("player")) do
					if (getCameraTarget(v2)==v and v~=v2) then
						if not getElementData(v2,"hud:removeclouds") then
							triggerClientEvent(v2, "onCaptionedEvent", root, message, 10)
							outputChatBoxSplitted( " * " .. message .. " #A0A0A0((" .. character.imie .. " " .. character.nazwisko .. "))", v2, 0x41,  0x69, 0xE1, true) -- aqq
						end
					end
				end
			end
        end
        destroyElement(strefa)
	end
)


addCommandHandler("k", 
	function(player, command, ...)
		if #arg == 0 then
			outputChatBox("Wpisz: /k <tekst>", player)
			return
		end

            if (isPedDead(player)) then
		outputChatBox("Jesteś martwy/a, nie możesz rozmawiać.", player ,255,0,0,true)

		return
	    end

	
	    local character = getElementData(player,"character")
		if (not character) then
			outputChatBox("Najpierw dołącz do gry", player, 255, 0, 0,true)
			return
		end
		local characterName=getCharacterName(player)
	
		local message = table.concat(arg, " ")
		local x,y,z   = getElementPosition(player)
        local strefa  = createColSphere(x,y,z,100)
        local gracze  = getElementsWithinColShape(strefa, "player")
		exports["lss-admin"]:gameView_add("IC " .. character.imie .. " " .. character.nazwisko .. "/"..getPlayerID(plr)..": /k " .. message)
		setPedAnimation ( player, "ON_LOOKERS", "shout_in", 2100, false, false )
		for i,v in ipairs(gracze) do
			if (getElementInterior(v)==getElementInterior(player) and getElementDimension(v)==getElementDimension(player)) then
				 outputChatBox( characterName .. " krzyczy: " .. message .. "!!!", v, 255, 255, 255, true)
				 setTimer(setPedAnimation, 2100, 1, player, false)
			end
        end
        destroyElement(strefa)
	end
,false,false)

addCommandHandler("m", 
	function(player, command, ...)
		if #arg == 0 then
			outputChatBox("Wpisz: /m <tekst>", player)
			return
		end
		if (isPedDead(player)) then
			outputChatBox("Jesteś martwy/a, nie możesz rozmawiać.", player ,255,0,0,true)
			return
	    end
		if not exports["lss-core"]:eq_getItem(player, 108) then
			outputChatBox("(( Nie posiadasz megafonu ))", player)
			return
		end

	
	    local character = getElementData(player,"character")
		if (not character) then
			outputChatBox("Najpierw dołącz do gry", player, 255, 0, 0,true)
			return
		end
		local characterName=getCharacterName(player)
	
		local message = table.concat(arg, " ")
		local x,y,z   = getElementPosition(player)
        local strefa  = createColSphere(x,y,z,150)
        local gracze  = getElementsWithinColShape(strefa, "player")
		exports["lss-admin"]:gameView_add("IC " .. character.imie .. " " .. character.nazwisko .. "/"..getPlayerID(plr)..": /m " .. message)
		for i,v in ipairs(gracze) do
			if (getElementInterior(v)==getElementInterior(player) and getElementDimension(v)==getElementDimension(player)) then
				 outputChatBox( characterName .. " mówi przez megafon: " .. message .. "!!!", v, 255, 255, 155, true)
			end
        end
        destroyElement(strefa)
	end
,false,false)


addCommandHandler("c", 
	function(player, command, ...)
		if #arg == 0 then
			outputChatBox("Wpisz: /c <tekst>", player)
			return
		end

            if (isPedDead(player)) then
		outputChatBox("Jesteś martwy/a, nie możesz rozmawiać.", player ,255,0,0,true)

		return
	    end

	
	    local character = getElementData(player,"character")
		if (not character) then
			outputChatBox("Najpierw dołącz do gry", player, 255, 0, 0,true)
			return
		end
		local characterName=getCharacterName(player)
	
		local message = table.concat(arg, " ")
		local x,y,z   = getElementPosition(player)
        local strefa  = createColSphere(x,y,z,2.5)
        local gracze  = getElementsWithinColShape(strefa, "player")
		exports["lss-admin"]:gameView_add("IC " .. character.imie .. " " .. character.nazwisko .. "/"..getPlayerID(player)..": /c " .. message)
		for i,v in ipairs(gracze) do
			if (getElementInterior(v)==getElementInterior(player) and getElementDimension(v)==getElementDimension(player)) then
				 outputChatBox( characterName .. " szepcze: " .. message, v, 255, 255, 255, true)
			end
        end
        destroyElement(strefa)
	end
,false,false)