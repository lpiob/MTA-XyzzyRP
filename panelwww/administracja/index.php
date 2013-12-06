<?php
require_once("p/init.php");

switch($_REQUEST['a']){
    case 'bany':
	    require("p/page.bany.php");
	    break;
    case 'bany-ajax':
	    if($_SERVER['REQUEST_METHOD']!="POST") die("Bledne wywolanie");
	    require("p/page.bany-ajax.php");
	    break;

    case 'postacie':
	    require("p/page.postacie.php");
	    break;      
    case 'postacie-ajax':
	    if($_SERVER['REQUEST_METHOD']!="POST") die("Bledne wywolanie");
	    require("p/page.postacie-ajax.php");
	    break;

    case 'wyloguj':
	    session_destroy();
	    Header("Location: /auth.html");
	    exit; break;
    default:
	    $smarty->display('start.tpl');
}


