/*
 * Egg Plugin Pack
 *
 * http://www.liam-galvin.co.uk/
 *
 */
 
 /*
 
	- EggPreload
	- EggAccordion
	- EggSlideshow
	- EggImageDropdown
 
	
 
 */
 
 /* Info */
 var EGG = {
	version:{
				number:0.4
			}
 };
 
  
 /* EggPreload */
 (function( $ ){

  var methods = {
      init: function(options){ //init runs only to make sure images are loaded before plugin starts
		
		var $c = $(this);
		
		$c.addClass('please_wait_preloading');
		
		$c.data('options',options);

		//if not then wait for everything to preload

		$('img',$c).each(function(i,e){$(e).attr('pre_src',$(e).attr('src'));$(e).attr('src','');});
		
		//check if all (non-errored) images are loaded each time an image loads
		$('img',$c).one('load', function() {

			$(this).attr('preloaded',"1");
		
			var $parent = $(this);
			
			while(!$parent.hasClass("please_wait_preloading")){
				$parent = $parent.parent();
			}
			
			var total = $('img',$parent).length;
			var loads = $('img[preloaded=1]',$parent).length;
			
			if(loads >= total){
				$parent.removeAttr('preload_images_loaded');
				$parent.removeAttr('preload_image_count');
				$('img',$parent).removeAttr('preloaded');
				var options = $parent.data('options');
				$parent.data('options','');
				options.complete($parent,options.options);
			}

		}).each(function(i,e) {
			if(this.complete){
				$(e).load();
			}
		});
		
		$('img',$c).each(function(i,e){$(e).attr('src',$(e).attr('pre_src'));$(e).removeAttr('pre_src')});
		
    }
  };

  $.fn.EggPreload = function(method,options) {

    var settings = {
		complete:function(){},
		options:{}
    };

	method = method == undefined ? 'init' : method;
    if ( options) { $.extend( settings, options ); }
    if(typeof method === 'object'){$.extend( settings, method ); method = 'init';}

    return this.each(function() {
        if ( methods[method] ) {
            return methods[method].apply( this, Array(settings));
        } else {
            $.error( 'Method ' +  method + ' does not exist on jQuery Egg plugin.' );
        }
    });

  };
})( jQuery );
/* End EggPreload */
 
 
 
 /* EggAccordion jQuery Plugin */
