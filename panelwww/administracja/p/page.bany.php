<?

global $LVL;
if ($LVL<2) die("Nie masz dostepu do tej zakladki.");

global $DB;

if ($_SERVER['REQUEST_METHOD']=='GET') {
    $_POST['aktywne']=1;
    $_POST['tl']='48h';
}

$q_select="";
$q_where="";

if ($_POST['aktywne']) {
    $q_where.=" AND b.date_to>NOW() ";
    $smarty->assign('k_aktywne',1);
}


if ($_POST['playerinfo']) {
    $q_select=',u1.gp ';
    $smarty->assign('k_playerinfo',1);
}


switch($_POST['tl']){
    case '24h':
	$q_where.=" AND date_from>=(NOW()-INTERVAL 1 DAY) ";	break;
    case '48h':
    	$q_where.=" AND date_from>=(NOW()-INTERVAL 2 DAY) ";	break;
    case '4d':
    	$q_where.=" AND date_from>=(NOW()-INTERVAL 4 DAY) ";	break;
    case '1w':
    	$q_where.=" AND date_from>=(NOW()-INTERVAL 7 DAY) ";	break;
    case '1m':
    	$q_where.=" AND date_from>=(NOW()-INTERVAL 1 MONTH) ";break;
    default:
	$_POST['tl']="";
}

$smarty->assign('k_tl',$_POST['tl']);

$q="select 
    b.id,b.serial,b.date_from,b.date_to,(b.date_to>NOW()) aktywny,reason,b.notes,u1.login zbanowany,u2.login przez 
    $q_select
    
    from lss_bany b 
    
    LEFT JOIN lss_users u1 on b.id_user=u1.id 
    JOIN lss_users u2 ON b.banned_by=u2.id
	WHERE 1 $q_where
    order by b.id desc;";
    

$bany=$DB->getAll($q);
$smarty->assign('bany',$bany);
$smarty->display('bany.tpl');
//print($q);

?>