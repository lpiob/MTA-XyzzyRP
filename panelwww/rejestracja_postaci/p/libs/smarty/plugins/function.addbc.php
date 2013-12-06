<?
function smarty_function_addbc($params, &$smarty) {
	$smarty->append('breadcrumbs',Array('txt'=>$params['txt'],'url'=>$params['url']));
	return;
}
?>