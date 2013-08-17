--[[
lss-admin: różne funkcje

@author Lukasz Biegaj <wielebny@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@lss-rp.pl>
@license GPLv2
]]--


function getAdminName(player)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if accName and isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" )) and not isObjectInACLGroup ("user."..accName, aclGetGroup ( "Administrator" ))  then
		return "Zdalny"
	else
		return (getElementData(player,"auth:login") or getPlayerName(player))
	end
end

function isSupport(player)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if accName and isObjectInACLGroup ("user."..accName, aclGetGroup ( "Support" ) ) then
	  return true
	end
	return false
end


function msgToSupport(text)
  for i,v in ipairs(getElementsByType("player")) do
	if (getElementData(v,"auth:support")) then
		outputChatBox(text, v)
	end
  end
end


addEventHandler("onPlayerLogin", root,
    function()
	outputDebugString(getPlayerName(source).." has logged in!")
	local accName = getAccountName ( getPlayerAccount ( source ) )
	if accName and isObjectInACLGroup ("user."..accName, aclGetGroup ( "Support" ) ) then
	    setElementData(source,"auth:support", true)
	end
	
    end
)

function loggedOut()
    outputDebugString( getPlayerName(source) .. " wylogował się")
    removeElementData(source,"auth:support")
end
addEventHandler("onPlayerLogout",getRootElement(),loggedOut)


addEventHandler("onTrailerAttach", root, function(poj)
	local dbid1=getElementData(poj,"dbid")
	local dbid2=getElementData(source,"dbid")
	if not dbid2 or not dbid1 then return end
	local kierowca=getVehicleController(poj)
	local kierowca_id=0
	if kierowca then
		local c=getElementData(kierowca,"character")
		if c and c.id then kierowca_id=tonumber(c.id) end
	end
	
	gameView_add(string.format("HOL pojazd %d holowany przez %d (kierowca %d)", dbid2, dbid1, kierowca_id))
end)
