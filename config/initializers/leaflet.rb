# "http://{s}.tile.cloudmade.com/YOUR-CLOUDMADE-API-KEY/997/256/{z}/{x}/{y}.png"
# see http://leafletjs.com/reference.html#tilelayer for more


carto_cdn = {
    tiles: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>'
}

open_sea_map = {
    tiles: 'https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png',
    attribution: 'Map data: &copy; <a href="http://www.openseamap.org">OpenSeaMap</a> contributors'
}

Leaflet.tile_layer = open_sea_map[:tiles]
Leaflet.attribution = open_sea_map[:attribution]

Leaflet.tile_layer = carto_cdn[:tiles]
Leaflet.attribution = carto_cdn[:attribution]


Leaflet.max_zoom = 18


# TODO - more maps - http://leaflet-extras.github.io/leaflet-providers/preview/

