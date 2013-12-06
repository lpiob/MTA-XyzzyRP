<?
function kiedy($data) {
        $ts=strtotime($data);
        $ts=time()-$ts;
		if ($ts<0) return "teraz";
        // sekundy
        if ($ts<60) return $ts." ".dli($ts,'sekundę','sekundy','sekund')." temu";
        $ts=round($ts/60);
        // minuty
        if ($ts<60) return $ts." ".dli($ts,'minutę','minuty','minut')." temu";
        $ts=round($ts/60);
        // godziny
        if ($ts<24) return $ts." ".dli($ts,'godzinę', 'godziny','godzin')." temu";
        $ts=round($ts/24);
        // dni
        if ($ts<7) return $ts." ".dli($ts,'dzień','dni','dni')." temu";
        // tygodnie
        //if (($ts/7)<4) return dli(round($ts/7),'tydzie�','tygodnie','tygodni')." temu";
        if (($ts/7)<4) return $ts." ".dli($ts,'dzień','dni','dni')." temu";
        $ts=round($ts/30.5);
        // miesiace
        if ($ts<12) return $ts." ".dli($ts,'miesiąc','miesiące','miesięcy')." temu";
        $ts=round($ts/12);
        // lata
        return $ts." ".dli($ts,'rok','lata','lat')." temu";
};

function kiedy2($data) {
        $ts=strtotime($data);
        $ts=time()-$ts;
        // sekundy
        if ($ts<60) return dli($ts,'sekundy','sekund','sekund',true);
        $ts=round($ts/60);
        // minuty
        if ($ts<60) return dli($ts,'minuty','minut','minut',true);
        $ts=round($ts/60);
        // godziny
        if ($ts<24) return dli($ts,'godziny', 'godzin','godzin',true);
        $ts=round($ts/24);
        // dni
        if ($ts<7) return dli($ts,'dnia','dni','dni',true);
        // tygodnie
        //if (($ts/7)<4) return dli(round($ts/7),'tygodnia','tygodni','tygodni');
        if (($ts/7)<4) return dli($ts,'dnia','dni','dni',true);
        $ts=round($ts/30.5);
        // miesiace
        if ($ts<12) return dli($ts,'miesiąca','miesięcy','miesięcy',true);
        $ts=round($ts/12);
        // lata
        return dli($ts,'roku','lat','lat',true);
};




function kiedy_short($data) {
        $ts=strtotime($data);
        $ts=time()-$ts;
        // sekundy
        if ($ts<60) return "-".$ts."s"; 
        $ts=round($ts/60);
        // minuty
        if ($ts<60) return "-".$ts."m";
        $ts=round($ts/60);
        // godziny
        if ($ts<24) return "-".$ts."h";
        $ts=round($ts/24);
        // dni
        if ($ts<7) return "-".$ts."d";
        // tygodnie
        //if (($ts/7)<4) return dli(round($ts/7),'tydzie�','tygodnie','tygodni')." temu";
        if (($ts/7)<4) return "-".$ts."d";
        $ts=round($ts/30.5);
        // miesiace
        if ($ts<12) return "-".dli($ts,'m-c','m-ce','m-cy')."";
        $ts=round($ts/12);
        // lata
        return "-".$ts."r";
};

function bezpliterek($t){
//	$from="ąśćęłńóżźĄŚĆĘŁŃÓŻŹ";
//	$to	 ="ascelnozzASCELNOZZ";
//	return strtr($t,$from,$to);
	return iconv('UTF-8', 'ASCII//TRANSLIT', $t);
}

function urlify($t) {
$t=preg_replace("/[^a-z0-9]+/i", '-',bezpliterek($t));
$t=preg_replace("/(^\-+|\-+$)/","",$t);
return $t;
////return $t;
}


function dli($x,$a,$b,$c,$adc=false) {
        if ($x==1) return ($adc==false?"":$x." ").$a;
        elseif (
        ($x%10>1) && ($x%10<5)  &&
        !(($x%100>=10) && ($x%100<=21))
        ) return ($adc==false?"":$x." ")." ".$b;
        return ($adc==false?"":$x." ")." ".$c;
};

function fdli($f,$x) {
		// $f: "tekst[%S%] %D% [%S%] tekst"
		
		$f=str_replace("%D%", $x, $f);
		$args=(func_num_args()-2);
		$i=2;
		while ($args-->0) {

			$a=func_get_arg($i++);
//			$b=func_get_arg($i++);
//			$c=func_get_arg($i++);
//			print "Zamiana ($a/$b/$c) ";
			$f=preg_replace("/%S%/", dli($x,$a[0],$a[1],$a[2],false), $f,1);
		}
		return $f;
};


function autoload($class_name) {
        if (file_exists(dirname(__FILE__).$class_name.".class.php"))
        require_once(dirname(__FILE__).$class_name.".class.php");
}
spl_autoload_register('autoload');

function sendmail($rcpt,$subj,$txt,$html=false) {
    return mail($rcpt,$subj,$txt.($html?("\n\nHTML PART:\n\n".$html):""));
/*
    require_once("Swift-4.0.6/lib/swift_required.php");
    $transport = Swift_SmtpTransport::newInstance();//'127.0.0.1','25')->setUsername('no-reply@bestplay.pl')->setPassword('g35vw4ws4');
    $mailer = Swift_Mailer::newInstance($transport);
    $message= Swift_Message::newInstance()
        ->setFrom(array('no-reply@bestplay.pl'=>'BestPlay'))
        ->setTo($rcpt)
        ->setSubject($subj)
					            ->setBody($txt);
						        if ($html) $message->addPart($html,'text/html');
    return $mailer->send($message);*/
}
							     							     

