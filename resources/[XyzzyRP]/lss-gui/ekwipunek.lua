--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--


local sw,sh = guiGetScreenSize()
local EQ={}
local oipumColor=
{
r={},
g={},
b={},
}

local ammoWeapons = {
	[31]=130,
	[25]=131,
	[24]=132,
	[23]=133,
	[28]=134,
	[30]=135,
	[29]=136,
	[22]=145,
	[26]=153,
--	[34]=156,
}

triggerEvent("onGUIOptionChange", root, "motionblur", false)

function eq_compact()
    -- zamienia tabele EQ na taka postac:
    -- { itemid, ilosc, subtype, itemid, ilosc, subtype, itemid, ilosc, subtype ... }
    local compact={}
    for i,v in ipairs(EQ) do
	table.insert(compact, v.itemid or 0)
	table.insert(compact, v.count or 0)
	table.insert(compact, v.subtype or 0)
    end
    return compact
end

function eq_removeByIndex(index)
    EQ[index].itemid=nil
    EQ[index].name=nil
    EQ[index].count=nil
    EQ[index].img=nil
    EQ[index].subtype=nil
	EQ[index].wepid=nil
end

    
function eq_getItemByID(id,subtype)
    for i,v in ipairs(EQ) do
	if (v.itemid==id and (not subtype or tonumber(subtype)==tonumber(v.subtype))) then return v end
    end
    return nil
end

function eq_getItemSlotByID(id,subtype)
    for i,v in ipairs(EQ) do
	if (v.itemid==id and (not subtype or tonumber(subtype)==tonumber(v.subtype))) then return i end
    end
    return nil
end

local function przyczepa(v)
	if getVehicleType(v)=="Trailer" then return true end
	if getElementModel(v)==450 then return true end
	return false
end

local function pojazdNaDachu(p)
    local rx,ry=getElementRotation(p)
    if (rx>90 and rx<270) or (ry>90 and ry<270) then return true end
    return false
end
 
	
function eq_getFreeIndex()
    for i,v in ipairs(EQ) do
	if (not v.itemid) then return i end
    end
    return nil
end

local function modifySatiation(value)
	local character=getElementData(localPlayer,"character")
	if not character then return false	end
	character.satiation=math.min(math.max((character.satiation or 75)+value,0),100)
	setElementData(localPlayer, "character", character)
	return true
end

function eq_fillMetaInfo(item)
    item.itemid=tonumber(item.itemid)
    -- todo sprezyc to z baza danych
    if (item.itemid==1) then
	item.name="Papierosy"
	item.img="img/EQ_papierosy.png"
	item.wepid=nil
    elseif (item.itemid==2) then
	item.name="Aparat"
	item.img="img/EQ_aparat.png"
	item.wepid=43
    elseif (item.itemid==3) then
	item.name="Żetony"
	item.img="img/EQ_zeton.png"
	item.wepid=nil
    elseif (item.itemid==4) then
	item.name="Mapa"
	item.img="img/EQ_mapa.png"
	item.wepid=nil
    elseif (item.itemid==5) then
	item.name="Aspiryna"
	item.img="img/EQ_aspiryna.png"
    elseif (item.itemid==6) then
	item.name="Klucze ".. (item.subtype or "")
	item.img="img/EQ_kluczyki_auto.png"
    elseif (item.itemid==7) then
	item.name="PDA"
	item.img="img/EQ_pda.png"
    elseif (item.itemid==8) then
	item.name="Surowa ryba"
	item.img="img/EQ_ryba.png"
    elseif (item.itemid==9) then
	item.name="Śmieci"
	item.img="img/EQ_smieci.png"
    elseif (item.itemid==10) then
	item.name="Ryba wędzona"
	item.img="img/EQ_ryba_1.png"
    elseif (item.itemid==11) then
	item.name="Klucze policji"
	item.img="img/EQ_kluczyki_policja.png"
    elseif (item.itemid==12) then
	item.name="Klucze SM"
	item.img="img/EQ_kluczyki_sm.png"
    elseif (item.itemid==13) then
	item.name="Kwit do wypłaty"
	item.img="img/EQ_kwit.png"
    elseif (item.itemid==14) then
	item.name="Klucze W-1"
	item.img="img/EQ_kluczyki_warsztat.png"
    elseif (item.itemid==15) then
	item.name="Paczka kurierska"
	item.img="img/EQ_paczka.png"
    elseif (item.itemid==16) then
	item.name="Nawigacja GPS"
	item.img="img/EQ_nav.png"
    elseif (item.itemid==17) then
	item.name="Prawo jazdy"
	item.img="img/EQ_prawojazdy.png"
    elseif (item.itemid==18) then
	item.name="Amtefamina"
	item.img="img/EQ_pill1.png"
    elseif (item.itemid==19) then
	item.name="Gazeta"
	item.img="img/EQ_gazeta.png"
	elseif (item.itemid==20) then
	item.name="Klucze do eLki"
	item.img="img/EQ_kluczyki_naukajazdy.png"
    elseif (item.itemid==21) then
	item.name="iPhone"
	item.img="img/EQ_telefon.png"
	elseif (item.itemid==22) then
	item.name="Drink"
	item.img="img/EQ_drink.png"
	elseif (item.itemid==23) then

	  item.name="Kwiaty - chabry"
	  item.wepid=14
	  item.img="img/EQ_kwiaty.png"	

	elseif (item.itemid==24) then
	  item.name="Kwiaty - bazie"
	  item.wepid=14
	  item.img="img/EQ_kwiaty.png"	

	elseif (item.itemid==25) then
		item.wepid=41
		item.img="img/EQ_spray.png"
		item.name="Spray"
		if (item.subtype==0) then
			item.name="Spray (czarny)"
		elseif (item.subtype==0xFFFFFF) then
			item.name="Spray (biały)"
		elseif (item.subtype==0x220C00) then
			item.name="Spray (brązowy)"
		elseif (item.subtype==0xFF0000) then
			item.name="Spray (czerwony)"
