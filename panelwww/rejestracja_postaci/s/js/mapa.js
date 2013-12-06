/**
 * jQuery.ScrollTo - Easy element scrolling using jQuery.
 * Copyright (c) 2007-2009 Ariel Flesler - aflesler(at)gmail(dot)com | http://flesler.blogspot.com
 * Dual licensed under MIT and GPL.
 * Date: 5/25/2009
 * @author Ariel Flesler
 * @version 1.4.2
 *
 * http://flesler.blogspot.com/2007/10/jqueryscrollto.html
 */
;(function(d){var k=d.scrollTo=function(a,i,e){d(window).scrollTo(a,i,e)};k.defaults={axis:'xy',duration:parseFloat(d.fn.jquery)>=1.3?0:1};k.window=function(a){return d(window)._scrollable()};d.fn._scrollable=function(){return this.map(function(){var a=this,i=!a.nodeName||d.inArray(a.nodeName.toLowerCase(),['iframe','#document','html','body'])!=-1;if(!i)return a;var e=(a.contentWindow||a).document||a.ownerDocument||a;return d.browser.safari||e.compatMode=='BackCompat'?e.body:e.documentElement})};d.fn.scrollTo=function(n,j,b){if(typeof j=='object'){b=j;j=0}if(typeof b=='function')b={onAfter:b};if(n=='max')n=9e9;b=d.extend({},k.defaults,b);j=j||b.speed||b.duration;b.queue=b.queue&&b.axis.length>1;if(b.queue)j/=2;b.offset=p(b.offset);b.over=p(b.over);return this._scrollable().each(function(){var q=this,r=d(q),f=n,s,g={},u=r.is('html,body');switch(typeof f){case'number':case'string':if(/^([+-]=)?\d+(\.\d+)?(px|%)?$/.test(f)){f=p(f);break}f=d(f,this);case'object':if(f.is||f.style)s=(f=d(f)).offset()}d.each(b.axis.split(''),function(a,i){var e=i=='x'?'Left':'Top',h=e.toLowerCase(),c='scroll'+e,l=q[c],m=k.max(q,i);if(s){g[c]=s[h]+(u?0:l-r.offset()[h]);if(b.margin){g[c]-=parseInt(f.css('margin'+e))||0;g[c]-=parseInt(f.css('border'+e+'Width'))||0}g[c]+=b.offset[h]||0;if(b.over[h])g[c]+=f[i=='x'?'width':'height']()*b.over[h]}else{var o=f[h];g[c]=o.slice&&o.slice(-1)=='%'?parseFloat(o)/100*m:o}if(/^\d+$/.test(g[c]))g[c]=g[c]<=0?0:Math.min(g[c],m);if(!a&&b.queue){if(l!=g[c])t(b.onAfterFirst);delete g[c]}});t(b.onAfter);function t(a){r.animate(g,j,b.easing,a&&function(){a.call(this,n,b)})}}).end()};k.max=function(a,i){var e=i=='x'?'Width':'Height',h='scroll'+e;if(!d(a).is('html,body'))return a[h]-d(a)[e.toLowerCase()]();var c='client'+e,l=a.ownerDocument.documentElement,m=a.ownerDocument.body;return Math.max(l[h],m[h])-Math.min(l[c],m[c])};function p(a){return typeof a=='object'?a:{top:a,left:a}}})(jQuery);

      // EuclideanProjection taken from: http://econym.googlepages.com/example_custommapflat.htm

      // ====== Create the Euclidean Projection for the flat map ======
      // == Constructor ==
      function EuclideanProjection(a){
        this.pixelsPerLonDegree=[];
        this.pixelsPerLonRadian=[];
        this.pixelOrigo=[];
        this.tileBounds=[];
        var b=256
        var c=1;
        for(var d=0;d<a;d++){
          var e=b/2;
          this.pixelsPerLonDegree.push(b/360);
          this.pixelsPerLonRadian.push(b/(2*Math.PI));
          this.pixelOrigo.push(new GPoint(e,e));
          this.tileBounds.push(c);
          b*=2;
          c*=2
        }
      }
 
      // == Attach it to the GProjection() class ==
      EuclideanProjection.prototype=new GProjection();
 
 
      // == A method for converting latitudes and longitudes to pixel coordinates == 
      EuclideanProjection.prototype.fromLatLngToPixel=function(a,b){
        var c=Math.round(this.pixelOrigo[b].x+a.lng()*this.pixelsPerLonDegree[b]);
        var d=Math.round(this.pixelOrigo[b].y+(-2*a.lat())*this.pixelsPerLonDegree[b]);
        return new GPoint(c,d)
      };

      // == a method for converting pixel coordinates to latitudes and longitudes ==
      EuclideanProjection.prototype.fromPixelToLatLng=function(a,b,c){
        var d=(a.x-this.pixelOrigo[b].x)/this.pixelsPerLonDegree[b];
        var e=-0.5*(a.y-this.pixelOrigo[b].y)/this.pixelsPerLonDegree[b];
        return new GLatLng(e,d,c)
      };

      // == a method that checks if the y value is in range, and wraps the x value ==
