skiny={137,145,167,203,204,205,256,257,26,264,38,39,45,81,83,84,87,80,18}

local function replaceSkin(i)
    txd = engineLoadTXD ( i..".txd" )
    engineImportTXD ( txd, i)
    dff = engineLoadDFF ( i..".dff", i )
    engineReplaceModel ( dff, i )

end


for i,v in ipairs(skiny) do
	replaceSkin(v)
end
