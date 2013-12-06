{* Smarty *}

{include file="_header.tpl"}

<h2>Twoje postacie</h2>

{if $bledy}
	<div class='alert alert-error alert-block'>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
		<h4>Wystąpiły następujące błędy:</h4>
		{foreach from=$bledy item=b}
		<p>{$b|htmlspecialchars}</p>
		{/foreach}

	</div>
{/if}

<p class='lead'>Obecnie posiadasz <b>{$postacie_zywe|intval}/{$limit_postaci|intval}</b> postaci.</p>

<div class="row-fluid">
{foreach from=$postacie item=p}
<div {if $p.dead}class='span4 well greyscale dead'{else}class='span4 well alive'{/if}>
	<img src='/i/skin/{$p.skin|intval}.png' alt='{$p.imie|htmlspecialchars} {$p.nazwisko|htmlspecialchars}' {if $p.dead}width='40' height='90'{else}width='80' height='180'{/if} />
	<h2><a nohref='/postacie/{$p.id|intval},{$p.imie|urlify}_{$p.nazwisko|urlify}'>{$p.imie|htmlspecialchars} {$p.nazwisko|htmlspecialchars}</a></h2>
	{if $p.dead}<p><i>{$p.dead|htmlspecialchars}</i></p>{/if}
{*	<p><span class='hp'>{$p.hp|intval}</span> <span class='ar'>{$p.ar|intval}</span> <span class='money'>{$p.money|intval}</span></p> *}
    {if $p.accepted==0}<p class='alert'>Postać oczekuje na akceptację.</p>{/if}
	<p>
	  <span class='stamina'>Stamina: <b>{$p.stamina|intval}/999</b></span>
	  <span class='energy'>Siła: <b>{$p.energy|intval}/999</b></span>
	  <span class='playtime'>Czas gry: <b>{floor($p.playtime/60)}h{floor($p.playtime)%60}m</b></span>
	</p>
</div>
{/foreach}
</div>

{if $postacie_zywe<$limit_postaci}
<hr />
<h2>Rejestracja nowej postaci</h2>
<fieldset><form method='POST'>
	<h3>Płeć</h3>
	<p>
		<label><input type='radio' name='plec' value='m' /> mężczyzna</label>
		<label><input type='radio' name='plec' value='f' /> kobieta</label>
	</p>
	<h3>Nazwa postaci</h3>
	<p>
		<label>Imię:</label><input type='text' name='imie' /></p>
	<p>
		<label>Nazwisko:</label><input type='text' name='nazwisko' />
	</p>
	<p><button onclick='return nazwisko_losowe()'>Wygeneruj losowe imię i nazwisko.</button></p>

	<h3>Skin</h3>
	<input type='hidden' name='skin' />
	<div class='wyborskina' style='display: none;'>

		<div class='podglad-skina'>
		<p>Wybrany:</p>
		<img width='160' height='360' alt='' />
		</div>

		<p>Dostępne skiny:</p>
		<div class='listaskinow skiny-zenskie' style='display: none;'>

		{foreach from=$dozwolone_skiny_f item=s}
			<img skin='{$s|intval}' src='/i/skin/{$s|intval}.png' width='53' height='120' />
		{/foreach}
{*		<p>Uważasz, że brakuje jakiejś postaci? <a href='http://forum.lss-rp.pl/viewforum.php?f=5'>Zaproponuj dodanie jej</a>.</p> *}
		</div>

		<div class='listaskinow skiny-meskie' style='display: none;'>

		{foreach from=$dozwolone_skiny_m item=s}
			<img skin='{$s|intval}' src='/i/skin/{$s|intval}.png' width='53' height='120' alt='{$s|intval}' />
		{/foreach}
{*		<p>Uważasz, że brakuje jakiejś postaci? <a href='http://forum.lss-rp.pl/viewforum.php?f=5'>Zaproponuj dodanie jej</a>.</p>*}
		</div>


	</div>

    <h3>Pytania:</h3>
    <p class='alert'>Odpowiedź na poniższe pytania zostanie wzięta pod uwagę podczas rozpatrywania wniosku o rejestrację tej postaci.</p>
    <p>Napisz kilka słów o przeszłości swojej postaci:</p>
    <input type='hidden' name='pyt_1_pytanie' value='Napisz kilka słów o przeszłości swojej postaci:' />
    <div><textarea class='span12' rows='4' name='pyt_1_odpowiedz'></textarea></div>

    <p>Opisz w kilku słowach charakter swojej postacii:</p>
    <input type='hidden' name='pyt_2_pytanie' value='Opisz w kilku słowach charakter swojej postaci:' />
    <div><textarea class='span12' rows='4' name='pyt_2_odpowiedz'></textarea></div>
    

    <p>Zauważasz trzyosobową grupę czarnoskórych mężczyzn podchodzących do Twojej postaci, mają przy sobie broń palną, jak sie zachowasz?</p>
    <input type='hidden' name='pyt_3_pytanie' value='Zauważasz trzyosobową grupę czarnoskórych mężczyzn podchodzących do Twojej postaci, mają przy sobie broń palną, jak sie zachowasz?' />
    <div><textarea class='span12' rows='4' name='pyt_3_odpowiedz'></textarea></div>

    <p>Jesteś świadkiem wypadku samochodowego, jak się zachowasz?</p>
    <input type='hidden' name='pyt_4_pytanie' value='Jak zachowasz się w sytuacji kiedy bedziesz swiadkiem wypadku samochodowego?' />
    <div><textarea class='span12' rows='4' name='pyt_4_odpowiedz'></textarea></div>
    
	<br />
	<p><button type='submit'>Złóż podanie o rejestrację postaci</button></p>

	
