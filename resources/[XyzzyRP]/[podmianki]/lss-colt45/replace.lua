local resourceRoot = getResourceRootElement(getThisResource())
     
addEventHandler("onClientResourceStart",resourceRoot,
function ()
    txd = engineLoadTXD ( "colt45.txd" )
    engineImportTXD ( txd, 350 )
    dff = engineLoadDFF ( "colt45.dff", 0 )
    engineReplaceModel ( dff, 350 )
end)