/*      EuclideanProjection.prototype.tileCheckRange=function(a,b,c){
        var d=this.tileBounds[b];
        if  (a.y<0 || a.y>=d || a.x<0 || a.x>=d) { // By DracoBlue: added this, to avoid repeatition 
          return false;
        }
        return true
      }*/
       // == a method that checks if the y value is in range, and wraps the x value ==
     EuclideanProjection.prototype.tileCheckRange=function(a,b,c){
         var d=this.tileBounds[b];
         if (a.y<0||a.y>=d) {
///               return false;
   	    a.y=a.y%d;
	    if(a.y<0){
	           a.y+=d;
	     }
           }
	 if(a.x<0||a.x>=d){
	    
	    a.x=a.x%d;
	    if(a.x<0){
	           a.x+=d;
	     }
	 }
	return true
  }
														       
														       

      // == a method that returns the width of the tilespace ==      
      EuclideanProjection.prototype.getWrapWidth=function(zoom) {
        return this.tileBounds[zoom]*256;
      }
	  
	  
	// Here comes the dmap specific stuff:

	var gtasaIcons = {};
	var markers = [];
	var markersText = [];
	var markersUrl = [];
	var map = null;
	var update_c = 1;
	
    function MapLoad(el) {
    
		if (GBrowserIsCompatible()) {
			map = new GMap2(document.getElementById(el),{backgroundColor: '#39484B'});

			var copyright = new GCopyright(1, new GLatLngBounds(new GLatLng(-180, -180), new GLatLng(180, 180)), 0, '&copy; LSS-RP');
			var copyrights = new GCopyrightCollection('');
			copyrights.addCopyright(copyright);
			var tilelayer = new GTileLayer(copyrights, 2, 4);
			tilelayer.getTileUrl = function(tile, zoom) { 
//			return '/i/map/'+tile.x+'x'+tile.y+'-'+(6-zoom)+".jpg"; };
			// 4 = 16, 5 == 8
			var scale=16; // jebac ten kod ponizej
			if (zoom==3) { scale=8; }
			if (zoom==2) { scale=4; }
			if (zoom==1) { scale=2; }


			return '/i/map2/'+(tile.x+tile.y*scale)+"-"+(6-zoom)+".jpg"; };
			var CUSTOM_MAP = new GMapType( [tilelayer], new EuclideanProjection(40), "LSS-RP");
			map.addMapType(CUSTOM_MAP);
			map.setMapType(CUSTOM_MAP);
			map.addControl(new GSmallMapControl());
			map.enableScrollWheelZoom();
		}

    }

function createMapMarker(point, type) {
	
	var icon = new GIcon(); 
	icon.image = '/i/'+type;
	icon.iconSize = new GSize(8, 8);
	icon.iconAnchor = new GPoint(4, 4);
	icon.infoWindowAnchor = new GPoint(1, 1);
	var marker = new GMarker(point, icon);
	return marker;
}

	function createDomyMapMarker(point, id, type) {
	
	var icon = new GIcon(); 
	icon.image = '/i/mapicons/Icon_'+type+'.gif';
	icon.iconSize = new GSize(20, 20);
	icon.iconAnchor = new GPoint(10, 10);
	icon.infoWindowAnchor = new GPoint(1, 1);
	var marker = new GMarker(point, icon);
	GEvent.addListener(marker, 'click', function() {	document.location='/domy/'+id; });
	GEvent.addListener(marker, 'mouseover', function() {
		$("#tdomyc").scrollTo("tr[hid="+id+"]")
//		$.scrollTo("tr[hid="+id+"]",1000);
		$("table#tdomy>tbody>tr[hid="+id+"]").addClass('hover').siblings("tr").removeClass('hover');
	});
	

      return marker;
    }


function createMapMarker16(point, type) {
	
	var icon = new GIcon(); 
	icon.image = '/i/'+type;
	icon.iconSize = new GSize(16, 16);
	icon.iconAnchor = new GPoint(8, 8);
	icon.infoWindowAnchor = new GPoint(1, 1);
	var marker = new GMarker(point, icon);
	return marker;
}

var marker;    
$(document).unload(function(){ GUnload(); });
    
