{* Smarty *}

{include file="_header.tpl"}


<h1>Changelog</h1>

<p>Ostatnie 99 zmian w kodzie:</p>

<table>

{foreach from=$zmiany item=z}
<tr xmlns:v="http://rdf.data-vocabulary.org/#" typeof="v:Event">
	<td property="v:startDate" content="{$z.data|date_format:"%Y-%m-%dT%H:%M:%S%z"}">{$z.data|htmlspecialchars}</td>
	<td>{$z.autor|htmlspecialchars}</td>
	<td property="v:description">{$z.title}</td>
</tr>
{/foreach}
</table>

{include file="_footer.tpl"}