</form>
</fieldset>
{/if}
<script>{literal}
var nazwiska=Array(
"Ahonen","Alexander","Ali","Alvarez","Anderson","Bakker","Bauer","Berger","Bernard","Bertrand","Bianchi","Bonnet","Brooks","Brouwer","Brown","Brunner","Bruno","Campbell","Cavadini","Chan","Claes","Clark",
"Clarke","Colombo","Conti","Cooper","Costa","Cox","Crivelli","Danielsen","Davies","Davis","Dekker","Delgado","De Boer","De Graaf","De Groot","De Jong","De Vries","De Wit","Diaz","Dijkstra","Djorov","Dmitrov","Dohery",
"Doyle","Dubois","Dupont","Durand","Eder","Edwards","Eiras","Esposito","Evans","Fischer","Fisher","Flores","Fournier","Fuchs","Gagnon","Garcia","Garnier","Gil","Giordano","Girard","Gomes","Graham","Green","Gruber",
"Guevara","Gustafsson","Hall","Hansen","Heikkinen","Hendriks","Hill","Horvat","Howard","Huber","Hughes","Iglesias","Illiev","Ivanov","Jackson","Jacobsen","Jansen","Janssens","Jenkins","Joensen","Johansen",
"Johansson","Johnson","Johnston","Jokinen","Jones","Kanev","Karlsson","Kaya","Kelly","Kennedy","Koppel","Kozlov","Laine","Lamber","Lang","Larsson",
"Lefebvre","Legrant","Leitner","Leroy","Lewis","Li","Lindberg","Lopes","Lopez","Louis","Lynch","MacDonal","Maes","Marinari","Marino","Martin","Mayer","McCarthy","Melo","Mercier","Mitchell","Moore",
"Morales","Moreau","Morel","Morgan","Morrison","Moser","Moss","Mota","Mulder","Muller","Murphy","Murray","Nelson","Nielsen","Nilsson","O'Connor","Olsen","Olsson","O'Neil","O'Neill","O'Reilly","Ortiz","O'Sullivan","Owen","Papp","Patel","Pavlov","Peeters","Penev","Perez","Persson","Peters","Petersen","Petridis","Petrov","Phillips","Pichler","Popov","Poulsen","Price","Quinn","Quisenberry","Ramos","Rebane","Rees","Reid","Reiter","Ricci","Richards","Rizzo","Roberts","Robinson","Rodriguez","Rojas","Romano","Rose","Ross","Rossi","Roux","Ruiz","Russo","Salas","Salo","Sanders","Schmidt","Schwarz","Scott","Shepherd","Silva",
"Simonsen","Smirnov","Smit","Smith","Smits","Stefanov","Steiner","Stoyanov","Svansson","Taylor","Thompson","Thomsen","Torres","Turner","Van der Meer","Ventura","Virtanen","Visser","Volkov","Wagner","Walker","Walsh",
"Ward","Watson","Wayland","Weber","White","Williams","Wilson","Winkler","Wolf","Wood","Wright","Yanev","Yankov","Young"
);

