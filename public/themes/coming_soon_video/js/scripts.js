<!-- HTML5 Video Mobile support -->

$(document).ready(function(){
	var video_url = $('#intro video').attr("src");
	var videoMobile = '<video src="' + video_url + '" preload="none" controls muted loop width="920" height="620"></video>'
	var videoComputer = '<video src="' + video_url + '" preload="auto" autoplay muted loop width="960"></video>'
	
			
	if( /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ) {
			$('#intro .grid-video').append(videoMobile);
		} else {
			$('#intro .grid-video').append(videoComputer);
		}

});

<!-- Gallery overview script -->
	
	$(function(){
		$('#content-slides').slides({
			preload: true,
			generateNextPrev: true
		});
	});

<!-- Parallax and Menu scroll script -->

$(document).ready(function(){
	$('#nav').localScroll({offset: -70});
	$('.menu').localScroll({offset: -70});
	$('#subscribe').parallax("50%", 0.3);
	$('#features').parallax("50%", 0.3);

});

// Responsive Menu

$(document).ready(function() {   
    $("#menu").click(function () {
		$("ul.menu").toggle();
	});
});

<!-- Tab Script -->
  
  // $(function() {
  //   $( "#tabs" ).tabs();
  // });

<!-- Intro slideshow Script -->

$(document).ready(function(){
	  $("#slide").responsiveSlides({
        maxwidth:12000,
        speed: 800
      });
});

<!-- Testimonials Script -->
	
	$(document).ready(function() {
							   
		var currentPosition = 0;
		var slideWidth = 960;
		var slides = $('.testimonials-slide');
		var numberOfSlides = slides.length;
		var slideShowInterval;
		var speed = 8000;

		
		slideShowInterval = setInterval(changePosition, speed);
		
		slides.wrapAll('<div id="slidesHolder"></div>')
		
		slides.css({ 'float' : 'left' });
		
		$('#slidesHolder').css('width', slideWidth * numberOfSlides);
		
		
		function changePosition() {
			if(currentPosition == numberOfSlides - 1) {
				currentPosition = 0;
			} else {
				currentPosition++;
			}
			moveSlide();
		}
		
		
		function moveSlide() {
				$('#slidesHolder')
				  .animate({'marginLeft' : slideWidth*(-currentPosition)});
		}

	});

<!-- Zoom prices table script -->

$(document).ready( function() {
$('.prices').hover(
    function() {
        $(this).animate({ 'zoom': 1.1, 'margin-top':'-20px'}, 200);
    },
    function() {
        $(this).animate({ 'zoom': 1,'margin-top':'0px' }, 200);
    });

});

<!-- Lightbox gallery script -->

jQuery(document).ready(function($) {
	
	$('.lightbox_trigger').click(function(e) {
		
		//prevent default action (hyperlink)
		e.preventDefault();
		
		//Get clicked link href
		var image_href = $(this).attr("href");
		
		/* 	
		If the lightbox window HTML already exists in document, 
		change the img src to to match the href of whatever link was clicked
		
		If the lightbox window HTML doesn't exists, create it and insert it.
		(This will only happen the first time around)
		*/
		
		if ($('#lightbox').length > 0) { // #lightbox exists
			
			//place href as img src value
			$('#content').html('<img src="' + image_href + '" />');
		   	
			//show lightbox window - you could use .show('fast') for a transition
			$('#lightbox').show();
		}
		
		else { //#lightbox does not exist - create and insert (runs 1st time only)
			
			//create HTML markup for lightbox window
			var lightbox = 
			'<div id="lightbox">' +
				'<p>Click to close</p>' +
				'<div id="content">' + //insert clicked link's href into img src
					'<img src="' + image_href +'" />' +
				'</div>' +	
			'</div>';
				
			//insert lightbox HTML into page
			$('body').append(lightbox);
		}
		
	});
	
	//Click anywhere on the page to get rid of lightbox window
	$('#lightbox').live('click', function() { //must use live, as the lightbox element is inserted into the DOM
		$('#lightbox').hide();
	});

});