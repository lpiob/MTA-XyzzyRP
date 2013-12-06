<?
global $szablon,$RDB;
$szablon->plik='m.postacie.tpl';

global $ipblogin,$user;
//print_r($ipblogin);

if (!($ipblogin['server_id']>0)) {
	$szablon->append('bledy', "Nie jesteś zarejestrowany. Przejdź do <a href='http://lss-rp.pl/index.php?app=core&module=global&section=login'>logowania</a> lub <a href='http://lss-rp.pl/index.php?app=core&module=global&section=register'>rejestracji</a>.");
	$szablon->plik='m.postacie.bledy.tpl';
	$szablon->wyswietl();
	exit;
}
/*
$quiz=$RDB->GetOne("SELECT quiz FROM lss_users WHERE id=?", Array($ipblogin['server_id']));
if (intval($quiz)!=1) {
	$szablon->append('bledy', "Przed założeniem postaci musisz przejść <a href='/quizrp'>test sprawdzający znajomość zasad RP</a>.");
	$szablon->plik='m.postacie.bledy.tpl';
	$szablon->wyswietl();
	exit;
}
*/

$dozwolone_skiny_m=Array(1,2,7,14,15,17,19,20,21,22,23,24,25,28,29,30,32,33,34,35,37,43,44,46,47,48,57,59,60,66,72,98,120,121,124,127,156,165,170,176,177,179,181,183,186,217,223,228,240,242,248,250,258,261,290,291,292,293,296,297,299);
// skiny bez screenow:
$dozwolone_skiny_f=Array(9,10,12,13,31,40,41,55,56,69,91,93,131,141,151,157,169,192,193,196,197,211,233,243,298);
//$dozwolone_skiny_f=Array(1,2,7,12,14,15,17,19,20,22,23,24,25,28,29,30,31,32,33,34,35,36,37,40,41,43,44,46,47,48,55,56,57,64,69,85,91,93,131,141,151,157,169,192,193,196,197,211,233,242,245,261,291,296,297,298,299);
//$dozwolone_skiny_m=Array(9,10,12,13,15,32,34,40,41,43,55,56,59,60,72,78,127,156,165,170,176,177,179,186,223,233,240,243,250,258,263,291);


$szablon->assign('dozwolone_skiny_f',$dozwolone_skiny_f);
$szablon->assign('dozwolone_skiny_m',$dozwolone_skiny_m);


$limit_postaci=$RDB->GetOne("SELECT character_limit FROM lss_users WHERE id=?", Array($ipblogin['server_id']));
$postacie=$RDB->GetAll("select c.id,c.accepted,c.playtime,c.imie,c.nazwisko,c.created,c.dead,c.skin,c.tytul,c.hp,c.ar,c.money,c.stamina,c.energy FROM lss_characters c JOIN lss_users u ON u.id=c.userid WHERE u.id=?", Array($ipblogin['server_id']));
$postacie_zywe=$RDB->GetOne("select count(c.id) FROM lss_characters c JOIN lss_users u ON u.id=c.userid WHERE c.dead IS NULL AND u.id=?", Array($ipblogin['server_id']));
$szablon->assign('postacie',$postacie);
$szablon->assign('postacie_zywe',$postacie_zywe);
$szablon->assign('limit_postaci',$limit_postaci);


if ($_SERVER['REQUEST_METHOD']=='POST') {
	$skin=intval($_POST['skin']);
	$imie=stripslashes($_POST['imie']);
	$nazwisko=stripslashes($_POST['nazwisko']);

    if (strlen($imie)<2) {
      $szablon->append('bledy','Podaj imię swojej postaci.');
      $szablon->wyswietl();
      exit;
    }

    if (strlen($nazwisko)<2) {
      $szablon->append('bledy','Podaj nazwisko swojej postaci.');
      $szablon->wyswietl();
      exit;
    }


	if (!in_array($skin,$dozwolone_skiny_f) && !in_array($skin,$dozwolone_skiny_m)) {
      $szablon->append('bledy','Wybrano niewłaściwy skin.');
      $szablon->wyswietl();
      exit;
    };

	$uid=intval($ipblogin['server_id']);
	if (!$uid>0)
		die("Nie odnaleziono użytkownika w bazie danych ");
//	$RDB->debug=true;
	$RDB->execute("INSERT INTO lss_characters SET userid=?,imie=?,nazwisko=?,created=NOW(),skin=?,fingerprint=md5(rand())", Array($uid,$imie,$nazwisko,$skin));
    // postacid
    $pid=$RDB->Insert_ID();
    $podanie=$_POST['pyt_1_pytanie'].": ".$_POST['pyt_1_odpowiedz']."\n\n".
            $_POST['pyt_2_pytanie'].": ".$_POST['pyt_2_odpowiedz']."\n\n".
            $_POST['pyt_3_pytanie'].": ".$_POST['pyt_3_odpowiedz']."\n\n".
            $_POST['pyt_4_pytanie'].": ".$_POST['pyt_4_odpowiedz']."\n\n";
    $RDB->execute("INSERT INTO lss_characters_podania set id=?,tresc=?", Array($pid,$podanie));

	Header("Location: /postacie?");
	exit;

}


// 12,31,40,41,55,56,64,69,85,91,93,131,141,151,157,169,192,193,196,197,211,233,245,298
// 15,32,34,43,59,60,72,78,127,156,165,170,176,177,179,186,223,240,250,258,310


$szablon->wyswietl();
exit;
?>