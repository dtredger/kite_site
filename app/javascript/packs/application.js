// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

global.Rails = require("@rails/ujs")
Rails.start()

require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

global.jquery = require('jquery')

require("leaflet")
require('packs/leaflet-custom')
require('leaflet.awesome-markers')

require('packs/filter-search')

require("trix")
require("@rails/actiontext")
require('packs/action-text-files')

require("ekko-lightbox")
//TODO - required on form directly because of rendering issue
//require("bootstrap-hardskilled-extend-select/js/select.min")

global.toastr = require("toastr")
global.toastr.options = {
    showMethod: 'slideDown',
    hideMethod: 'slideUp',
    hideDuration: 150,
    closeMethod: 'slideUp',
    closeButton: true,
    closeDuration: 150,
    showEasing: 'linear',
    hideEasing: 'linear',
    closeEasing: 'linear',
    timeOut: 10000,
    progressBar: true
}

window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());

gtag('config', 'UA-179199554-1');

document.addEventListener('turbolinks:load', function(event) {
  if (typeof gtag === 'function') {
    gtag('config', 'UA-179199554-1', {
      'page_location': event.data.url
    })
  }
})

//var glob = require( 'glob' ),
//    path = require( 'path' );
//
//glob.sync( './partials/**/*.js' ).forEach(function(file) {
//  require(path.resolve(file));
//});
require("packs/partials/wind-info");
require("packs/partials/photo-gallery");
//require("packs/bootstrap-forms");
