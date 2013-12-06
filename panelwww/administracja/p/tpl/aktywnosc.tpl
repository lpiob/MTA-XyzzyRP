{include file="html.top.tpl"}

<form method='POST'>
<fieldset class='crit'><legend>Kryteria</legend>

<p>
    <label><input type='checkbox' {if $k_level[1]}checked='checked'{/if} name='k_level[1]' /> moderatorzy</label>
    <label><input type='checkbox' {if $k_level[3]}checked='checked'{/if} name='k_level[3]' /> admini</label>
    <label><input type='checkbox' {if $k_level[4]}checked='checked'{/if} name='k_level[4]' /> rconi</label>
</p>

<p>
    <label><input type='checkbox' {if $k_viewd}checked='checked'{/if} name='k_viewd' /> pokaz aktywność z ostatnich dni</label>
</p>

<p>
    <label><input type='checkbox' {if $smarty.post.k_abs}checked='checked'{/if} name='k_abs' /> pokazuj czas absolutny</label>
<p>
    <input type='submit' value='&raquo;' />
</p>
</fieldset>
</form>

<table class='full' id='aa'>
{*<colgroup span='2'></colgroup>
<colgroup span='3'></colgroup>
<colgroup span='3'></colgroup>*}
<thead>
    <tr>
    	<th>Id</th>
	<th>Nick</th>
	
	<th class="minuty">3tyg temu</th>
	<th class="minuty">2tyg temu</th>
	<th class="minuty">1tyg temu</th>
	<th class="minuty">Biezacy tydzien</th>
	<th class="minuty">3+2+1</th>
	<th class="minuty">2+1+b</th>
{if $k_viewd}
	<th class="minuty">Przedwczoraj</th>
	<th class="minuty">Wczoraj</th>
	<th class="minuty">Dzis</th>
{/if}
	
    </th>
</thead>
<tbody>
{foreach from=$aa key=pid item=dane}
<tr class='level{$dane.level}{if ($dane.week1+$dane.week2+$dane.week3)>(420*3)} zaliczone{/if}'>
    <td>{$pid}</td>
    <td>{$dane.nick}</td>
    <td class='minuty'>{$dane.week3|default:"0"}</td>        
    <td class='minuty'>{$dane.week2|default:"0"}</td>        
    <td class='minuty'>{$dane.week1|default:"0"}</td>    
    <td class='minuty'>{$dane.week0|default:"0"}</td>    
    <td class='minuty'>{($dane.week1+$dane.week2+$dane.week3)|default:"0"}</td>
    <td class='minuty'>{($dane.week0+$dane.week1+$dane.week2)|default:"0"}</td>
{if $k_viewd}
    <td class='minuty'>{$dane.day2|default:"0"}</td>    
    <td class='minuty'>{$dane.day1|default:"0"}</td>
    <td class='minuty'>{$dane.day0|default:"0"}</td>
{/if}
</tr>
{/foreach}
</tbody>
</table>

<script>{literal}

var k_abs=$("input[name=k_abs]:checked").length;

$(document).ready(function() {
    $('table#aa').dataTable({
	"bPaginate": false,
	"oLanguage": { "sUrl": "/s/dataTables.polish.txt" },
	"aoColumnDefs": [
	    {	"bSearchable": false, 
		"bUseRendered": false,
		"fnRender": function ( oObj ) {
			var m=oObj.aData[oObj.iDataColumn];
			if (m==0) return "-";
			if(!k_abs) {
			    var podstawa=((oObj.iDataColumn==6?3:(oObj.iDataColumn==7?3:1))*420);
			    if (m>=podstawa) return "0m";
			    m=podstawa-m;
			    return m+'m';
			}
			return Math.floor(m/60)+'h'+(m%60)+'m';
			
		 },
	        "aTargets": [ "minuty" ] }
	    
	]
	
	});
} );

{/literal}</script>
{include file="html.bottom.tpl"}