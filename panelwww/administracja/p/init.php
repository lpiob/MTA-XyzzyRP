<?
session_start('fsadm');

require_once("p/libs/adodb5/adodb.inc.php");

$DB=NewADOConnection("mysql");
$DB->Connect("mysql-1.serverproject.pl", "db_3426", "TU WPISZ HASLO DO SERWERA GRY", "db_3426");
$DB->Execute("set names utf8");

$LVL=0;

if ($_SERVER['REQUEST_METHOD']=='POST' && $_POST['login'] && $_POST['haslo']) {
	$hasz=md5(strtolower($_POST['login']) . "MRFX_01" . $_POST['haslo']);
    $autentykacja=$DB->CacheGetOne(600,"SELECT 1 FROM lss_users WHERE level>=2 AND login=? AND hash=?",Array($_POST['login'], $hasz));

    if (intval($autentykacja)!=1) die("Logowanie nieudane!" . $autentykacja);
//	die($_POST['login'] . " - " . strtolower($hash) . " - " . $_SESSION['authkey']);
    $_SESSION['authkey']=md5($_POST['login'].strtolower($hasz));
	$_SESSION['login']=htmlspecialchars($_POST['login']);
//	die($_POST['login'] . " - " . strtolower($hash) . " - " . $_SESSION['authkey']);
}
if (!isset($_SESSION['authkey'])) {
    Header("Location: /auth.html"); exit;
} else {
								// j.w.
    $autentykacja=$DB->CacheGetOne(600,"SELECT level FROM lss_users WHERE level>=2 AND md5(CONCAT(login,LOWER(hash)))=?", Array($_SESSION['authkey']));

    if (!(intval($autentykacja)>=2)) {
//		die($_SESSION['authkey']);
	    @session_destroy();
	    Header("Location: /auth.html");
	    exit;
    }
    $LVL=intval($autentykacja);
}


require_once("libs/Smarty.class.php");
$smarty=new Smarty();
$smarty->template_dir='p/tpl';
$smarty->compile_dir='p/tpl_c';
$smarty->plugins_dir='p/libs/plugins/';

if ($LVL<2) die("Nieprawidlowy poziom dostepu.");
$smarty->assign('LVL',$LVL);


