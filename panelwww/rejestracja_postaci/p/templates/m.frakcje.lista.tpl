{* Smarty *}

{include file="_header.tpl"}

<h1>Frakcje</h1>

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

<ul>
{foreach from=$frakcje item=f}
<li>{$f.name|htmlspecialchars}{if $f.czlonkow>0} {$f.czlonkow|intval|dli:"członek":"członków":"członków"}{/if}</li>
{/foreach}
</ul>

{include file="_footer.tpl"}