(function( $ ){

  var methods = {
	  init: function(options){ //init runs only to make sure images are loaded before plugin starts
		$(this).EggPreload({complete:function($e,options){$e.EggAccordion('load',options);},options:options});
      },
	  
	  load:function(options){
		var $c = $(this);
		
			
		$c.addClass('egg_accordion').data('egg_accordion_options',options);
		
		$c.width(options.width);
		
		if(options.height != 'auto') $c.height(options.height);
		
		options.count = $('img',$c).length;
		
		$('img',$c).wrap('<div class="egg_accordionSlide" />');
		$('.egg_accordionSlide',$c).each(function(index,e){
			var $e = $(e);
			var options = $e.parent().data('egg_accordion_options');
			$(e).attr('egg_accordion_slide',index);
			$(e).width(1);
		});
		
		
		$('img',$c).click(function(){
			var $img = $(this);
			var $slide = $img;
			
			while(!$slide.hasClass('egg_accordionSlide')){
				$slide = $slide.parent();
			}
			
			var $accordion = $slide;
			
			while(!$accordion.hasClass('egg_accordion')){
				$accordion = $accordion.parent();
			}
			
			var options = $accordion.data('egg_accordion_options');
			var new_selected = $slide.attr('egg_accordion_slide');
			options.slide = new_selected;
			$accordion.data('egg_accordion_options',options);
			$accordion.EggAccordion('select');
			
		}).mouseover(function(){
			
			$accordion = $(this);
			while(!$accordion.hasClass('egg_accordion')){
				$accordion = $accordion.parent();
			}
			$('.egg_accordionSlide > img',$accordion).stop().animate({opacity:0.5});
			$(this).stop().animate({opacity:1});
			
			
		}).mouseout(function(){
			
			$accordion = $(this);
			while(!$accordion.hasClass('egg_accordion')){
				$accordion = $accordion.parent();
			}
			$('.egg_accordionSlide > img',$accordion).stop().animate({opacity:1});
			
		});
		
		$c.EggAccordion('select');
				
		if(options.auto){
			$c.data('interval', setInterval(function(){var options = $c.data('egg_accordion_options');options.slide++;if(options.slide>=options.count){options.slide=0;}$c.data('egg_accordion_options',options);$c.EggAccordion('select');},options.delay));
		}
		
	  },
	  
	  select:function(){
		
		
		$accordion = $(this);
		
		options = $accordion.data('egg_accordion_options');
		
		var image_width = $('.egg_accordionSlide[egg_accordion_slide=' + options.slide + '] img', $accordion).width();
		
		if(image_width == 0){
		
			setTimeout(function(){$accordion.EggAccordion('select');},10);
		
		}else{
		
			if(options.auto){
				var interval = $accordion.data('interval');
				clearInterval(interval);
				$accordion.data('interval', setInterval(function(){var options = $accordion.data('egg_accordion_options');options.slide++;if(options.slide>=options.count){options.slide=0;}$accordion.data('egg_accordion_options',options);$accordion.EggAccordion('select');},options.delay));
			}
			
			var images = $('img',$accordion).length;
			
			var peek = Math.round((options.width - image_width) / (images-1));
			
			$('.egg_accordionSlide',$accordion).stop().animate({width:peek},390);
			$slide = $('.egg_accordionSlide[egg_accordion_slide=' + options.slide + ']',$accordion);
			$slide.stop().animate({width:image_width},400);
			$('img',$accordion).stop().animate({opacity:1});
			
		}
	  
	  }
	  
	  
	  
	};

  $.fn.EggAccordion = function(method,options) {

    var settings = {
		slide:0, //slide to start on
		width:600, //width of widget
		height:'auto', //height of widget
		auto:false,
		delay:8000
    };
	
	method = method == undefined ? 'init' : method;
    if ( options) { $.extend( settings, options ); }
    if(typeof method === 'object'){$.extend( settings, method ); method = 'init';}

    return this.each(function() {
        if ( methods[method] ) {
            return methods[method].apply( this, Array(settings));
        } else {
            $.error( 'Method ' +  method + ' doesn\'t even exist on that Egg plugin. Check your code, fool.' );
        }
    });

  };
})( jQuery );
/* End EggAccordion */


/* EggSlideshow */

