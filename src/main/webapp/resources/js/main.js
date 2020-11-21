$(document).ready(function(){
  
  // fullpage customization
  $('#fullpage').fullpage({
    sectionSelector: '.section',
    navigation: true,
    slidesNavigation: true,
    css3: true,
    controlArrows: false    
  });

 /*  $("#btn").on("click", function(event){
    var offset = $("#p2").offset();
    $("html body").animate({scrollTop:offset.top}, 1000);

  $('div').remove('#fp-nav');


  });
 */
  $('#p2').hover(function() {
    $('.arrowbox').removeClass('bounce animated');
  });

  $('#p1').hover(function() {
    $('.arrowbox').addClass('bounce animated');
  });


});