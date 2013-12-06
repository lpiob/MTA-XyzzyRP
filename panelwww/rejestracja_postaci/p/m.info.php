<?
global $szablon,$RDB,$user;

global $ipblogin,$user;
//print $ipblogin['server_id'];
//if (!($ipblogin['member_id']>0)) {



switch ($_REQUEST['m2']) {
  case "changelog": 
	if ($_SERVER['REQUEST_METHOD']=='POST' && strlen($_POST['opis'])>1 && $LSS->perm_manage) {
		$userid=$RDB->GetOne("SELECT id FROM lss_users WHERE id=?", Array($ipblogin['server_id']));
		$RDB->Execute("INSERT INTO lss_aktualnosci SET opis=?,autor=?", Array($_POST['opis'], $userid));
	}
	$szablon->plik='m.info.changelog.tpl';
	$szablon->add_bc("Changelog", "/info/changelog");
	$changelog=$RDB->GetAll("SELECT a.ts,a.opis,u.login FROM lss_aktualnosci a JOIN lss_users u ON u.id=a.autor ORDER BY ts DESC LIMIT 10");
	$szablon->assign('changelog', $changelog);


	break;
  case "teamactivity":
	// sprawdzamy czy dana osoba ma dostep
	
	$dostep=$RDB->GetOne("SELECT 1 FROM lss_users WHERE level>0 AND id=?", Array($ipblogin['server_id']));
	if (!(intval($dostep)>0))
	  die("Brak dostępu");

	// loginy czlonkow ekipy
	$dane_loginy=$RDB->CacheGetAll(60,"SELECT login FROM lss_users WHERE level>0 ORDER BY login ASC");
	$loginy=Array();
	foreach ($dane_loginy as $v) $loginy[]=$v['login'];

	// aktywnosc tygodniowa
	$do_wyrobienia=600;
	$dane_aktywnosci=$RDB->CacheGetAll(60,"SELECT WEEK(ua.data) tydzien,ua.id_user,u.login,sum(ua.minut) minut FROM lss_users_activity ua JOIN lss_users u ON u.id=ua.id_user WHERE datediff(NOW(),ua.data)<14 GROUP BY WEEK(ua.data),ua.id_user ORDER BY tydzien ASC,login ASC;");
	$aktywnosc_tygodniowa=Array();
	foreach ($dane_aktywnosci as $v)
	  if (!isset($aktywnosc_tygodniowa[$v['tydzien']]))
		  foreach ($loginy as $login) 
			$aktywnosc_tygodniowa[$v['tydzien']][$login]=Array('minutabs'=>0, 'pozostalo'=>$do_wyrobienia, 'norma'=>0);
	foreach ($dane_aktywnosci as $v) {
	  $pozostalo=$do_wyrobienia-intval($v['minut']);
	  if ($pozostalo<0) $pozostalo=0;
	  $norma=(intval($v['minut'])/$do_wyrobienia)*100;
	  if ($norma>100) $norma=100;
	  $aktywnosc_tygodniowa[$v['tydzien']][$v['login']]=Array('minutabs'=>$v['minut'], 'pozostalo'=>$pozostalo, 'norma'=>$norma);
	}
	$szablon->assign('aktywnosc_tygodniowa',$aktywnosc_tygodniowa);

	$szablon->plik='m.info.teamactivity.tpl';
	break;
  default:
	Header("Location: /info/changelog");
	exit;
}


$szablon->wyswietl();
exit;
?>