--[[
lss-admin: wykonywanie ssów u graczy i zapisywanie ich na dysk

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub

]]--


--local ss_invoker=nil	-- admin ktory zazadal ss

addCommandHandler("sshot", function(plr,cmd,cel)
	if (not cel) then
		outputChatBox("Uzyj: /sshot <nick/id>",plr)
		return
	end
	local target=findPlayer(plr,cel)

	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end
--	ss_invoker=plr
	takePlayerScreenShot( target, 640, 480,getPlayerName(plr),70,30000 )
end,true,false)

addEventHandler( "onPlayerScreenShot", root,
	function ( theResource, status, pixels, timestamp, tag )
		local ss_invoker=getPlayerFromName(tag)
		if not ss_invoker then return end
--		if (not ss_invoker or getElementType(ss_invoker)~="player") then return end

		if (status~="ok") then
			outputChatBox("Nie udalo sie wykonac SS (gra zminimalizowana/gracz wylaczyl upload ss)", ss_invoker)
			return
		end

		local time = getRealTime()
		local tn=string.format("%d-%04d%02d%02d%02d%02d%02d-%02d.jpg", getElementData(source,"auth:uid") or 0, time.year+1900, time.month, time.monthday, time.hour, time.minute, time.second, math.random(1,99))
		local fh=fileCreate("ss/"..tn)
		fileWrite(fh, pixels)
		fileClose(fh)


		triggerClientEvent( ss_invoker, "onMyClientScreenShot", root, pixels )
	end
)
