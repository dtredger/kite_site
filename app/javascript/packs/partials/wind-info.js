// for views/partials/_wind_info.html.erb

$(document).ready(function() {
  $(".wind-nav").on("click", function(a) {

    var target = $(this).data('target');

    $('.wind-nav').removeClass('active');
    $(this).addClass('active');

    $('.wind-panel ').hide();
    $('.'+target).show();
  });
});
