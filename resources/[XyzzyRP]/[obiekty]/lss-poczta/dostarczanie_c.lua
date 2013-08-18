function dostarczListy(odbiorca)
    -- no i teraz jest hardkor
    -- mamy id wlasciciela domu i musimy znalezc w eq listy ktore do niego należą
    -- musimy zabrac je z eq i poinformowac serwer ze listy zostaly dostarczone
    if (type(odbiorca)=="table" and odbiorca.skrzynka) then odbiorca=odbiorca.skrzynka end
    local ekwipunek=exports["lss-gui"]:eq_get()
    local listy={}
    for i,v in ipairs(ekwipunek) do
	if (v and v.itemid==38 and v.subtype<0) then
	    table.insert(listy, -v.subtype)
	end
    end
    if (#listy>0) then
        triggerServerEvent("doDelivery", resourceRoot, localPlayer, listy, odbiorca)
    else
	outputChatBox("Nie masz żadnych listów.")
    end
end