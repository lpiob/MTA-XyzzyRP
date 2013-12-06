<?
class LSS {
                                                              // 145,244,256,257
    public $skiny_m=Array(0,1,2,7,14,15,17,19,20,21,22,23,24,25,28,29,30,32,33,34,35,36,37,43,44,45,46,47,48,57,59,60,66,67,68,72,78,98,101,102,115,120,121,122,123,124,127,156,158,165,170,176,177,179,180,181,183,186,217,220,223,228,240,242,248,250,258,261,271,286,290,291,292,293,296,297,299,305);
    public $skiny_f=Array(9,10,12,13,31,40,41,55,56,64,69,85,91,93,131,141,151,157,169,192,193,196,197,211,233,243,245,298);
    public $skiny_f_premium=Array(38,39,87,145,205,244,256,257);
    public $skiny_m_premium=Array(26,45,80,81,83,84,137,167,203,204,213,231,252,264);
	public $perm_manage=false;

	function __construct() {
        $this->perm_manage=false;
	}
    
    function skinMeski($skin) {
	if (in_array($skin,$this->skiny_m) or in_array($skin,$this->skiny_m_premium))
	    return true;
    return false;
    }
    function validPremiumSkin($skin) {
	if (in_array($skin,$this->skiny_m_premium) or in_array($skin,$this->skiny_f_premium))
	    return true;
    return false;
    
    }

  function getOnlinePlayers(){
	global $RDB;
	return $RDB->CacheGetOne(60, "select value_i from lss_currentstats where name='online_players'");
  }

  function getOnlinePlayerList(){
	global $RDB;
	$dane=json_decode($RDB->CacheGetOne(60, "select value_t from lss_currentstats where name='online_players'"));
	$dane=$dane[0];
//	$FDB= uwaga gowno
	$FDB=NewADOConnection("mysql");
	$FDB->Connect("mysql2.netshock.pl","lbiegaj_lssforum","xxxxxxxx", "lbiegaj_lssforum");
	$FDB->Execute("set names utf8");

	$usernames=Array();
	foreach($dane as $g) {
	  $usernames[]=$FDB->qstr($g[5]);

	}
//	print_r($usernames);
//	$FDB->debug=true;
	$usernames=join($usernames,",");
	$avatars=$FDB->CacheGetAssoc(60, "SELECT username,user_email,user_avatar FROM flss_users WHERE username IN (".$usernames.")");
//	print_r($avatars);
	foreach($dane as $i=>$g) {
	  $dane[$i]['email']=$avatars[$g[5]][user_email];
	  $dane[$i]['avatar']=$avatars[$g[5]][user_avatar];
	  if (strlen($dane[$i]['avatar'])<2) {
		  $dane[$i]['avatar']="http://www.gravatar.com/avatar/".md5(strtolower(trim($dane[$i]['email'])))."?s=64&d=mm";
	  } elseif (preg_match("/^http:\/\//",$dane[$i]['avatar'])) { 
	  }  else {
		  $dane[$i]['avatar']="http://forum.lss-rp.pl/download/file.php?avatar=".$dane[$i]['avatar'];
	  }
	}

//	print_r($dane);;
/*
	$uidy=join($userids,",");
	$emaile=Array();
	$emaile=$RDB->CacheGetAssoc(60,"SELECT id,email FROM lss_users WHERE ID IN (".$uidy.")");
	foreach ($dane as $i=>$g) {
	  $dane[$i]['email']=$emaile[$g[3]];
	}
  */


	return $dane;
  }

}
