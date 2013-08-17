-- nie chce mi sie juz robic do tego gui, i tak ten interfejs bedzie obslugiwac jedna lub dwie osoby - dostana jedna komende a ja zaoszczedze godzine czasu


local importowanePojazdy = { 496, 516, 517, 401, 410, 518, 600, 527, 436, 419, 439, 533, 549, 526,
491, 474, 445, 426, 507, 547, 585, 405, 466, 492, 566, 540, 551, 421,
529, 420, 499, 609, 498, 422, 414, 531, 456, 543, 482, 554, 418, 413,
536, 575, 567, 535, 576, 412, 402, 542, 603, 475, 495, 508, 500,
559, 561, 480, 560, 565, 558, 555, 579, 400, 404, 489, 479, 610, 611}

-- sportowe zablokowane - 411, 506, 451, 541, 415, 429, 477, 587, 602

local function pojazdImportowalny(vid)
    if (getVehicleType(vid)~="Automobile") then return false end
    for i,v in ipairs(importowanePojazdy) do
	if (v==vid) then return true end
    end
    return false
end

local function maDostep(plr)
    local c=getElementData(plr,"character")
    if not c then return false end
    if c and c.id and (tonumber(c.id)==1 or tonumber(c.id)==3578 or tonumber(c.id)==19) then return true end
    return false
end

function listaPojazdowDoImportu(full)
    local dane=exports.DB:pobierzTabeleWynikow("SELECT vid FROM lss_importpojazdow")
    local wyniki={}
    if not full then
	for i,v in ipairs(dane) do
	    table.insert(wyniki, tonumber(v.vid))
	end
	return wyniki
    end
    for i,v in ipairs(dane) do
	v.vid=tonumber(v.vid)
	v.nazwa=getVehicleNameFromModel(v.vid)
    end
    return dane
    
end

local D=3
local I=2

local marker=createMarker(2424.71,-2678.00,2034.37,"cylinder",1,255,255,255,100)
setElementInterior(marker,I)
setElementDimension(marker,D)


addEventHandler("onMarkerHit", marker, function(he,md)

    if (getElementType(he)~="player") then	return	end
    if (not maDostep(he)) then return end
    
    local listapojazdow=listaPojazdowDoImportu(true)
    if (not listapojazdow or #listapojazdow<7) then
	outputChatBox("Lista zamówień jest pusta.", he)
	outputChatBox("(( Dodaj pojazd za pomocą komendy /importujpojazd ))", he)
	return
    end
    outputChatBox("Lista pojazdów do importu:", he)
    for i,v in ipairs(listapojazdow) do
	outputChatBox(string.format("%d. %d %s", i, v.vid, v.nazwa), he)
    end
    if (#listapojazdow<7) then
        outputChatBox("(( Dodaj kolejny pojazd za pomocą komendy /importujpojazd ))", he)
    else
	outputChatBox("Lista zamówień jest pełna.", he)
    end
end)

function cmd_importujpojazd(plr,cmd,vid,cena)
    if (not maDostep(plr)) then return false end
    if (not isElementWithinMarker(plr,marker)) then
	outputChatBox("Nie jesteś przy komputerze w biurze.", plr)
	return
    end
    local listapojazdow=listaPojazdowDoImportu(false)
    if (not vid or not tonumber(vid)) then
	outputChatBox("Uzyj: /importujpojazd <id pojazdu>", plr)
	return
    end
    vid=tonumber(vid)
    if (not pojazdImportowalny(vid)) then
	outputChatBox("Tego pojazdu nie można zaimportować.", plr)
	return
    end
    local cenaPojazdu=math.floor(getModelHandling(vid).monetary*43.8);
    if (not cena or not tonumber(cena) or tonumber(cena)~=cenaPojazdu) then
	outputChatBox("Koszt importu: " .. cenaPojazdu .."$.", plr)
	outputChatBox("Aby potwierdzić import wpisz: /importujpojazd " .. vid .. " " .. cenaPojazdu, plr)
	return
    end

    if (listapojazdow and type(listapojazdow)=="table" and #listapojazdow>=7) then
	outputChatBox("Obecnie złożona jest już maksymalna ilość zamówień na pojazdy, poczekaj na dostawę aktualnych.", plr)
	return
    end

    if (getPlayerMoney(plr)<cenaPojazdu) then
	outputChatBox("Nie masz wystarczającej ilości gotówki.", plr)
	return
    end
    takePlayerMoney(plr, cenaPojazdu)
    local query=string.format("INSERT INTO lss_importpojazdow SET vid=%d", vid)
    exports.DB:zapytanie(query)
    outputChatBox("Pojazd został dodany na listę pojazdów do importu", plr);
end

addCommandHandler("importujpojazd", cmd_importujpojazd, false,false)