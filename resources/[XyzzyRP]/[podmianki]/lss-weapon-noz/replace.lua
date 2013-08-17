local resourceRoot = getResourceRootElement(getThisResource())
     
addEventHandler("onClientResourceStart",resourceRoot,
function ()
    txd = engineLoadTXD ( "knifecur.txd" )
    engineImportTXD ( txd, 333 )
    dff = engineLoadDFF ( "knifecur.dff", 0)
    engineReplaceModel ( dff, 333 )
end)