var imiona_meskie=Array(
"Aaron","Adam","Alessandro","Alex","Alexander","Alfie","Ali","Andrea","Antonio","Aron","Artem","Arthur","Aziz","Ben","Benjamin","Cameron","Charles","Charlie","Daan","Daniel","David","Dawid","Deven","Diego","Dimitar","Dmytro","Dylan","Elias","Eliasz","Emil","Eric","Eryk","Ethan","Francesco","Frederic","George","Georgi","Hans","Harry","Hiroto","Hugo","Ionut","Ivan","Jack","James","John","Jonas","Jose","Joseph","Joshua","Juan","Jules","Julian","Jusif","Kaspar","Kevin","Kobe","Kristofer","Lars","Leonardo","Lewis","Liam","Logan","Lorenzo","Louis","Lukas","Luke","Magnus","Manuel","Marc","Marian","Mario","Markus","Matas","Mathias","Mathis","Matteo","Max","Maxim","Maxime","Maximilian","Mehdi","Mikkel","Milan","Mohammed","Nathan","Nikolay","Noah","Oliver","Omar","Pablo","Patric","Peter","Phillip","Raphael","Rayyan","Riccardo","Richard","Robin","Rodrigo","Ryan","Salomon","Samuel","Sean","Stefan","Theo","Thomas","Tim","Tobias","Tom","Umar","Victor","Wiktor","William","Yann","Yegor");

var imiona_zenskie=Array(
"Abigail","Adela","Agnes","Aicha","Alessia","Alice","Alise","Alma","Alysha","Amanda","Ananya","Anastasia","Angel","Angela","Angelika","Anna","Anya","Arianna","Ariel","Aurora","Ava","Aya","Ayan","Ayla",
"Barbra","Beatriz","Brooklyn","Camille","Carol","Charlotte","Chloe","Clara","Daniela","Dima","Dora","Dorothy","Elen","Eleonor","Elisabeth","Elise","Elizabete","Ellen","Emily","Emma",
"Esther","Eva","Ewa","Ewelina","Fatima","Fiona","Gabriele","Grace","Guilia","Hannah","Indrid","Ines","Inez","Isa","Isabel","Isabella","Jade","Jana","Jessica","Joanna","Julie","Juliette",
"Katalin","Katerina","Kira","Klaudia","Kristin","Lara","Laura","Lea","Lena","Leonie","Leonor","Lilou","Lily","Louise","Lucie","Lucy","Maya","Manuela","Margaret","Maria","Marie","Marta","Mary","Mathilde","Matilde",
"Maya","Megan","Mia","Milagrosa","Milena","Natalia","Nela","Nika","Nikol","Nina","Norah","Olivia","Rachel","Rosalie","Ruby","Sarah","Seren","Simona","Sophie","Soussana","Stefania","Summer","Tala",
"Teresa","Valentina","Valeria","Victoria","Violeta","Wilma","Yasmine","Zoe"
);

function nazwisko_losowe(){
	$("input[name=nazwisko]").val(nazwiska[Math.floor((Math.random()*nazwiska.length))]);

	if ($("input[name=plec]:checked").val()=="m")
		$("input[name=imie]").val(imiona_meskie[Math.floor((Math.random()*imiona_meskie.length))]);

	if ($("input[name=plec]:checked").val()=="f")
		$("input[name=imie]").val(imiona_zenskie[Math.floor((Math.random()*imiona_zenskie.length))]);




	return false;
}

$(document).ready(function(){
	$("input[name=plec]").change(function(){
		if ($("input[name=plec]:checked").val()=="f") {
			$("div.wyborskina").fadeIn("slow");
			$(".skiny-zenskie").show();
			$(".skiny-meskie").hide();
			$("div.podglad-skina>img").attr('src',"");
			$("input[name=skin]").val(-1);
		}

	if ($("input[name=plec]:checked").val()=="m") {
			$("div.wyborskina").fadeIn("slow");
			$(".skiny-zenskie").hide();
			$(".skiny-meskie").show();
			$("div.podglad-skina>img").attr('src',"");
			$("input[name=skin]").val(-1);
		}

	});
	$(".listaskinow img").click(function(){
		$("div.podglad-skina").show();
		$("div.podglad-skina>img").attr('src',$(this).attr('src'));
		$("input[name=skin]").val($(this).attr('skin'));
	});
//	nazwiska[Math.floor((Math.random()*nazwiska.length))]
});
{/literal}</script>

{include file="_footer.tpl"}