--		elseif (item.subtype==0xFFFF00) then
		elseif (item.subtype==0xD78E10) then
			item.name="Spray (żółty)"
		elseif (item.subtype==0x004000) then
			item.name="Spray (zielony)"
		elseif (item.subtype==0x0E316D) then
			item.name="Spray (niebieski)"
		elseif (item.subtype==0x00FFFF) then
			item.name="Spray (morski)"
		elseif (item.subtype==0xAAAAAA) then
			item.name="Spray (metalik)"
		elseif (item.subtype==0xFF00F6) then
			item.name="Spray (playboya)"
		else
			item.name=string.format("Spray %06x", item.subtype)
		end
    elseif (item.itemid==26) then
	item.name="Klucze TAXI"
	item.img="img/EQ_kluczyki_taxi.png"
	elseif (item.itemid==27) then
	item.name="Joint"
	item.img="img/EQ_joint.png"
	elseif (item.itemid==28) then
	item.name="Kajdanki"
	item.img="img/EQ_kajdanki.png"
    elseif (item.itemid==29) then
	item.name="Klucze medyków"
	item.img="img/EQ_kluczyki_medycy.png"
	elseif (item.itemid==30) then
	item.name="Glock"
	item.img="img/EQ_glock.png"
	item.wepid=22
	elseif (item.itemid==31) then
	  item.name="Baseball"
	  item.img="img/EQ_baseball.png"
	  item.wepid=5
    elseif (item.itemid==32) then
	item.wepid=2
	item.name="Mikrofon"
	item.img="img/EQ_mikrofon.png"
	elseif (item.itemid==33) then
	item.wepid=3
	item.name="Pałka policyjna"
	item.img="img/EQ_palka.png"
	elseif (item.itemid==34) then
	  item.name="Grzybek"
	  item.img="img/EQ_grzybek.png"
	elseif (item.itemid==35) then
	  item.name="Pager"
	  item.img="img/EQ_pager.png"
	elseif (item.itemid==36) then
	item.wepid=42
	item.name="Gaśnica"
	item.img="img/EQ_gasnica.png"
    elseif (item.itemid==37) then
	item.name="Zastrzyk - "
	item.img="img/EQ_strzykawka.png"
	if (item.subtype==1) then
	    item.name=item.name .. " morfina"
	elseif (item.subtype==2) then
	    item.name=item.name .. " pavulon"
	end
    elseif (item.itemid==38) then
	if (item.subtype<0) then
	    item.name="List do dostarczenia"
	    item.img="img/EQ_list_zamkniety.png"
	else
	    item.name="List"
	    item.img="img/EQ_list_otwarty.png"
	end
    elseif (item.itemid==39) then
	item.name="Klucze strażaków"
	item.img="img/EQ_kluczyki_medycy.png"
	elseif (item.itemid==40) then

	  item.name="Kwiaty - stokrotki"
	  item.wepid=14
	  item.img="img/EQ_kwiaty.png"	
	elseif (item.itemid==41) then
	  item.name="Krotkofalowka"
	  item.img="img/EQ_krotkofalowka.png"
	elseif (item.itemid==42) then
	  item.name="Piwo"
	  item.img="img/EQ_piwo.png"
	elseif (item.itemid==43) then
	  item.name="Szkicownik"
	  item.img="img/EQ_szkicownik.png"
	elseif (item.itemid==44) then
	  item.name="Snopek"
	  item.img="img/EQ_snop.png"
	elseif (item.itemid==45) then
	  item.name="Miotacz ognia"
	  item.wepid=37
	  item.img="img/EQ_miotaczplomieni.png"
	elseif (item.itemid==46) then
	  item.name="Dowód osobisty"
	  item.img="img/EQ_dowod.png"
	elseif (item.itemid==47) then
	  if (not item.subtype or tonumber(item.subtype)==0) then
		  item.name="Notes"
		  item.img="img/EQ_notes.png"
	  else
		  item.name="Notatka (".. (item.subtype or "") .. ")"
		  item.img="img/EQ_notatka.png"
	  end
	elseif (item.itemid==48) then

	  item.name="Kwiaty - róże"
	  item.wepid=14
	  item.img="img/EQ_kwiaty.png"	

    elseif (item.itemid==49) then
	item.name="Klucze CNN"
	item.img="img/EQ_kluczyki_cnn_news.png"
    elseif (item.itemid==50) then
	item.name="Klucze UM"
	item.img="img/EQ_kluczyki_urzad_miasta.png"
    elseif (item.itemid==51) then
	item.name="Klucze kurierów"
	item.img="img/EQ_kluczyki_kurierzy.png"		
    elseif (item.itemid==52) then
	item.name="Klucze W-2"
	item.img="img/EQ_kluczyki_warsztat.png"
    elseif (item.itemid==53) then
	item.name="Klucze W-3"
	item.img="img/EQ_kluczyki_warsztat.png"
    elseif (item.itemid==54) then
	item.name="Klucze W-4"
	item.img="img/EQ_kluczyki_warsztat.png"
    elseif (item.itemid==55) then
	item.name="Klucze W-5"
	item.img="img/EQ_kluczyki_warsztat.png"
    elseif (item.itemid==56) then
	item.name="Klucze do eLki-2"
	item.img="img/EQ_kluczyki_naukajazdy.png"
    elseif (item.itemid==57) then
	item.name="Klucze ochrony"
	item.img="img/EQ_kluczyki_ochrony.png"
	elseif (item.itemid==58) then
	  item.name="Kwiaty"
	  item.wepid=14
	  item.img="img/EQ_kwiaty.png"	
	elseif (item.itemid==59) then

	  item.name="Kwiaty - tulipany"
	  item.wepid=14
	  item.img="img/EQ_kwiaty.png"	

	elseif (item.itemid==60) then

	  item.name="Kwiaty - bez"
	  item.wepid=14
	  item.img="img/EQ_kwiaty.png"	

	elseif (item.itemid==61) then
		item.name="Neony [".. (item.subtype or "").."]"
		item.img="img/EQ_neony.png"
	elseif (item.itemid==62) then
		item.name="Klucze importu"
		item.img="img/EQ_kluczyki_import.png"	
	elseif (item.itemid==63) then
		item.name="Płyta CD [".. (item.subtype or "").."]"
		item.img="img/EQ_plyta.png"
	elseif (item.itemid==64) then
		item.name="Moneta"
		item.img="img/EQ_moneta.png"
	elseif (item.itemid==65) then
		item.name="Kostka do gry"
		item.img="img/EQ_kostka.png"
	elseif (item.itemid==66) then
		item.name="Aluminium"
		item.img="img/EQ_m_aluminium.png"
	elseif (item.itemid==67) then
		item.name="Drewno"
		item.img="img/EQ_m_drewno.png"
	elseif (item.itemid==68) then
		item.name="Papier"
		item.img="img/EQ_m_papier.png"
	elseif (item.itemid==69) then
		item.name="Polietylen"
		item.img="img/EQ_m_polietylen.png"
	elseif (item.itemid==70) then
		item.name="Polipropylen"
		item.img="img/EQ_m_polipropylen.png"
	elseif (item.itemid==71) then
		item.name="Polistyren"
		item.img="img/EQ_m_polistyren.png"
	elseif (item.itemid==72) then
		item.name="Stal"
		item.img="img/EQ_m_stal.png"
	elseif (item.itemid==73) then
		item.name="Szkło"
		item.img="img/EQ_m_szklo.png"
	elseif (item.itemid==74) then
		item.wepid=9
		item.name="Piła spalinowa"
		item.img="img/EQ_pila.png"
	elseif (item.itemid==75) then
		item.name="Klucze gornikow"
		item.img="img/EQ_kluczyki_gornikow.png"	
	elseif (item.itemid==76) then
		item.name="Pachołek"
		item.img="img/EQ_pacholek.png"
	elseif (item.itemid==77) then
		item.name="Klucze SR"
		item.img="img/EQ_kluczyki_sadu_rejonowego.png"	
	elseif (item.itemid==78) then
		item.name="Klucze SW"
		item.img="img/EQ_kluczyki_sluzb_wieziennych.png"			
	elseif (item.itemid==79) then
		item.name="Zestaw kół\n"..(item.subtype or "-")
		item.img=fileExists("img/EQ_kolo_"..(item.subtype or "1025")..".png") and "img/EQ_kolo_"..(item.subtype or "1025")..".png" or "img/EQ_kolo_1025.png"
	elseif (item.itemid==80) then
		item.name="Klucze SS"
		item.img="img/EQ_kluczyki_sluzb_specjalnych.png"
	elseif (item.itemid==81) then
		item.wepid=4
		item.name="Nóż"
		item.img="img/EQ_noz.png"
	elseif (item.itemid==82) then
	  item.name="Whiskey"
	  item.img="img/EQ_whiskey.png"
	elseif (item.itemid==83) then
	  item.name="Pizza"
	  item.img="img/EQ_pizza.png"
	elseif (item.itemid==84) then
	  item.name="Cola"
	  item.img="img/EQ_cola.png"
	elseif (item.itemid==85) then
	  item.name="Sok"
	  item.img="img/EQ_sok.png"
	elseif (item.itemid==86) then
	  item.name="Chleb"
	  item.img="img/EQ_chleb.png"
	elseif (item.itemid==87) then
	  item.name="Woda niegazowana"
	  item.img="img/EQ_woda.png"
	elseif (item.itemid==88) then
	  item.name="Hot-Dog"
	  item.img="img/EQ_hotdog.png"
	elseif (item.itemid==89) then
	  item.name="Frytki"
	  item.img="img/EQ_frytki.png"
	elseif (item.itemid==90) then
	  item.name="Baton"
	  item.img="img/EQ_baton.png"
	elseif (item.itemid==91) then
	  item.name="Owoce"
	  item.img="img/EQ_owoce.png"
	elseif (item.itemid==92) then
	  item.name="Klucze PP"
	  item.img="img/EQ_kluczyki_przychodni_lekarskiej.png"
	elseif (item.itemid==93) then
	  item.name="Papier toaletowy"
	  item.img="img/EQ_papier_toaletowy.png"
	elseif (item.itemid==94) then
	  item.name="Spirytus"
	  item.img="img/EQ_spirytus.png"
	elseif (item.itemid==95) then
	item.name="Kubańskie cygaro"
	item.img="img/EQ_cygaro.png"
	elseif (item.itemid==96) then
	item.name="Rybka w konserwie"
	item.img="img/EQ_rybka_w_konserwie.png"
	elseif (item.itemid==97) then
	item.name="Ręcznik"
	item.img="img/EQ_recznik.png"
	elseif (item.itemid==98) then
	item.name="Lody"
	item.img="img/EQ_lody.png"
	elseif (item.itemid==99) then
	item.name="Szaszłyk"
	item.img="img/EQ_szaszlyk.png"
	elseif (item.itemid==100) then
	item.name="Dropsy miętowe"
	item.img="img/EQ_dropsy_mietowe.png"
	elseif (item.itemid==101) then
	  item.name="Klucze SK"
	  item.img="img/EQ_kluczyki_sluzb_koscielnych.png"
	elseif (item.itemid==102) then -- generyczny item od tuningu
		if item.subtype==1087 then
			item.name="Zest. hydrauliczny"
			item.img="img/EQ_hydraulika.png"
		end
	elseif (item.itemid==103) then
	  item.name="Klucze Tartaku"
	  item.img="img/EQ_kluczyki_tartaku.png"
	elseif (item.itemid==104) then
		item.wepid=46
		item.name="Spadochron"
		item.img="img/EQ_spadochron.png"
	elseif (item.itemid==105) then
		item.name="Kominiarka"
		item.img="img/EQ_kominiarka.png"
	elseif (item.itemid==106) then
		item.name="Klucze szkoły lotniczej"
		item.img="img/EQ_kluczyki_szkoly_lotniczej.png"
	elseif (item.itemid==107) then
		item.name="Fajerwerki"
		item.img="img/EQ_fajerwerki.png"
	elseif (item.itemid==108) then
		item.name="Megafon"
		item.img="img/EQ_megafon.png"
	elseif (item.itemid==109) then
		item.name="Shotgun"
		item.img="img/EQ_shotgun.png"
		item.wepid=25 
    elseif (item.itemid==110) then

    	item.name="Desert Eagle"
    	item.img="img/EQ_deagle.png"
    	item.wepid=24
    elseif (item.itemid==111) then
    	item.name="Paralizator"
    	item.img="img/EQ_paralizator.png"
    	item.wepid=23
    elseif (item.itemid==112) then
	  item.name="UZI"
	  item.img="img/EQ_uzi.png"
	  item.wepid=28
    elseif (item.itemid==113) then
	  item.name="Karabin szkoleniowy"
	  item.img="img/EQ_karabinek.png"
	  item.wepid=30
    elseif (item.itemid==114) then
		item.name="MP5"
		item.img="img/EQ_mp5.png"
		item.wepid=29
    elseif (item.itemid==115) then
		item.name="M4"
		item.img="img/EQ_m4.png"
		item.wepid=31
	elseif (item.itemid==117) then
	  item.name="Klucze Gastronomii I"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==118) then
	  item.name="Klucze Gastronomii II"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==119) then
	  item.name="Klucze Gastronomii III"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==120) then
	  item.name="Klucze Gastronomii IV"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==121) then
	  item.name="Klucze Gastronomii V"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==122) then
	  item.name="Klucze Gastronomii VI"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==123) then
	  item.name="Klucze Gastronomii VII"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==124) then
	  item.name="Klucze Gastronomii VIII"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==125) then
	  item.name="Klucze Gastronomii IX"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==126) then
	  item.name="Klucze Turystyki"
	  item.img="img/EQ_kluczyki_turystyki.png"
	elseif (item.itemid==127) then
	  item.name="Klucze Gastronomii X"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==128) then
	  item.name="Klucze Gastronomii XI"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==129) then
	  item.name="Klucze Gastronomii XII"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==130) then
	  item.img="img/EQ_amunicja.png"
	  item.name="Amunicja M4"
	  item.wepid=31
	elseif (item.itemid==131) then
	  item.img="img/EQ_amunicja.png"
	  item.name="Amunicja Shotgun"
	  item.wepid=25
	elseif (item.itemid==132) then
	  item.img="img/EQ_amunicja.png"
	  item.name="Amunicja Deagle"
	  item.wepid=24
	elseif (item.itemid==133) then
	  item.img="img/EQ_amunicja.png"
	  item.name="Amunicja Paralizator"
	  item.wepid=23
	elseif (item.itemid==134) then
	  item.img="img/EQ_amunicja.png"
	  item.name="Amunicja Uzi"
	  item.wepid=28
	elseif (item.itemid==135) then
	  item.img="img/EQ_amunicja.png"
	  item.name="Amunicja szkol (2)"
	  item.wepid=30
	elseif (item.itemid==136) then
	  item.img="img/EQ_amunicja.png"
	  item.name="Amunicja MP5"
	  item.wepid=29
	elseif (item.itemid==137) then
	  item.img="img/EQ_pill1.png"
	  item.name="Dopalacze"
	elseif (item.itemid==138) then
	  item.img="img/EQ_kakanina.png"
	  item.name="Kakanina"
	elseif (item.itemid==139) then
	  item.img="img/EQ_kokaina.png"
	  item.name="Amtefamina"  
	elseif (item.itemid==140) then
	  item.img="img/EQ_lds.png"
	  item.name="LDS"
	elseif (item.itemid==141) then
	  item.img="img/EQ_oipum.png"
	  item.name="oipum" 
	elseif (item.itemid==142) then
	  item.img="img/EQ_kokaina.png"
	  item.name="Metamtefamina" 
	elseif (item.itemid==143) then
	  item.img="img/EQ_heronina.png"
	  item.name="Heronina" 
	elseif (item.itemid==144) then
	  item.img="img/EQ_extas.png"
	  item.name="Extas" 
	elseif (item.itemid==145) then
	  item.img="img/EQ_amunicja.png"
	  item.name="Amunicja Glock"
	  item.wepid=22
	elseif (item.itemid==146) then
	  item.name="(( Pojemnik ))"
	  item.img="img/EQ_plecak.png"
	elseif (item.itemid==147) then
	  item.name="(( Pojemnik ))"
	  item.img="img/EQ_plecak.png"
	elseif (item.itemid==148) then
		if (item.subtype==1) then
		  item.name="Granat hukowo-błyskowy"
		  item.img="img/EQ_granathukowy.png"
		  item.wepid=16
		elseif (item.subtype==2) then
		  item.name="Granat dymny"
		  item.img="img/EQ_granatdymny.png"
		  item.wepid=16
		else
		  item.name="Granat"
		  item.img="img/EQ_granat.png"
		  item.wepid=16
		end
	elseif (item.itemid==149) then
	  item.name="Klucze Gastronomii XIII"
	  item.img="img/EQ_kluczyki_gastronomii.png"
	elseif (item.itemid==150) then
	  item.name="Defibrylator"
	  item.img="img/EQ_defibrylator.png"
	elseif (item.itemid==151) then
	  item.name="Kamizelka PD"
	  item.img="img/EQ_kamizelkapd.png"
	  if item.subtype then
		item.name= string.format("Kamizelka PD %s", item.subtype)
	  end
	elseif (item.itemid==152) then
	  item.name="Pistolet szkoleniowy"
	  item.img="img/EQ_straszak.png"
	  item.wepid=26
	elseif (item.itemid==153) then
	  item.img="img/EQ_amunicja.png"
	  item.name="Amunicja szkol (1)"
	  item.wepid=26
	elseif (item.itemid==154) then
	  item.img="img/EQ_laser.png"
	  item.name="Laser"
		if (item.subtype==1) then
			item.name="Laser M4"
			item.wepid=31
		elseif (item.subtype==2) then
			item.name="Laser Glock"
			item.wepid=22
		elseif (item.subtype==3) then
			item.name="Laser Deagle"
			item.wepid=24
--[[
		elseif (item.subtype==4) then
			item.name="Laser AK47"
			item.wepid=30
--]]
		elseif (item.subtype==5) then
			item.name="Laser MP5"
			item.wepid=29
		end
--[[		elseif (item.subtype==6) then
			item.name="Lader Snajperka"
			item.wepid=34
		end
	elseif (item.itemid==155) then
	  item.img="img/EQ_snajperka.png"
	  item.name="Karabin snajperski"
	  item.wepid=34
	elseif (item.itemid==156) then
	  item.img="img/EQ_amunicja.png"
	  item.name="Amunicja Snajperka"
	  item.wepid=34]]--
	elseif (item.itemid==157) then
	  item.img="img/EQ_grill.png"
	  item.name="Grill"
	elseif (item.itemid==158) then
	  item.img="img/EQ_kielbasa1.png"
	  item.name="Surowa kielbasa"
	elseif (item.itemid==159) then
	  item.img="img/EQ_kielbasa2.png"
	  item.name="Pieczona kielbasa"
	elseif (item.itemid==160) then
	  item.img="img/EQ_kwiaty.png"
	  item.name="Kwiaty - malwy"
	elseif (item.itemid==161) then
	  item.img="img/EQ_kanister.png"
	  item.name="Kanister 5L"
	elseif (item.itemid==162) then
	  item.img="img/EQ_kanister.png"
	  item.name="Kanister 10L"
    elseif (item.itemid==163) then
	  item.name="Klucze Klubu Miasta"
	  item.img="img/EQ_kluczyki_urzad_miasta.png"
	elseif (item.itemid==164) then
	  item.name="Boombox"
	  item.img="img/EQ_boombox.png"
	elseif (item.itemid==165) then
	  item.name="Obroża"
	  item.img="img/EQ_obroza.png"
	elseif (item.itemid==166) then
	  item.name="Zwłoki"
	  item.img="img/EQ_zwloki.png"
	  if item.subtype then
		item.name=string.format("Zwłoki %s",item.subtype)
	  end
	elseif (item.itemid==167) then
	  item.name="Karma (pies)"
	  item.img="img/EQ_karma.png"
	elseif (item.itemid==168) then
	  item.name="Prezent - DD"
	  item.img="img/EQ_prezent.png"
	elseif (item.itemid==169) then
	  item.name="Kamizelka LSMC"
	  item.img="img/EQ_kamizelkamc.png"
	elseif (item.itemid==170) then
	  item.name="Opony Slick"
	  item.img="img/EQ_opony.png"
	elseif (item.itemid==171) then
	  item.name="Opony z m. mieszanki"
	  item.img="img/EQ_opony.png"
	elseif (item.itemid==172) then
	  item.name="Chipset ECO"
	  item.img="img/EQ_chipset.png"
	elseif (item.itemid==173) then
	  item.name="Chipset HARD"
	  item.img="img/EQ_chipset.png"
	elseif (item.itemid==174) then
	  item.name="Rozpórka pod maską"
	  item.img="img/EQ_rozporka.png"
	elseif (item.itemid==175) then
	  item.name="Klatka bezpieczenstwa"
	  item.img="img/EQ_klatkabezpieczenstwa.png"
	elseif (item.itemid==176) then
	  item.name="Filtr stożkowy"
	  item.img="img/EQ_filtr.png"
	elseif (item.itemid==177) then
	  item.name="Filtr sportowy"
	  item.img="img/EQ_filtr.png"
	elseif (item.itemid==178) then
	  item.name="Wtrysk wody z metanolem"
	  item.img="img/EQ_filtr.png"
	elseif (item.itemid==179) then
	  item.name="Wtrysk sportowy"
	  item.img="img/EQ_filtr.png"
	elseif (item.itemid==180) then
	  item.name="Karoseria (wl. weglowe)"
	  item.img="img/EQ_karoseria.png"
	elseif (item.itemid==181) then
	  item.name="Karoseria (alphaBx)"
	  item.img="img/EQ_karoseria.png"
	elseif (item.itemid==182) then
	  item.name="Biturbo"
	  item.img="img/EQ_biturbo.png"
	elseif (item.itemid==183) then
	  item.name="Twin-turbo"
	  item.img="img/EQ_biturbo.png"
	elseif (item.itemid==184) then
	  item.name="Drążek stabilizatora"
	  item.img="img/EQ_drazek.png"
	elseif (item.itemid==185) then
	  item.name="Amortyzator gazowy"
	  item.img="img/EQ_amortyzator.png"
	elseif (item.itemid==186) then
	  item.name="Zes. cięż. zawieszenia gwint."
	  item.img="img/EQ_zawieszenie.png"
	elseif (item.itemid==187) then
	  item.name="Folia R10"
	  item.img="img/EQ_folia.png"
	elseif (item.itemid==188) then
	  item.name="Folia przyciemniająca"
	  item.img="img/EQ_folia.png"
	elseif (item.itemid==189) then
	  item.name="Bi-ksenon XBluePower"
	  item.img="img/EQ_swiatla.png"
	elseif (item.itemid==190) then
	  item.name="LED XGreenPower"
	  item.img="img/EQ_swiatla.png"
	elseif (item.itemid==191) then
	  item.name="Klocki hamulcowe"
	  item.img="img/EQ_hamulce.png"
	elseif (item.itemid==192) then
	  item.name="Zacisk hamulcowy"
	  item.img="img/EQ_zacisk.png"
	elseif (item.itemid==193) then
	  item.name="Tarcza hamulcowa"
	  item.img="img/EQ_tarczahamulcowa.png"
	elseif (item.itemid==194) then
	  item.name="Skrz. biegów SPRINT"
	  item.img="img/EQ_biegi.png"
	elseif (item.itemid==195) then
	  item.name="Skrz. biegów FAST"
	  item.img="img/EQ_biegi.png"
	elseif (item.itemid==196) then
	  item.name="Audio - Little music"
	  item.img="img/EQ_audio.png"
	 elseif (item.itemid==197) then
	  item.name="Audio - BIG BASTARD"
	  item.img="img/EQ_audio.png"
	else
		item.name=""
		item.itemid=nil
		item.count=nil
		item.wepid=nil
    end