(function( $ ){

  var methods = {
      init: function(options){
		$(this).EggPreload({complete:function($e,options){$e.EggSlideshow('load',options);},options:options});
	  },
	  load:function(options){
	  
		var $EggSlideshow = $(this);	
		
		$EggSlideshow.addClass('egg_slideshow');
		
		var $children = $($EggSlideshow).children().remove();
		
		$runner = $('<div class="egg_slideshow_runner"></div>');
		$runner.append($children);
		$EggSlideshow.append($runner);
		
		$runner.find('> slide').addClass('egg_slide').find('extract').addClass('egg_slide_extract');
		
		$runner.find('img').addClass('egg_slide_image').each(function(i,el){
		
			if(!$(el).parent().is('a')){
				$(el).wrap('<a href="#"></a>');
			}
		
		});
				
		var current = options.slide;
		$EggSlideshow.attr('ess_current',current); //Set current slide to #1
		var count = $('.egg_slide',$EggSlideshow).length;
		$EggSlideshow.attr('ess_count',count); //Set number of slides
		
		$('.egg_slideshow_runner',$EggSlideshow).css('width',(options.width * count) + 'px').css('height',(options.height) + 'px');
		
		// Set all the dimensions
		$EggSlideshow.css('height',options.height + 'px');
		$EggSlideshow.css('width',options.width + 'px');
		
		$("egg_slideshow_runner", $EggSlideshow).css('height',options.height + 'px');
		
		$(".egg_slide", $EggSlideshow).css('height',options.height + 'px');
		$(".egg_slide", $EggSlideshow).css('width',options.width + 'px');
		
		$(".egg_slide a img", $EggSlideshow).css('width',options.width + 'px');
         
		$(".egg_slide_extract", $EggSlideshow).css('width',(options.width-40) + 'px'); 
		
		$(".egg_slide_extract", $EggSlideshow).css('opacity','0.8');
				
		// For each slide add a 'Read More' link to the extract and hide the extract if no text is supplied for it.
		if(options.extracts){		
			$.each($(".egg_slide", $EggSlideshow), function(i,e){
				var href= $('a',e).attr('href');
				var text = $('.egg_slide_extract',e).text();
				var width = $('.egg_slide_extract',e).width();
				var maxLength = Math.round(width / 6.5); //max length of string
				if(text != ""){
					$('a',e).removeAttr('href');
					if(text.length > maxLength){
						text = text.substring(0,maxLength);
						while(!/ $/.test(text)){ text = text.substring(0,text.length-1); }
						text = text.substring(0,text.length-1);	
						if(/\.$/.test(text)){text = text.substring(0,text.length-1);}
						text += '...';
						$('.egg_slide_extract',e).text(text);
					}
					$('.egg_slide_extract',e).append('<div class="egg_ess_right"><a href="' + href + '">Read More</a></div>');
				}else{
					$('.egg_slide_extract',e).hide();
				}
			} );
		}else{
			$(".egg_slide_extract", $EggSlideshow).hide();
		}
		
		 // Open links in new windows
		if(options.openLinksInNewWindow){
			$("a", $EggSlideshow).attr('target','_blank');
		}
		
		// Check images cover all of slide, change locked dimension to height if not
		$.each($(".egg_slide", $EggSlideshow),function(i,e){
			$img = $("img.egg_slide_image",$(e));
			if($img.height() > 0 && $img.height() < $(e).height()){
				$img.css('width','');
				$img.css('height',$(e).css('height'));
			}
			
			$(e).css('left',($(e).width() * (i)) + 'px');
			
		});
		
		// Prev/next buttons
		if(options.buttons){
			var left_a = $('<div class="egg_slide-arrow-left"></div>');
			var right_a = $('<div class="egg_slide-arrow-right"></div>');
			
			$EggSlideshow.append(left_a);
			$EggSlideshow.append(right_a);
			var arrow_top = Math.round(($EggSlideshow.height()-13)/2);
			left_a.css('top',arrow_top + 'px').click(function(){$(this).parent().EggSlideshow('prev');});
			right_a.css('top',arrow_top + 'px').click(function(){$(this).parent().EggSlideshow('next');});
		}
		
		// Blocks
		
		if(options.blocks){
			$block_container = $('<div class="egg_slideshow_block_container"></div>');
			var bcw = (13 * count);
			$block_container.css('width',bcw + 'px');
			var bcl = Math.round(($EggSlideshow.width() - bcw)/2);
			$block_container.css('left',bcl + 'px');
			
			$EggSlideshow.append($block_container);
			
			var $block;
			
			for(var i =1;i<=count;i++){
				if(i == current){
					$block = $('<div class="egg_slideshow_block egg_slideshow_block_selected" slide="' + i + '"><!--' + i + '--></div>');
				}else{
					$block = $('<div class="egg_slideshow_block" slide="' + i + '"><!--' + i + '--></div>');
				}
				$block_container.append($block);
				if(options.blockNav){
					$block.click(function(){
						$(this).parent().parent().EggSlideshow('go',{slide:parseInt($(this).attr('slide'))});
					});
				}
			}
			if(options.blockNav){
				$('.egg_slideshow_block',$EggSlideshow).css('cursor','pointer');
			}
		}
		
		$EggSlideshow.EggSlideshow('go',{slide:1});
		
		$EggSlideshow.auto = options.auto;
		
		if(options.auto){
			var interval = setInterval(function(){$('.egg_slideshow').EggSlideshow('next');},options.delay);
			$EggSlideshow.attr('delay',options.delay);
			$EggSlideshow.attr('auto','1');
			$EggSlideshow.data('interval',interval);
		}

      },
	  
	  next:function(){
		var $EggSlideshow = $(this);
		var current = parseInt($EggSlideshow.attr('ess_current')) + 1;
		var count = parseInt($EggSlideshow.attr('ess_count'));
		if(current <= count){
			$EggSlideshow.EggSlideshow('go',{slide:current});
		}else{
			$EggSlideshow.EggSlideshow('go',{slide:1});
		}
	  },
	  
	  prev:function(){
		var $EggSlideshow = $(this);
		var current = parseInt($EggSlideshow.attr('ess_current')) - 1;
		if(current > 0){
			$EggSlideshow.EggSlideshow('go',{slide:current});
		}
	  },
	  
	  go:function(options){
	  
		slide = options.slide;
		
		
	  
		 //Set current slide to #1
		 var $EggSlideshow = $(this);
		
		if($EggSlideshow.attr('auto') == '1'){
			var interval = parseInt($EggSlideshow.data('interval'));
			clearInterval(interval);
			interval = setInterval(function(){$('.egg_slideshow').EggSlideshow('next');},parseInt($($('.egg_slideshow')[0]).attr('delay')));
			$EggSlideshow.data('interval',interval);
		}
		
		var old = parseInt($EggSlideshow.attr('ess_current'));		
		var count = parseInt($EggSlideshow.attr('ess_count'));
		
		if(slide > 0 && slide <= count){
			current = slide;
			$EggSlideshow.attr('ess_current',current);
			
			if(current == count){
				//last slide so hide next button
				$('.egg_slide-arrow-right',$EggSlideshow).fadeOut();
			}else{
				if(old == count){
					$('.egg_slide-arrow-right',$EggSlideshow).fadeIn();
				}
			}
			
			if(current == 1){
				//first slide so hide prev button
				$('.egg_slide-arrow-left',$EggSlideshow).fadeOut();
			}else{
				if(old == 1){
					$('.egg_slide-arrow-left',$EggSlideshow).fadeIn();
				}
			}
			
			$('.egg_slideshow_block_selected',$EggSlideshow).removeClass('egg_slideshow_block_selected');
			
			$('.egg_slideshow_block[slide=' + current + ']',$EggSlideshow).addClass('egg_slideshow_block_selected');
			
			var newLeft = -((current - 1) * $EggSlideshow.width());
			$('.egg_slideshow_runner',$EggSlideshow).animate({left:newLeft});
			
			
		}
	  }
  };


  $.fn.EggSlideshow = function(method,options) {

    if(method == undefined){
        method = 'init';
    }
	
    var settings = {
		slide:1, // slide to start on
		auto:false, //whether to loop slides automatically
		delay:5000, //ms between slides
        extracts:true, // show extract text for each slide
        openLinksInNewWindow:false, // open links in a new window
		blocks:true, // show blocks to represent which slide we are on
		blockNav:true, // make blocks clickable to navigate slides
		buttons:true, // show prev/next arrow buttons
		width:500, // width of the EggSlideshow
		height:300 // :: height of the EggSlideshow
    };

    if ( options) { $.extend( settings, options ); }

    if(typeof method === 'object'){$.extend( settings, method ); method = 'init';}

    return this.each(function() {
        if ( methods[method] ) {
            return methods[method].apply( this, Array(settings));
        } else {
            $.error( 'Method ' +  method + ' does not exist on EggPlugin' );
        }
    });

  };
})( jQuery );
/* End EggSlideshow */


