//////----TO TOP---////////
jQuery(document).ready(function ($) {
jQuery('.totop').click(function(){
	jQuery('html, body').animate({ scrollTop: 0 }, "slow");
});
});	

//////----MENU---////////
jQuery(document).ready(function ($) {
$('.navbar .dropdown').hover(function() {
	$(this).addClass('extra-nav-class').find('.dropdown-menu').first().stop(true, true).delay(250).slideDown();
}, function() {
	var na = $(this)
	na.find('.dropdown-menu').first().stop(true, true).delay(100).slideUp('fast', function(){ na.removeClass('extra-nav-class') })
});

$('.dropdown-submenu').hover(function() {
	$(this).addClass('extra-nav-class').find('.dropdown-menu').first().stop(true, true).delay(250).slideDown();
}, function() {
	var na = $(this)
	na.find('.dropdown-menu').first().stop(true, true).delay(100).slideUp('fast', function(){ na.removeClass('extra-nav-class') })
});

});	

//////----Tiny Nav Responsive Menu---////////
jQuery(document).ready(function ($) {
    $("#menu-header").tinyNav({
  active: 'selected', // String: Set the "active" class
  header: 'NAVIGATION', // String: Specify text for "header" and show header instead of the active item
  label: '' // String: Sets the <label> text for the <select> (if not set, no label will be added)
});
});
  
//////----Placeholder for IE---////////
jQuery(document).ready(function ($) {
    // Invoke the plugin
    $('input, textarea').placeholder();
  });
  
//////----Fade in Images---////////  
jQuery(document).ready(function ($) {
    $("body.blog .container img, body.single .container img, .thumbnail img, .imgOpa").hover(function() {
      $(this).stop().animate({opacity: "0.6"}, 'slow');
    },
    function() {
      $(this).stop().animate({opacity: "1"}, 'slow');
    });
});
