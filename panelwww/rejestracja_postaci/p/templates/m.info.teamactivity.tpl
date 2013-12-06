{* Smarty *}

{include file="_header.tpl"}
<h2>Aktywność ekipy</h2>
<h3>Aktywność tygodniowa</h3>
<p>Norma tygodniowa: 10h==600 minut</p>
{foreach from=$aktywnosc_tygodniowa item=t key=tydzien}
<h4>Tydzień {$tydzien}</h4>
<table class='activity'>
<thead>
  <tr>
	<th>Login</th>
	<th align='right'>Norma</th>
	<th align='right'>Pozostało minut</th>
{if $LSS->perm_manage}	<th align='right'>Przegranych minut</th>{/if}
  </tr>

</thead>
<tbody>
{foreach from=$t item=w key=osoba}
  <tr>
	<th width='33%'>{$osoba|htmlspecialchars}</th>
	<td align='right' width='33%'><div class='progressbar' value='{$w.norma|intval}'></div></td>
	<td align='right'>{$w.pozostalo|intval}</td>
{if $LSS->perm_manage}	<td align='right'>{$w.minutabs|intval}</td>{/if}
	
  </tr>
{/foreach}
</tbody>
</table>
{/foreach}




{include file="_footer.tpl"}