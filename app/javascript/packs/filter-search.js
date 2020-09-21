/**
 * Created by dtredger on 20-09-18.
 * For filtering grid items
 */

window.jQuery = $;
window.$ = $;
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

$(document).ready(function() {
  $("#sticky-search").on("keyup", function(a) {
    var value = $(this).val().toLowerCase();

    $("#grid-items .resource-col").filter(function() {

      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});
