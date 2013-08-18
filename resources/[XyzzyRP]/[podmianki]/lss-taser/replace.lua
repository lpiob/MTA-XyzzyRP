local resourceRoot = getResourceRootElement(getThisResource())
     
addEventHandler("onClientResourceStart",resourceRoot,
function ()
    txd = engineLoadTXD ( "silenced.txd" )
    engineImportTXD ( txd, 347 )
    dff = engineLoadDFF ( "silenced.dff", 0 )
    engineReplaceModel ( dff, 347 )
end)