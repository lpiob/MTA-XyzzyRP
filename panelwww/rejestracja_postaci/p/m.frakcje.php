<?
global $szablon,$RDB;
$szablon->plik='m.frakcja.tpl';

$fid=intval($_REQUEST['fid']);
if (!$fid) {
    $szablon->blad_krytyczny("Nie odnaleziono podanej frakcji.");
    exit;
};

$frakcja=$RDB->CacheGetRow(3600,"SELECT * FROM lss_faction WHERE id=?", Array($fid));

$url="/frakcje/".$fid.",".urlify($frakcja['name']);
$szablon->add_bc($frakcja['name'],$url);

$szablon->assign('frakcja',$frakcja);

// rangi i czlonkowie
$rangi=$RDB->CacheGetAll(3600,"select rank_id,name from lss_faction_ranks where faction_id=? order by rank_id desc", Array($fid));
$czlonkowie=$RDB->CacheGetAll(3600,"SELECT cf.character_id,c.imie,c.nazwisko,cf.rank,cf.jointime,cf.lastduty FROM lss_character_factions cf JOIN lss_characters c ON c.id=cf.character_id WHERE cf.faction_id=?", Array($fid));
$szablon->assign('rangi', $rangi);
$szablon->assign('czlonkowie', $czlonkowie);

$szablon->wyswietl();
exit;
?>