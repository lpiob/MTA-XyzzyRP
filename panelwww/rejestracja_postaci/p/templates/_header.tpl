<!DOCTYPE html>
<html lang="pl">
  <head>
    <title>{$html_title}</title>
    <meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="/s/js/bootstrap.js" type="text/javascript"></script>

    <link rel='stylesheet' href='/s/css/bootstrap.min.css' type='text/css' />

    <script src='/s/js/jquery.validate.min.js' type='text/javascript'></script>
	<script src='/s/js/lss.js' type='text/javascript'></script>

    {foreach from=$html_js item=js}
	<script type='text/javascript' src='{$js}'></script>
	{/foreach}
    {foreach from=$html_css item=css}
	<link rel='stylesheet' href='{$css}' type='text/css' />{/foreach}
    <link rel="icon" type="image/x-icon" href="/favicon.ico" />
</head><body>
<div class="container">

        
            <h1>XyzzyRP</h1>

