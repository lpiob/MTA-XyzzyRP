{* Smarty *}

{include file="_header.tpl"}

<h1>Zmiana hasła</h1>

{if $bledy}
	<div class='error'>
		<p>Wystąpiły następujące błędy:</p>
		<ul>
			{foreach from=$bledy item=b}
			<li>{$b}</li>
			{/foreach}
		</ul>
	</div>
{/if}

{if $informacje}
	<div class='info'>
		<ul>
			{foreach from=$informacje item=b}
			<li>{$b}</li>
			{/foreach}
		</ul>
	</div>
{/if}

<fieldset><form method='POST'>
	<p>
		<label>Twoje aktualne hasło:</label>
		<input type='password' name='aktualne' />
	</p>
	<p>
		<label>Nowe hasło:</label>
		<input type='password' name='nowe1' />
	<p>
	<p>
		<label>Powtórz nowe hasło:</label>
		<input type='password' name='nowe2' />
	<p>

	<p>
	  <button type='submit'>Zmień hasło</button>
	</p>

</form></fieldset>

{include file="_footer.tpl"}