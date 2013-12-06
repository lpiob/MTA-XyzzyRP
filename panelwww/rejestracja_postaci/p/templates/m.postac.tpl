{* Smarty *}

{include file="_header.tpl"}
<div class='postac'>
<img src='/i/skin/{$postac.skin|intval}.png' alt='{$postac.imie|htmlspecialchars} {$postac.nazwisko|htmlspecialchars}' width='80' height='180' />
<h2>{$postac.imie|htmlspecialchars} {$postac.nazwisko|htmlspecialchars}</h2>

{if $postac.data_urodzenia}<p>Data urodzenia: <i>{$postac.data_urodzenia|date_format:"%Y.%m.%d"}</i></p>{/if}
<p>Rasa: <b>{$postac.rasa|htmlspecialchars}</b>.</p>

{if $postac.dead}<p><i>{$postac.dead|htmlspecialchars}</i></p>{/if}
</div>


{if $frakcje|@count>0}
<h3>Frakcje:</h3>
<table class='zestawienie'>
<thead>
    <tr>
	<th>Frakcja</th>
	<th>Ranga</th>
	<th>Członek od</th>
	<th>Ostatnio na służbie</th>
    </tr>
</thead>
<tbody>
{foreach from=$frakcje item=f}
    <tr>
	<td><a href='/frakcje/{$f.faction_id|intval},{$f.name|urlify}'>{$f.name|htmlspecialchars}</a></td>
	<td>{$f.rank_name|htmlspecialchars}</td>
	<td>{$f.jointime|date_format:"Y-m-d"}<br />{$f.jointime|kiedy2}</td>
	<td>{$f.lastduty|date_format:"Y-m-d"}<br />{$f.lastduty|kiedy2} temu</td>
    </tr>
{/foreach}
</tbody>
</table>
{/if}

{if $osiagniecia|@count>0}
<h3>Osiągnięcia:</h3>
<table class='zestawienie'>
<tbody>
{foreach from=$osiagniecia item=o}
	<tr>
		<td>{$o.ts|date_format:"Y-m-d"}</td>
		<td>+{$o.amount}</td>
		<td>{$o.descr|htmlspecialchars}{if $o.notes}<br /><i>{$o.notes|htmlspecialchars}</i>{/if}</td>
	</tr>
{/foreach}
</tbody>
</table>
{/if}


{if $postac.owncharacter && !$postac.dead && $postac.rasa=='nieznana'}
<h3>Dane dodatkowe</h3>
<p>Wymagane do wyrobienia dokumentu tożsamości.</p>
<form method='POST'><fieldset>
  <input type='hidden' name='ma' value='characterupdate'>
  <p><label>Rasa:</label><select name='rasa'>
		<option value='biala'>biała</option>
		<option value='czarna'>czarna</option>
		<option value='zolta'>żółta</option>
	</select></p>

  <p><label>Data urodzenia:</label><input type='text' name='data_urodzenia' value='nieznana' class='dp_data_urodzenia' /></p>
  <p>Sprawdź dokładnie podane dane, nie można ich później zmienić.</p>
  <p><button type='submit'>Zapisz</button></p>
</fieldset></form>
{literal}<script>
$(document).ready(function(){
  $( "input.dp_data_urodzenia" ).datepicker({
	  monthNames: ["Styczeń","Luty","Marzec","Kwiecień","Maj","Czerwiec","Lipiec","Sierpień","Wrzesień","Październik","Listopad","Grudzień"],
	  monthNamesShort: ["Sty","Lut","Mar","Kwi","Maj","Cze","Lip","Sie","Wrz","Paź","Lis","Gru"],
	  dateFormat: "yy.mm.dd",
	  dayNamesMin: ["Ni", "Po", "Wt", "Śr", "Cz", "Pi", "So"],
	  yearRange: "1930:1997",
	  changeYear: true,
	  changeMonth: true,

	  minDate: new Date(1920, 1 - 1, 1),
	  maxDate: new Date(1998, 1 - 1, 1)
	});
});
</script>{/literal}

{/if}


{if $postac.owncharacter && $postac.premium>0 && !$postac.dead}
<h3>Premium:</h3>
<p>Jako użytkownik premium, możesz wybrać zastępczy skin dla swojej postaci:</p>
<form method='POST'>
<input type='hidden' name='ma' value='changepremiumskin' />
<table width='100%'>
<tr><td valign='top'>
<p>Twój domyślny skin:</p>
<label><input type='radio' name='skinpremium' value='-1' {if !$postac.premiumskin}checked='checked'{/if} /> <img style='vertical-align: middle;' src='/i/skin/{$postac.original_skin|intval}.png' width='80' height='180' /></label>
</td><td valign='top'>
<p>Skiny Premium:</p>
{foreach from=$skiny_premium item=sp}
<label style='white-space: pre;'><input type='radio' name='skinpremium' value='{$sp}' {if $postac.premiumskin==$sp}checked='checked'{/if} /> <img style='vertical-align: middle;' src='/i/skin/{$sp|intval}.png' width='80' height='180' /></label>
{/foreach}

</td></tr></table>
<br /><p align='center'><button type='submit'>Zapisz zmiany</button></p>

</form>


<br /><p>Za mało skinów? Brakuje Ci jakiegoś? <a href='http://forum.lss-rp.pl/viewtopic.php?f=109&t=797'>Złóż propozycję na kolejne</a>.</p>
<p>Przestrzegamy przed zmienianiem koloru skóry swojej postaci. Nijaczenie postaci jest zabronione i może doprowadzić do jej śmierci. 
Jeśli stworzyłeś/aś postać o białym kolorze skóry, to nie zmieniaj skina na czarnoskórego. Stwórz nową postać - czarnoskórą. Będziemy to wyrywkowo sprawdzać i reagować na informacje o tym ze ktoś zmienił kolor skóry postaci.</p>
{/if}


{* Zarzadzanie postacia *}




{if $LSS->perm_manage}
<div class='manage'>

<form method='POST'><input type="hidden" name="ma" value="manage_character" />
<fieldset>
  <legend>Edycja danych postaci:</legend>

  <p><label>Imię:</label><input type='text' name='imie' value='{$postac.imie|htmlspecialchars}' /></p>
  <p><label>Nazwisko:</label><input type='text' name='nazwisko' value='{$postac.nazwisko|htmlspecialchars}' /></p>

  <p><label>Data urodzenia:</label><input type='text' disabled='disabled' name='data_urodzenia' value='{$postac.data_urodzenia|default:"nieznana"|htmlspecialchars}' /></p>

  <p><button type='submit'>Zapisz</button></p>

</fieldset></form>

</div>
{/if}




<br /><br /><p><small>Dane na tej stronie są odświeżane co godzinę.</small></p>


{include file="_footer.tpl"}