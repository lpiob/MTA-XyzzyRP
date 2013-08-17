skiny={271,270,269,105,106,107,102,103,104,114,115,116,108,109,110,173,174,175,195,201,244,245,146,97}

local function replaceSkin(i)
    txd = engineLoadTXD ( i..".txd" )
    engineImportTXD ( txd, i)
    dff = engineLoadDFF ( i..".dff", i )
    engineReplaceModel ( dff, i )

end


for i,v in ipairs(skiny) do
	replaceSkin(v)
end
