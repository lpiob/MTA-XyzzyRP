<ul id='lsschangelog'>
  {foreach from=$changelog item=c}
	<li xmlns:v="http://rdf.data-vocabulary.org/#" typeof="v:Event"><b property="v:startDate" content="{$c.ts|date_format:"%Y-%m-%dT%H:%M:%S%z"}">{$c.ts|date_format:"%Y.%m.%d %H:%M"}</b> <span property="v:summary">{$c.opis|htmlspecialchars}</span> <small>--{$c.login|htmlspecialchars}</small></li>
  {/foreach}
</ul>