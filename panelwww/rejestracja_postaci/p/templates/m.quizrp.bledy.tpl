{* Smarty *}

{include file="_header.tpl"}

<h1>Quiz RP</h1>

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

{include file="_footer.tpl"}