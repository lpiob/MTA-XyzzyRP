<?
global $RDB,$szablon;
$m2=$_REQUEST['m2'];
if (is_numeric($m2)) {
  $dane=$RDB->CacheGetOne("SELECT pngdata FROM lss_tagi WHERE id=?", Array(intval($m2)));
  Header("Content-type: image/png");
  print($dane);
  exit;
}


$tagi=$RDB->CacheGetAll(180,"SELECT t.id,t.creator,c.imie,c.nazwisko,t.ts,t.x,t.y,t.z FROM lss_tagi t JOIN lss_characters c ON c.id=t.creator;");
$szablon->assign('tagi', $tagi);
$szablon->plik="m.tagi.tpl";
$szablon->wyswietl();

exit;