$zones=Array(
Array("Bayside Marina", Array(-2353.17, 2275.79, 0.0 ), Array(-2153.17, 2475.79, 200.0 ) ),
Array("Bayside", Array(-2741.07, 2175.15, 0.0 ), Array(-2353.17, 2722.79, 200.0 ) ),
Array("Battery Point", Array(-2741.07, 1268.41, -4.57764e-005 ), Array(-2533.04, 1490.47, 200.0 ) ),
Array("Paradiso", Array(-2741.07, 793.411, -6.10352e-005 ), Array(-2533.04, 1268.41, 200.0 ) ),
Array("Santa Flora", Array(-2741.07, 458.411, -7.62939e-005 ), Array(-2533.04, 793.411, 200.0 ) ),
Array("Palisades", Array(-2994.49, 458.411, -6.10352e-005 ), Array(-2741.07, 1339.61, 200.0 ) ),
Array("City Hall", Array(-2867.85, 277.411, -9.15527e-005 ), Array(-2593.44, 458.411, 200.0 ) ),
Array("Ocean Flats", Array(-2994.49, 277.411, -9.15527e-005 ), Array(-2867.85, 458.411, 200.0 ) ),
Array("Ocean Flats", Array(-2994.49, -222.589, -0.000106812 ), Array(-2593.44, 277.411, 200.0 ) ),
Array("Ocean Flats", Array(-2994.49, -430.276, -0.00012207 ), Array(-2831.89, -222.589, 200.0 ) ),
Array("Foster Valley", Array(-2270.04, -430.276, -0.00012207 ), Array(-2178.69, -324.114, 200.0 ) ),
Array("Foster Valley", Array(-2178.69, -599.884, -0.00012207 ), Array(-1794.92, -324.114, 200.0 ) ),
Array("Hashbury", Array(-2593.44, -222.589, -0.000106812 ), Array(-2411.22, 54.722, 200.0 ) ),
Array("Juniper Hollow", Array(-2533.04, 968.369, -6.10352e-005 ), Array(-2274.17, 1358.9, 200.0 ) ),
Array("Esplanade North", Array(-2533.04, 1358.9, -4.57764e-005 ), Array(-1996.66, 1501.21, 200.0 ) ),
Array("Esplanade North", Array(-1996.66, 1358.9, -4.57764e-005 ), Array(-1524.24, 1592.51, 200.0 ) ),
Array("Esplanade North", Array(-1982.32, 1274.26, -4.57764e-005 ), Array(-1524.24, 1358.9, 200.0 ) ),
Array("Financial", Array(-1871.72, 744.17, -6.10352e-005 ), Array(-1701.3, 1176.42, 300.0 ) ),
Array("Calton Heights", Array(-2274.17, 744.17, -6.10352e-005 ), Array(-1982.32, 1358.9, 200.0 ) ),
Array("Downtown", Array(-1982.32, 744.17, -6.10352e-005 ), Array(-1871.72, 1274.26, 200.0 ) ),
Array("Downtown", Array(-1871.72, 1176.42, -4.57764e-005 ), Array(-1620.3, 1274.26, 200.0 ) ),
Array("Downtown", Array(-1700.01, 744.267, -6.10352e-005 ), Array(-1580.01, 1176.52, 200.0 ) ),
Array("Downtown", Array(-1580.01, 744.267, -6.10352e-005 ), Array(-1499.89, 1025.98, 200.0 ) ),
Array("Juniper Hill", Array(-2533.04, 578.396, -7.62939e-005 ), Array(-2274.17, 968.369, 200.0 ) ),
Array("Chinatown", Array(-2274.17, 578.396, -7.62939e-005 ), Array(-2078.67, 744.17, 200.0 ) ),
Array("Downtown", Array(-2078.67, 578.396, -7.62939e-005 ), Array(-1499.89, 744.267, 200.0 ) ),
Array("King's", Array(-2329.31, 458.411, -7.62939e-005 ), Array(-1993.28, 578.396, 200.0 ) ),
Array("King's", Array(-2411.22, 265.243, -9.15527e-005 ), Array(-1993.28, 373.539, 200.0 ) ),
Array("King's", Array(-2253.54, 373.539, -9.15527e-005 ), Array(-1993.28, 458.411, 200.0 ) ),
Array("Garcia", Array(-2411.22, -222.589, -0.000114441 ), Array(-2173.04, 265.243, 200.0 ) ),
Array("Doherty", Array(-2270.04, -324.114, -0.00012207 ), Array(-1794.92, -222.589, 200.0 ) ),
Array("Doherty", Array(-2173.04, -222.589, -0.000106812 ), Array(-1794.92, 265.243, 200.0 ) ),
Array("Downtown", Array(-1993.28, 265.243, -9.15527e-005 ), Array(-1794.92, 578.396, 200.0 ) ),
Array("Easter Bay Airport", Array(-1499.89, -50.0963, -0.000106812 ), Array(-1242.98, 249.904, 200.0 ) ),
Array("Easter Basin", Array(-1794.92, 249.904, -9.15527e-005 ), Array(-1242.98, 578.396, 200.0 ) ),
Array("Easter Basin", Array(-1794.92, -50.0963, -0.000106812 ), Array(-1499.89, 249.904, 200.0 ) ),
Array("Esplanade East", Array(-1620.3, 1176.52, -4.57764e-005 ), Array(-1580.01, 1274.26, 200.0 ) ),
Array("Esplanade East", Array(-1580.01, 1025.98, -6.10352e-005 ), Array(-1499.89, 1274.26, 200.0 ) ),
Array("Esplanade East", Array(-1499.89, 578.396, -79.6152 ), Array(-1339.89, 1274.26, 20.3848 ) ),
Array("Angel Pine", Array(-2324.94, -2584.29, -6.10352e-005 ), Array(-1964.22, -2212.11, 200.0 ) ),
Array("Shady Cabin", Array(-1632.83, -2263.44, -3.05176e-005 ), Array(-1601.33, -2231.79, 200.0 ) ),
Array("Back o Beyond", Array(-1166.97, -2641.19, 0.0 ), Array(-321.744, -1856.03, 200.0 ) ),
Array("Leafy Hollow", Array(-1166.97, -1856.03, 0.0 ), Array(-815.624, -1602.07, 200.0 ) ),
Array("Flint Range", Array(-594.191, -1648.55, 0.0 ), Array(-187.7, -1276.6, 200.0 ) ),
Array("Fallen Tree", Array(-792.254, -698.555, -5.34058e-005 ), Array(-452.404, -380.043, 200.0 ) ),
Array("The Farm", Array(-1209.67, -1317.1, 114.981 ), Array(-908.161, -787.391, 251.981 ) ),
Array("El Quebrados", Array(-1645.23, 2498.52, 0.0 ), Array(-1372.14, 2777.85, 200.0 ) ),
Array("Aldea Malvada", Array(-1372.14, 2498.52, 0.0 ), Array(-1277.59, 2615.35, 200.0 ) ),
Array("The Sherman Dam", Array(-968.772, 1929.41, -3.05176e-005 ), Array(-481.126, 2155.26, 200.0 ) ),
Array("Las Barrancas", Array(-926.13, 1398.73, -3.05176e-005 ), Array(-719.234, 1634.69, 200.0 ) ),
Array("Fort Carson", Array(-376.233, 826.326, -3.05176e-005 ), Array(123.717, 1220.44, 200.0 ) ),
Array("Hunter Quarry", Array(337.244, 710.84, -115.239 ), Array(860.554, 1031.71, 203.761 ) ),
Array("Octane Springs", Array(338.658, 1228.51, 0.0 ), Array(664.308, 1655.05, 200.0 ) ),
Array("Green Palms", Array(176.581, 1305.45, -3.05176e-005 ), Array(338.658, 1520.72, 200.0 ) ),
Array("Regular Tom", Array(-405.77, 1712.86, -3.05176e-005 ), Array(-276.719, 1892.75, 200.0 ) ),
Array("Las Brujas", Array(-365.167, 2123.01, -3.05176e-005 ), Array(-208.57, 2217.68, 200.0 ) ),
Array("Verdant Meadows", Array(37.0325, 2337.18, -3.05176e-005 ), Array(435.988, 2677.9, 200.0 ) ),
Array("Las Payasadas", Array(-354.332, 2580.36, 2.09808e-005 ), Array(-133.625, 2816.82, 200.0 ) ),
Array("Arco del Oeste", Array(-901.129, 2221.86, 0.0 ), Array(-592.09, 2571.97, 200.0 ) ),
Array("Easter Bay Airport", Array(-1794.92, -730.118, -3.05176e-005 ), Array(-1213.91, -50.0963, 200.0 ) ),
Array("Hankypanky Point", Array(2576.92, 62.1579, 0.0 ), Array(2759.25, 385.503, 200.0 ) ),
Array("Palomino Creek", Array(2160.22, -149.004, 0.0 ), Array(2576.92, 228.322, 200.0 ) ),
Array("North Rock", Array(2285.37, -768.027, 0.0 ), Array(2770.59, -269.74, 200.0 ) ),
Array("Montgomery", Array(1119.51, 119.526, -3.05176e-005 ), Array(1451.4, 493.323, 200.0 ) ),
Array("Montgomery", Array(1451.4, 347.457, -6.10352e-005 ), Array(1582.44, 420.802, 200.0 ) ),
Array("Hampton Barns", Array(603.035, 264.312, 0.0 ), Array(761.994, 366.572, 200.0 ) ),
Array("Fern Ridge", Array(508.189, -139.259, 0.0 ), Array(1306.66, 119.526, 200.0 ) ),
Array("Dillimore", Array(580.794, -674.885, -9.53674e-006 ), Array(861.085, -404.79, 200.0 ) ),
Array("Hilltop Farm", Array(967.383, -450.39, -3.05176e-005 ), Array(1176.78, -217.9, 200.0 ) ),
Array("Blueberry", Array(104.534, -220.137, 2.38419e-007 ), Array(349.607, 152.236, 200.0 ) ),
Array("Blueberry", Array(19.6074, -404.136, 3.8147e-006 ), Array(349.607, -220.137, 200.0 ) ),
Array("The Panopticon", Array(-947.98, -304.32, -1.14441e-005 ), Array(-319.676, 327.071, 200.0 ) ),
Array("Frederick Bridge", Array(2759.25, 296.501, 0.0 ), Array(2774.25, 594.757, 200.0 ) ),
Array("The Mako Span", Array(1664.62, 401.75, 0.0 ), Array(1785.14, 567.203, 200.0 ) ),
Array("Blueberry Acres", Array(-319.676, -220.137, 0.0 ), Array(104.534, 293.324, 200.0 ) ),
Array("Martin Bridge", Array(-222.179, 293.324, 0.0 ), Array(-122.126, 476.465, 200.0 ) ),
Array("Fallow Bridge", Array(434.341, 366.572, 0.0 ), Array(603.035, 555.68, 200.0 ) ),
Array("Shady Creeks", Array(-1820.64, -2643.68, -8.01086e-005 ), Array(-1226.78, -1771.66, 200.0 ) ),
Array("Shady Creeks", Array(-2030.12, -2174.89, -6.10352e-005 ), Array(-1820.64, -1771.66, 200.0 ) ),
Array("Queens", Array(-2533.04, 458.411, 0.0 ), Array(-2329.31, 578.396, 200.0 ) ),
Array("Queens", Array(-2593.44, 54.722, 0.0 ), Array(-2411.22, 458.411, 200.0 ) ),
Array("Queens", Array(-2411.22, 373.539, 0.0 ), Array(-2253.54, 458.411, 200.0 ) ),
Array("Los Santos", Array(44.6147, -2892.97, -242.99 ), Array(2997.06, -768.027, 900.0 ) ),
Array("Las Venturas", Array(869.461, 596.349, -242.99 ), Array(2997.06, 2993.87, 900.0 ) ),
Array("Bone County", Array(-480.539, 596.349, -242.99 ), Array(869.461, 2993.87, 900.0 ) ),
Array("Tierra Robada", Array(-2997.47, 1659.68, -242.99 ), Array(-480.539, 2993.87, 900.0 ) ),
Array("Gant Bridge", Array(-2741.45, 1659.68, -6.10352e-005 ), Array(-2616.4, 2175.15, 200.0 ) ),
Array("Gant Bridge", Array(-2741.07, 1490.47, -6.10352e-005 ), Array(-2616.4, 1659.68, 200.0 ) ),
Array("San Fierro", Array(-2997.47, -1115.58, -242.99 ), Array(-1213.91, 1659.68, 900.0 ) ),
Array("Tierra Robada", Array(-1213.91, 596.349, -242.99 ), Array(-480.539, 1659.68, 900.0 ) ),
Array("Red County", Array(-1213.91, -768.027, -242.99 ), Array(2997.06, 596.349, 900.0 ) ),
Array("Flint County", Array(-1213.91, -2892.97, -242.99 ), Array(44.6147, -768.027, 900.0 ) ),
Array("Easter Bay Chemicals", Array(-1132.82, -768.027, 0.0 ), Array(-956.476, -578.118, 200.0 ) ),
Array("Easter Bay Chemicals", Array(-1132.82, -787.391, 0.0 ), Array(-956.476, -768.027, 200.0 ) ),
Array("Easter Bay Airport", Array(-1213.91, -730.118, 0.0 ), Array(-1132.82, -50.0963, 200.0 ) ),
Array("Foster Valley", Array(-2178.69, -1115.58, 0.0 ), Array(-1794.92, -599.884, 200.0 ) ),
Array("Foster Valley", Array(-2178.69, -1250.97, 0.0 ), Array(-1794.92, -1115.58, 200.0 ) ),
Array("Easter Bay Airport", Array(-1242.98, -50.0963, 0.0 ), Array(-1213.91, 578.396, 200.0 ) ),
Array("Easter Bay Airport", Array(-1213.91, -50.096, -4.57764e-005 ), Array(-947.98, 578.396, 200.0 ) ),
Array("Whetstone", Array(-2997.47, -2892.97, -242.99 ), Array(-1213.91, -1115.58, 900.0 ) ),
Array("Los Santos International", Array(1249.62, -2394.33, -89.0839 ), Array(1852.0, -2179.25, 110.916 ) ),
Array("Los Santos International", Array(1852.0, -2394.33, -89.0839 ), Array(2089.0, -2179.25, 110.916 ) ),
Array("Verdant Bluffs", Array(930.221, -2488.42, -89.0839 ), Array(1249.62, -2006.78, 110.916 ) ),
Array("El Corona", Array(1812.62, -2179.25, -89.0839 ), Array(1970.62, -1852.87, 110.916 ) ),
Array("Willowfield", Array(1970.62, -2179.25, -89.0839 ), Array(2089.0, -1852.87, 110.916 ) ),
Array("Willowfield", Array(2089.0, -2235.84, -89.0839 ), Array(2201.82, -1989.9, 110.916 ) ),
Array("Willowfield", Array(2089.0, -1989.9, -89.0839 ), Array(2324.0, -1852.87, 110.916 ) ),
Array("Willowfield", Array(2201.82, -2095.0, -89.0839 ), Array(2324.0, -1989.9, 110.916 ) ),
Array("Ocean Docks", Array(2373.77, -2697.09, -89.0837 ), Array(2809.22, -2330.46, 110.916 ) ),
Array("Ocean Docks", Array(2201.82, -2418.33, -89.0837 ), Array(2324.0, -2095.0, 110.916 ) ),
Array("Marina", Array(647.712, -1804.21, -89.0839 ), Array(851.449, -1577.59, 110.916 ) ),
Array("Verona Beach", Array(647.712, -2173.29, -89.0839 ), Array(930.221, -1804.21, 110.916 ) ),
Array("Verona Beach", Array(930.221, -2006.78, -89.0839 ), Array(1073.22, -1804.21, 110.916 ) ),
Array("Verdant Bluffs", Array(1073.22, -2006.78, -89.0839 ), Array(1249.62, -1842.27, 110.916 ) ),
Array("Verdant Bluffs", Array(1249.62, -2179.25, -89.0839 ), Array(1692.62, -1842.27, 110.916 ) ),
Array("El Corona", Array(1692.62, -2179.25, -89.0839 ), Array(1812.62, -1842.27, 110.916 ) ),
Array("Verona Beach", Array(851.449, -1804.21, -89.0839 ), Array(1046.15, -1577.59, 110.916 ) ),
Array("Marina", Array(647.712, -1577.59, -89.0838 ), Array(807.922, -1416.25, 110.916 ) ),
Array("Marina", Array(807.922, -1577.59, -89.0839 ), Array(926.922, -1416.25, 110.916 ) ),
Array("Verona Beach", Array(1161.52, -1722.26, -89.0839 ), Array(1323.9, -1577.59, 110.916 ) ),
Array("Verona Beach", Array(1046.15, -1722.26, -89.0839 ), Array(1161.52, -1577.59, 110.916 ) ),
Array("Conference Center", Array(1046.15, -1804.21, -89.0839 ), Array(1323.9, -1722.26, 110.916 ) ),
Array("Conference Center", Array(1073.22, -1842.27, -89.0839 ), Array(1323.9, -1804.21, 110.916 ) ),
Array("Commerce", Array(1323.9, -1842.27, -89.0839 ), Array(1701.9, -1722.26, 110.916 ) ),
Array("Commerce", Array(1323.9, -1722.26, -89.0839 ), Array(1440.9, -1577.59, 110.916 ) ),
Array("Commerce", Array(1370.85, -1577.59, -89.084 ), Array(1463.9, -1384.95, 110.916 ) ),
Array("Commerce", Array(1463.9, -1577.59, -89.0839 ), Array(1667.96, -1430.87, 110.916 ) ),
Array("Pershing Square", Array(1440.9, -1722.26, -89.0839 ), Array(1583.5, -1577.59, 110.916 ) ),
Array("Commerce", Array(1583.5, -1722.26, -89.0839 ), Array(1758.9, -1577.59, 110.916 ) ),
Array("Little Mexico", Array(1701.9, -1842.27, -89.0839 ), Array(1812.62, -1722.26, 110.916 ) ),
Array("Little Mexico", Array(1758.9, -1722.26, -89.0839 ), Array(1812.62, -1577.59, 110.916 ) ),
Array("Commerce", Array(1667.96, -1577.59, -89.0839 ), Array(1812.62, -1430.87, 110.916 ) ),
Array("Idlewood", Array(1812.62, -1852.87, -89.0839 ), Array(1971.66, -1742.31, 110.916 ) ),
Array("Idlewood", Array(1812.62, -1742.31, -89.0839 ), Array(1951.66, -1602.31, 110.916 ) ),
Array("Idlewood", Array(1951.66, -1742.31, -89.0839 ), Array(2124.66, -1602.31, 110.916 ) ),
Array("Idlewood", Array(1812.62, -1602.31, -89.0839 ), Array(2124.66, -1449.67, 110.916 ) ),
Array("Idlewood", Array(2124.66, -1742.31, -89.0839 ), Array(2222.56, -1494.03, 110.916 ) ),
Array("Glen Park", Array(1812.62, -1449.67, -89.0839 ), Array(1996.91, -1350.72, 110.916 ) ),
Array("Glen Park", Array(1812.62, -1100.82, -89.0839 ), Array(1994.33, -973.38, 110.916 ) ),
Array("Jefferson", Array(1996.91, -1449.67, -89.0839 ), Array(2056.86, -1350.72, 110.916 ) ),
Array("Jefferson", Array(2124.66, -1494.03, -89.0839 ), Array(2266.21, -1449.67, 110.916 ) ),
Array("Jefferson", Array(2056.86, -1372.04, -89.0839 ), Array(2281.45, -1210.74, 110.916 ) ),
Array("Jefferson", Array(2056.86, -1210.74, -89.0839 ), Array(2185.33, -1126.32, 110.916 ) ),
Array("Jefferson", Array(2185.33, -1210.74, -89.0839 ), Array(2281.45, -1154.59, 110.916 ) ),
Array("Las Colinas", Array(1994.33, -1100.82, -89.0839 ), Array(2056.86, -920.815, 110.916 ) ),
Array("Las Colinas", Array(2056.86, -1126.32, -89.0839 ), Array(2126.86, -920.815, 110.916 ) ),
Array("Las Colinas", Array(2185.33, -1154.59, -89.0839 ), Array(2281.45, -934.489, 110.916 ) ),
Array("Las Colinas", Array(2126.86, -1126.32, -89.0839 ), Array(2185.33, -934.489, 110.916 ) ),
Array("Idlewood", Array(1971.66, -1852.87, -89.0839 ), Array(2222.56, -1742.31, 110.916 ) ),
Array("Ganton", Array(2222.56, -1852.87, -89.0839 ), Array(2632.83, -1722.33, 110.916 ) ),
Array("Ganton", Array(2222.56, -1722.33, -89.0839 ), Array(2632.83, -1628.53, 110.916 ) ),
Array("Willowfield", Array(2541.7, -1941.4, -89.0839 ), Array(2703.58, -1852.87, 110.916 ) ),
Array("East Beach", Array(2632.83, -1852.87, -89.0839 ), Array(2959.35, -1668.13, 110.916 ) ),
Array("East Beach", Array(2632.83, -1668.13, -89.0839 ), Array(2747.74, -1393.42, 110.916 ) ),
Array("East Beach", Array(2747.74, -1668.13, -89.0839 ), Array(2959.35, -1498.62, 110.916 ) ),
Array("East Los Santos", Array(2421.03, -1628.53, -89.0839 ), Array(2632.83, -1454.35, 110.916 ) ),
Array("East Los Santos", Array(2222.56, -1628.53, -89.0839 ), Array(2421.03, -1494.03, 110.916 ) ),
Array("Jefferson", Array(2056.86, -1449.67, -89.0839 ), Array(2266.21, -1372.04, 110.916 ) ),
Array("East Los Santos", Array(2266.26, -1494.03, -89.0839 ), Array(2381.68, -1372.04, 110.916 ) ),
Array("East Los Santos", Array(2381.68, -1494.03, -89.0839 ), Array(2421.03, -1454.35, 110.916 ) ),
Array("East Los Santos", Array(2281.45, -1372.04, -89.084 ), Array(2381.68, -1135.04, 110.916 ) ),
Array("East Los Santos", Array(2381.68, -1454.35, -89.0839 ), Array(2462.13, -1135.04, 110.916 ) ),
Array("East Los Santos", Array(2462.13, -1454.35, -89.0839 ), Array(2581.73, -1135.04, 110.916 ) ),
Array("Los Flores", Array(2581.73, -1454.35, -89.0839 ), Array(2632.83, -1393.42, 110.916 ) ),
Array("Los Flores", Array(2581.73, -1393.42, -89.0839 ), Array(2747.74, -1135.04, 110.916 ) ),
Array("East Beach", Array(2747.74, -1498.62, -89.0839 ), Array(2959.35, -1120.04, 110.916 ) ),
Array("Las Colinas", Array(2747.74, -1120.04, -89.0839 ), Array(2959.35, -945.035, 110.916 ) ),
Array("Las Colinas", Array(2632.74, -1135.04, -89.0839 ), Array(2747.74, -945.035, 110.916 ) ),
Array("Las Colinas", Array(2281.45, -1135.04, -89.0839 ), Array(2632.74, -945.035, 110.916 ) ),
Array("Downtown Los Santos", Array(1463.9, -1430.87, -89.084 ), Array(1724.76, -1290.87, 110.916 ) ),
Array("Downtown Los Santos", Array(1724.76, -1430.87, -89.0839 ), Array(1812.62, -1250.9, 110.916 ) ),
Array("Downtown Los Santos", Array(1463.9, -1290.87, -89.084 ), Array(1724.76, -1150.87, 110.916 ) ),
Array("Downtown Los Santos", Array(1370.85, -1384.95, -89.0839 ), Array(1463.9, -1170.87, 110.916 ) ),
Array("Downtown Los Santos", Array(1724.76, -1250.9, -89.0839 ), Array(1812.62, -1150.87, 110.916 ) ),
Array("Mulholland Intersection", Array(1463.9, -1150.87, -89.0839 ), Array(1812.62, -768.027, 110.916 ) ),
Array("Mulholland", Array(1414.07, -768.027, -89.0839 ), Array(1667.61, -452.425, 110.916 ) ),
Array("Mulholland", Array(1281.13, -452.425, -89.0839 ), Array(1641.13, -290.913, 110.916 ) ),
Array("Mulholland", Array(1269.13, -768.027, -89.0839 ), Array(1414.07, -452.425, 110.916 ) ),
Array("Market", Array(787.461, -1416.25, -89.0838 ), Array(1072.66, -1310.21, 110.916 ) ),
Array("Vinewood", Array(787.461, -1310.21, -89.0838 ), Array(952.663, -1130.84, 110.916 ) ),
Array("Market", Array(952.663, -1310.21, -89.0839 ), Array(1072.66, -1130.85, 110.916 ) ),
Array("Downtown Los Santos", Array(1370.85, -1170.87, -89.0839 ), Array(1463.9, -1130.85, 110.916 ) ),
Array("Downtown Los Santos", Array(1378.33, -1130.85, -89.0838 ), Array(1463.9, -1026.33, 110.916 ) ),
Array("Downtown Los Santos", Array(1391.05, -1026.33, -89.0839 ), Array(1463.9, -926.999, 110.916 ) ),
Array("Temple", Array(1252.33, -1130.85, -89.0839 ), Array(1378.33, -1026.33, 110.916 ) ),
Array("Temple", Array(1252.33, -1026.33, -89.0839 ), Array(1391.05, -926.999, 110.916 ) ),
Array("Temple", Array(1252.33, -926.999, -89.0839 ), Array(1357.0, -910.17, 110.916 ) ),
Array("Mulholland", Array(1357.0, -926.999, -89.0838 ), Array(1463.9, -768.027, 110.916 ) ),
Array("Mulholland", Array(1318.13, -910.17, -89.0839 ), Array(1357.0, -768.027, 110.916 ) ),
Array("Mulholland", Array(1169.13, -910.17, -89.0838 ), Array(1318.13, -768.027, 110.916 ) ),
Array("Vinewood", Array(787.461, -1130.84, -89.0839 ), Array(952.604, -954.662, 110.916 ) ),
Array("Temple", Array(952.663, -1130.84, -89.084 ), Array(1096.47, -937.184, 110.916 ) ),
Array("Temple", Array(1096.47, -1130.84, -89.0838 ), Array(1252.33, -1026.33, 110.916 ) ),
Array("Temple", Array(1096.47, -1026.33, -89.0839 ), Array(1252.33, -910.17, 110.916 ) ),
Array("Mulholland", Array(768.694, -954.662, -89.0838 ), Array(952.604, -860.619, 110.916 ) ),
Array("Mulholland", Array(687.802, -860.619, -89.0839 ), Array(911.802, -768.027, 110.916 ) ),
Array("Mulholland", Array(737.573, -768.027, -89.0838 ), Array(1142.29, -674.885, 110.916 ) ),
Array("Mulholland", Array(1096.47, -910.17, -89.0838 ), Array(1169.13, -768.027, 110.916 ) ),
Array("Mulholland", Array(952.604, -937.184, -89.0839 ), Array(1096.47, -860.619, 110.916 ) ),
Array("Mulholland", Array(911.802, -860.619, -89.0838 ), Array(1096.47, -768.027, 110.916 ) ),
Array("Mulholland", Array(861.085, -674.885, -89.0839 ), Array(1156.55, -600.896, 110.916 ) ),
Array("Santa Maria Beach", Array(342.648, -2173.29, -89.0838 ), Array(647.712, -1684.65, 110.916 ) ),
Array("Santa Maria Beach", Array(72.6481, -2173.29, -89.0839 ), Array(342.648, -1684.65, 110.916 ) ),
Array("Rodeo", Array(72.6481, -1684.65, -89.084 ), Array(225.165, -1544.17, 110.916 ) ),
Array("Rodeo", Array(72.6481, -1544.17, -89.0839 ), Array(225.165, -1404.97, 110.916 ) ),
Array("Rodeo", Array(225.165, -1684.65, -89.0839 ), Array(312.803, -1501.95, 110.916 ) ),
Array("Rodeo", Array(225.165, -1501.95, -89.0839 ), Array(334.503, -1369.62, 110.916 ) ),
Array("Rodeo", Array(334.503, -1501.95, -89.0839 ), Array(422.68, -1406.05, 110.916 ) ),
Array("Rodeo", Array(312.803, -1684.65, -89.0839 ), Array(422.68, -1501.95, 110.916 ) ),
Array("Rodeo", Array(422.68, -1684.65, -89.0839 ), Array(558.099, -1570.2, 110.916 ) ),
Array("Rodeo", Array(558.099, -1684.65, -89.0839 ), Array(647.522, -1384.93, 110.916 ) ),
Array("Rodeo", Array(466.223, -1570.2, -89.0839 ), Array(558.099, -1385.07, 110.916 ) ),
Array("Rodeo", Array(422.68, -1570.2, -89.0839 ), Array(466.223, -1406.05, 110.916 ) ),
Array("Vinewood", Array(647.557, -1227.28, -89.0839 ), Array(787.461, -1118.28, 110.916 ) ),
Array("Richman", Array(647.557, -1118.28, -89.0839 ), Array(787.461, -954.662, 110.916 ) ),
Array("Richman", Array(647.557, -954.662, -89.0839 ), Array(768.694, -860.619, 110.916 ) ),
Array("Rodeo", Array(466.223, -1385.07, -89.0839 ), Array(647.522, -1235.07, 110.916 ) ),
Array("Rodeo", Array(334.503, -1406.05, -89.0839 ), Array(466.223, -1292.07, 110.916 ) ),
Array("Richman", Array(225.165, -1369.62, -89.0839 ), Array(334.503, -1292.07, 110.916 ) ),
Array("Richman", Array(225.165, -1292.07, -89.084 ), Array(466.223, -1235.07, 110.916 ) ),
Array("Richman", Array(72.6481, -1404.97, -89.0839 ), Array(225.165, -1235.07, 110.916 ) ),
Array("Richman", Array(72.6481, -1235.07, -89.0839 ), Array(321.356, -1008.15, 110.916 ) ),
Array("Richman", Array(321.356, -1235.07, -89.0839 ), Array(647.522, -1044.07, 110.916 ) ),
Array("Richman", Array(321.356, -1044.07, -89.0839 ), Array(647.557, -860.619, 110.916 ) ),
Array("Richman", Array(321.356, -860.619, -89.0839 ), Array(687.802, -768.027, 110.916 ) ),
Array("Richman", Array(321.356, -768.027, -89.0839 ), Array(700.794, -674.885, 110.916 ) ),
Array("The Strip", Array(2027.4, 863.229, -89.0839 ), Array(2087.39, 1703.23, 110.916 ) ),
Array("The Strip", Array(2106.7, 1863.23, -89.0839 ), Array(2162.39, 2202.76, 110.916 ) ),
Array("The Four Dragons Casino", Array(1817.39, 863.232, -89.084 ), Array(2027.39, 1083.23, 110.916 ) ),
Array("The Pink Swan", Array(1817.39, 1083.23, -89.0839 ), Array(2027.39, 1283.23, 110.916 ) ),
Array("The High Roller", Array(1817.39, 1283.23, -89.0839 ), Array(2027.39, 1469.23, 110.916 ) ),
Array("Pirates in Men's Pants", Array(1817.39, 1469.23, -89.084 ), Array(2027.4, 1703.23, 110.916 ) ),
Array("The Visage", Array(1817.39, 1863.23, -89.0839 ), Array(2106.7, 2011.83, 110.916 ) ),
Array("The Visage", Array(1817.39, 1703.23, -89.0839 ), Array(2027.4, 1863.23, 110.916 ) ),
Array("Julius Thruway South", Array(1457.39, 823.228, -89.0839 ), Array(2377.39, 863.229, 110.916 ) ),
Array("Julius Thruway West", Array(1197.39, 1163.39, -89.0839 ), Array(1236.63, 2243.23, 110.916 ) ),
Array("Julius Thruway South", Array(2377.39, 788.894, -89.0839 ), Array(2537.39, 897.901, 110.916 ) ),
Array("Rockshore East", Array(2537.39, 676.549, -89.0839 ), Array(2902.35, 943.235, 110.916 ) ),
Array("Come-A-Lot", Array(2087.39, 943.235, -89.0839 ), Array(2623.18, 1203.23, 110.916 ) ),
Array("The Camel's Toe", Array(2087.39, 1203.23, -89.0839 ), Array(2640.4, 1383.23, 110.916 ) ),
Array("Royal Casino", Array(2087.39, 1383.23, -89.0839 ), Array(2437.39, 1543.23, 110.916 ) ),
Array("Caligula's Palace", Array(2087.39, 1543.23, -89.0839 ), Array(2437.39, 1703.23, 110.916 ) ),
Array("Caligula's Palace", Array(2137.4, 1703.23, -89.0839 ), Array(2437.39, 1783.23, 110.916 ) ),
Array("Pilgrim", Array(2437.39, 1383.23, -89.0839 ), Array(2624.4, 1783.23, 110.916 ) ),
Array("Starfish Casino", Array(2437.39, 1783.23, -89.0839 ), Array(2685.16, 2012.18, 110.916 ) ),
Array("The Strip", Array(2027.4, 1783.23, -89.084 ), Array(2162.39, 1863.23, 110.916 ) ),
Array("The Strip", Array(2027.4, 1703.23, -89.0839 ), Array(2137.4, 1783.23, 110.916 ) ),
Array("The Emerald Isle", Array(2011.94, 2202.76, -89.0839 ), Array(2237.4, 2508.23, 110.916 ) ),
Array("Old Venturas Strip", Array(2162.39, 2012.18, -89.0839 ), Array(2685.16, 2202.76, 110.916 ) ),
Array("K.A.C.C. Military Fuels", Array(2498.21, 2626.55, -89.0839 ), Array(2749.9, 2861.55, 110.916 ) ),
Array("Creek", Array(2749.9, 1937.25, -89.0839 ), Array(2921.62, 2669.79, 110.916 ) ),
Array("Sobell Rail Yards", Array(2749.9, 1548.99, -89.0839 ), Array(2923.39, 1937.25, 110.916 ) ),
Array("Linden Station", Array(2749.9, 1198.99, -89.0839 ), Array(2923.39, 1548.99, 110.916 ) ),
Array("Julius Thruway East", Array(2623.18, 943.235, -89.0839 ), Array(2749.9, 1055.96, 110.916 ) ),
Array("Linden Side", Array(2749.9, 943.235, -89.0839 ), Array(2923.39, 1198.99, 110.916 ) ),
Array("Julius Thruway East", Array(2685.16, 1055.96, -89.0839 ), Array(2749.9, 2626.55, 110.916 ) ),
Array("Julius Thruway North", Array(2498.21, 2542.55, -89.0839 ), Array(2685.16, 2626.55, 110.916 ) ),
Array("Julius Thruway East", Array(2536.43, 2442.55, -89.0839 ), Array(2685.16, 2542.55, 110.916 ) ),
Array("Julius Thruway East", Array(2625.16, 2202.76, -89.0839 ), Array(2685.16, 2442.55, 110.916 ) ),
Array("Julius Thruway North", Array(2237.4, 2542.55, -89.0839 ), Array(2498.21, 2663.17, 110.916 ) ),
Array("Julius Thruway North", Array(2121.4, 2508.23, -89.0839 ), Array(2237.4, 2663.17, 110.916 ) ),
Array("Julius Thruway North", Array(1938.8, 2508.23, -89.0839 ), Array(2121.4, 2624.23, 110.916 ) ),
Array("Julius Thruway North", Array(1534.56, 2433.23, -89.0839 ), Array(1848.4, 2583.23, 110.916 ) ),
Array("Julius Thruway West", Array(1236.63, 2142.86, -89.084 ), Array(1297.47, 2243.23, 110.916 ) ),
Array("Julius Thruway North", Array(1848.4, 2478.49, -89.0839 ), Array(1938.8, 2553.49, 110.916 ) ),
Array("Harry Gold Parkway", Array(1777.39, 863.232, -89.0839 ), Array(1817.39, 2342.83, 110.916 ) ),
Array("Redsands East", Array(1817.39, 2011.83, -89.0839 ), Array(2106.7, 2202.76, 110.916 ) ),
Array("Redsands East", Array(1817.39, 2202.76, -89.0839 ), Array(2011.94, 2342.83, 110.916 ) ),
Array("Redsands East", Array(1848.4, 2342.83, -89.084 ), Array(2011.94, 2478.49, 110.916 ) ),
Array("Julius Thruway North", Array(1704.59, 2342.83, -89.0839 ), Array(1848.4, 2433.23, 110.916 ) ),
Array("Redsands West", Array(1236.63, 1883.11, -89.0839 ), Array(1777.39, 2142.86, 110.916 ) ),
Array("Redsands West", Array(1297.47, 2142.86, -89.084 ), Array(1777.39, 2243.23, 110.916 ) ),
Array("Redsands West", Array(1377.39, 2243.23, -89.0839 ), Array(1704.59, 2433.23, 110.916 ) ),
Array("Redsands West", Array(1704.59, 2243.23, -89.0839 ), Array(1777.39, 2342.83, 110.916 ) ),
Array("Las Venturas Airport", Array(1236.63, 1203.28, -89.0839 ), Array(1457.37, 1883.11, 110.916 ) ),
Array("Las Venturas Airport", Array(1457.37, 1203.28, -89.0839 ), Array(1777.39, 1883.11, 110.916 ) ),
Array("Las Venturas Airport", Array(1457.37, 1143.21, -89.0839 ), Array(1777.4, 1203.28, 110.916 ) ),
Array("LVA Freight Depot", Array(1457.39, 863.229, -89.0839 ), Array(1777.4, 1143.21, 110.916 ) ),
Array("Blackfield Intersection", Array(1197.39, 1044.69, -89.0839 ), Array(1277.05, 1163.39, 110.916 ) ),
Array("Blackfield Intersection", Array(1166.53, 795.01, -89.0839 ), Array(1375.6, 1044.69, 110.916 ) ),
Array("Blackfield Intersection", Array(1277.05, 1044.69, -89.0839 ), Array(1315.35, 1087.63, 110.916 ) ),
Array("Blackfield Intersection", Array(1375.6, 823.228, -89.084 ), Array(1457.39, 919.447, 110.916 ) ),
Array("LVA Freight Depot", Array(1375.6, 919.447, -89.0839 ), Array(1457.37, 1203.28, 110.916 ) ),
Array("LVA Freight Depot", Array(1277.05, 1087.63, -89.0839 ), Array(1375.6, 1203.28, 110.916 ) ),
Array("LVA Freight Depot", Array(1315.35, 1044.69, -89.0839 ), Array(1375.6, 1087.63, 110.916 ) ),
Array("LVA Freight Depot", Array(1236.63, 1163.41, -89.0839 ), Array(1277.05, 1203.28, 110.916 ) ),
Array("Greenglass College", Array(964.391, 1044.69, -89.0839 ), Array(1197.39, 1203.22, 110.916 ) ),
Array("Greenglass College", Array(964.391, 930.89, -89.0839 ), Array(1166.53, 1044.69, 110.916 ) ),
Array("Blackfield", Array(964.391, 1203.22, -89.084 ), Array(1197.39, 1403.22, 110.916 ) ),
Array("Blackfield", Array(964.391, 1403.22, -89.084 ), Array(1197.39, 1726.22, 110.916 ) ),
Array("Roca Escalante", Array(2237.4, 2202.76, -89.0839 ), Array(2536.43, 2542.55, 110.916 ) ),
Array("Roca Escalante", Array(2536.43, 2202.76, -89.0839 ), Array(2625.16, 2442.55, 110.916 ) ),
Array("Last Dime Motel", Array(1823.08, 596.349, -89.0839 ), Array(1997.22, 823.228, 110.916 ) ),
Array("Rockshore West", Array(1997.22, 596.349, -89.0839 ), Array(2377.39, 823.228, 110.916 ) ),
Array("Rockshore West", Array(2377.39, 596.349, -89.084 ), Array(2537.39, 788.894, 110.916 ) ),
Array("Randolph Industrial Estate", Array(1558.09, 596.349, -89.084 ), Array(1823.08, 823.235, 110.916 ) ),
Array("Blackfield Chapel", Array(1375.6, 596.349, -89.084 ), Array(1558.09, 823.228, 110.916 ) ),
Array("Blackfield Chapel", Array(1325.6, 596.349, -89.084 ), Array(1375.6, 795.01, 110.916 ) ),
Array("Julius Thruway North", Array(1377.39, 2433.23, -89.0839 ), Array(1534.56, 2507.23, 110.916 ) ),
Array("Pilson Intersection", Array(1098.39, 2243.23, -89.0839 ), Array(1377.39, 2507.23, 110.916 ) ),
Array("Whitewood Estates", Array(883.308, 1726.22, -89.0839 ), Array(1098.31, 2507.23, 110.916 ) ),
Array("Prickle Pine", Array(1534.56, 2583.23, -89.0839 ), Array(1848.4, 2863.23, 110.916 ) ),
Array("Prickle Pine", Array(1117.4, 2507.23, -89.0839 ), Array(1534.56, 2723.23, 110.916 ) ),
Array("Prickle Pine", Array(1848.4, 2553.49, -89.0839 ), Array(1938.8, 2863.23, 110.916 ) ),
Array("Spinybed", Array(2121.4, 2663.17, -89.0839 ), Array(2498.21, 2861.55, 110.916 ) ),
Array("Prickle Pine", Array(1938.8, 2624.23, -89.0839 ), Array(2121.4, 2861.55, 110.916 ) ),
Array("Pilgrim", Array(2624.4, 1383.23, -89.084 ), Array(2685.16, 1783.23, 110.916 ) ),
Array("San Andreas Sound", Array(2450.39, 385.503, -100.0 ), Array(2759.25, 562.349, 200.0 ) ),
Array("Fisher's Lagoon", Array(1916.99, -233.323, -100.0 ), Array(2131.72, 13.8002, 200.0 ) ),
Array("Garver Bridge", Array(-1339.89, 828.129, -89.0839 ), Array(-1213.91, 1057.04, 110.916 ) ),
Array("Garver Bridge", Array(-1213.91, 950.022, -89.0839 ), Array(-1087.93, 1178.93, 110.916 ) ),
Array("Garver Bridge", Array(-1499.89, 696.442, -179.615 ), Array(-1339.89, 925.353, 20.3848 ) ),
Array("Kincaid Bridge", Array(-1339.89, 599.218, -89.0839 ), Array(-1213.91, 828.129, 110.916 ) ),
Array("Kincaid Bridge", Array(-1213.91, 721.111, -89.0839 ), Array(-1087.93, 950.022, 110.916 ) ),
Array("Kincaid Bridge", Array(-1087.93, 855.37, -89.0839 ), Array(-961.95, 986.281, 110.916 ) ),
Array("Los Santos Inlet", Array(-321.744, -2224.43, -89.0839 ), Array(44.6147, -1724.43, 110.916 ) ),
Array("Sherman Reservoir", Array(-789.737, 1659.68, -89.084 ), Array(-599.505, 1929.41, 110.916 ) ),
Array("Flint Water", Array(-314.426, -753.874, -89.0839 ), Array(-106.339, -463.073, 110.916 ) ),
Array("Easter Tunnel", Array(-1709.71, -833.034, -1.52588e-005 ), Array(-1446.01, -730.118, 200.0 ) ),
Array("Bayside Tunnel", Array(-2290.19, 2548.29, -89.084 ), Array(-1950.19, 2723.29, 110.916 ) ),
Array("'The Big Ear'", Array(-410.02, 1403.34, -3.05176e-005 ), Array(-137.969, 1681.23, 200.0 ) ),
Array("Lil' Probe Inn", Array(-90.2183, 1286.85, -3.05176e-005 ), Array(153.859, 1554.12, 200.0 ) ),
Array("Valle Ocultado", Array(-936.668, 2611.44, 2.09808e-005 ), Array(-715.961, 2847.9, 200.0 ) ),
Array("Glen Park", Array(1812.62, -1350.72, -89.0839 ), Array(2056.86, -1100.82, 110.916 ) ),
Array("Ocean Docks", Array(2324.0, -2302.33, -89.0839 ), Array(2703.58, -2145.1, 110.916 ) ),
Array("Linden Station", Array(2811.25, 1229.59, -39.594 ), Array(2861.25, 1407.59, 60.406 ) ),
Array("Unity Station", Array(1692.62, -1971.8, -20.4921 ), Array(1812.62, -1932.8, 79.5079 ) ),
Array("Vinewood", Array(647.712, -1416.25, -89.0839 ), Array(787.461, -1227.28, 110.916 ) ),
Array("Market Station", Array(787.461, -1410.93, -34.1263 ), Array(866.009, -1310.21, 65.8737 ) ),
Array("Cranberry Station", Array(-2007.83, 56.3063, 0.0 ), Array(-1922.0, 224.782, 100.0 ) ),
Array("Yellow Bell Station", Array(1377.48, 2600.43, -21.9263 ), Array(1492.45, 2687.36, 78.0737 ) ),
Array("San Fierro Bay", Array(-2616.4, 1501.21, -3.05176e-005 ), Array(-1996.66, 1659.68, 200.0 ) ),
Array("San Fierro Bay", Array(-2616.4, 1659.68, -3.05176e-005 ), Array(-1996.66, 2175.15, 200.0 ) ),
Array("El Castillo del Diablo", Array(-464.515, 2217.68, 0.0 ), Array(-208.57, 2580.36, 200.0 ) ),
Array("El Castillo del Diablo", Array(-208.57, 2123.01, -7.62939e-006 ), Array(114.033, 2337.18, 200.0 ) ),
Array("El Castillo del Diablo", Array(-208.57, 2337.18, 0.0 ), Array(8.42999, 2487.18, 200.0 ) ),
Array("Restricted Area", Array(-91.586, 1655.05, -50.0 ), Array(421.234, 2123.01, 250.0 ) ),
Array("Montgomery Intersection", Array(1546.65, 208.164, 0.0 ), Array(1745.83, 347.457, 200.0 ) ),
Array("Montgomery Intersection", Array(1582.44, 347.457, 0.0 ), Array(1664.62, 401.75, 200.0 ) ),
Array("Robada Intersection", Array(-1119.01, 1178.93, -89.084 ), Array(-862.025, 1351.45, 110.916 ) ),
Array("Flint Intersection", Array(-187.7, -1596.76, -89.0839 ), Array(17.0632, -1276.6, 110.916 ) ),
Array("Easter Bay Airport", Array(-1315.42, -405.388, 15.4061 ), Array(-1264.4, -209.543, 25.4061 ) ),
Array("Easter Bay Airport", Array(-1354.39, -287.398, 15.4061 ), Array(-1315.42, -209.543, 25.4061 ) ),
Array("Easter Bay Airport", Array(-1490.33, -209.543, 15.4061 ), Array(-1264.4, -148.388, 25.4061 ) ),
Array("Market", Array(1072.66, -1416.25, -89.084 ), Array(1370.85, -1130.85, 110.916 ) ),
Array("Market", Array(926.922, -1577.59, -89.0839 ), Array(1370.85, -1416.25, 110.916 ) ),
Array("Avispa Country Club", Array(-2646.4, -355.493, 0.0 ), Array(-2270.04, -222.589, 200.0 ) ),
Array("Avispa Country Club", Array(-2831.89, -430.276, -6.10352e-005 ), Array(-2646.4, -222.589, 200.0 ) ),
Array("Missionary Hill", Array(-2994.49, -811.276, 0.0 ), Array(-2178.69, -430.276, 200.0 ) ),
Array("Mount Chiliad", Array(-2178.69, -1771.66, -47.9166 ), Array(-1936.12, -1250.97, 576.083 ) ),
Array("Mount Chiliad", Array(-2997.47, -1115.58, -47.9166 ), Array(-2178.69, -971.913, 576.083 ) ),
Array("Mount Chiliad", Array(-2994.49, -2189.91, -47.9166 ), Array(-2178.69, -1115.58, 576.083 ) ),
Array("Mount Chiliad", Array(-2178.69, -2189.91, -47.9166 ), Array(-2030.12, -1771.66, 576.083 ) ),
Array("Yellow Bell Golf Course", Array(1117.4, 2723.23, -89.0839 ), Array(1457.46, 2863.23, 110.916 ) ),
Array("Yellow Bell Golf Course", Array(1457.46, 2723.23, -89.0839 ), Array(1534.56, 2863.23, 110.916 ) ),
Array("Las Venturas Airport", Array(1515.81, 1586.4, -12.5 ), Array(1729.95, 1714.56, 87.5 ) ),
Array("Ocean Docks", Array(2089.0, -2394.33, -89.0839 ), Array(2201.82, -2235.84, 110.916 ) ),
Array("Los Santos International", Array(1382.73, -2730.88, -89.0839 ), Array(2201.82, -2394.33, 110.916 ) ),
Array("Ocean Docks", Array(2201.82, -2730.88, -89.0839 ), Array(2324.0, -2418.33, 110.916 ) ),
Array("Los Santos International", Array(1974.63, -2394.33, -39.0839 ), Array(2089.0, -2256.59, 60.9161 ) ),
Array("Los Santos International", Array(1400.97, -2669.26, -39.0839 ), Array(2189.82, -2597.26, 60.9161 ) ),
Array("Los Santos International", Array(2051.63, -2597.26, -39.0839 ), Array(2152.45, -2394.33, 60.9161 ) ),
Array("Starfish Casino", Array(2437.39, 1858.1, -39.0839 ), Array(2495.09, 1970.85, 60.9161 ) ),
Array("Beacon Hill", Array(-399.633, -1075.52, -1.48904 ), Array(-319.033, -977.516, 198.511 ) ),
Array("Avispa Country Club", Array(-2361.51, -417.199, 0.0 ), Array(-2270.04, -355.493, 200.0 ) ),
Array("Avispa Country Club", Array(-2667.81, -302.135, -28.8305 ), Array(-2646.4, -262.32, 71.1695 ) ),
Array("Garcia", Array(-2395.14, -222.589, -5.34058e-005 ), Array(-2354.09, -204.792, 200.0 ) ),
Array("Avispa Country Club", Array(-2470.04, -355.493, 0.0 ), Array(-2270.04, -318.493, 46.1 ) ),
Array("Avispa Country Club", Array(-2550.04, -355.493, 0.0 ), Array(-2470.04, -318.493, 39.7 ) ),
Array("Playa del Seville", Array(2703.58, -2126.9, -89.0839 ), Array(2959.35, -1852.87, 110.916 ) ),
Array("Ocean Docks", Array(2703.58, -2302.33, -89.0839 ), Array(2959.35, -2126.9, 110.916 ) ),
Array("Starfish Casino", Array(2162.39, 1883.23, -89.0839 ), Array(2437.39, 2012.18, 110.916 ) ),
Array("The Clown's Pocket", Array(2162.39, 1783.23, -89.0839 ), Array(2437.39, 1883.23, 110.916 ) ),
Array("Ocean Docks", Array(2324.0, -2145.1, -89.084 ), Array(2703.58, -2059.23, 110.916 ) ),
Array("Willowfield", Array(2324.0, -2059.23, -89.0839 ), Array(2541.7, -1852.87, 110.916 ) ),
Array("Willowfield", Array(2541.7, -2059.23, -89.0839 ), Array(2703.58, -1941.4, 110.916 ) ),
Array("Whitewood Estates", Array(1098.31, 1726.22, -89.0839 ), Array(1197.39, 2243.23, 110.916 ) ),
Array("Downtown Los Santos", Array(1507.51, -1385.21, 110.916 ), Array(1582.55, -1325.31, 335.916 ) )
);

function getZoneName($x,$y,$z) {
  global $zones;
  $zone=NULL;
  $last_size=0;
  foreach ($zones as $k=>$s)
                if ($s[1][0] <= $x && $x <= $s[2][0] && $s[1][1] <= $y  && $y <= $s[2][1] &&  $s[1][2] <= $z  && $z <= $s[2][2]) {
		  $zone_size= ( $s[2][0]-$s[1][0] ) * ( $s[2][1]-$s[1][1] ) * ( $s[2][2]-$s[1][2] ); 
		  if ($zone===NULL || $zone_size < $last_size) {
		    $zone=$k;
		    $last_size=$zone_size;
		  }
		}
  return $zone!==NULL?$zones[$zone][0]:"Best Andreas";
}


?>