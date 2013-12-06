<?php

function wm_lastpart($t) {
    if (!(strpos($t,'/')>0))
        return $t;
    $parts=split("/",$t);
    return array_pop($parts);
}
function wm_href($t,$txt=false) {
    global $wiki,$deitar_admin;
    if ($wiki->pageExists($t))
	return "<a href=\"".$wiki->urlifyParts($t)."\">". ($txt?$txt:wm_lastpart($t))."</a>";
    elseif ($deitar_admin==1)
	return wm_lastpart($t)." <a href=\"".$wiki->urlifyParts($t)."?akcja=edit\" class='small'>[utwórz]</a>";
    else
    return wm_lastpart($t);
}

function wm_rawhtml($t) {
    return htmlspecialchars_decode($t);
//    return $t;
}

function smarty_modifier_wikimarkdown($string)
{
    require_once('modifier.markdown.php');
    global $purifier;
    $string=stripslashes($string);
    $znaki="[a-zA-Z0-9ąśćęłńóśżźĄŚĆĘŁŃÓŚŻŹ\-\_\.: \/]";

    // {html}....{/html}
//    $string=preg_replace("/{html}(.*?){\/html}/me","wm_rawhtml('\\1')",$string);
    $string=markdown($string);
    $string=preg_replace("/\[($znaki+)\]([^\(])/e",
	    "''.wm_href('\\1').'\\2'",$string);
//	    "'<a href=\"'.Wiki::urlifyParts('\\1').'\">'.wm_lastpart('\\1').'</a>\\2'",$string);


    // [tekst|katalog/odnosnik]
    $string=preg_replace("/\[($znaki+)\|($znaki+)\]/e",
	    "''.wm_href('\\1','\\2').''",$string);		    


    $string=$purifier->purify($string);

    return $string;
}

?>
