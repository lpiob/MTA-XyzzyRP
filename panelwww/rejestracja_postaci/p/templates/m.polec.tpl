{* Smarty *}

{include file="_header.tpl"}
{literal}<style type='text/css'>
div.polecbox { float: left; width: 42%; margin: 0.5em 1em; background: white; padding: 1em 2em 6em; border: 3px solid #ddd; border-radius: 1em; }
div.polecbox2 { float: right; width: 42%; margin: 0.5em 1em; background: white; padding: 1em 2em; border: 3px solid #ddd; border-radius: 1em; clear: right; }
div.polecbox>ol { font-size: 24pt; padding-left: 20pt; color: #666; font-weight: bold;}
div.polecbox>ol>li { margin-bottom: 2em; }
div.polecbox>ol>li>h2 { font-family: sans-serif; font-size: 20pt; color: black; margin: 0;}
div.polecbox>ol>li>h2>b { color: navy; }
div.polecbox>ol>li>h2>b.p { color: yellow; font-weight: bold; text-shadow: 0px 0px 5px black; }
div.polecbox2 input { width: 90%; padding: 0.5em; border: 1px solid #ddd; text-align: center; }
div.polecbox2>ul { margin-left: 1em; }

</style>{/literal}

<h1>Poleć LSS-RP znajomemu, odbierz nagrodę!</h1>




<div class='polecbox'>
<ol>
	<li><h2>Poleć LSS-RP swoim znajomym!</h2>
		<p>Zainstaluj MTA koledze/koleżance, pomóż założyć konto i rozpocząć grę na serwerze.</p></li>
	<li><h2>Za polecenie otrzymacie <b>oboje</b> konto <b class='p'>PREMIUM</b> na okres 10 dni</h2>
		<p>W momencie gdy osoba polecona uzbiera 50GP. W przypadku posiadania konta PREMIUM, jego ważność zostanie przedłużona.</p></li>
	<li><h2>Korzyści się kumulują!</h2>
		<p>Poleć serwer 10 osobom - otrzymasz 100 dni konta PREMIUM. Nie ma żadnych limitów!</p></li>
</ol>

<p>Uwagi: sprawdzanie poleceń i nadawanie nagród odbywa się automatycznie raz dziennie około północy. 
	Możesz publikować link polecający na forach, pamiętaj jednak aby dostosować się do zasad danego forum.
	Osoby polecone będą weryfikowane pod względem autentyczności, nie opłaca się więc oszukiwać.
	Konkurs dotyczy tylko nowych rejestracji graczy, nie ma możliwości nadania nagrody za polecenie wykonane przed uruchomieniem konkursu. 
	Wymagana ilość punktów GP może ulec zmianie.
	Pytania można zadawać na <a href='http://forum.lss-rp.pl/viewtopic.php?f=12&t=8530'>forum</a>.</p>
</div>

<div class='polecbox2'>
	<p><b>Link polecający</b></p>
	{if $login_gracza}
	<p>Twój login to: <b>{$login_gracza|htmlspecialchars}</b>. Oto link rejestrujący gracza z Twojego polecenia:</p>
	<input type='text' readonly='readonly' value='http://lss-rp.pl/rejestracja/{$id_gracza_obf|intval}' /><br /><br />
	<p>Nowy gracz musi zarejestrować się korzystając z tego linku, aby polecenie zostało zarejestrowane.</p>
	{else}
	<p><a href='http://forum.lss-rp.pl/ucp.php?mode=login'>Zaloguj się</a> aby otrzymać swój link polecający. Jest on wymagany do poprawnego
		zarejestrowania polecenia nowej osoby.</p>
	{/if}
</div>

<div class='polecbox2'>
	<p><b>Ostatnio nagrodzeni zostali:</b></p>
	<ul>
	{foreach from=$wlasnie_nagrodzeni item=op}
		<li>
			<b>{$op.polecajacy_done|kiedy}</b> - <b>{$op.login|htmlspecialchars}</b> oraz <b>{$op.login2|htmlspecialchars}</b> dostali +10 dni Premium,
		</li>
	{/foreach}
	</ul>
</div>


<div class='polecbox2'>
	<p><b>Ostatnie polecenia:</b></p>
	<ul>
	{foreach from=$ostatnie_polecenia item=op}
		<li>{$op.registered|kiedy} <b>{$op.login2|htmlspecialchars}</b> polecił gracza <b>{$op.login|htmlspecialchars}</b>.</li>
	{/foreach}
	</ul>
</div>

<div class='polecbox2'>
	<p><b>Wkrótce nagrodzeni zostaną:</b></p>
	<ul>
	{foreach from=$wkrotce_nagrodzeni item=op}
		{if $op.gp>=50}
			<li><b>{$op.login|htmlspecialchars}</b> zebrał/a już <b>{$op.gp|intval}</b>GP i zaraz, wraz z graczem <b>{$op.login2|htmlspecialchars}</b> otrzyma nagrodę!</li>
		{else}
			<li>Graczowi <b>{$op.login|htmlspecialchars}</b>  (z polecenia gracza <b>{$op.login2|htmlspecialchars}</b>) brakuje jeszcze {50-$op.gp}GP do odebrania nagrody!.</li>
		{/if}
	{/foreach}
	</ul>
</div>

<br /><br /><br /><br />

{include file="_footer.tpl"}