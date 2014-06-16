<?

session_name("rp");
session_start();

Header("Access-Control-Allow-Origin: http://rp.xaa.pl/");
$CFG_page_name="rp";
require_once("p/libs/xmlrpc.inc");
require_once("p/libs/phpbbauth.php");
ini_set('display_errors', '0');
//print_r($user->data);

require_once("p/libs/misc.php");

require_once("p/libs/Szablon.class.php");
$szablon=new Szablon;

//$szablon->setCaching(Smarty::CACHING_LIFETIME_SAVED);

//$szablon->dodaj_js('/s/js/jquery.validate.min.js');
//$szablon->dodaj_js('/s/js/jquery.dataTables.min.js');
//$szablon->dodaj_js('/s/js/statystyki.js');

$szablon->add_bc('rp','/');



////require_once("p/libs/BazaDanych-adodb.class.php");
require_once("p/libs/adodb5/adodb.inc.php");

$RDB=NewADOConnection("mysql");
// TU WPROWADZ DANE DO BAZY DANYCH SERWERA
$RDB->Connect("mysql-1.serverproject.pl", "db_6120", "f75bb07f4603", "db_6120");
$RDB->Execute("set names utf8");

require_once("p/libs/rp.class.php");
$rp=new rp();

$szablon->assign('RDB',$RDB);
$szablon->assign('rp',$rp);

//$szablon->setCacheLifetime(3600*3);

$modul=preg_replace('/[^a-z\-]/', '', $_REQUEST['m']);
if (strlen($modul)==0) $modul="404";
$szablon->assign('modul',$modul);

