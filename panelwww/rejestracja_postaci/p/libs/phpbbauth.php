<?php

/* ten plik obslugiwal integracje z phpbb, obecnie obsluguje integracje z ipboard 
  wymagana jest tu aktualizacja sciezki do instalacji ipboard */

/*
define('IN_PHPBB', true);
$phpbb_root_path = (defined('PHPBB_ROOT_PATH')) ? PHPBB_ROOT_PATH : '/home/lbiegaj/forum.lss-rp.pl/public_html/';
$phpEx = substr(strrchr(__FILE__, '.'), 1);
include($phpbb_root_path . 'common.' . $phpEx);


// Start session management
$user->session_begin();
$auth->acl($user->data);
$user->setup();
*/
//define('IPS_ROOT_PATH', '/home/lbiegaj/lss-rp.pl/public_html/admin/');
require_once("/home/lbiegaj/lss-rp.pl/public_html/initdata.php");
require_once( IPS_ROOT_PATH . 'sources/base/ipsController.php' );
require_once( IPS_ROOT_PATH . 'sources/base/ipsRegistry.php' );
$registry = ipsRegistry::instance();
define('ALLOW_FURLS', false); // ugly hack
$registry->init();
$ipblogin=$registry->member()->fetchMemberData();

//$szablon->assign('ipblogin',$ipblogin);
// phpbb emulation
$user=Array(
  'username_clean'=>$ipblogin['name'],
  
  
);

