<?
//		print_r($_REQUEST);
switch($_REQUEST['m2']) {
  case "changelog":
		$plik="/home/lbiegaj/lss-rp.pl/public_html/changelog.html";
		$plikrss="/home/lbiegaj/lss-rp.pl/public_html/changelog.xml";
		$changelog=$RDB->CacheGetAll(120,"SELECT a.ts,a.opis,u.login FROM lss_aktualnosci a JOIN lss_users u ON u.id=a.autor ORDER BY ts DESC LIMIT 15");
		$szablon->assign('changelog', $changelog);
		$chgtpl=$szablon->fetch("m.mini.changelog.tpl");
		$fh=fopen($plik,"w");
		fwrite($fh,$chgtpl);
		fclose($fh);

		$chgtpl=$szablon->fetch("m.mini.changelog-rss.tpl");
		$fh=fopen($plikrss,"w");
		fwrite($fh,$chgtpl);
		fclose($fh);

		exit;
  case "onlineplayers":



		$plik="/home/lbiegaj/lss-rp.pl/public_html/onlineplayerlist.txt";
		$gracze=$LSS->getOnlinePlayerList();
		$graczy=0;

//		print $uidy;
		
//		print_r($gracze);
		$fh=fopen($plik,"w");
		fwrite($fh,"<ul class='onlineplayerlist'>");
		foreach($gracze as $g) {
		  // { tonumber(c.id), c.imie.." "..c.nazwisko, c.skin, getElementData(v,"auth:uid"), (getElementData(v,"premium") and 1 or 0) }
		  fwrite($fh,"<li".($g[4]>0?" class='premium'":"").">");
		  fwrite($fh,"<a href='http://lss-rp.pl/postacie/".intval($g[0]).",".urlify($g[1])."'>");
//		  fwrite($fh,"<img border='0' src='http://lss-rp.pl/i/skin-32/".intval($g[2]).".png' width='32' height='32' alt='");
		  if ($g[4]>0)
			  fwrite($fh,"<img border='0' src='".$g['avatar']."' width='64' height='64' class='tip' title='".htmlspecialchars($g[1])." (".htmlspecialchars($g[5]).")' alt='");
//			  fwrite($fh,"<img border='0' src='".$g['avatar']."' width='64' height='64' class='tip' title='".htmlspecialchars($g[5])."' alt='");
		  else
			  fwrite($fh,"<img border='0' src='".$g['avatar']."' width='32' height='32' class='tip' title='".htmlspecialchars($g[1])." (".htmlspecialchars($g[5]).")' alt='");
//			  fwrite($fh,"<img border='0' src='".$g['avatar']."' width='32' height='32' class='tip' title='".htmlspecialchars($g[5])."' alt='");
//			  fwrite($fh,"<img border='0' src='http://www.gravatar.com/avatar/".$g['mailhash']."?s=32' width='32' height='32' alt='");
		  fwrite($fh,htmlspecialchars($g[1]));
		  fwrite($fh,"' />");
		  fwrite($fh,"</a>");
		  fwrite($fh,"</li>");
			$graczy++;
		}
		fwrite($fh,"</ul>");

		fclose($fh);
		$plik="/home/lbiegaj/lss-rp.pl/public_html/onlineplayers.txt";
//		$graczy=$LSS->getOnlinePlayers();
		$fh=fopen($plik,"w");
		fwrite($fh,$graczy);
		fclose($fh);


		print $graczy;
		exit;
		break;
  case "testpng":
		Header("Content-type: image/png");
		$png=$RDB->GetOne("SELECT pngdata FROM lss_tagi WHERE id=1");
		print $png;
		exit;
		break;
}
