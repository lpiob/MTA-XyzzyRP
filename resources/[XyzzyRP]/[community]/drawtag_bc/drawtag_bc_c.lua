addCommandHandler("xxdraw",function()
	local show = not exports.drawtag:isDrawingWindowVisible()
	exports.drawtag:showDrawingWindow(show)
end)

