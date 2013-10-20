  <!-- Slider -->
      $(function() {
      
        $('#da-slider').cslider({
          autoplay  : true,
          interval : 7000
        });
      
      });




/* prettyPhoto Gallery */

jQuery(".prettyphoto").prettyPhoto({
overlay_gallery: false, social_tools: false
});


/* Isotype */

// cache container
var $container = $('#portfolio');
// initialize isotope
$container.isotope({
  // options...
});

// filter items when filter link is clicked
$('#filters a').click(function(){
  var selector = $(this).attr('data-filter');
  $container.isotope({ filter: selector });
  return false;
});