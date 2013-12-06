<?
global $szablon,$RDB,$LSS;
$szablon->plik='m.postac.tpl';
global $user;
$cid=intval($_REQUEST['cid']);
if (!$cid) {
    $szablon->blad_krytyczny("Nie odnaleziono podanej postaci.");
    exit;
};

$cachetime=60;

if ($_SERVER['REQUEST_METHOD']=='POST' && $_POST['ma']=="changepremiumskin") {
    if (!$user->data['is_registered']) {
	$szablon->blad_krytyczny("Nie jestes zalogowany/a!");
	exit;
    }
    // sprawdzamy czy postac nalezy do gracza
    $postacUzytkownika=$RDB->GetOne("select 1 FROM lss_characters c JOIN lss_users u ON u.id=c.userid WHERE c.id=? and u.login=?", Array($cid,$user->data['username_clean']));
    if (!$postacUzytkownika) {
	$szablon->blad_krytyczny("Ta postac nie nalezy do Ciebie.");
	exit;
    }
    // sprawdzamy czy podany skin nalezy do skinow premium
    $newskin=intval($_POST['skinpremium']);
    if ($newskin>=0 && !$LSS->validPremiumSkin($newskin)) {
    	$szablon->blad_krytyczny("Podano niewlasciwe ID skinu.");
	exit;
    }
    // aktualizujemy dane
    if ($newskin<0)
        $RDB->Execute("UPDATE lss_characters SET premiumskin=NULL WHERE id=? LIMIT 1", Array($cid));
    else
        $RDB->Execute("UPDATE lss_characters SET premiumskin=? WHERE id=? LIMIT 1", Array($newskin,$cid));
    $cachetime=0;
};

if ($_SERVER['REQUEST_METHOD']=='POST' && $_POST['ma']=="characterupdate") {
    $postacUzytkownika=$RDB->GetOne("select 1 FROM lss_characters c JOIN lss_users u ON u.id=c.userid WHERE c.id=? and u.login=?", Array($cid,$user->data['username_clean']));
    if (!$postacUzytkownika) {
	$szablon->blad_krytyczny("Ta postac nie nalezy do Ciebie.");
	exit;
    }

	$rasy=Array("biala","czarna","zolta");
	$rasa=$_POST['rasa'];
	if (!in_array($rasa,$rasy)) die("Podano nieprawidłowe dane. Uzyj przycisku wstecz i sprobuj ponownie.");
//	$data=date_create_from_format('Y.m.d',$_POST['data_urodzenia']);
//	$data=strptime('%Y.%m.%d',$_POST['data_urodzenia']);
//	if ( $data->format('Y')<1920) die("Podano nieprawidłowe dane. Uzyj przycisku wstecz i sprobuj ponownie.");
//	if ( $data->format('Y')>date("Y")) die("Podano nieprawidłowe dane. Uzyj przycisku wstecz i sprobuj ponownie.");

//	$RDB->Execute("UPDATE lss_characters SET rasa=?,data_urodzenia=? WHERE id=?",Array($rasa,$data->format("Y-m-d"),$cid));
	$RDB->Execute("UPDATE lss_characters SET rasa=? WHERE id=?",Array($rasa,$cid));
	$cachetime=0;
};

if ($_SERVER['REQUEST_METHOD']=='POST' && $_POST['ma']=="manage_character") {
	if (!$LSS->perm_manage) die("Brak dostepu.");
//	$RDB->debug=true;
	$RDB->Execute("UPDATE lss_characters SET imie=?,nazwisko=? WHERE id=?", Array($_POST['imie'], $_POST['nazwisko'], $cid));

	$cachetime=0;
//	print_r($_POST);
//	exit;
};


$postac=$RDB->CacheGetRow($cachetime,"SELECT c.id,c.imie,c.nazwisko,c.rasa,c.data_urodzenia,c.skin,c.premiumskin,c.hp,c.ar,c.energy,c.stamina,c.dead,u.premium>NOW() premium,u.login from lss_characters c JOIN lss_users u ON u.id=c.userid WHERE c.id=?", Array($cid));



$postac['original_skin']=$postac['skin'];

if ($postac['premium']>0 && $postac['premiumskin']>0)
    $postac['skin']=$postac['premiumskin'];
    

if ($user->data['is_registered'] && strtolower($postac['login'])==strtolower($user->data['username_clean']))
    $postac['owncharacter']=true;


$url="/postacie/".$cid.",".urlify($postac['imie'])."_".urlify($postac['nazwisko']);
$szablon->add_bc($postac['imie']." ".$postac['nazwisko'],$url);

$szablon->assign('postac',$postac);

// czlonkowstwo we frakcjach
$frakcje=$RDB->CacheGetAll(3600,"SELECT f.name,fr.name rank_name,cf.faction_id,cf.jointime,cf.lastduty from lss_character_factions cf JOIN lss_faction f ON f.id=cf.faction_id JOIN lss_faction_ranks fr ON fr.faction_id=cf.faction_id AND fr.rank_id=cf.rank WHERE character_id=?", Array($cid));
$szablon->assign('frakcje',$frakcje);

// osiagnieca
$osiagniecia=$RDB->CacheGetAll(3600,"select ah.ts,an.descr,ah.achname,ah.amount,ah.notes from lss_achievements_history ah JOIN lss_achievements_name an ON an.achname=ah.achname WHERE ah.character_id=?;", Array($cid));
$szablon->assign('osiagniecia',$osiagniecia);


// dodatkowy wybor skinow dla premium

if ($postac['premium']>0) {
    if ($LSS->skinMeski($postac['original_skin']))
	$skiny_premium=$LSS->skiny_m_premium;
    else
	$skiny_premium=$LSS->skiny_f_premium;    
    $szablon->assign('skiny_premium', $skiny_premium);
}

$szablon->wyswietl();
exit;
?>