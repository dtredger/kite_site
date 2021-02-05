//For filtering main_grid items

$(document).ready(function() {
  $("#sticky-search").on("keyup", function(a) {
    var value = $(this).val().toLowerCase();

    $("#grid-items .resource-col").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });


  $("#distance-range-selector").change(function(el) {
    $input_value = $(el.delegateTarget).val();
    $label = $("#distance-range-selector").siblings("label");
    if($input_value == "10000") {
      $label.text("Max Distance away from me: Unlimited");
    } else {
      $label.text("Max Distance away from me: " + $input_value + "KM");
    }
  });

});
