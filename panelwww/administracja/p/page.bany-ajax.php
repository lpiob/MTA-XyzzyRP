<?

global $DB;
switch($_REQUEST['a2']) {
    case "unban": 
	$banid=intval($_POST['banid']);
	if (!($banid>0)) die("Nieprawidlowe dane!");
	$notes=date("Y-m-d")." skrócenie bana przez " . $_SESSION['login'];
	$DB->query("UPDATE lss_bany SET date_to=NOW(),notes=CONCAT(notes,'\n',?) WHERE id=? AND date_to>NOW() LIMIT 1",Array($notes,$banid));
	if ($DB->Affected_Rows()==1) { print "OK"; exit; }
	else die("Nie znaleziono bana, byc moze juz wygasl?");
	
    default:
	die("Nieznana akcja!");
}

?>