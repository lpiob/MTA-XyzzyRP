addEventHandler("onClientResourceStart",getResourceRootElement(),
	function(resource)
		local partlist = xmlLoadFile("partlist.xml")
		local partnodes = xmlNodeGetChildren(partlist)
		for partnum,partnode in ipairs(partnodes) do
			local model_id = tonumber(xmlNodeGetAttribute(partnode,"id"))
			local part_name = xmlNodeGetAttribute(partnode,"name")
			local part_dff = engineLoadDFF("particles/"..part_name..".dff",0)
			engineReplaceModel(part_dff,model_id)
		end
		xmlUnloadFile(partlist)
	end
)