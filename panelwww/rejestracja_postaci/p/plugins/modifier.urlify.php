<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * @file  modifier.urlify.php
 * Smarty 'urlify' modifier plugin
 *
 * Type:     modifier<br>
 * Name:     urlify<br>
 * Purpose:  turn url text into hyperlinks
 * Example:  {$var|urlify}
 * @param string
 * @return string
 */
function smarty_modifier_urlify($string)
{
     
//    $string=strtr($string,'ąśćęłńóśżźĄŚĆĘŁŃÓŚŻŹ','ascelnoszzASCELNOSZZ');
    $string=mb_convert_encoding($string,"ASCII","UTF-8");
    $string=preg_replace('@[^a-z]+@i','_',$string);

    return $string;
}
?> 