<?

global $LVL;
if ($LVL<2) die("Nie masz dostepu do tej zakladki.");

global $DB;

$podania=$DB->getAll("select p.id,u.login,c.imie,c.nazwisko,p.id,p.tresc from lss_characters_podania p join lss_characters c on c.id=p.id join lss_users u on u.id=c.userid;");


$smarty->assign('podania',$podania);
$smarty->display('podania.tpl');
//print($q);

?>