{* Smarty *}

{include file="_header.tpl"}

<h2>Rejestracja konta</h2>

<p class='lead'>Załóż konto aby móc zalogować się na serwerze gry i na forum.</p>
<p>Przy rejestracji konieczne jest wypełnienie <b>podstawowego</b> testu znajomości zasad serwera. Podanie błędnych odpowiedzi blokuje dostęp do rejestracji z Twojego adresu IP na okres 1 godziny.</p>

<fieldset><form method='POST' class='form-horizontal'>

{if $rejestracja_bledy}
	<div class='alert alert-error alert-block'>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
		<h4>Wystąpiły następujące błędy:</h4>
		{foreach from=$rejestracja_bledy item=b}
		<p>{$b|htmlspecialchars}</p>
		{/foreach}

	</div>
{/if}

	<div class='control-group'><label class="control-label" >Login:</label>
		<div class='controls'><input type='text' name='login' value='{$smarty.post.login|htmlspecialchars}' /></div></div>

	<div class='control-group'><label class="control-label" >Hasło:</label>
        <div class='controls'><input type='password' name='haslo' /></div></div>

	<div class='control-group'><label class="control-label" >Powtórz hasło:</label>
		<div class='controls'><input type='password' name='haslo2' /></div></div>

	<div class='control-group'><label class="control-label" >Adres e-mail:</label>
		<div class='controls'><input type='text' name='email' value='{$smarty.post.email|htmlspecialchars}' /></div></div>

	<div class='control-group'><div class='controls'>Na podany adres e-mail przyjdzie link potwierdzający rejestrację.</div></div>

{* if $polecajacy>0}
	<p><label style='text-align: left; width: 30%; margin-left: 1em; text-indent:-1em;'><input type='checkbox' checked='checked' name='polecenie' /> Rejestrujesz się z polecenia gracza <b>{$polecajacy_nick|htmlspecialchars}</b> i 
		zgadzasz się na udział w konkursie <a href='/polec'>poleć znajomemu - odbierz konto Premium</a>. Odznacz jeśli nie chcesz brać w tym udziału.</label></p>
{/if *}

	<div class='control-group'><label class="control-label" >Skrót RP oznacza:</label>
		<div class='controls'><select name='pyt_1'><option value=''>-</option><option value='1'>Real Players</option><option value='2'>Role-Play</option><option value='3'>Random Position</option></select></div></div>
    
	<div class='control-group'><label class="control-label" >Nazwy postaci na serwerze RP:</label>
		<div class='controls'><select name='pyt_2'><option value=''>-</option><option value='1'>Mogą być dowolne</option><option value='2'>Mogą być dowolne, ale bez wulgaryzmów.</option><option value='3'>Muszą zawierać rok urodzenia np. Wiktor1985</option><option value='4'>Muszą zawierać wymyślone imię i nazwisko</option></select></div></div>

	<div class='control-group'><label class="control-label" >W przypadku śmierci postaci:</label>
		<div class='controls'><select name='pyt_3'><option value=''>-</option><option value='1'>Postać pozostaje martwa i nie można już nią grać.</option><option value='2'>Trzeba napisać do admina by zrespawnował postać.</option><option value='3'>Postać odradza się sama</option><option value='4'>Postać traci trochę gotówki i się odradza.</option></select></div></div>
        

    <div class='control-group'><div class='controls'>
	  <button type='submit' class='btn btn-primary'>Załóż konto</button>
    </div></div>

	
</form></fieldset>

{include file="_footer.tpl"}