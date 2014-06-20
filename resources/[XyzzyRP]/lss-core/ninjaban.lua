--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
]]--


-- nie mam nic przeciwko innym serwerom, doceniam i szanuję konkurencję, jest ona dobra dla gracza
-- ale niestety niektórych graczy nie da się ogarnąć i wchodzą tylko po to aby ściągać graczy
-- na inne serwery. Ninjabanowanie (<http://pawno.pl/index.php?/topic/4078-ninjaban-na-adresy-ip-wyrazenia-regularne/?hl=ninjaban>)
-- ich wypowiedzi to najlepsza metoda reagowania na takie akcje i jest lepsze niż kontakt
-- z adminami innych serwerów i zawracanie sobie nawzajem głowy w takich sprawach

function ninjaban(text)
	if string.match(text,"[dD][eE][vV][gG][aA]") then return true end
	if string.match(text,"[oO][tT][hH][eE][rR][lL][iI][fF][eE]") then return true end
	if string.match(text,"1[pP][lL][aA][yY]") then return true end
	return false
end