end

function eq_get()	-- uzywane do pobierania ekwipunku przez lss-trade
    return EQ
end

function eq_giveItem(id,count,subtype)
    local przedmiot=eq_getItemByID(id,subtype)
    if (przedmiot) then
	przedmiot.count=przedmiot.count+(count or 1)
	eq_sync()
	eq_redraw()
	return true
    end
    -- nie mamy przedmiotu w inwentarzu - musimy go dodac
    local wolny_indeks=eq_getFreeIndex()
    if (not wolny_indeks) then
	triggerEvent("onCaptionedEvent", resourceRoot, "Nie masz miejsca w inwentarzu.", 3)
	return false
    end
    EQ[wolny_indeks].itemid=id
    EQ[wolny_indeks].count=count or 1
	EQ[wolny_indeks].subtype=subtype or nil
    eq_fillMetaInfo(EQ[wolny_indeks])
    eq_sync()
    eq_redraw()
    return true
    
end

function eq_takeItem(id,count,subtype)
    for i,v in ipairs(EQ) do
	if (v.itemid==id and (not subtype or subtype==v.subtype)) then
	    if (count and v.count<count) then	-- gracz ma mniejsza ilosc przedmiotu niz potrzeba
		return false
	    end
	    if (not count or count==v.count) then
		eq_removeByIndex(i)
		eq_sync()
		eq_redraw()
		return true
	    end
	    EQ[i].count=v.count-count
	    eq_sync()
	    eq_redraw()
	    return true
	end
    end
    return false
end

function eq_sync()
    setElementData(localPlayer, "EQ", eq_compact(EQ))
end

function eq_change(dataName, oldValue)
    if (dataName~="EQ") then return end	-- obslugujemy tylko zmiane wartosc EQ
    -- event moze byc wywolany z powodu akcji po stronie serwera (zmiana ekwipunku po stronie serwera)
    -- lub z powodu dzialania funkcji eq_sync. Tego drugiego przypadku nie obslugujemy aby nie zapetlic kodu
    local newEQ=getElementData(localPlayer,"EQ")
    if (not newEQ or type(newEQ)~="table") then return end	-- nie powinno sie wydarzyc

    if (simple_table_compare(newEQ,eq_compact(EQ))) then return end	-- zdarzenie wywolane przez eq_sync
    for i=1,28 do
      EQ[i].itemid=tonumber(table.remove(newEQ,1) or 0)
      EQ[i].count=tonumber(table.remove(newEQ,1) or 0)
      EQ[i].subtype=tonumber(table.remove(newEQ,1) or 0)
      eq_fillMetaInfo(EQ[i])
    end

    eq_redraw()

end
addEventHandler ( "onClientElementDataChange", localPlayer, eq_change)
    
function eq_redraw(passive)
    local weapons={}
    local radar_widoczny=false
	local veh=getPedOccupiedVehicle(localPlayer)
	if veh then
		local vm=getElementModel(veh)
		if vm==438 or vm==420 then -- taxi
			radar_widoczny=true
		end
	end
	local maKominiarke=false
    for i,v in ipairs(EQ) do
		if (v.itemid) then
		    if (v.itemid==16 or v.itemid==4) then radar_widoczny=true end
			if (v.itemid==105) then maKominiarke=true end
		    guiSetText(v.g_ilosc, v.count==1 and "" or tostring(v.count))
		    guiSetText(v.g_nazwa, tostring(v.name))
		    guiStaticImageLoadImage ( v.g_img, v.img or "img/EQ_blank.png" )
			if (v.wepid and v.wepid>0) then
				table.insert(weapons, { v.wepid, v.count })
			end
		else
		    guiSetText(v.g_ilosc, "")
		    guiSetText(v.g_nazwa, "")
		    guiStaticImageLoadImage ( v.g_img, "img/EQ_blank.png" )
		end
    end
    toggleControl("radar",radar_widoczny)
    showPlayerHudComponent("radar", radar_widoczny)
	local zamaskowany=getElementData(localPlayer, "zamaskowany")
	if zamaskowany and zamaskowany==105 and not maKominiarke then	-- byl zamaskowany ale pozbyl sie kominiarki
		triggerServerEvent("kominiarkaAction", localPlayer,true)
	end

    if (not passive) then
		triggerServerEvent("syncPlayerWeapons", localPlayer, weapons)
    end
end

addEventHandler("onClientPlayerVehicleEnter", localPlayer, function()
	eq_redraw(true)
end)
addEventHandler("onClientPlayerVehicleExit", localPlayer, function()
	eq_redraw(true)
end)

function abortAllStealthKills(targetPlayer)
    cancelEvent()
end
addEventHandler("onClientPlayerStealthKill", getLocalPlayer(), abortAllStealthKills)


function syncEQWeaponsOnFire(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
--	outputChatBox("syncEQWeaponsOnFire " .. weapon .. " " .. ammo)
	if (not (weapon>0)) then return end
	local subtype=nil
	if (weapon==41) then-- spray
	  subtype=tonumber(getElementData(localPlayer,"spray:color"))
	end
	for i,v in ipairs(EQ) do
		if (v.itemid and (not ammoWeapons[v.wepid] or ammoWeapons[v.wepid]==v.itemid) and v.wepid and v.wepid==weapon and (not subtype or v.subtype==subtype)) then
			if (ammo<=0) then
				eq_removeByIndex(i)
				eq_redraw(true)
				eq_sync()
				return
			end
			
			if (v.itemid==148) and (weapon==16) then
				if v.subtype == 1 then
					v.count=ammo
					eq_redraw(true)
					return true
				elseif v.subtype == 2 then
					v.count=ammo
					eq_redraw(true)
					return true
				end
			else
				v.count=ammo
			end
			
			eq_redraw(true)
			if (math.random(1,3)==1) then eq_sync() end
			return
		end
	end
end

addEventHandler ( "onClientPlayerWeaponFire", localPlayer, syncEQWeaponsOnFire )

eq_item_mapa={}
eq_item_mapa.scale=1
eq_item_mapa.win=guiCreateWindow(0.1,0.1,1.3,1.3,"Mapa",true)                                                                                                  
eq_item_mapa.bgimg=guiCreateStaticImage(0,0,1,1,"img/bgcolor.png", true, eq_item_mapa.win)
eq_item_mapa.img=guiCreateStaticImage(0,0,20,20,"img/EQ_mapa_duza.jpg", true, eq_item_mapa.win)
guiSetSize(eq_item_mapa.win,0.8,0.7,true)
guiSetVisible(eq_item_mapa.win,false)

eq_item_nav={}
eq_item_nav.img= guiCreateStaticImage(0.02,0.40,0.18,0.35,"img/nav.png",true)
eq_item_nav.displbl = guiCreateLabel(0.17,0.23,0.66,0.3375,"Brak podanego celu.",true,eq_item_nav.img)
guiLabelSetColor(eq_item_nav.displbl,0,0,0)
guiLabelSetHorizontalAlign(eq_item_nav.displbl,"left", true)
guiSetFont(eq_item_nav.displbl, "default-small")
guiSetVisible(eq_item_nav.img,false)


local nav_cel={ }

function eq_item_nav_turnOff()
    nav_cel={}
    guiSetVisible(eq_item_nav.img,false)
    guiSetText(eq_item_nav.displbl,"Brak podanego celu.")
end

function eq_item_nav_clear()
    nav_cel={}
    guiSetText(eq_item_nav.displbl,"Brak podanego celu.")
end



function eq_item_nav_refresh()
    if (not guiGetVisible(eq_item_nav.img)) then return end
    if (not nav_cel[1]) then return end
    local x,y,z=getElementPosition(localPlayer)

    local tx, ty = getWorldFromScreenPosition(sw * 0.5, sh * 0.5, 100)
    local cx, cy = getCameraMatrix()
    local cameraAngle = findRotation(tx, ty, cx,cy)
    local kat=cameraAngle-findRotation(nav_cel[1],nav_cel[2],x,y)+270
    dxDrawImage(sw*0.9/10,sh*1.1/2, 32,32, "img/arrow.png", kat,0,0,tocolor(255,255,255),true)
    local odleglosc=getDistanceBetweenPoints3D(x,y,z,nav_cel[1],nav_cel[2],nav_cel[3])
    dxDrawText(string.format("%dm", odleglosc), sw*0.02, sh*1.1/2+32,sw*0.20,sh, tocolor(255,255,255), 1, "default", "center", "top", false, false, true)
end

eq_item_pda={}
eq_item_pda.img= guiCreateStaticImage(0.56,0.2313,0.45,0.65,"img/pda.png",true)
eq_item_pda.displbl = guiCreateLabel(0.17,0.23,0.66,0.3375,"Terminal miejski.\n\nTylko do użytku przez służby miejskie i policję.\n\nW przypadku znalezienia, zwrócić w najbliższym komisariacie.",true,eq_item_pda.img)


guiLabelSetColor(eq_item_pda.displbl,0,0,0)
guiLabelSetHorizontalAlign(eq_item_pda.displbl,"left", true)
guiSetFont(eq_item_pda.displbl, "default-small")
eq_item_pda.btn_scan = guiCreateButton(0.10,0.73,0.25,0.09,"Skanuj pojazd", true, eq_item_pda.img)
eq_item_pda.btn_fscan = guiCreateButton(0.65,0.73,0.25,0.09,"Skanuj odciski", true, eq_item_pda.img)

eq_item_pda.vehscan_timer=nil
eq_item_pda.fscan_timer=nil

function eq_item_pda_startVehicleScan()
    guiSetText(eq_item_pda.displbl,"Trwa odczytywanie danych pojazdu.")
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " używa PDA.", 5, 15, true)
    if (isTimer(eq_item_pda.vehscan_timer)) then
	    killTimer(eq_item_pda.vehscan_timer)
    end
    if (isTimer(eq_item_pda.fscan_timer)) then
	    killTimer(eq_item_pda.fscan_timer)
    end
    
    setTimer(eq_item_pda_vehicleScan, 4000, 1, 1)
end

function eq_item_pda_startFingerprintScan()
    guiSetText(eq_item_pda.displbl,"Trwa skanowanie i poszukiwanie odcisków palców...")
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " używa PDA.", 5, 15, true)
    if (isTimer(eq_item_pda.fscan_timer)) then
	    killTimer(eq_item_pda.fscan_timer)
    end
    if (isTimer(eq_item_pda.vehscan_timer)) then
	    killTimer(eq_item_pda.vehscan_timer)
    end
    setTimer(eq_item_pda_fingerprintScan, 4000, 1, 1)
end

addEventHandler("onClientGUIClick", eq_item_pda.btn_scan, eq_item_pda_startVehicleScan, false)
addEventHandler("onClientGUIClick", eq_item_pda.btn_fscan, eq_item_pda_startFingerprintScan, false)
guiSetVisible(eq_item_pda.img,false)


