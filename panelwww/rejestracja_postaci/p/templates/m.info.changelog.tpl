{* Smarty *}

{include file="_header.tpl"}
<h2>Ostatnie zmiany</h2>

{if $LSS->perm_manage}
<div class='manage'>

<form method='POST'>
<fieldset>
  <legend>Nowy wpis</legend>
  <p><input type="text" size="80" name="opis"></textarea><input type="submit" value="Dodaj &raquo;" /></p>
  <p><small>Ewentualne usuwanie w bazie danych, tabela lss_aktualnosci</small></p>
</fieldset>
</form>
</div>
{/if}


{include file="m.mini.changelog.tpl"}



{include file="_footer.tpl"}