switch($modul){
	case "tagi":

		require_once("p/m.tagi.php");
		exit; break;
	case "ajax":
//        if ($_SERVER['REMOTE_ADDR']!='83.10.145.149')
//          die("Trwaja prace nad panelem.");

		require_once("p/m.ajax.php");
		exit;
		break;
	case "mini":
//        if ($_SERVER['REMOTE_ADDR']!='83.10.145.149')
//          die("Trwaja prace nad panelem.");

		require_once("p/m.mini.php");
		exit;
		break;
	case "profil":
//        if ($_SERVER['REMOTE_ADDR']!='83.10.145.149')
//          die("Trwaja prace nad panelem.");

		require_once("p/m.profil.php");
		break;
	case "quizrp":
        if ($_SERVER['REMOTE_ADDR']!='83.10.145.149')
          die("Trwaja prace nad panelem.");

		$szablon->add_bc('Quiz RP','/quizrp');
		require_once("p/m.quizrp.php");
		break;
	case "logowanie":
        if ($_SERVER['REMOTE_ADDR']!='83.10.145.149')
          die("Trwaja prace nad panelem.");

		require_once("p/m.logowanie.php");
		break;
	case "rejestracja":
//		die("Rejestracja nowych kont jest wstrzymana na czas przenosin serwera. Zapraszamy za kilka godzin.");
		$szablon->add_bc("Rejestracja konta", "/rejestracja");
		require_once("p/m.rejestracja.php");
//		$szablon->plik='m.rejestracja.tpl';
		break;
	case "frakcje":
		$szablon->add_bc("Frakcje", "/frakcje");
		require_once("p/m.frakcje.php");
		break;
	case "polec":
        die("Konkurs polecen jest obecnie wstrzymany, ich uruchomienie nastapi w ciagu kilku dni.");

		$szablon->add_bc("Poleć znajomemu, odbierz nagrodę", "/polec");
		require_once("p/m.polec.php");

		break;
/*
	case "changelog":
		require_once("p/libs/lastRSS.php");
		$RSS=new lastRSS();
		$zmiany=Array();
		if ($rs = $RSS->get('p/CHANGELOG.xml')) {
			$count=0;
			foreach($rs['items'] as $v) {
				$zmiany[]=Array('title'=>$v['title'],'data'=>$v['pubDate'],'autor'=>str_replace("Lukasz Biegaj","wielebny",$v['author']));
				
				if ($count++>100) break;
			}
		}
		$szablon->assign('zmiany',$zmiany);
		$szablon->plik='m.changelog.tpl';
		break;
*/
	case "info":
//        exit;
		require_once("p/m.info.php");
		break;
	case "frakcja":
        exit;
		$szablon->add_bc('Frakcje','/frakcje');
		require_once("p/m.frakcja.php");
		break;

	case "postac":
//        if ($_SERVER['REMOTE_ADDR']!='83.10.145.149')
//          die("Trwaja prace nad panelem.");

		$cid=intval($_REQUEST['cid']);
		$szablon->add_bc('Postacie','/postacie');
		require_once("p/m.postac.php");
		break;
	case "postacie":
	
//        if ($_SERVER['REMOTE_ADDR']!='83.10.145.149' && $_SERVER['REMOTE_ADDR']!='178.213.94.229')
//          die("Trwaja prace nad panelem.");

		$szablon->add_bc('Postacie','/postacie');
		require_once("p/m.postacie.php");

		break;
	case "domy":
        if ($_SERVER['REMOTE_ADDR']!='83.10.145.149')
          die("Trwaja prace nad panelem.");

		$szablon->add_bc('Domy','/domy');
		$szablon->dodaj_js('http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyA2AAeiAjN-Qjvd4h6VuEIZdkYdLe8h0OU');
		$szablon->dodaj_js('/s/js/mapa.js');

		if ($_REQUEST['m2']>0) {
//			if ($_SERVER['REMOTE_ADDR']!='83.10.174.174') die("Podstrona w trakcie przygotowywania");
			$dom=$RDB->GetRow("select d.id,d.descr,d.koszt,(IFNULL(d.ownerid,0)>0 AND d.paidTo>=DATE(NOW())) zajety,d.paidTo,d.drzwi,d.ownerid,u.login,concat(c.imie,' ',c.nazwisko) ownernick FROM rp_domy d LEFT JOIN rp_characters c ON c.id=d.ownerid LEFT JOIN rp_users u ON c.userid=u.id WHERE d.active=1 AND d.id=?",Array(intval($_REQUEST['m2'])));
			$dom['dzielnica']=getZoneName($dom['drzwi'][0], $dom['drzwi'][1], $dom['drzwi'][2]);

			$szablon->add_bc(intval($dom['id']).". ".$dom['descr'], "/domy/".intval($dom['id']));
			$dom['drzwi']=split(",",$dom['drzwi']);
			$szablon->assign('dom',$dom);

			$szablon->plik='m.dom.tpl';
			
			break;
		}

		$domy=$RDB->GetAll("select d.id,d.descr,d.koszt,(IFNULL(d.ownerid,0)>0 AND d.paidTo>=DATE(NOW())) zajety,d.drzwi,d.ownerid,concat(c.imie,' ',c.nazwisko) ownernick FROM rp_domy d LEFT JOIN rp_characters c ON c.id=d.ownerid WHERE d.active=1;");

		foreach ($domy as &$d) {
			$d['drzwi']=split(",",$d['drzwi']);
			$d['dzielnica']=getZoneName($d['drzwi'][0], $d['drzwi'][1], $d['drzwi'][2]);
		}

		$szablon->assign('domy',$domy);

//		$szablon->dodaj_js('http://openlayers.org/api/OpenLayers.js');

		$szablon->plik='m.domy.tpl';
		break;
	case "uslugi":
        if ($_SERVER['REMOTE_ADDR']!='83.10.145.149')
          die("Trwaja prace nad panelem.");

		$szablon->add_bc('Usługi płatne','/uslugi');
		$szablon->plik='m.uslugi.tpl';
		break;

	case "start":
        if ($_SERVER['REMOTE_ADDR']!='83.10.145.149')
          die("Trwaja prace nad panelem.");

		$szablon->plik='m.start.tpl';
		break;
	case "przywroc":
        if ($_SERVER['REMOTE_ADDR']!='83.10.145.149')
          die("Trwaja prace nad panelem.");

		require_once("p/m.przywroc.php");
		break;
	case "404":
	default:
		header("HTTP/1.0 404 Not Found");
		$szablon->plik='m.404.tpl';


}


$szablon->wyswietl();