function eq_item_pda_vehicleScan(step)
    if (step==1) then

	    local x,y,z=getElementPosition(localPlayer)
	    local veh=nil
	    local veh_dist=nil
	    for i,v in ipairs(getElementsByType("vehicle",root,true)) do
		local px,py,pz=getElementPosition(v)
		local tmp_veh_dist=getDistanceBetweenPoints3D(x,y,z,px,py,pz)
		if(tmp_veh_dist<10 and (not veh_dist or veh_dist>tmp_veh_dist)) then
		    veh=v
		    veh_dist=tmp_veh_dist
		end
	    end

	    if (not veh) then
		    guiSetText(eq_item_pda.displbl,"Nie udało się odczytać danych.\n\nPodejdź do tablicy rejestracyjnej/tablicy znamionowej pojazdu i ponownie uruchom skanowanie.")
		    return
	    end
	    
	    local dbid=getElementData(veh,"dbid")
	    if (not dbid) then
		    guiSetText(eq_item_pda.displbl,"Pojazd " .. getVehicleName(veh) .."\n\nPOJAZD NIE POSIADA NUMEROW SERYJNYCH lub zostały celowo zamazane!\n\nNatychmiast odholować na parking policyjny lub powiadomić policję!")
		    return
	    end
	    
	    guiSetText(eq_item_pda.displbl,"Znaleziono pojazd, model: " .. getVehicleName(veh) .. "\n\nNr rejestracyjny: " .. tostring(dbid).."\n\nTrwa pobieranie informacji z bazy miejskiej.")
	    triggerServerEvent("onPDARequestVehicleInformation", localPlayer, veh)
    end
end


function eq_item_pda_fingerprintScan(step)
    if (step==1) then

	    local x,y,z=getElementPosition(localPlayer)
	    local veh=nil
	    local veh_dist=nil
	    for i,v in ipairs(getElementsByType("vehicle",root,true)) do
		local px,py,pz=getElementPosition(v)
		local tmp_veh_dist=getDistanceBetweenPoints3D(x,y,z,px,py,pz)
		if(tmp_veh_dist<10 and (not veh_dist or veh_dist>tmp_veh_dist)) then
		    veh=v
		    veh_dist=tmp_veh_dist
		end
	    end

	    if (not veh) then
		    guiSetText(eq_item_pda.displbl,"Nie udało się zeskanować żadnych odcisków palców.")
		    return
	    end
	    local fp1=getElementData(veh,"fingerprint:1") or "-"
	    local fp2=getElementData(veh,"fingerprint:2") or "-"
	    local fp3=getElementData(veh,"fingerprint:3") or "-"	    
	    local fp4=getElementData(veh,"fingerprint:4") or "-"
	    local fp5=getElementData(veh,"fingerprint:5") or "-"

	    guiSetText(eq_item_pda.displbl,"Odczytane odciski palcow:\n\n1. "..fp1.."\n2. "..fp2.."\n3. "..fp3.."\n4. "..fp4.."\n5. "..fp5)


    end
end

addEvent("onPDAReturnInformation", true)
addEventHandler("onPDAReturnInformation", root, function(dane) guiSetText(eq_item_pda.displbl,dane) end)


function eq_item_mapa_resize()

    guiSetProperty(eq_item_mapa.img, "UnifiedSize", string.format("{{%.1f,0},{%.1f,0}}",eq_item_mapa.scale,eq_item_mapa.scale))	 -- dziala    
    -- polozenie
--    local x,y=getElementPosition(localPlayer)
--    guiSetProperty(eq_item_mapa.img, "UnifiedPosition", "{{-0.1,0},{-0.1,0}}")
end
addEventHandler("onClientGUISize", eq_item_mapa.win, eq_item_mapa_resize)

--[[
function eq_item_mapa_scale(upordown)
--    outputChatBox(tostring(upordown))
    if upordown>0 then
	eq_item_mapa.scale=eq_item_mapa.scale+10
    elseif (eq_item_mapa.scale>1) then
	eq_item_mapa.scale=eq_item_mapa.scale-10
    end
    if (eq_item_mapa.scale<1) then
	eq_item_mapa.scale=1
    end
    eq_item_mapa_resize()
end
addEventHandler("onClientMouseWheel", eq_item_mapa.img, eq_item_mapa_scale)
]]--
eq_item_mapa_resize()
function eq_item_mapa_toggle()
    guiSetVisible(eq_item_mapa.win, not guiGetVisible(eq_item_mapa.win))
end

function eq_item_papieros_koniec()
    setElementData(localPlayer, "papieros",false)
    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " kończy palić papierosa", 3, 20, true)
end

function eq_getBTNIdx(gui_button)
    for i,v in ipairs(EQ) do
	if (source==v.g_btn2) then return i end
    end
    return nil
end

local last_clicked_btn=nil
local last_ctrl_clicked_btn=nil
local last_clicked_time=getTickCount()

function oipumEffect()
	if oipumTick >= 100 then
	
		if oipumMinus then
			if oipumState == "r" then
				oipumColor.r = oipumColor.r-1
				
				if oipumColor.r == 255 then
					oipumMinus = true
				elseif oipumColor.r == 0 then
					oipumMinus = false
					oipumState = "g"
				end
				
			elseif oipumState == "g" then
				oipumColor.g = oipumColor.g-1
				
				if oipumColor.g == 255 then
					oipumMinus = true
				elseif oipumColor.g == 0 then
					oipumMinus = false
					oipumState = "b"
				end
				
			elseif oipumState == "b" then
				oipumColor.b = oipumColor.b-1
				
				if oipumColor.b == 255 then
					oipumMinus = true
				elseif oipumColor.b == 0 then
					oipumMinus = false
					oipumState = "r"
				end
				
			end
			
		else
			if oipumState == "r" then
				oipumColor.r = oipumColor.r+1
				
				if oipumColor.r == 255 then
					oipumMinus = true
				elseif oipumColor.r == 0 then
					oipumMinus = false
					oipumState = "g"
				end
				
			elseif oipumState == "g" then
				oipumColor.g = oipumColor.g+1
				
				if oipumColor.g == 255 then
					oipumMinus = true
				elseif oipumColor.g == 0 then
					oipumMinus = false
					oipumState = "b"
				end
				
			elseif oipumState == "b" then
				oipumColor.b = oipumColor.b+1
				
				if oipumColor.b == 255 then
					oipumMinus = true
				elseif oipumColor.b == 0 then
					oipumMinus = false
					oipumState = "r"
				end
				
			end
		end

		dxDrawRectangle(0, 0, w, h, tocolor(oipumColor.r, oipumColor.g, oipumColor.b, 180))
		oipumTick = getTickCount()
	end
end

function eq_btnclick(button,state)
	if (getElementHealth(localPlayer)==0) then return end
	if (isPedDoingGangDriveby(localPlayer)) then panel_hide() return end

    if getTickCount()-last_clicked_time<500 then return end


    -- button
    -- szukamy przycisku ktory gracz wcisnal
    local btnidx=eq_getBTNIdx(source)
    if (not btnidx) then return end

    if (getKeyState("lctrl") and not getKeyState("lshift")) then
        if not last_ctrl_clicked_btn or (last_ctrl_clicked_btn or -1)==btnidx or getTickCount()-last_clicked_time>6000 then
          if (not EQ[btnidx].itemid or EQ[btnidx].itemid<1) then return end	-- kliknieto pusty przycisk
          outputChatBox("Przytrzymaj CTRL i kliknij w miejsce, w które chcesz przenieść przedmiot.",255,0,0)
          last_ctrl_clicked_btn=btnidx
          last_clicked_time=getTickCount()
          return
        end
        if (last_ctrl_clicked_btn and last_ctrl_clicked_btn~=btnidx and getTickCount()-last_clicked_time<6000) then
          outputDebugString("zzz")
          outputDebugString("zamieniamy "..btnidx .. " z " .. last_ctrl_clicked_btn)
          -- zamieniamy itemy miejscami

          EQ[btnidx].itemid, EQ[btnidx].count, EQ[btnidx].subtype,           EQ[last_ctrl_clicked_btn].itemid, EQ[last_ctrl_clicked_btn].count, EQ[last_ctrl_clicked_btn].subtype =           EQ[last_ctrl_clicked_btn].itemid, EQ[last_ctrl_clicked_btn].count, EQ[last_ctrl_clicked_btn].subtype,          EQ[btnidx].itemid, EQ[btnidx].count, EQ[btnidx].subtype
          eq_fillMetaInfo(EQ[btnidx])
          eq_fillMetaInfo(EQ[last_ctrl_clicked_btn])
          last_ctrl_clicked_btn=nil
          eq_sync()
          eq_redraw()
          last_clicked_time=getTickCount()
        end
        return
    end
    if (not EQ[btnidx].itemid or EQ[btnidx].itemid<1) then return end	-- kliknieto pusty przycisk

    last_clicked_time=getTickCount()

	if (getKeyState("lctrl") and getKeyState("lshift")) then
		if (not last_clicked_btn or last_clicked_btn~=btnidx) then
			outputChatBox("Kliknij znowu (trzymając lshift i lctrl) aby wyrzucić ten przedmiot z ekwipunku.",255,0,0,true)
			last_clicked_btn=btnidx
			return
		end
--		last_clicked_btn=nil
--		outputChatBox   ("Wyrzucasz przedmiot.")
		if EQ[btnidx].count%1 ~= 0 then
		  outputChatBox("Nie możesz wyrzucić zbugowanego przedmiotu.",255,0,0,true)
		  return	
		end
		triggerServerEvent("onItemDrop", localPlayer, EQ[btnidx].itemid, EQ[btnidx].subtype, EQ[btnidx].name)
		eq_takeItem(EQ[btnidx].itemid, 1, EQ[btnidx].subtype)
        triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyrzuca coś.", 3,15, true)
        return
    end

    last_clicked_btn=nil
    -- podejmujemy akcje w zaleznosci od rodzaju przedmiotu
    if (EQ[btnidx].itemid==1) then -- papierosy
	-- todo animacji, hold
	if (getElementData(localPlayer,"papieros")) then
		outputChatBox("Palisz już papierosa.", 255,0,0,true)
		return
	end
	if (getElementData(localPlayer,"joint")) then
			outputChatBox("Palisz już jointa.", 255,0,0,true)
			return
	end
	if (getElementData(localPlayer,"cygaro")) then
			outputChatBox("Palisz już cygaro.", 255,0,0,true)
			return
	end

	
	eq_takeItem(1, 1)
	triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " odpala papierosa.", 3, 20, true)
	triggerServerEvent("onPapieros", localPlayer)
	setElementData(localPlayer, "papieros", true)
--	setElementData(localPlayer,"papieros", true)
--	setTimer(eq_item_papieros_koniec, 60000, 1)
	-- aqq
	elseif (EQ[btnidx].itemid==2) then -- aparat
		if (getPedWeapon(localPlayer)==43) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa aparat.", 3, 15, true)
		else
			triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, EQ[btnidx].count } }, 9 )
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga aparat.", 3, 15, true)
		end

    elseif (EQ[btnidx].itemid==3) then	-- ZETON
	triggerEvent("onCaptionedEvent", resourceRoot, "Żetony służą do gry w kasynie.", 2)
    elseif (EQ[btnidx].itemid==4) then	-- MAPA
	eq_item_mapa_toggle()
    elseif (EQ[btnidx].itemid==5) then	-- APIRYNA
		triggerEvent("onCaptionedEvent", resourceRoot, "Zażywasz aspirynę.", 2)	
		eq_takeItem(5, 1)	
		local hp=getElementHealth(localPlayer)
		if (hp<10) then
		    hp=hp+10
		    if (hp>10) then hp=10 end
		    setElementHealth(localPlayer, hp)
		end
    elseif (EQ[btnidx].itemid==7) then -- PDA
		guiSetVisible(eq_item_pda.img, not guiGetVisible(eq_item_pda.img))
		if (guiGetVisible(eq_item_pda.img)) then
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga PDA.", 5, 15, true)
		else
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa PDA.", 5, 15, true)	
		end
		guiSetText(eq_item_pda.displbl,"Terminal miejski.\n\nTylko do użytku przez służby miejskie i policję.\n\nW przypadku znalezienia, zwrócić w najbliższym komisariacie.")
    elseif (EQ[btnidx].itemid==8) then
		triggerEvent("onCaptionedEvent", resourceRoot, "Piękna ryba, tylko że surowa.", 2)
		return
    elseif (EQ[btnidx].itemid==10) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zjada wędzoną rybę.", 3, 20, true)
		eq_takeItem(10, 1)	
		local hp=getElementHealth(localPlayer)
		if (hp<60) then
			hp=hp+30
			if (hp>60) then hp=60 end
			setElementHealth(localPlayer, hp)
		end
		modifySatiation(25)
    elseif (EQ[btnidx].itemid==13) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga jakieś rzeczy z kieszeni.", 3, 15, true)
		outputChatBox("Kwity możesz zamienić na gotówkę w urzędzie miasta.")
		return
    elseif (EQ[btnidx].itemid==15) then -- paczka
		-- pobieramy od zasobu lss-kurierzy informacje o miejscu dostarczenia paczki
		triggerServerEvent("onPlayerRequestPackageInfo", localPlayer, EQ[btnidx].subtype)
		if (not eq_getItemByID(16)) then
		    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " ogląda paczkę.", 5, 15, true)
		else
		    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wprowadza dane z paczki do swojej nawigacji.", 5, 15, true)
		end
    elseif (EQ[btnidx].itemid==16) then -- nawigacja
	    toggleControl("radar",true)
	    showPlayerHudComponent("radar", true)
		guiSetVisible(eq_item_nav.img, not guiGetVisible(eq_item_nav.img))
		if (guiGetVisible(eq_item_nav.img)) then
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga nawigację GPS.", 5, 15, true)
			addEventHandler("onClientRender", getRootElement(), eq_item_nav_refresh)
		else
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa nawigację GPS.", 5, 15, true)	
			removeEventHandler("onClientRender", getRootElement(), eq_item_nav_refresh)
		end
    elseif (EQ[btnidx].itemid==17) then -- prawo jazdy
	--	triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga jakieś rzeczy z kieszeni.", 3, 15, true)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga prawo jazdy.", 3, 15, true)
		triggerServerEvent("requestDLDetails", localPlayer, tonumber(EQ[btnidx].subtype))
	--	outputChatBox("Prawo jazdy - niestety nazwisko się rozmazało i nie możesz odczytać.")
    elseif (EQ[btnidx].itemid==18) then -- narkotyki
		eq_takeItem(18, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wciąga coś.", 3, 15, true)
		drug_inject(1)
    elseif (EQ[btnidx].itemid==116) then -- narkotyki
		eq_takeItem(116, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wstrzykuje coś.", 3, 15, true)
		drug_inject(2)
    elseif (EQ[btnidx].itemid==19) then -- gazeta
		news_read(EQ[btnidx].subtype)
    elseif (EQ[btnidx].itemid==21) then -- telefon
		telefon_toggle(EQ[btnidx].subtype)
	elseif (EQ[btnidx].itemid==22) then -- alkohol:drink
		alkohol_wypij(1)
		eq_takeItem(22, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wypija drinka.", 3, 15, true)
		modifySatiation(math.random(-1,1))
	elseif (EQ[btnidx].itemid==25) then -- spray
		if (getPedWeapon(localPlayer)==41) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa spray.", 3, 15, true)
			setElementData(localPlayer,"drawtag:spraymode", "none")
		else
			triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, EQ[btnidx].count } }, 9 )
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga spray.", 3, 15, true)
			local c=getElementData(localPlayer,"character")
			if not c then return end
			if (tonumber(c.ab_spray or 0)<50) then
			  setElementData(localPlayer,"drawtag:spraymode", "none")
			else
				if (EQ[btnidx].subtype==0xFFFFFF) then
					setElementData(localPlayer,"drawtag:spraymode", "erase")
				else
					setElementData(localPlayer,"drawtag:spraymode", "draw")
				end
			end
			setElementData(localPlayer,"spray:color", EQ[btnidx].subtype)
		end
		
		if (getElementData(localPlayer,"papieros")) then
			outputChatBox("Palisz już papierosa.", 255,0,0,true)
			return
		end
		if (getElementData(localPlayer,"joint")) then
			outputChatBox("Palisz już jointa.", 255,0,0,true)
			return
		end
	elseif (EQ[btnidx].itemid==95) then -- cygaro
		if (getElementData(localPlayer,"cygaro")) then
			outputChatBox("Palisz już cygaro.", 255,0,0,true)
			return
		end

	elseif (EQ[btnidx].itemid==27) then -- joint		
		eq_takeItem(27, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " odpala jointa.", 3, 20, true)
		triggerServerEvent("onJoint", localPlayer)
		setElementData(localPlayer, "joint", true)
		modifySatiation(-2)
	elseif (EQ[btnidx].itemid==95) then -- cygaro
		eq_takeItem(95, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " odpala cygaro.", 3, 20, true)
		triggerServerEvent("onCygaro", localPlayer)
		setElementData(localPlayer, "cygaro", true)
	elseif (EQ[btnidx].itemid==30) then -- glock
		if (getPedWeapon(localPlayer)==22) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa glocka.", 3, 15, true)
		else
			local pestki = eq_getItemByID(145) or false
			if pestki then
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, pestki.count } }, 2 )
			else
				
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, -1 } }, 2 )
			end
