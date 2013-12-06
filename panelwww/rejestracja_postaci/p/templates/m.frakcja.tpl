{* Smarty *}

{include file="_header.tpl"}
<div class='frakcja'>
<h2>{$frakcja.name|htmlspecialchars}</h2>

<table class='zestawienie'>
<thead>
    <tr>
	<th>Ranga/nazwisko</th>
	<th>Członek od</th>
	<th>Ostatnio na służbie</th>
    </tr>
</thead>
<tbody>
{foreach from=$rangi item=r}
<tr>
    <th colspan='3'>{$r.name|htmlspecialchars}</th>
</tr>
{foreach from=$czlonkowie item=c}
    {if $c.rank==$r.rank_id}
    <tr>
	<td><a href='/postacie/{$c.character_id|intval},{$c.imie|urlify}_{$c.nazwisko|urlify}'>{$c.imie|htmlspecialchars} {$c.nazwisko|htmlspecialchars}</a></td>
	<td>{$c.jointime|date_format:"Y-m-d"}<br />{$c.jointime|kiedy2}</td>
	<td>{$c.lastduty|date_format:"Y-m-d"}</td>
    </tr>
    {/if}
{/foreach}
{/foreach}
</tbody>
</table>

</div>
<br /><br /><p><small>Dane na tej stronie są odświeżane co godzinę.</small></p>


{include file="_footer.tpl"}