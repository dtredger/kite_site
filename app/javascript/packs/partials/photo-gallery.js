
// photo_gallery
$(document).on('click', '[data-toggle="lightbox"]', function(event) {
  event.preventDefault();
  $(this).ekkoLightbox({
    //alwaysShowClose: false,
    //loadingMessage: 'loading',
    //leftArrow: '❮',
    //rightArrow: '❯'
  });
});
