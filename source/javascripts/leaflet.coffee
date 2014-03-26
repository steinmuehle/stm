#= require leaflet-dist/leaflet
#= require leaflet-providers/leaflet-providers

onMapClick = (e) ->
map = L.map("map").setView([ 52.0420556802915, 8.8904132197084979 ], 18)
#L.tileLayer.provider('Stamen.Watercolor').addTo(map);
#circle = L.circle([ 52.0420556802915, 8.8904132197084979 ], 10, 100, color: 'red').addTo(map)


baseLayers = [ "OpenStreetMap.DE" ]
overlays = [ "OpenStreetMap.Mapnik" ]
layerControl = L.control.layers.provided(baseLayers).addTo(map)
marker = L.marker([ 52.0420556802915, 8.8904132197084979 ]).addTo(map)