--			setPedWeaponSlot(localPlayer, 2)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga glocka.", 3, 15, true)
		end
	elseif (EQ[btnidx].itemid==31) then -- baseball
		if (getPedWeapon(localPlayer)==5) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa baseball.", 3, 15, true)
		else
			triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, EQ[btnidx].count } }, 1 )
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga baseball.", 3, 15, true)
		end

	elseif (EQ[btnidx].itemid==32) then -- mikrofon-wibrator
		if (getPedWeapon(localPlayer)==2) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa mikrofon.", 3, 15, true)
		else
			triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, EQ[btnidx].count } }, 1)
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga mikrofon.", 3, 15, true)
		end

	elseif (EQ[btnidx].itemid==33) then --pałka
		if (getPedWeapon(localPlayer)==3) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa pałkę.", 3, 15, true)
		else
			triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, EQ[btnidx].count } }, 1 )
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga pałkę.", 3, 15, true)
		end
    elseif (EQ[btnidx].itemid==34) then -- narkotyki:grzybki
		eq_takeItem(34, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " połyka coś.", 3, 15, true)
		drug_inject(2)
		modifySatiation(-5)
	elseif (EQ[btnidx].itemid==35) then
		outputChatBox("(( Pager pozwala otrzymywac zgłoszenia od obywateli. ))")
--		outputChatBox("(( 999 - pogotowie, 998 - straż pożarna, 997 - policja ))")
		outputChatBox("(( 112 - alarmowy, 990 - pomoc drogowa, 9696 - taxi, 313 - departament turystyki, 9292 - cnn news ))")
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " sprawdza swój pager.", 3, 15, true)
	elseif (EQ[btnidx].itemid==36) then --gasnica
		if (getPedWeapon(localPlayer)==42) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa gaśnicę.", 3, 15, true)
		else
			triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, EQ[btnidx].count } }, 9 )
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga gaśnicę.", 3, 15, true)
		end
    elseif (EQ[btnidx].itemid==37) then	-- zastrzyk
	if (EQ[btnidx].subtype==1) then	-- morfina
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " robi sobie zastrzyk.", 3, 10, true)
		eq_takeItem(37, 1, EQ[btnidx].subtype)
		local hp=getElementHealth(localPlayer)
		hp=hp+25
		if (hp>100) then hp=100 end
		setElementHealth(localPlayer, hp)
		modifySatiation(3)
	end
    elseif (EQ[btnidx].itemid==38 and EQ[btnidx].subtype<0) then -- list do dostarczenia
	-- pobieramy od zasobu lss-poczta informacje o miejscu dostarczenia listu

	if (not eq_getItemByID(16)) then
	    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " ogląda list.", 5, 15, true)
	else
	    triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wprowadza dane z listu do swojej nawigacji.", 5, 15, true)
	end
	triggerServerEvent("onPlayerRequestMailInfo", localPlayer, EQ[btnidx].subtype)

	elseif (EQ[btnidx].itemid==42) then -- alkohol:piwo
		eq_takeItem(42, 1)
		alkohol_wypij(2)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wypija piwo.", 3, 15, true)
		modifySatiation(3)
	elseif (EQ[btnidx].itemid==82) then -- alkohol:whiskey
		eq_takeItem(82, 1)
		alkohol_wypij(3)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wypija whiskey.", 3, 15, true)
		modifySatiation(1)
	elseif (EQ[btnidx].itemid==43) then -- szkicownik
		local show = not exports.drawtag:isDrawingWindowVisible()
		exports.drawtag:showDrawingWindow(show)
		if show then
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga szkicownik.", 3, 15, true)
		else
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa szkicownik.", 3, 15, true)
		end
	elseif (EQ[btnidx].itemid==45) then -- miotacz
		if (getPedWeapon(localPlayer)==37) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa miotacz.", 3, 15, true)
		else
			triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, EQ[btnidx].count } }, 7 )
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga miotacz płomieni.", 3, 15, true)
		end
    elseif (EQ[btnidx].itemid==46) then -- dowód osobisty
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga dowód osobisty.", 3, 15, true)
		triggerServerEvent("requestPCDetails", localPlayer, tonumber(EQ[btnidx].subtype))
	elseif (EQ[btnidx].itemid==47) then	-- notatnik/notatka
		if (EQ[btnidx].subtype and tonumber(EQ[btnidx].subtype)>0) then
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga z kieszeni notatkę.", 3, 15, true)
			exports["lss-notatki"]:notatka_pokaz(EQ[btnidx].subtype)
		else
			exports["lss-notatki"]:notatka_stworz()
--			outputChatBox("(( notatnik w przygotowaniu ))")
		end
	elseif (EQ[btnidx].itemid==58) then -- kwiaty
		if (getPedWeapon(localPlayer)==14) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa kwiaty.", 3, 15, true)
		else
			triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, EQ[btnidx].count } }, 10)
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga kwiaty.", 3, 15, true)
		end
	elseif (EQ[btnidx].itemid==109) then -- shotgun
		if (getPedWeapon(localPlayer)==25) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa shotguna.", 3, 15, true)
		else
			local pestki = eq_getItemByID(131) or false
			if pestki then
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, pestki.count } }, 3 )
			else
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, -1 } }, 3 )
			end
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga shotguna.", 3, 15, true)
		end		
	elseif (EQ[btnidx].itemid==63) then -- plyta CD
		exports["lss-muzyka"]:eq_plyta(EQ[btnidx].subtype)
	elseif (EQ[btnidx].itemid==64) then -- moneta
		local strony={"orzeł","reszka"}
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " rzuca monetą.", 3, 10, true)
		local rzut=strony[math.random(1,2)]
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, "Wypada "..rzut..".", 3, 15, true)
	elseif (EQ[btnidx].itemid==65) then -- kostka do gry
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " rzuca kostką do gry.", 3, 10, true)
		local rzut=math.random(1,6)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, "Wypada "..rzut..".", 3, 15, true)
	elseif (EQ[btnidx].itemid==74) then --pila spalinowa
		if (getPedWeapon(localPlayer)==9) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa piłę.", 3, 15, true)
		else
			triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, EQ[btnidx].count } }, 1 )
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga piłę spalinową.", 3, 15, true)
			outputChatBox("(( Informacja OOC: zabicie innego gracza z uzyciem pily spalinowej = automatyczny ban ))", 140, 140, 140)
		end
	elseif (EQ[btnidx].itemid==81) then -- noz
		if (getPedWeapon(localPlayer)==4) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa nóż.", 3, 15, true)
		else
			triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, EQ[btnidx].count } }, 1)
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga nóż.", 3, 15, true)
		end
	elseif (EQ[btnidx].itemid==76) then --pacholek
		exports["lss-worlditems"]:postawPacholek()
	elseif (EQ[btnidx].itemid==83) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zjada pizzę.", 3, 20, true)
		eq_takeItem(83, 1)	
		modifySatiation(25)
	elseif (EQ[btnidx].itemid==84) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wypija colę.", 3, 20, true)
		eq_takeItem(84, 1)	
		modifySatiation(2)
	elseif (EQ[btnidx].itemid==85) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wypija sok.", 3, 20, true)
		eq_takeItem(85, 1)	
		modifySatiation(25)
	elseif (EQ[btnidx].itemid==86) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zjada chleb.", 3, 20, true)
		eq_takeItem(86, 1)	
		modifySatiation(12)
	elseif (EQ[btnidx].itemid==87) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wypija wodę.", 3, 20, true)
		eq_takeItem(87, 1)	
		local hp=getElementHealth(localPlayer)
		if (hp<50) then
			hp=hp+2
			if (hp>50) then hp=50 end
			setElementHealth(localPlayer, hp)
		end
		modifySatiation(5)
	elseif (EQ[btnidx].itemid==88) then
	triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zjada hot-doga.", 3, 20, true)
		eq_takeItem(88, 1)	
		modifySatiation(15)
	elseif (EQ[btnidx].itemid==89) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zjada frytki.", 3, 20, true)
		eq_takeItem(89, 1)	
		modifySatiation(10)
	elseif (EQ[btnidx].itemid==90) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zjada batona.", 3, 20, true)
		eq_takeItem(90, 1)	
		modifySatiation(25)
	elseif (EQ[btnidx].itemid==91) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zjada owoc.", 3, 20, true)
		eq_takeItem(91, 1)	
		modifySatiation(5)
	elseif (EQ[btnidx].itemid==93) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zużywa kawałek papieru.", 3, 20, true)
		return
	elseif (EQ[btnidx].itemid==94) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " używa spirytus.", 3, 20, true)
		return
	elseif (EQ[btnidx].itemid==96) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zjada rybkę z konserwy.", 3, 20, true)
		eq_takeItem(96, 1)	
		modifySatiation(20)
	elseif (EQ[btnidx].itemid==97) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " używa ręcznika.", 3, 20, true)
		return
	elseif (EQ[btnidx].itemid==98) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zjada porcję lodów.", 3, 20, true)
		eq_takeItem(98, 1)	
		modifySatiation(5)
	elseif (EQ[btnidx].itemid==99) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zjada szaszłyka.", 3, 20, true)
		eq_takeItem(99, 1)	
		modifySatiation(5)
		
--[[
	elseif (EQ[btnidx].itemid==146) then
		if getElementData(localPlayer, "plecak") then
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zdejmuje plecak.", 3, 20, true)
			triggerServerEvent("torbaOff", localPlayer)
		else
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zakłada plecak.", 3, 20, true)
			triggerServerEvent("torbaOn", localPlayer,2752)
		end
		return
	elseif (EQ[btnidx].itemid==147) then
		if getElementData(localPlayer, "plecak") then
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zdejmuje torebkę.", 3, 20, true)
			triggerServerEvent("torbaOff", localPlayer)
		else
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zakłada torebkę.", 3, 20, true)
			triggerServerEvent("torbaOn", localPlayer,2437)
		end
		return
--]]
	elseif (EQ[btnidx].itemid==146) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " spogląda na...", 3, 20, true)
		return
	elseif (EQ[btnidx].itemid==147) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " spogląda na...", 3, 20, true)
		return
	elseif (EQ[btnidx].itemid==100) then
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zażywa miętowego dropsa.", 3, 20, true)
		eq_takeItem(100, 1)	
		modifySatiation(math.random(0,1))
	elseif (EQ[btnidx].itemid==104) then -- spadochron
		if (getPedWeapon(localPlayer)==46) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa spadochron.", 3, 15, true)
		else
			triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, EQ[btnidx].count } }, 11 )
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga spadochron.", 3, 15, true)
		end
	elseif (EQ[btnidx].itemid==105) then -- kominiarka
		triggerServerEvent("kominiarkaAction", localPlayer)
	elseif (EQ[btnidx].itemid==107) then -- fajerwerki
		triggerServerEvent("odpalFajerke", localPlayer)
		eq_takeItem(107, 1)	
	elseif (EQ[btnidx].itemid==108) then
		outputChatBox("(( Aby skorzystać z megafonu, użyj /m tekst ))")


	elseif (EQ[btnidx].itemid==111) then -- paralizator
		if (getPedWeapon(localPlayer)==23) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa paralizator.", 3, 15, true)
		else
			local pestki = eq_getItemByID(133) or false
			if pestki then
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, pestki.count } }, 2 )
			else
				
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, -1 } }, 2 )
			end
