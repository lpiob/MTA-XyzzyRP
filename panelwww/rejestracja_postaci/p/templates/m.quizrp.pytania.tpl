{* Smarty *}

{include file="_header.tpl"}

<h1>Quiz RP</h1>

<p>Chcemy, aby poziom gry u nas był jak najwyższy. Dlatego też, każdy z nowych graczy musi przejść <i>Quiz RP</i> który potwierdzi znajomość podstawowych
zasad RP.</p>

<p style="clear: both; "></p>

<fieldset id='quiz'><form method='POST'>
<ol>
{foreach from=$pytania item=p}
	<li>
		<p><b>{$p.pytanie}</b></p>
		{foreach from=$p.odpowiedzi item=o name=po}
			<p>
				<label><input type='radio' name='p{$p.id|intval}' value='{$smarty.foreach.po.index}' /> {$o}</label>
			</p>
		{/foreach}

	</li>
{/foreach}
</ol>

<button type='submit'>Wyślij</button>

</form></fieldset>

<style>{literal}
#quiz ol { margin-left: 2em; }
#quiz label { width: auto !important; }
#quiz input { vertical-align: middle !important; }
{/literal}</style>
{include file="_footer.tpl"}