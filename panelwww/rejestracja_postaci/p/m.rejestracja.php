<?
global $szablon,$RDB;

$polecajacy=false;

if (isset($_REQUEST['m2'])) {
	$polecajacy=intval($_REQUEST['m2'])^31337;
	if ($polecajacy>0) {
		$polecajacy_nick=$RDB->GetOne("select login from lss_users where id=?", array($polecajacy));
		$szablon->assign('polecajacy', $polecajacy);
		$szablon->assign('polecajacy_nick', $polecajacy_nick);
	}
}



if ($_SERVER['REQUEST_METHOD']=='GET' && $_REQUEST['uid'] && $_REQUEST['klucz']) {
	// weryfikujemy potwierdzenie
	$uid=intval($_REQUEST['uid']);
	$klucz=$_REQUEST['klucz'];
	$dd=$RDB->GetRow("SELECT id,login,hash,email,polecajacy FROM lss_registrations WHERE id=? AND md5(concat(id,email,id))=?",array($uid,$klucz));
	if (intval($dd['id'])!=$uid) {
			$szablon->plik='m.rejestracja.zla-aktywacja.tpl';
			$szablon->wyswietl();
			exit;
	}
	$szablon->assign('login',$dd['login']);

	// rejestracja konta
	$RDB->execute("DELETE FROM lss_registrations WHERE id=?", array($uid));
	$RDB->execute("INSERT INTO lss_users SET login=?,hash=?,email=?,polecajacy=?", array($dd['login'],$dd['hash'],$dd['email'],$dd['polecajacy']));
	$szablon->plik='m.rejestracja.zakonczona.tpl';
	$szablon->wyswietl();
	
	exit;
}


if ($_SERVER['REQUEST_METHOD']=='POST') {

	$bledne=false;
	$login=strtr($_POST['login'],"\"'","..");
	if ($login!=$_POST['login']) {
		unset($_POST['login']);
		$bledne=true;
		$szablon->append('rejestracja_bledy',"Login zawiera niedozwolone znaki.");

	}
	
	$haslo=$_POST['haslo'];
	$email=strtr($_POST['email'],"\"'", "..");
	if ($email!=$_POST['email']) {
		unset($_POST['email']);
		$bledne=true;
		$szablon->append('rejestracja_bledy',"E-mail zawiera niedozwolone znaki.");

	}

	if (strlen($login)<1) {
		$bledne=true;
		$szablon->append('rejestracja_bledy',"Musisz podać login.");
	}
	if (strlen($haslo)<5) {
		$bledne=true;
		$szablon->append('rejestracja_bledy',"Hasło musi mieć przynajmniej 5 znaków.");
	}
	if ($haslo!=$_POST['haslo2']) {
		$bledne=true;
		$szablon->append('rejestracja_bledy',"Powtórzone hasło nie zgadza się.");
	}
	if (strlen($email)<6) {
		$bledne=true;
		$szablon->append('rejestracja_bledy', "Musisz podać prawidłowy adres e-mail.");
	}
    // koszmail itd
    $trolle=Array('/@koszmail.pl$/','/@asdasd.ru$/','/@yopmail.com$/','/@filzmail.com$/','/@rtrtr.com$/','/@sharklasers.com$/','/@rppkn.com$/');
    foreach ($trolle as $re)
      if (preg_match($re, $email)) {
        $bledne=true;
        $szablon->append('rejestracja_bledy', "Podaj prawdziwy adres e-mail.");
      }
    // blokady wypelniania formularza
    if (!$bledne) {
      $blokada=$RDB->CacheGetOne(60,"SELECT TIMEDIFF(ts,NOW()) FROM lss_blocked_registrations WHERE ip=INET_ATON(?) AND ts>NOW()", Array($_SERVER['REMOTE_ADDR']));
      if ($blokada) {
        $bledne=true;
        $szablon->append('rejestracja_bledy', "Na Twój adres IP została nałożona blokada prób rejestracji. Będziesz mógł/a spróbować ponownie za: ".$blokada);
      }
      $RDB->Execute("DELETE FROM lss_blocked_registrations WHERE ts<NOW()");
    }
  
    // quiz
    if (!$bledne && ($_POST['pyt_1']!=2 || $_POST['pyt_2']!=4 || $_POST['pyt_3']!=1)) {
      $bledne=true;
      $szablon->append('rejestracja_bledy', "Podano nieprawidłowe odpowiedzi na pytania kontrolne. Rejestracje z Twojego adresu IP zostają wstrzymane na godzinę.");
      $RDB->Execute("INSERT INTO lss_blocked_registrations SET ip=INET_ATON(?),ts=NOW() + INTERVAL 1 HOUR ON DUPLICATE KEY UPDATE ts=NOW() + INTERVAL 1 HOUR", Array($_SERVER['REMOTE_ADDR']));
    }
    

	if (!$bledne) {
		// sprawdzamy czy login nie jest zajety
		$val=$RDB->GetOne("SELECT 1 FROM lss_users WHERE login=?",Array($login));
		if ($val==1) {
			$bledne=true;
			$szablon->append('rejestracja_bledy', "Podany przez Ciebie login jest już zajęty. Wybierz inny.");
		}
		// sprawdzamy czy email nie jest zajety
		$val=$RDB->GetOne("SELECT 1 FROM lss_users WHERE email=?",Array($email));
			if ($val==1) {
			$bledne=true;
			$szablon->append('rejestracja_bledy', "Podany przez Ciebie adres e-mail jest już przypisany do innego konta.");
		}
		// to samo w forum
/*
		$val=$FDB->GetOne("SELECT 1 FROM flss_users WHERE lower(username)=LOWER(?) LIMIT 1", Array($login));
		if ($val==1) {
			$bledne=true;
			$szablon->append('rejestracja_bledy', "Podany przez Ciebie login jest już zajęty. Wybierz inny.");
		}
*/
		
		
	if ($bledne) {
		$szablon->plik='m.rejestracja.tpl';
		$szablon->wyswietl();
		exit;
	}

	// todo ograniczenie czasowe
	$hash=md5(strtolower($login)."MRFX_01".$haslo);
	$RDB->execute("DELETE FROM lss_registrations WHERE login=? OR email=?", array($login, $email));

	if (!$_POST['polecenie']) $polecajacy=0;

	$RDB->execute("INSERT INTO lss_registrations SET login=?,email=?,hash=?,ip=?,polecajacy=?", array($login,$email,$hash,$_SERVER['REMOTE_ADDR'],$polecajacy));
	$iid=intval($RDB->Insert_ID());
	$klucz=md5($iid.$email.$iid);
	$link="http://panel.lss-rp.pl/rejestracja?uid=".$iid."&klucz=".$klucz;
	$wiadomosc="Dziękujemy za rejestrację na LSS-RP.pl. Aby ją potwerdzić, kliknij w poniższy link:\r\n\r\n$link\r\n\r\nJeśli nie rejestrowałeś się u nas, zignoruj tą wiadomość\r\n\r\n-- \r\nEkipa LSS-RP.pl";
	mail($email,"Rejestracja w XyzzyRP", $wiadomosc, "From: LSS-RP <no-reply@xyzzyrp.pl>");
//	mail("wielebny@bestplay.pl", "LSS-RP rejestracja", "$login\r\n$email\r\n".$_POST['skad']."\r\n");

	$szablon->plik='m.rejestracja.ok.tpl';
	$szablon->wyswietl();
	exit;

	}
	
}


$szablon->plik='m.rejestracja.tpl';

?>