/* EggImageDropdown */
(function( $ ){

  var methods = {
      init: function(options){
          if(!/select/i.test(this.tagName)){return false;}

            var element = $(this);

          var selectName = element.attr('id');
		  if(!selectName){
			var nid = 'egg_rnd_' + Math.floor(Math.random()*99999);
			while($('#' + nid).length > 0){
				nid = 'egg_rnd_' + Math.floor(Math.random()*99999);
			}
			element.attr('id', nid);
			selectNamer = nid;
		  }
          var id = 'egg_imagedropdown_' + selectName;

          if($('#'+id).length > 0){
              //already exists
              return;
          }

          var iWidth= options.width > options.dropdownWidth ? options.width : options.dropdownWidth;

          var imageSelect = $(document.createElement('div')).attr('id',id).addClass('jqis');

          imageSelect.css('width',iWidth+'px').css('height',options.height+'px');

          var header = $(document.createElement('div')).addClass('egg_imagedropdown_header');
          header.css('width',options.width+'px').css('height',options.height +'px');
          header.css('text-align','center').css('background-color',options.backgroundColor);
          header.css('border','1px solid ' + options.borderColor);

          var dropdown = $(document.createElement('div')).addClass('egg_imagedropdown_dropdown');

          dropdown.css('width',options.dropdownWidth+'px');//.css('height',options.dropdownHeight +'px');
          dropdown.css('z-index',options.z).css('background-color',options.backgroundColor).css('border','1px solid ' + options.borderColor);;
          dropdown.hide();

          var selectedImage = $('option:selected',element).text();

          header.attr('lock',options.lock);
          if(options.lock == 'height'){
            header.append('<img style="height:' + options.height + 'px" />');
          }else{
            header.append('<img style="width:' + (options.width-75) + 'px" />');
          }
          

          var $options = $('option',element);

          $options.each(function(i,el){
                dropdown.append('<img style="width:100%" onclick="var t=jQuery(\'select[id=' + selectName + ']\').val(\''+ $(el).val() + '\').EggImageDropdown(\'close\').EggImageDropdown(\'update\',{src:\''+ $(el).text() + '\'});t.trigger(\'change\');" src="' + $(el).text() + '"/>');
          });


          imageSelect.append(header);
          imageSelect.append(dropdown);

          element.after(imageSelect);
          element.hide();


          header.attr('linkedselect',selectName);
          header.children().attr('linkedselect',selectName);
          header.click(function(){$('select[id=' + $(this).attr('linkedselect') + ']').EggImageDropdown('open');});
          //header.children().click(function(){$('select[id=' + $(this).attr('linkedselect') + ']').ImageSelect('open');});

          var w = 0;

          $('.egg_imagedropdown_dropdown img').mouseover(function(){
              $(this).css('opacity',1);
          }).mouseout(function(){
              $(this).css('opacity',0.9);
          }).css('opacity',0.9).each(function(i,el){
            w = w+$(el).width();
          });

          dropdown.css('max-height',options.dropdownHeight + 'px');

          element.EggImageDropdown('update',{src:selectedImage});

      },
      
      update:function(options){

          var element = $(this);

          var selectName = element.attr('id');
          var id = 'egg_imagedropdown_' + selectName;

          if($('#'+id + ' .egg_imagedropdown_header').length == 1){

                var ffix = false;

             if($('#'+id + ' .egg_imagedropdown_header img').attr('src') != options.src){
                 ffix = true; //run fix for firefox
             }

             $('#'+id + ' .egg_imagedropdown_header img').attr('src',options.src).css('opacity',0.1);

			 
			 
             if(ffix){
                 setTimeout(function(){element.EggImageDropdown('update',options);},1);
             }else{

             if($('#'+id + ' .egg_imagedropdown_header').attr('lock') == 'height'){

                $('#'+id + ' .egg_imagedropdown_header img').unbind('load');

                $('#'+id + ' .egg_imagedropdown_header img').one('load',function(){

                    $(this).parent().stop();
                    //$('.jqis_dropdown',$(this).parent().parent()).stop();
                    $(this).parent().parent().stop();
                    $(this).parent().animate({width:$(this).width() + 60});
                    $(this).parent().parent().animate({width:$(this).width() + 60});
                    $('.egg_imagedropdown_dropdown',$(this).parent().parent()).animate({width:$(this).width() + 50});

                }).each(function() {
                  if(this.complete) $(this).load();
                });
             }else{
                $('#'+id + ' .egg_imagedropdown_header img').unbind('load');
                $('#'+id + ' .egg_imagedropdown_header img').one('load', function() {
                    $(this).parent().parent().stop();
                    $(this).parent().stop();
                    $(this).parent().parent().css('height',($(this).height()+2) + 'px');
                    $(this).parent().animate({height:$(this).height()+2});
                }).each(function() {
                  if(this.complete) $(this).load();
                });
                
             }

             $('#'+id + ' .egg_imagedropdown_header img').animate({opacity:1});

			 }

          }
		  
		  element.trigger('change');

      },
      open: function(){

          var element = $(this);

          var selectName = element.attr('id');
          var id = 'egg_imagedropdown_' + selectName;

          var w = 0;

          if($('#'+id).length == 1){

            if($('#'+id + ' .egg_imagedropdown_dropdown').is(':visible')){
                $('#'+id + ' .egg_imagedropdown_dropdown').stop();
                $('#'+id + ' .egg_imagedropdown_dropdown').slideUp().hide();
            }else{
                $('#'+id + ' .egg_imagedropdown_dropdown').stop();
                var mh = $('#'+id + ' .egg_imagedropdown_dropdown').css('max-height').replace(/px/,'');
                mh = parseInt(mh);

                element.data('imageHeightTotal', 0);

                $('#'+id + ' .egg_imagedropdown_dropdown').show().css('opacity',1);

				
                $('#'+id + ' .egg_imagedropdown_dropdown img').each(function(i,el){
                   $(el).parent().parent().data('imageHeightTotal', $(el).parent().parent().data('imageHeightTotal') + $(el).height());
                });

                var ih = element.data('imageHeightTotal');

                mh = (ih < mh && ih > 0) ? ih : mh;

                $('#'+id + ' .egg_imagedropdown_dropdown').height(mh).css('overflow-y','scroll');
            }
              
          }
      },
      close:function(){

          var element = $(this);

          var selectName = element.attr('id');
          var id = 'egg_imagedropdown_' + selectName;

		  
          if($('#'+id).length == 1){

            $('#'+id + ' .egg_imagedropdown_dropdown').slideUp().hide();

          }
      },
      remove: function(){
          if(!/select/i.test(this.tagName)){return false;}

          var element = $(this);

          var selectName = element.attr('id');
          var id = 'egg_imagedropdown_' + selectName;

          if($('#'+id).length > 0){
              $('#'+id).remove();
              $('select[id=' + selectName + ']').show();
              return;
          }
      }
  };


  $.fn.EggImageDropdown = function(method,options) {

    if(method == undefined){
        method = 'init';
    }

    var settings = {
        width:200,
        height:75,
        dropdownHeight:250,
        dropdownWidth:200,
        z:99999,
        backgroundColor:'#ffffff',
        border:true,
        borderColor:'#cccccc',
        lock:'height'
    };

    if ( options) { $.extend( settings, options ); }

    if(typeof method === 'object'){$.extend( settings, method ); method = 'init';}

    return this.each(function() {
        if ( methods[method] ) {
            return methods[method].apply( this, Array(settings));
        } else {
            $.error( 'Method ' +  method + ' does not exist on EggPlugin' );
        }
    });

  };
})( jQuery );

/* NiceForm */
// resize, validation
// http://james.padolsey.com/javascript/jquery-plugin-autoresize/
// http://www.tripwiremagazine.com/2010/01/75-top-jquery-plugins-to-improve-your-html-forms.html