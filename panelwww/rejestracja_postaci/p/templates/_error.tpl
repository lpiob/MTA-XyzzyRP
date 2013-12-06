{* Smarty *}


{include file="_header.tpl"}


	<div class='alert alert-error alert-block'>

					<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span> 
					<strong>Wystąpił błąd:</strong> {foreach from=$_error_msgs item=e}{$e}<br />{/foreach}</p>
	<p>Kontakt: <a href='mailto:{$contact_email|default:"kontakt@lss-rp.pl"}'>{$contact_email|default:"kontakt@lss-rp.pl"}</a>.</p>
    </div>



{include file="_footer.tpl"}