--			setPedWeaponSlot(localPlayer, 2)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga paralizator.", 3, 15, true)
		end

	elseif (EQ[btnidx].itemid==110) then -- deagle
		if (getPedWeapon(localPlayer)==24) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa pistolet.", 3, 15, true)
		else
			local pestki = eq_getItemByID(132) or false
			if pestki then
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, pestki.count } }, 2 )
			else
				
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, -1 } }, 2 )
			end
--			setPedWeaponSlot(localPlayer, 2)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga pistolet.", 3, 15, true)
		end
	elseif (EQ[btnidx].itemid==112) then -- uzi
		if (getPedWeapon(localPlayer)==28) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa UZI.", 3, 15, true)
		else
			local pestki = eq_getItemByID(134) or false
			if pestki then
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, pestki.count } }, 4 )
			else
				
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, -1 } }, 4 )
			end
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga UZI.", 3, 15, true)
		end
	elseif (EQ[btnidx].itemid==113) then -- karabin szkoleniowy
		if (getPedWeapon(localPlayer)==30) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa karabin.", 3, 15, true)
		else
			local pestki = eq_getItemByID(135) or false
			if pestki then
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, pestki.count } }, 5 )
			else
				
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, -1 } }, 5 )
			end
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga karabin.", 3, 15, true)
		end
	elseif (EQ[btnidx].itemid==114) then -- MP5
		if (getPedWeapon(localPlayer)==29) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa MP5.", 3, 15, true)
		else
			local pestki = eq_getItemByID(136) or false
			if pestki then
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, pestki.count } }, 4 )
			else
				
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, -1 } }, 4 )
			end
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga MP5.", 3, 15, true)
		end
	elseif (EQ[btnidx].itemid==115) then -- M4
		if (getPedWeapon(localPlayer)==31) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa M4.", 3, 15, true)
		else
		
			local pestki = eq_getItemByID(130) or false
			if pestki then
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, pestki.count } }, 5 )
			else
				
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, -1 } }, 5 )
			end
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga M4.", 3, 15, true)
		end
	elseif (EQ[btnidx].itemid==137) then -- dopalacze
		if getElementData(localPlayer, "newdrugs") then outputChatBox("(( Nie możesz wziąć więcej narkotyków! ))", 255, 0, 0) return false end
		eq_takeItem(137, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zażywa dopalacze.", 3, 15, true)
		newDrug_inject(1)
	elseif (EQ[btnidx].itemid==138) then -- kakanina
		if getElementData(localPlayer, "newdrugs") then outputChatBox("(( Nie możesz wziąć więcej narkotyków! ))", 255, 0, 0) return false end
		eq_takeItem(138, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zażywa kokainę.", 3, 15, true)
		newDrug_inject(2)
	elseif (EQ[btnidx].itemid==139) then -- amtefamina
		if getElementData(localPlayer, "newdrugs") then outputChatBox("(( Nie możesz wziąć więcej narkotyków! ))", 255, 0, 0) return false end
		eq_takeItem(139, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zażywa amtefaminę.", 3, 15, true)
		newDrug_inject(3)
	elseif (EQ[btnidx].itemid==140) then -- lds
		if getElementData(localPlayer, "newdrugs") then outputChatBox("(( Nie możesz wziąć więcej narkotyków! ))", 255, 0, 0) return false end
		eq_takeItem(140, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zażywa LDS.", 3, 15, true)
		newDrug_inject(4)
		triggerEvent("onGUIOptionChange", root, "motionblur", true)
		setElementData(localPlayer, "drunkLevel", 10)
		setElementData(localPlayer, "colorLevel", -10)
	elseif (EQ[btnidx].itemid==141) then -- oipum
		if getElementData(localPlayer, "newdrugs") then outputChatBox("(( Nie możesz wziąć więcej narkotyków! ))", 255, 0, 0) return false end
		eq_takeItem(141, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zażywa oipum.", 3, 15, true)
		setSunColor(0,0,0,0,0,0)
		setWaterColor(255,0,0)
		w,h = guiGetScreenSize()
		oipumTick = getTickCount()
		oipumColor.r = 0
		oipumColor.g = 0
		oipumColor.b = 0
		oipumState = "r"
		addEventHandler("onClientRender", getRootElement(), oipumEffect)
		setTimer(function(plr)
			setElementData(plr, "newdrugs", false)
			resetWaterColor()
			resetSunColor()
			removeEventHandler("onClientRender", getRootElement(), oipumEffect)
		end, 1200000, 1, localPlayer)
	elseif (EQ[btnidx].itemid==148) then --granat
		if (getPedWeapon(localPlayer)==16) then
			setPedWeaponSlot(localPlayer, 0)
			if EQ[btnidx].subtype == 1 then
				triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa granat hukowy.", 3, 15, true)
			elseif EQ[btnidx].subtype == 2 then
				triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa granat dymny.", 3, 15, true)
			end
		else
			triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, EQ[btnidx].count } }, 8 )
--			setPedWeaponSlot(localPlayer, 1)
			if EQ[btnidx].subtype == 1 then
				triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga granat hukowy.", 3, 15, true)
				setElementData(localPlayer, "granat", "hukowy")
			elseif EQ[btnidx].subtype == 2 then
				triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga granat dymny.", 3, 15, true)
				setElementData(localPlayer, "granat", "dymny")
			end
		end
	elseif (EQ[btnidx].itemid==142) then -- metamtefamina
		if getElementData(localPlayer, "newdrugs") then outputChatBox("(( Nie możesz wziąć więcej narkotyków! ))", 255, 0, 0) return false end
		eq_takeItem(142, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zażywa metamtefaminę.", 3, 15, true)
		newDrug_inject(5)
	elseif (EQ[btnidx].itemid==143) then -- heronina
		if getElementData(localPlayer, "newdrugs") then outputChatBox("(( Nie możesz wziąć więcej narkotyków! ))", 255, 0, 0) return false end
		eq_takeItem(143, 1)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zażywa heroninę.", 3, 15, true)
		newDrug_inject(6)
	elseif (EQ[btnidx].itemid==150) then -- defibrylator
		triggerServerEvent("defibrylatorUse", localPlayer)
	elseif (EQ[btnidx].itemid==151) then -- kamizelka pd
		triggerServerEvent("toggleKamizelkaPD", getRootElement(), localPlayer, EQ[btnidx].subtype)


	elseif (EQ[btnidx].itemid==152) then -- pistolet szkoleniowy - obrzyn
		if (getPedWeapon(localPlayer)==26) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa pistolet.", 3, 15, true)
		else
			local pestki = eq_getItemByID(153) or false
			if pestki then
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, pestki.count } }, 3 )
			else
				setElementData(localPlayer, "laser", false)
				setElementData(localPlayer, "laserchange", false)
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, -1 } }, 3 )
			end
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga pistolet.", 3, 15, true)
		end

	elseif (EQ[btnidx].itemid==154) then -- laserek
		local weaponid = getPedWeapon(localPlayer)
		if not (EQ[btnidx].wepid == weaponid) then return end
		
		if getElementData(localPlayer, "laser") then
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zdejmuje celownik laserowy", 3, 15, true)
			setElementData(localPlayer, "laser", false)
			setElementData(localPlayer, "laserchange", false)
			--zabierz laser
		else
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zakłada celownik laserowy", 3, 15, true)
			setElementData(localPlayer, "laserchange", true)
			--daj laser
		end
		laserToggle()
--[[	elseif (EQ[btnidx].itemid==155) then -- snajperka
		if (getPedWeapon(localPlayer)==34) then
			setPedWeaponSlot(localPlayer, 0)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " chowa karabin snajperski.", 3, 15, true)
		else
		
			local pestki = eq_getItemByID(156) or false
			if pestki then
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, pestki.count } }, 6 )
			else
				triggerServerEvent("syncPlayerWeapons", localPlayer, { { EQ[btnidx].wepid, -1 } }, 6 )
			end
--			setPedWeaponSlot(localPlayer, 1)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " wyciąga karabin snajperski.", 3, 15, true)
		end]]--
	elseif (EQ[btnidx].itemid==157) then -- grill
		
		eq_takeItem(157,1)
		grill = createObject(1481,0,0,0)
		attachElements(grill,localPlayer,0,1,0)
		setTimer(function()
			local x,y,z = getElementPosition(grill)
			destroyElement(grill)
			triggerServerEvent("onGrillMake", localPlayer, x, y, z)
			triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " rozkłada grilla.", 3, 15, true)
		end, 300, 1)
		
	elseif (EQ[btnidx].itemid==158)  then --surowa kielbasa
		triggerEvent("onCaptionedEvent", resourceRoot, "Surowa kiełbasa, aż chce się ją upiec na grillu.", 3)
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " ogląda surową kiełbasę.", 3, 20, false)
	elseif (EQ[btnidx].itemid==159) then --pieczona kielbasa
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " zjada grillowaną kiełbasę.", 3, 20, true)
		eq_takeItem(159, 1)
		local hp=getElementHealth(localPlayer)
		if (hp<60) then
			hp=hp+10
			if (hp>60) then hp=60 end
			setElementHealth(localPlayer, hp)
		end
		modifySatiation(20)
--[[	elseif (EQ[btnidx].itemid==160) then --barierka drogowa
		if not getElementData(localPlayer, "faction:id") then return end
		triggerServerEvent("broadcastCaptionedEvent", localPlayer, getPlayerName(localPlayer) .. " rozstawia blokadę drogową.", 3, 20, true)
		eq_takeItem(160, 1)
		triggerServerEvent("onBarierkaMake", localPlayer)
--]]
	elseif (EQ[btnidx].itemid==164) then --boombox
		if getElementData(localPlayer, "boombox:object") then
			triggerServerEvent("onBoomboxStop", localPlayer)
		else
			triggerServerEvent("onBoomboxStart", localPlayer)
			
		end
	elseif (EQ[btnidx].itemid==165) then --obroza
		triggerServerEvent("obroza", localPlayer)
	elseif (EQ[btnidx].itemid==166) then --zwolki
		triggerServerEvent("onCorpseWantInfo", localPlayer, EQ[btnidx].subtype)
	elseif (EQ[btnidx].itemid==167) then --karma dla psa
		triggerServerEvent("karma", localPlayer)
	elseif (EQ[btnidx].itemid==168) then --prezent dd
		triggerServerEvent("onPrezentDdOpen", localPlayer)
	elseif (EQ[btnidx].itemid==169) then -- kamizelka mc
		triggerServerEvent("toggleKamizelkaMC", localPlayer)
	end
end

EQ_TabPanel = {}
EQ_Tab = {}
EQ_Button = {}
EQ_Button2 = {}
EQ_Btns={}
EQ_Img={}
EQ_Ilosc={}
EQ_Edt={}
EQ_Lbl={}

EQ_TabPanel[1] = guiCreateTabPanel(0.000,0.77,1,0.23,true)
guiSetAlpha(EQ_TabPanel[1], 0.95)
EQ_Tab[1] = guiCreateTab("Ekwipunek",EQ_TabPanel[1])
--EQ_Tab[2] = guiCreateTab("Statystyki",EQ_TabPanel[1])
--EQ_Tab[2]="loremipsum"
EQ_Tab[3] = guiCreateTab("Opis",EQ_TabPanel[1])
EQ_Tab[4] = guiCreateTab("Styl chodzenia", EQ_TabPanel[1])
EQ_Tab[5] = guiCreateTab("Styl walki", EQ_TabPanel[1])
--guiSetEnabled(EQ_Tab[5], false)

--guiSetAlpha(EQ_TabPanel[1],0.8)
for i=1,28 do
    if (not EQ[i]) then EQ[i]={} end
    i2=i-1
    EQ[i].g_btn1 = guiCreateButton(0.0113+((i2%14)*0.07),0.052+(i>14 and 0.45 or 0),0.065,0.43,"",true,EQ_Tab[1])
    
    guiSetAlpha(EQ[i].g_btn1,1)
    EQ[i].g_img= guiCreateStaticImage(0.25,0.15,0.5,0.5,"img/EQ_blank.png", true, EQ[i].g_btn1)
--    guiMoveToBack(EQ_Img[i])
--    guiBringToFront(EQ_Button[i])
    
    EQ[i].g_ilosc=guiCreateLabel(0.05,0.0,0.89,0.5,"", true, EQ[i].g_btn1)
    guiSetFont(EQ[i].g_ilosc, "default-bold-small")
    guiLabelSetHorizontalAlign(EQ[i].g_ilosc, "right")
    EQ[i].g_nazwa=guiCreateLabel(0,0,1,0.9,"", true, EQ[i].g_btn1)
    guiSetFont(EQ[i].g_nazwa, "default-small")
    guiLabelSetHorizontalAlign(EQ[i].g_nazwa, "center")
    guiLabelSetVerticalAlign(EQ[i].g_nazwa,"bottom")
    
    EQ[i].g_btn2=guiCreateButton(0.0113+((i2%14)*0.07),0.052+(i>14 and 0.45 or 0),0.065,0.43,"",true,EQ_Tab[1])
    guiSetAlpha(EQ[i].g_btn2,0)
    addEventHandler("onClientGUIClick", EQ[i].g_btn2, eq_btnclick,false)
    
