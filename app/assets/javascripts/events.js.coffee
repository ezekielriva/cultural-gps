if !navigator.geolocation
  console.log 'Geolocation is not supported for this Browser/OS version yet.'
else
  navigator.geolocation.getCurrentPosition (position) ->
    $('#latitude').val position.coords.latitude
    $('#longitude').val position.coords.longitude
    $('[type=checkbox]').attr 'disabled', false

$('#useCurrentPosition').on 'click', (e) ->
  if e.target.checked
      $('form').submit()
  else
    window.location.href = '/'

