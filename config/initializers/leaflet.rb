# "http://{s}.tile.cloudmade.com/YOUR-CLOUDMADE-API-KEY/997/256/{z}/{x}/{y}.png"
# see http://leafletjs.com/reference.html#tilelayer for more
open_street_tiles = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
watercolor_tiles = 'http://tile.stamen.com/watercolor/{z}/{x}/{y}.png'
# open_sea_tiles = 'https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png'
open_topography_tiles = 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png'
open_attribution = 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'

satellite = 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
satellite_attribution = 'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community'

Leaflet.tile_layer = satellite
Leaflet.attribution = satellite_attribution

Leaflet.max_zoom = 18
