<?
global $szablon,$RDB;
$szablon->add_bc('Profil','/profil');

global $ipblogin,$user;
//print_r($ipblogin['server_id']);exit;
if (!($ipblogin['server_id']>0)) {
	$szablon->blad_krytyczny("Nie jesteś zarejestrowany. Przejdź do <a href='http://lss-rp.pl/index.php?app=core&module=global&section=login'>logowania</a> lub <a href='http://lss-rp.pl/index.php?app=core&module=global&section=register'>rejestracji</a>.");
	exit;
}

function vrfyCurP($haslo) {
  global $ipblogin,$RDB;
//$RDB->debug=true;
  $zgadzasie=$RDB->GetOne("SELECT 1 FROM lss_users WHERE id=? AND hash=?", Array($ipblogin['server_id'], strtolower(md5(strtolower($ipblogin['name'])."MRFX_01".$haslo))));

  return intval($zgadzasie)>0;
}

if ($_SERVER['REQUEST_METHOD']=='POST') {
  if (strlen($_POST['aktualne'])<1 || strlen($_POST['nowe1'])<1 || strlen($_POST['nowe2'])<1) {
	$szablon->append("bledy", "Nie uzupełniłeś/aś wszystkich pól w formularzu.");
  } elseif (!vrfyCurP($_POST['aktualne'])) {
	$szablon->append("bledy", "Aktualne hasło nie jest prawidłowe.");
  } elseif ($_POST['nowe1']!=$_POST['nowe2']) {
	$szablon->append("bledy", "Nowe hasło nie zostało powtórzone prawidłowo.");
  } elseif (strlen($_POST['nowe1'])<6) {
	$szablon->append("bledy", "Nowe hasło musi mieć conajmniej 6 znaków.");
  } else {	// zmieniamy hasło
//	$RDB->debug=true;
	$RDB->Execute("UPDATE lss_users SET hash=? WHERE id=? LIMIT 1", 
      Array( 
        strtolower(md5(strtolower($ipblogin['name'])."MRFX_01".$_POST['nowe1'])),
        $ipblogin['server_id']
      )
    );
	$szablon->append("informacje", "Hasło zostało zmienione.");
  }

}


$szablon->plik="m.profil.tpl";
$szablon->wyswietl();
exit;