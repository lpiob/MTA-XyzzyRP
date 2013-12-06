<?php
function smarty_modifier_komunikat($string)
{
    return preg_replace("/\n/","<br />",$string);
} 

?>
