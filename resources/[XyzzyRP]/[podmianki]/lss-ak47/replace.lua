local resourceRoot = getResourceRootElement(getThisResource())
     
addEventHandler("onClientResourceStart",resourceRoot,
function ()
    txd = engineLoadTXD ( "ak47.txd" )
    engineImportTXD ( txd, 355 )
    dff = engineLoadDFF ( "ak47.dff", 0 )
    engineReplaceModel ( dff, 355 )
end)