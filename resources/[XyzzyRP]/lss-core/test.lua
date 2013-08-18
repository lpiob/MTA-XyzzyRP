--[[
addEvent("onPlayerTakePhoto", true)
addEventHandler("onPlayerTakePhoto", root, function(photo)
    outputChatBox("optp " .. getPlayerName(source) .. string.len(photo))
	local fileHandle = fileCreate("grafika.raw")             -- attempt to create a new file
	if fileHandle then                                    -- check if the creation succeeded
	    fileWrite(fileHandle, photo)     -- write a text line
	    fileClose(fileHandle)                             -- close the file once you're done with it
	end
end)
]]--