end

-- zakladka z opisem

--EQ_Lbl[1]=guiCreateLabel(0.0063,0.205, 0.665, 0.25, "-", true, EQ_Tab[3])
EQ_Edt[1]=guiCreateEdit(0.0063, 0.205+0.1, 0.665, 0.25, "", true, EQ_Tab[3])

EQ_Btns[1]=guiCreateButton(1-0.0063-0.3,0.175, 0.300, 0.5, "Ustaw opis", true, EQ_Tab[3])
--guiLabelSetHorizontalAlign(EQ_Lbl[1], "left")



guiEditSetMaxLength(EQ_Edt[1], 170)
addEventHandler("onClientGUIClick", EQ_Btns[1], function()
	setElementData(localPlayer, "opis", guiGetText(EQ_Edt[1]))
	panel_hide()
end, false)

-- zakladka ze stylem chodzenia

--[[
do
	local walkingAnims={
	 "WALK_drunk",	--1
	 "WALK_fat",
	 "WALK_fatold",
	 "WALK_gang1",
	 "WALK_gang2",
	 "WALK_old",
	 "WALK_player",
	 "WALK_shuffle",
	 "WALK_Wuzi",
	 "PLAYER_sneak", -- 10
	 "RUN_gang1",    -- 11
	 "RUN_1armed",
	 "RUN_civi",
	 "WOMAN_runfatold", -- 14
	 "WOMAN_walkbusy",
	 "WOMAN_walksexy",
	 "WOMAN_run", 		-- 17
	 "WOMAN_runbusy", -- 18
	}
	local bw=0.8/#walkingAnims

	for i,v in ipairs(walkingAnims) do
		local btn=guiCreateButton((i-0.90)*bw, 0.1, bw*0.9, 0.8, tostring(i), true, EQ_Tab[4])
		addEventHandler("onClientGUIClick", btn, function()
			setElementData(localPlayer, "walkingStyle", v)
			outputChatBox("(( Zmieniono styl chodzenia na nr " .. i .." ))", 180,180,180)
		end, false)
	end
	local lbl=guiCreateLabel(#walkingAnims*bw+0.05, 0.1, 0.95-#walkingAnims*bw, 0.9, "Spacją włączasz i wyłączasz wybrany styl.", true, EQ_Tab[4])
	guiLabelSetHorizontalAlign(lbl,"center", true)
	guiLabelSetVerticalAlign(lbl,"center")
--	guiSetFont(lbl,"default-small")
end
]]--
do
	local walkingAnims={55,56,118,120,121,122,123,124,125,126,128,129,131,132,133}
	local bw=0.99/#walkingAnims

	for i,v in ipairs(walkingAnims) do
		local btn=guiCreateButton((i-0.9)*bw, 0.1, bw*0.9, 0.8, tostring(i), true, EQ_Tab[4])
		addEventHandler("onClientGUIClick", btn, function()
			--setElementData(localPlayer, "walkingStyle", v)
			triggerServerEvent("setPedWalkingStyle", localPlayer, v)
			outputChatBox("(( Zmieniono styl chodzenia na nr " .. i .." ))", 180,180,180)
		end, false)
	end


end

local fightingname = {
	[4]="standard",
	[5]="boks",
	[6]="kung-fu",
	[7]="knee-head",
	[15]="grab-kick",
	[16]="elblows",
}


do
	local fightingStyles={4,5,6,7,15,16}
	local bw=0.99/#fightingStyles

	for i,v in ipairs(fightingStyles) do
		local btn=guiCreateButton((i-0.9)*bw, 0.1, bw*0.9, 0.8, tostring(fightingname[v]), true, EQ_Tab[5])
		addEventHandler("onClientGUIClick", btn, function()
			--setElementData(localPlayer, "walkingStyle", v)
			triggerServerEvent("setPedFightingStyler", localPlayer, v)
			outputChatBox("(( Zmieniono styl walki na "..tostring(fightingname[v]).." ))", 180,180,180)
		end, false)
	end


end


guiSetVisible(EQ_TabPanel[1],false)
--eq_sync()
--eq_redraw()

-- jesli gracz jest juz zalogowany tzn ze byl restart zasobu => prosimy serwer o podanie nam ekwipunku
local character=getElementData(localPlayer,"character")
if (character and character.id) then
    triggerServerEvent("onPlayerRequestEQSync", localPlayer)
end



--- --- --- --- ---

-- ---------------------------------------------------------- panel



local panel_visible=false
function panel_hide()
    panel_visible=false
    destroyContextMenu()
    showCursor(false)
    guiSetVisible(EQ_TabPanel[1],false)
    
    guiSetVisible(eq_item_pda.img,false)
    guiSetText(eq_item_pda.displbl,"Terminal miejski.\n\nTylko do użytku przez służby miejskie i policję.\n\nW przypadku znalezienia, zwrócić w najbliższym komisariacie.")

end
function panel_show()
    panel_visible=true
    destroyContextMenu()
    showCursor(true)
    guiSetVisible(EQ_TabPanel[1],true)
end
function panel_toggle()
    if (not getElementData(localPlayer,"character")) then return end	-- gracz jeszcze nie wybral postaci
	if (getElementData(localPlayer, "kajdanki")) then return end

    panel_visible = not panel_visible
    if (isPedDoingGangDriveby(localPlayer)) then panel_visible=false end

	if (getElementHealth(localPlayer)==0) then panel_visible=false end

    if (panel_visible) then
        toggleControl("fire", false)
        toggleControl("aim_weapon", false)
	    showCursor(true)
	    guiSetVisible(EQ_TabPanel[1],true)
		guiSetInputMode("no_binds_when_editing")
        if not getElementData(localPlayer, "kary:blokada_bicia") then
          toggleControl("fire", true)
          toggleControl("aim_weapon", true)
        end
    else
	    destroyContextMenu()
	    showCursor(false)
	    guiSetVisible(EQ_TabPanel[1],false)
    end
	guiSetSelectedTab(EQ_TabPanel[1], EQ_Tab[1])
	guiSetText(EQ_Edt[1], getElementData(localPlayer, "opis") or "")
end


bindKey ( "TAB", "down", panel_toggle )

local function czyTaksowka(p)
	local vm=getVehicleModel(p)
	if vm==438 or vm==420 then return true end
	local kierowca=getVehicleController(p)
	if kierowca then
		local taxi=getElementData(p,"taxi")
		if taxi and taxi==kierowca then return true end
	end
	return false
end

local contextMenu={element=nil,btns={}}

function destroyContextMenu()
    if (not contextMenu.active) then return end
    for i,v in pairs(contextMenu.btns) do
	if (contextMenu.btns[i].btn) then
	    destroyElement(contextMenu.btns[i].btn)
	end
    end
    contextMenu={active=false,element=nil,btns={}}
end
function showContextMenu(el,x,y)
	local lfid=getElementData(localPlayer, "faction:id")
    destroyContextMenu()
    contextMenu.active=true
    contextMenu.element=el
    local i=0
    local desc=getElementData(el,"desc")
    if (desc) then
    	i=i+1
        contextMenu.btns[i]={}
        contextMenu.btns[i].btn=guiCreateButton(x,y,100,20,desc,false,nil)
	guiSetEnabled(contextMenu.btns[i].btn,false)

    end
    local cact=getElementData(el,"customAction")
    if (cact) then
    	i=i+1
	contextMenu.btns[i]={}
	contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,cact.label or "-",false,nil)
	addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
	    call(getResourceFromName(cact.resource),cact.funkcja,cact.args or {})
	    panel_hide()
	end)

    end

	outputDebugString("ET " .. getElementType(el))

	if (getElementType(el)=="object") then

	  if false and (getPlayerName(localPlayer)=="Karer_Brown" and (getElementModel(el)==1727 or getElementModel(el)==1364)) then

			i=i+1
			contextMenu.btns[i]={}
			contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Usiądź",false,nil)
			addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				    call(getResourceFromName("lss-core"),"menu_usiadz",{el=el})
				    panel_hide()
			end)

	  end
	end
	
	if (getElementType(el)=="object") and (getElementModel(el)==16102) and (getElementData(el, "isBarierka")) then
		if (getElementData(el, "factionid")==getElementData(localPlayer, "faction:id")) then
			i=i+1
			contextMenu.btns[i]={}
			contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Weź blokadę",false,nil)
			addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				call(getResourceFromName("lss-core"),"menu_blokadaTake",{player=localPlayer, blokada=el})
				panel_hide()
			end)
		end
	end
	
	
	
	if (getElementType(el)=="object") and (getElementModel(el)==1481) and (getElementData(el, "grill")) then
		--kliknal na grilla, sprawdzamy, czy moze cos upiec
		if eq_getItemByID(158) then
			i=i+1
			contextMenu.btns[i]={}
			contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Upiecz kiełbasę",false,nil)
			addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				call(getResourceFromName("lss-core"),"menu_kielbasaUpiecz",{player=localPlayer, grill=el})
				panel_hide()
			end)
		end
		if eq_getItemByID(8) then
			i=i+1
			contextMenu.btns[i]={}
			contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Upiecz rybę",false,nil)
			addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				call(getResourceFromName("lss-core"),"menu_rybaUpiecz",{player=localPlayer, grill=el})
				panel_hide()
			end)
		end
		
		if (getElementData(el, "grill:owner")==localPlayer) or (not getElementData(el, "grill:owner")) then
			i=i+1
			contextMenu.btns[i]={}
			contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Weź grilla",false,nil)
			addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				call(getResourceFromName("lss-core"),"menu_grillTake",{player=localPlayer, grill=el})
				panel_hide()
			end)
		end
		
		
	end
	
	if getElementData(el, "item:id") and getElementType(el)=="object" then
			i=i+1
			contextMenu.btns[i]={}
			contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Podnieś",false,nil)
			addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				call(getResourceFromName("lss-worlditems"),"menu_itemPickup",{player=localPlayer, item=el})
				panel_hide()
			end)
	end
	
    if (getElementType(el)=="vehicle" and getElementModel(el)~=481 and getElementModel(el)~=509 and getElementModel(el)~=510 and getElementData(el,"dbid") and getElementHealth(el)>0) then	-- pojazd objety zasobem lss-vehicles
	  if (getElementData(el,"spedycja")) then -- pojazd przewozi paczki spedycyjne
			i=i+1
			contextMenu.btns[i]={}
			contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Odczytaj paczki",false,nil)
			addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				    call(getResourceFromName("lss-spedycja"),"menu_spedycjaInfo",{vehicle=el})
				    panel_hide()
			end)
	  end

	if (getPedOccupiedVehicle(localPlayer)==el and (getVehicleOccupant(el,0)==localPlayer or getVehicleOccupant(el,1)==localPlayer)) then
		local caudio=getElementData(el,"audio:cd")
		if caudio and type(caudio)=="table" and caudio[1] then
				-- ?
				i=i+1
				contextMenu.btns.cdPrev={}
				contextMenu.btns.cdPrev.btn=guiCreateButton(x,y+(i-1)*20,30,20,"◀",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns.cdPrev.btn, function()
				    call(getResourceFromName("lss-muzyka"),"menu_cdPrev",{vehicle=el})
				    panel_hide()
				end)

				contextMenu.btns.cdEject={}
    				contextMenu.btns.cdEject.btn=guiCreateButton(x+30,y+(i-1)*20,40,20,"⏏",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns.cdEject.btn, function()
				    call(getResourceFromName("lss-muzyka"),"menu_cdEject",{vehicle=el})
				    panel_hide()
				end)


				contextMenu.btns.cdNext={}
    				contextMenu.btns.cdNext.btn=guiCreateButton(x+70,y+(i-1)*20,30,20,"▶",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns.cdNext.btn, function()
				    call(getResourceFromName("lss-muzyka"),"menu_cdNext",{vehicle=el})
				    panel_hide()
				end)


		end
	end


	if (getPedOccupiedVehicle(localPlayer)==el and (getVehicleController(el)==localPlayer or getVehicleOccupant(el,1)==localPlayer)) then
			
			
			
			
			i=i+1
			contextMenu.btns[i]={}
			if (getVehicleEngineState(el)) then
				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Zgaś silnik",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				    call(getResourceFromName("lss-vehicles"),"menu_stopEngine",{vehicle=el})
				    panel_hide()
				end)
			else
				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Odpal silnik",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				    call(getResourceFromName("lss-vehicles"),"menu_startEngine",{vehicle=el})
				    panel_hide()
				end)
			end
			i=i+1
			contextMenu.btns[i]={}
			if (isElementFrozen(el)) then
				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,getVehicleType(el)=="Boat" and "Wciągnij kotwice" or "Spuść ręczny",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				    call(getResourceFromName("lss-vehicles"),"menu_unfreeze",{vehicle=el})
				    panel_hide()
				end)
			else
				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,getVehicleType(el)=="Boat" and "Spuść kotwice" or "Zaciągnij ręczny",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				    call(getResourceFromName("lss-vehicles"),"menu_freeze",{vehicle=el})
				    panel_hide()
				end)
			end
			local vm=getElementModel(el)
			-- gracz siedzi w kabinie dft-30 jako kierowca
			if (false and vm==578 and false) then
