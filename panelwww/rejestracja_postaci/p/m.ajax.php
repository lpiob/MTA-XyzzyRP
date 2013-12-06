<?
global $RDB,$LSS;

switch($_REQUEST['m2']) {
  case "proxyconnect":	// autoryzacja z forum vanilla
//    mail("lukasz.biegaj@gmail.com","vani",print_r($_REQUEST,1));
    $ck=$_REQUEST['LSSRPAUTH'];
//    print "A";
    if (strlen($ck)<14) exit;
    if (!isset($_REQUEST['ip'])) exit;
    $ip=$_REQUEST['ip'];
    list($userid,$hash1)=preg_split("/\|/",$ck,2);
    
    if (!(intval($userid)>0)) exit;

    $dane=$RDB->CacheGetRow(3600,"SELECT id,login,email FROM lss_users WHERE id=?", Array($userid));
    
//    print_r($dane);
//print "A";
    if (!$dane || !isset($dane['id'])) exit;
    $nhash=md5($dane['email'].$ip);
//    print $nhash."\n".$hash1."\n".$ip;
    if ($nhash==$hash1) {
    	print "UniqueID=".intval($dane['id'])."\n";
	print "Name=".$dane['login']."\n";
	print "Email=".$dane['email']."\n";
    };
    
    
    
//    print $userid;
    exit;
    
    
    

    if ($_SESSION['auth']==1) {
	print "UniqueID=".intval($_SESSION['userid'])."\n";
	print "Name=".$_SESSION['login']."\n";
	print "Email=".$_SESSION['email']."\n";
//	$user['uniqueid']=$_SESSION['userid'];
//	$user['name']=$_SESSION['login'];
//	$user['email']=$_SESSION['email'];
//	$user['photourl'] = '';
    }
    exit;    
  case "jsconnect":	// autoryzacja z forum vanilla
    require_once dirname(__FILE__).'/libs/functions.jsconnect.php';;
    $clientID = "85705927";
    $secret = "03be238d3cbd8069807c532788c0d6b1";
    $user = array();

    if ($_SESSION['auth']==1) {
	$user['uniqueid']=$_SESSION['userid'];
	$user['name']=$_SESSION['login'];
	$user['email']=$_SESSION['email'];
	$user['photourl'] = '';
    }
		 
    $secure = true; 
    WriteJsConnect($user, $_GET, $clientID, $secret, $secure);
    exit; break;
  case "characters":

	$login=$_REQUEST['login'];
	$characters=$RDB->CacheGetAll(3600, "select c.id,c.imie,c.nazwisko from lss_characters c JOIN lss_users u ON c.userid=u.id WHERE c.dead IS NULL AND u.login=? ORDER BY c.lastseen DESC;", Array($login));

	$linki=Array();
	foreach ($characters as $c) {
	  $linki[]="<a href='http://lss-rp.pl/postacie/".intval($c['id']).",".urlify($c['imie']." ".$c['nazwisko'])."'>".htmlspecialchars($c['imie']." ".$c['nazwisko'])."</a>";
	}
	print(join($linki,", "));
	exit;	break;
}
exit;