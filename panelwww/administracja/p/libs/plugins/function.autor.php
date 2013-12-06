<?php
function smarty_function_autor($params, $smarty, $template)
{
    $h=$params['kto'];
    $r=mb_substr($h['nazwisko'],0,1).mb_substr($h['imie'],0,1);
    if ($h['placowka_handlowa_symbol']) $r.=" <span class='h6'>".$h['placowka_handlowa_symbol']."</span>";    
    
    
    return $r;
}
?>