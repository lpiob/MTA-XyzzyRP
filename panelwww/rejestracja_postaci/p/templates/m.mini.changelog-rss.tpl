<rss version="2.0">
<channel>
	<title>LSS-RP Changelog</title>
	<link>http://lss-rp.pl/</link>
	<description>Ostatnie zmiany w LSS-RP</description>
  {foreach from=$changelog item=c}
	<item>
	<link>http://lss-rp.pl/</link>
	<title>{$c.opis|htmlspecialchars}</title>
	<pubDate>{$c.ts|date_format:"%a, %d %b %Y %H:%M:%S %z"}</pubDate>
	<guid>{$c.id}</guid>
	</item>
  {/foreach}
</channel>
</rss>