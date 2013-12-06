$(document).ready(function(){
  $(".progressbar[value]").each(function(){ $(this).progressbar({value:parseInt($(this).attr('value'))}) })
});