--			    menu_wyladujPojazdy
				i=i+1
				contextMenu.btns[i]={}
    				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Wyładuj pojazdy",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				    call(getResourceFromName("lss-frakcje"),"menu_wyladujPojazdy",{vehicle=el})
				    panel_hide()
				end)
			end
			-- kierowca taksowki
			if (czyTaksowka(el)) then
				i=i+1
				contextMenu.btns[i]={}
    				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Zresetuj licznik",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				    call(getResourceFromName("lss-frakcje"),"menu_taxiResetLicznika",{vehicle=el})
				    panel_hide()
				end)
			end
			-- cargobob
			if (vm==548) then
				i=i+1
				contextMenu.btns[i]={}
    				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Magnes",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				    call(getResourceFromName("lss-frakcje"),"menu_magnes",{vehicle=el})
				    panel_hide()
				end)

			end
			
			if (getElementData(el, "owning_faction")==2) or (getElementData(el, "owning_faction")==22) then
				if (getElementData(localPlayer, "faction:id")==2) or (getElementData(localPlayer, "faction:id")==22) then
					i=i+1
					contextMenu.btns[i]={}
					contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Kartoteka",false,nil)
					addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
						call(getResourceFromName("lss-kartoteka"),"onKartotekaOpen",localPlayer)
						panel_hide()
					end)
				end
			end

			if getElementData(el, "vehicle:audio") then
				i=i+1
				contextMenu.btns[i]={}
				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Radio",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
					call(getResourceFromName("lss-core"),"menu_zestawAudio",{player=localPlayer,vehicle=el})
					panel_hide()
				end)
			end
	end

	-- gracz stoi na dft-30
	if (getElementModel(el)==578 and getPedContactElement(localPlayer)==el) then
	    i=i+1
	    contextMenu.btns[i]={}

	    contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Blokada kół",false,nil)
	    addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-frakcje"),"menu_blokadaKol",{vehicle=el})
		    panel_hide()
	    end)
	    
	end

	if (getElementModel(el)==571 and getPedOccupiedVehicle(localPlayer)~=el) then -- kart

	  local px,py,pz=getElementPosition(localPlayer)
	  local px2,py2,pz2=getElementPosition(el)
	  if (getDistanceBetweenPoints3D(px,py,pz,px2,py2,pz2)<5) then

			i=i+1
			contextMenu.btns[i]={}

			if (getVehicleEngineState(el)) then
				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Zgaś silnik",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				    call(getResourceFromName("lss-vehicles"),"menu_stopEngine",{vehicle=el})
				    panel_hide()
				end)
			else
				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Odpal silnik",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				    call(getResourceFromName("lss-vehicles"),"menu_startEngine",{vehicle=el})
				    panel_hide()
				end)
			end




	  end
	end
	
	

	if (isVehicleLocked(el) and not przyczepa(el)) then
		i=i+1
		contextMenu.btns[i]={}

		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Otwórz",false,nil)
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-vehicles"),"menu_openVehicle",{vehicle=el})
		    panel_hide()
		end)
	elseif not przyczepa(el) then
	
		i=i+1
		contextMenu.btns[i]={}

		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Zamknij",false,nil)
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-vehicles"),"menu_closeVehicle",{vehicle=el})
		    panel_hide()
		end)


		if (getPedOccupiedVehicle(localPlayer)~=el) then
			i=i+1
			contextMenu.btns[i]={}

			contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Maska",false,nil)
			addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
			    call(getResourceFromName("lss-vehicles"),"menu_maska",{vehicle=el})
			    panel_hide()
			end)

			if (exports["lss-bagazniki"]:pojazdMaBagaznik(el)) then
				i=i+1
				contextMenu.btns[i]={}
		
				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Bagażnik",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
				    call(getResourceFromName("lss-bagazniki"),"menu_bagaznik",{vehicle=el})
				    panel_hide()
				end)
			end
		end
		
		
		if (getPedOccupiedVehicle(localPlayer)~=el) then
			local kanister = eq_getItemByID(161)
			if kanister then
			
				i=i+1
				contextMenu.btns[i]={}

				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Kanister 5L",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
					call(getResourceFromName("lss-core"),"menu_kanisterFill",{vehicle=el,player=localPlayer,pojemnosc=5})
					panel_hide()
				end)
				end
		end
		
		if (getPedOccupiedVehicle(localPlayer)~=el) then
			local kanister = eq_getItemByID(162)
			if kanister then
			
				i=i+1
				contextMenu.btns[i]={}

				contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Kanister 10L",false,nil)
				addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
					call(getResourceFromName("lss-core"),"menu_kanisterFill",{vehicle=el,player=localPlayer,pojemnosc=10})
					panel_hide()
				end)
				end
		end



	end

	if (eq_getItemByID(61) and getVehicleController(el)~=localPlayer) then	-- neony
		i=i+1
		contextMenu.btns[i]={}

		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Zamontuj neony",false,nil)
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-misc"),"menu_montazWPojezdzie",{vehicle=el, itemid=61})
		    panel_hide()
		end)

	end
	


    if (lfid and tonumber(lfid)==4 and isElementFrozen(el)) then
			i=i+1
			contextMenu.btns[i]={}

			contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Spuść hamulec",false,nil)
			guiSetFont(contextMenu.btns[i].btn, "default-small")
			addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
			    call(getResourceFromName("lss-admin"),"menu_unfreeze",{el=el})
			    panel_hide()
			end)
	end
	if (pojazdNaDachu(el) and getVehicleController(el)~=localPlayer) then
		i=i+1
		contextMenu.btns[i]={}
		
		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Obróć na koła",false,nil)
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-vehicles"),"menu_flip",{vehicle=el})
		    panel_hide()
		end)
	end
	if (getElementData(el,"kogut") and getVehicleController(el)==localPlayer) then
		i=i+1
		contextMenu.btns[i]={}
		
		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Kogut",false,nil)
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-vehicles"),"menu_kogut",{vehicle=el})
		    panel_hide()
		end)
	end
	
	
	if ( (getElementModel(el)==555 or getElementModel(el)==439) and getVehicleController(el)==localPlayer) then
		i=i+1
		contextMenu.btns[i]={}
		
		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Dach",false,nil)
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-vehicles"),"menu_dach",{vehicle=el})
		    panel_hide()
		end)
	end

	if (getElementData(el,"neony") and getVehicleController(el)==localPlayer) then
		i=i+1
		contextMenu.btns[i]={}
		
		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Neony",false,nil)
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-vehicles"),"menu_neony",{vehicle=el})
		    panel_hide()
		end)
	end

    end -- if getElementType==vehicle
    if (getElementType(el)=="player" and el~=localPlayer) then
		i=i+1
		contextMenu.btns[i]={}

		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Wymiana",false,nil)
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-trade"),"menu_trade",{with=el})
		    panel_hide()
		end)
--[[
		if getPlayerMoney()>0 then
			i=i+1
			contextMenu.btns[i]={}
			contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Przekaż pieniądze",false,nil)
			addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
			    call(getResourceFromName("lss-payment"),"menu_payment",{with=el})
			    panel_hide()
			end)
		end
]]--




		local lfid=tonumber(getElementData(localPlayer, "faction:id"))
		if lfid then
			i=i+1
			contextMenu.btns[i]={}
			contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Oferuj usługę",false,nil)
			addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
			    call(getResourceFromName("lss-oferta"),"menu_oferta",{with=el})
			    panel_hide()
			end)
		end
		local coid=getElementData(localPlayer, "character")
		if ((coid.co_id and tonumber(coid.co_id)>0 and tonumber(coid.co_rank)>2) or (lfid and (lfid==2 or lfid==20 or lfid==22))) then
			i=i+1
			contextMenu.btns[i]={}

			contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Przeszukaj",false,nil)
			addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
			    call(getResourceFromName("lss-przeszukanie"),"menu_przeszukaj",{with=el})
			    panel_hide()
			end)
		end



	  -- kajdanki
	  if (eq_getItemByID(28)) then
		i=i+1
		contextMenu.btns[i]={}

		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,getElementData(el, "kajdanki") and "Rozkuj" or "Zakuj",false,nil)
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-frakcje"),"menu_zakuj",{with=el})
		    panel_hide()
		end)

	  end
	  if (eq_getItemByID(37,1)) then	-- zastrzyk - morfina
		i=i+1
		contextMenu.btns[i]={}

		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Zastrzyk - morfina",false,nil)
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-frakcje"),"menu_zastrzyk",{with=el,subtype=1})
		    panel_hide()
		end)

	  end
	  if (eq_getItemByID(37,2)) then	-- zastrzyk - pavulon
		i=i+1
		contextMenu.btns[i]={}

		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Zastrzyk - pavulon",false,nil)
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-frakcje"),"menu_zastrzyk",{with=el,subtype=2})
		    panel_hide()
		end)
	  end




    end
    -- FUNKCJE SUPPORTU ----------------------------------------------------------------------------
	
	
	
    if (getElementData(localPlayer,"auth:support")) then
        if (isElementFrozen(el)) then
		i=i+1
		contextMenu.btns[i]={}

		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Odmróź",false,nil)
		guiSetFont(contextMenu.btns[i].btn, "default-small")
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-admin"),"menu_unfreeze",{el=el})
		    panel_hide()
		end)
        end
	if (getElementType(el)~="ped" and getElementType(el)~="object") then
		i=i+1
		contextMenu.btns[i]={}
		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Podnieś o 1m",false,nil)
		guiSetFont(contextMenu.btns[i].btn, "default-small")
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-admin"),"menu_lift1",{el=el})
		    panel_hide()
		end)
	end
	if (getElementType(el)=="vehicle" and not getVehicleController(el)) then
		i=i+1
		contextMenu.btns[i]={}
		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"Przenieś tu",false,nil)
		guiSetFont(contextMenu.btns[i].btn, "default-small")
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-admin"),"menu_bringHere",{el=el})
		    panel_hide()
		end)
	end
	if (getElementType(el)=="vehicle") then
		i=i+1
		contextMenu.btns[i]={}
		contextMenu.btns[i].btn=guiCreateButton(x,y+(i-1)*20,100,20,"[INFORMACJE]",false,nil)
		guiSetFont(contextMenu.btns[i].btn, "default-small")
		addEventHandler("onClientGUIClick", contextMenu.btns[i].btn, function()
		    call(getResourceFromName("lss-admin"),"menu_vehinfo",{el=el})
		    panel_hide()
		end)
	end



    end
    
end

function worldClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
--    outputChatBox("world Click")
	if (button=="left" and state=="down" and clickedElement and getElementType(clickedElement)=="player") then
		local afk=getElementData(clickedElement, "afk")
		if afk and tonumber(afk) then
			if tonumber(afk)>=10 then
				outputChatBox(string.format("(( %s jest AFK od conajmniej 5 minut ))", getPlayerName(clickedElement)))
			elseif tonumber(afk)>=2 then
				outputChatBox(string.format("(( %s jest AFK od conajmniej 1 minuty ))", getPlayerName(clickedElement)))
			end
		end
	end

    if (clickedElement and button=="right" and state=="up") then
	local elementType = getElementType ( clickedElement )
	if ((getElementType(clickedElement)=="player" and clickedElement~=localPlayer) or getElementData(clickedElement,"customAction") or (getElementType(clickedElement)=="vehicle" and getElementData(clickedElement,"dbid")) or (getElementType(clickedElement)=="object") ) then
	    showContextMenu(clickedElement,absoluteX, absoluteY)
	else
	    local x,y,z=getElementPosition(clickedElement)
	    outputDebugString(elementType .. " model: " .. getElementModel(clickedElement) .. " x: " .. x .. " y: " .. y .. " z: " .. z )
	end

    end
end

addEventHandler ( "onClientClick", getRootElement(), worldClick )

function setGPSTarget(plr,target,text)
	if not (plr==getLocalPlayer()) then return false end
	if (eq_getItemByID(16)) then
		nav_cel=target
		guiSetVisible(eq_item_nav.img,true)
		guiSetText(eq_item_nav.displbl, text)
		eq_item_nav_refresh()
		return true
    end
	return false
end

addEvent("onPackageInfo", true)	-- odpowiedz na onPlayerRequestPackageInfo
addEventHandler("onPackageInfo", root, function(cel)
    
    if (eq_getItemByID(16)) then
	nav_cel=cel
	guiSetVisible(eq_item_nav.img,true)
	guiSetText(eq_item_nav.displbl, cel.nazwa)
    end
    outputChatBox("Odczytujesz z paczki adres dostawy: " .. cel.nazwa)
    

end)


addEvent("onEQDataRequest", true)
addEventHandler("onEQDataRequest", root, function(komu,przeszukanie)
  triggerServerEvent("onPlayerShowEQ", localPlayer, komu, EQ, przeszukanie)
end)

addEventHandler ( "onClientPlayerDamage", getLocalPlayer(),
function ( attacker, weapon, bodypart )
    if ( weapon == 16 ) then --granat
        cancelEvent()
    end
end)

addEvent("BONE_SPINE1_pos", true)
addEventHandler("BONE_SPINE1_pos", getRootElement(), function(plr)
	local x,y,z = getPedBonePosition(plr, 3)
	setElementData(plr, "BONE_SPINE1_pos", {x,y,z})
end)

boomboxMP3 = {}

addEvent("onBoomboxStartSound", true)
addEventHandler("onBoomboxStartSound", getRootElement(), function()
	boomboxMP3[source] = playSound3D(getElementData(source, "boombox:url"), 0, 0, 0)
	setElementInterior(boomboxMP3[source], getElementInterior(source))
	setElementDimension(boomboxMP3[source], getElementDimension(source))
	attachElements(boomboxMP3[source], source)
	setSoundVolume(boomboxMP3[source], 0.5)
	setSoundMaxDistance(boomboxMP3[source], 7)
end)

addEvent("onBoomboxStopSound", true)
addEventHandler("onBoomboxStopSound", getRootElement(), function()
	if boomboxMP3[source] then
		destroyElement(boomboxMP3[source])
	end
end)

addEventHandler("onClientPlayerQuit", root, function()
	if (boomboxMP3[source] and isElement(boomboxMP3[source])) then 
		destroyElement(boomboxMP3[source]) 
		boomboxMP3[source]=nil
	end
end)
