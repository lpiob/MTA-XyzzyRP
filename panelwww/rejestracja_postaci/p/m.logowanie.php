<?
global $szablon,$RDB,$LSS;

//unset($_SESSION['auth']);
setcookie('Vanilla', ' ', time() - 3600, '/', '.lss-rp.pl'); unset($_COOKIE['Vanilla']);
setcookie('LSSAUTH', ' ', time() - 3600, '/', '.lss-rp.pl'); unset($_COOKIE['LSSAUTH']);

if ($_SERVER['REQUEST_METHOD']=='POST') {
    if (strlen($_POST['login'])<1 || strlen($_POST['haslo'])<1) {
	$szablon->append("bledy","Wypełnij wszystkie pola.");
    }
    $hash=strtolower(md5(strtolower($_POST['login'])."MRFX_01".$_POST['haslo']));
    $dane=$RDB->GetRow("SELECT id,login,email FROM lss_users WHERE login=? AND hash=? LIMIT 1", Array($_POST['login'], $hash));
    if ($dane && intval($dane['id'])>0) {
	$_SESSION['auth']=1;
	$_SESSION['login']=$dane['login'];
	$_SESSION['email']=$dane['email'];
	$_SESSION['userid']=intval($dane['id']);
	$ck=intval($dane['id'])."|".md5($dane['email'].$_SERVER['REMOTE_ADDR']);

	setcookie('LSSRPAUTH', $ck, time() + 3600*24, '/', '.lss-rp.pl');
//	print $ck;
//	exit;
	Header("Location: http://mybb.lss-rp.pl/");
	exit;
    } else {
	$szablon->append("bledy","Autoryzacja nieudana. Sprawdź podany login i hasło.");
    }
}

$szablon->add_bc("Logowanie","/logowanie");
$szablon->plik='m.logowanie.tpl';

?>