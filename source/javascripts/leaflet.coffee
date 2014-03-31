#= require leaflet-providers/leaflet-providers

onMapClick = (e) ->
map = L.map("map").setView([ 52.0420556802915, 8.8904132197084979 ], 13)
#L.tileLayer.provider('Stamen.Watercolor').addTo(map);


baseLayers = [ "OpenStreetMap.DE" ]
#overlays = [ "OpenStreetMap.Mapnik" ]
layerControl = L.control.layers.provided(baseLayers).addTo(map)
marker = L.marker([ 52.0407066999999, 8.891762199999999 ]).addTo(map)
    .bindPopup('<b>Steinmühle Lemgo</b><br /> Entruper Weg 88 <br />32657 Lemgo')
    .openPopup();


