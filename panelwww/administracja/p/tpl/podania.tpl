{include file="html.top.tpl"}
<table class='full' id='podania'>
<thead>
<tr>
    <th>ID</th>
    <th>Akcja</th>
	<th>Imie_Nazwisko</th>
    <th>Login</th>
    <th>Treść</th>
</tr>
</thead>
<tbody>
{foreach from=$podania item=p}
<tr class='bid{$p.id}'>
    <td class='banid'>{$p.id}</td>
    <td class='klik'>&nbsp;</td>
    <td>{$p.imie|htmlspecialchars}_{$p.nazwisko|htmlspecialchars}</td>
    <td class='login'>{$p.login|htmlspecialchars}</td>
    <td class='test'>{$p.tresc|htmlspecialchars|nl2br}</td>
</tr>
{/foreach}
</tbody>
</table>
<script>{literal}
$(document).ready(function() {
    var banTable=$('table#podania').dataTable({
	"bPaginate": false,
	"oLanguage": { "sUrl": "/s/dataTables.polish.txt" }
	
	});
    $('table#podania td.klik').live('click', function(){
	    $("table#podania>tbody>tr.akcje").remove();
	    var bid=$(this).siblings("td.banid").html();
//	    alert(bid);
	    var nTr=$(this).parent("tr").after("<tr class='akcje'><td colspan='4'><button onclick='p_accept("+bid+")'>ACCEPT</button> <button onclick='p_delete("+bid+")'>USUŃ</button></td></tr>");
	    
//	    banTable.fnOpen( nTr, fnFormatDetails(banTable, nTr), 'details' );
	    
	});
} );

function fnFormatDetails ( banTable, nTr )
{
    var sOut="<div class='akcje'>Usuń ban</div>";
    
    return sOut;
}
			    

function p_accept(banid){
    if (!window.confirm("Czy na pewno chcesz zaakceptowac podanie  gracza "+$("table#podania>tbody>tr.bid"+banid+">td.login").html()+"?"))
	return;
    $.ajax({
	url: "/postacie-ajax",
	data: { characterid: banid, a2: "accept" },
	type: "POST",
	success: function(msg){
	    if (msg=='OK') {
		alert("Postać zaakceptowana");
		$("table#podania>tbody>tr.bid"+banid+"+tr.akcje").remove();
		$("table#podania>tbody>tr.bid"+banid).remove();
	    } else alert("Wystapil blad:."+msg);
	}
	})
}

function p_delete(banid){
    if (!window.confirm("Czy na pewno chcesz ODRZUCIC podanie  gracza "+$("table#podania>tbody>tr.bid"+banid+">td.login").html()+"?"))
	return;
    $.ajax({
	url: "/postacie-ajax",
	data: { characterid: banid, a2: "delete" },
	type: "POST",
	success: function(msg){
	    if (msg=='OK') {
		alert("Podanie usuniete");
		$("table#podania>tbody>tr.bid"+banid+"+tr.akcje").remove();
		$("table#podania>tbody>tr.bid"+banid).remove();
	    } else alert("Wystapil blad:."+msg);
	}
	})
}

{/literal}</script>


{include file="html.bottom.tpl"}