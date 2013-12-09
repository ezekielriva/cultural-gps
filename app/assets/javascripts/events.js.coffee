if navigator.geolocation
  console.log 'Geolocation is supported!'
else
  console.log 'Geolocation is not supported for this Browser/OS version yet.'

$('#useCurrentPosition').on 'click', (e) ->
  if e.target.checked
    navigator.geolocation.getCurrentPosition (position) ->
      console.log position.coords.latitude
      console.log position.coords.longitude
      ubication =
        latitude: position.coords.latitude
        longitude: position.coords.longitude
      $.getJSON '/events', ubication, (data) ->
        console.log data

