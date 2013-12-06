<?

global $DB;
switch($_REQUEST['a2']) {
    case "delete":
    	$cid=intval($_POST['characterid']);
    	if (!($cid>0)) die("Nieprawidlowe dane!");
        $DB->query("DELETE FROM lss_characters WHERE id=? LIMIT 1", Array($cid));
//        $DB->query("UPDATE lss_characters SET accepted=1 WHERE id=? LIMIT 1", Array($cid));

    	if ($DB->Affected_Rows()==1) { print "OK"; exit; }
    	else die("Nie znaleziono podana, moze ktos Cie uprzedzil?");

    case "accept": 
    	$cid=intval($_POST['characterid']);
    	if (!($cid>0)) die("Nieprawidlowe dane!");
        $DB->query("DELETE FROM lss_characters_podania WHERE id=? LIMIT 1", Array($cid));
        $DB->query("UPDATE lss_characters SET accepted=1 WHERE id=? LIMIT 1", Array($cid));

    	if ($DB->Affected_Rows()==1) { print "OK"; exit; }
    	else die("Nie znaleziono podana, moze ktos Cie uprzedzil?");
	
    default:
	die("Nieznana akcja!");
}

?>