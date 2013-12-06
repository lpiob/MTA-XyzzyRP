{* Smarty *}

{include file="_header.tpl"}

<h1>Tagi</h1>
<table width='100%' border='1' cellpadding='10' cellspacing='0'>
{foreach from=$tagi item=t}
<tr>
  <td valign='top'>{$t.id|intval}</td>
  <td><img src='/tagi/{$t.id|intval}' width='128' height='128' /></td>
  <td valign='top'><a href='/postacie/{$t.creator|intval},{$t.imie|urlify}_{$t.nazwisko|urlify}'>{$t.imie|htmlspecialchars} {$t.nazwisko|htmlspecialchars}</a></td>
  <td valign='top'>{$t.x|intval},{$t.y|intval},{$t.z|floatval}</td>
</tr>
{/foreach}
</table>


{include file="_footer.tpl"}