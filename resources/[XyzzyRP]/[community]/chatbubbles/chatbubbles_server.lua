local showtime = tonumber(get("chatbubbles.DefaultTime"))
local characteraddition = tonumber(get("chatbubbles.PerCharacterAddition"))
local maxbubbles = get("chatbubbles.MaxBubbles")
if maxbubbles == "false" then maxbubbles = false else maxbubbles = tonumber(maxbubbles) end
local hideown = get("chatbubbles.HideOwn")
if hideown == "true" then hideown = true else hideown = false end

function sendMessageToClient(message,messagetype)
	if messagetype == 0 or messagetype == 2 then
		triggerClientEvent("onMessageIncome",source,message,messagetype)
	end
end

function returnSettings()
	local settings =
	{
	showtime,
	characteraddition,
	maxbubbles,
	hideown
	}
	triggerClientEvent(source,"onBubbleSettingsReturn",getRootElement(),settings)
end

--addEventHandler("onPlayerChat",getRootElement(),sendMessageToClient)
addEvent("onAskForBubbleSettings",true)
addEventHandler("onAskForBubbleSettings",getRootElement(),returnSettings)