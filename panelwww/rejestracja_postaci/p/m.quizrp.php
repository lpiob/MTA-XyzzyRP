<?

global $szablon,$RDB;
global $user;
if (!$user->data['is_registered']) {
	$szablon->append('bledy', "Nie jesteś zarejestrowany. Przejdź do <a href='http://forum.lss-rp.pl/ucp.php?mode=login'>logowania</a> lub <a href='http://lss-rp.pl/rejestracja'>rejestracji</a>.");
	$szablon->plik='m.quizrp.bledy.tpl';
	$szablon->wyswietl();
	exit;
}

$quiz=$RDB->GetOne("SELECT quiz FROM lss_users WHERE login=?", Array($user->data['username_clean']));

if (intval($quiz)==1) {
	$szablon->append('bledy', "Zdałeś już Quiz-RP. Nie możesz go przejść ponownie :-).");
//Nie jesteś zarejestrowany. Przejdź do <a href='http://forum.lss-rp.pl/ucp.php?mode=login'>logowania</a> lub <a href='http://lss-rp.pl/rejestracja'>rejestracji</a>.");
	$szablon->plik='m.quizrp.bledy.tpl';
	$szablon->wyswietl();
	exit;
}
$pytania=Array(
	Array('id'=>0,'pytanie'=>'Co oznacza skrót RP?', 'odpowiedzi'=>Array('Real Play', 'Role Play', 'Nie ma takiego określenia'), 'correct'=>1),
	Array('id'=>1,'pytanie'=>'Wskaż zdanie w którym został użyty metagaming.', 
			'odpowiedzi'=>Array('[l]Cześć Shawn! [s]Skąd znasz moje imię?[l]Masz napisane to nad głową.','[/me]Julius wpycha Shawna do samochodu a następnie go zabija.','[ic]Gdzie mogę kupić spadochron?'),
			'correct'=>0),
	Array('id'=>2,'pytanie'=>'Wskaż poprawne użycie komendy /me.', 'odpowiedzi'=>Array('/me ((ale jestem fajny, wszyscy mnie lubią)).','/me ptaki dookoła latają oraz ćwierkają.','/me rozgląda się dookoła.'), 'correct'=>2),
	Array('id'=>3,'pytanie'=>'Do czego służy czat OOC?', 'odpowiedzi'=>Array('Do nadawania ogłoszeń sprzedaży.','Do rozmów z graczami które nie dotyczą gry i postaci.','Do rozmów z graczami które dotyczą gry i postaci.'), 'correct'=>1),
	Array('id'=>4,'pytanie'=>'Jak zachowasz się podczas napadu na sklep wówczas gdy robisz zakupy.', 'odpowiedzi'=>Array('Zachowam spokój oraz będę wykonywał polecenia napastników.','Wyciągnę spluwę a następnie zacznę strzelać do każdego z nich.','Wyzwę ich od noobów a następnie wybiegnę ze sklepu.'), 'correct'=>0),
	Array('id'=>5,'pytanie'=>'W jaki sposób będziesz szukał/a pracy?', 'odpowiedzi'=>Array('Napiszę na czacie ooc czy ktoś mnie przyjmie.','Będę chodził/a po firmach i czytał tablice ogłoszeń.','Napiszę do administratora.'), 'correct'=>1),
	Array('id'=>6,'pytanie'=>'W jakiej sytuacji możesz pobić bądź zabić innego gracza?', 'odpowiedzi'=>Array('Gdy ten mnie wyzwie na czacie OOC.','Ponieważ mam ważny powód IC.','Mogę zabijać każdego napotkanego przechodnia.'), 'correct'=>1),
	Array('id'=>7,'pytanie'=>'W jakim celu używa się komendy /do?', 'odpowiedzi'=>Array('Do opisywania otoczenia, postaci oraz wykonywanych czynności.','Nie ma zastosowania.','Służy do nadawania ogłoszeń.'), 'correct'=>0),
	Array('id'=>8,'pytanie'=>'Jak się zachowasz gdy zobaczysz cheatera na serwerze.', 'odpowiedzi'=>Array('Będę się razem z nim dobrze bawił.','Zgłoszę go administracji a jeżeli nie ma takowego to zrobię screeny i napiszę w odpowiednim dziale na forum.','Ucieknę z serwera, ponieważ nie chcę BW.'), 'correct'=>1),
	Array('id'=>9,'pytanie'=>'Co to jest Brutally Wounded?', 'odpowiedzi'=>Array('Stan w którym moja postać jest nieprzytomna.','Jazda samochodem po pijanemu.','Jest to wymuszenie na innym graczu akcji RP.'), 'correct'=>0),
//	Array('pytanie'=>'', 'odpowiedzi'=>Array('','',''), 'correct'=>),
//	Array('pytanie'=>'', 'odpowiedzi'=>Array('','',''), 'correct'=>),
);

function sprawdzOdp($pytanie,$odpowiedz){
	global $pytania;
	foreach($pytania as $p) {
		if ($p['id']==$pytanie) {
			if ($odpowiedz==$p['correct']) return true;
			return false;
		}
	}
	return false;
}

if ($_SERVER['REQUEST_METHOD']=='POST') {

	$odpowiedzi=Array();
	$dobre=0;
	$zle=0;
	foreach ($_POST as $k=>$v) {
		if ($k[0]=="p") {
			$odpowiedzi[intval($k[1])]=intval($v);
			if (sprawdzOdp(intval($k[1]),intval($v)))
				$dobre++;
			else
				$zle++;
		}
	}
	if (count($odpowiedzi)<10) {
		$szablon->append('bledy', "Niestety, nie udzielono odpowiedzi na wszystkie pytania. Cofnij się i popraw odpowiedzi.");
		$szablon->plik='m.quizrp.bledy.tpl';
		$szablon->wyswietl();
		exit;
	}
	if ($zle>0) {
		$szablon->append('bledy', "Niestety, nie udzielono poprawnej odpowiedzi na wszystkie pytania. Cofnij się i popraw odpowiedzi. Ilość błędów: ".$zle);
		$szablon->plik='m.quizrp.bledy.tpl';
		$szablon->wyswietl();
		exit;
	}
	// wszystko ok
	$RDB->execute("UPDATE lss_users SET quiz=1 WHERE login=?", Array($user->data['username_clean']));
	$szablon->plik='m.quizrp.zdany.tpl';
//	$szablon->plik='m.quizrp.bledy.tpl';
	$szablon->wyswietl();
	exit;
}

$szablon->plik='m.quizrp.pytania.tpl';




shuffle($pytania);

$szablon->assign('pytania', $pytania);


$szablon->wyswietl();
exit;