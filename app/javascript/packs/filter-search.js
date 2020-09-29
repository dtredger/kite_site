//For filtering main_grid items

$(document).ready(function() {
  $("#sticky-search").on("keyup", function(a) {
    var value = $(this).val().toLowerCase();

    $("#grid-items .resource-col").filter(function() {

      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});
