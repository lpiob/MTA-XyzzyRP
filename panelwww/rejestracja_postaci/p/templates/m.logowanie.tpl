{* Smarty *}

{include file="_header.tpl"}

<h1>Logowanie</h1>

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

<fieldset><form method='POST'>

	<p><label>Login:</label>
			<input type='text' name='login' value='{$smarty.post.login|htmlspecialchars}' /></p>

	<p><label>Hasło:</label>
			<input type='password' name='haslo' /></p>

	<button type='submit'>Zaloguj</button>

	
</form></fieldset>

{include file="_footer.tpl"}