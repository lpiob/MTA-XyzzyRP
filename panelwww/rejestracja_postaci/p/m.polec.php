<?
global $szablon,$RDB,$user;
$szablon->plik='m.polec.tpl';

if ($user->data['is_registered']) {
	$id_gracza=$RDB->GetOne("SELECT id FROM lss_users WHERE login=?", array($user->data['username_clean']));
	if ($id_gracza>0) {
		$szablon->assign('login_gracza', $user->data['username_clean']);
	
		$szablon->assign('id_gracza', $id_gracza);
		$szablon->assign('id_gracza_obf', intval($id_gracza) ^ 31337);
	};
}

$ostatnie_polecenia=$RDB->CacheGetAll(60, "select l1.login,l1.registered,l2.login login2 from lss_users l1 JOIN lss_users l2 ON l1.polecajacy=l2.id WHERE l1.polecajacy>0 AND l1.polecajacy_done IS NULL ORDER BY l1.registered DESC limit 7");
$szablon->assign('ostatnie_polecenia',$ostatnie_polecenia);

$wkrotce_nagrodzeni=$RDB->CacheGetAll(60, "select l1.login,l1.gp,l1.registered,l2.login login2 from lss_users l1 JOIN lss_users l2 ON l1.polecajacy=l2.id WHERE l1.polecajacy>0 AND l1.polecajacy_done IS NULL  ORDER BY l1.gp DESC limit 7");
$szablon->assign('wkrotce_nagrodzeni', $wkrotce_nagrodzeni);

$wlasnie_nagrodzeni=$RDB->CacheGetAll(60, "select l1.login,l1.gp,l1.polecajacy_done,l1.registered,l2.login login2 from lss_users l1 JOIN lss_users l2 ON l1.polecajacy=l2.id WHERE l1.polecajacy>0 AND l1.polecajacy_done IS NOT NULL  ORDER BY l1.polecajacy_done DESC limit 7");
$szablon->assign('wlasnie_nagrodzeni', $wlasnie_nagrodzeni);

$szablon->wyswietl();
exit;
?>