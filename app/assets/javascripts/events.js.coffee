if !navigator.geolocation
  console.log 'Geolocation is not supported for this Browser/OS version yet.'
else
  navigator.geolocation.getCurrentPosition (position) ->
    $('#latitude').val position.coords.latitude
    $('#longitude').val position.coords.longitude
    $('#useCurrentPosition_button').attr 'disabled', false

$('#useCurrentPosition_button').on 'click', (e) ->
  e.preventDefault();
  $check = $('#useCurrentPosition');
  $check.attr 'checked', !$check.is(':checked')
  if $check.is(':checked')
      $('form').submit()
  else
    window.location.href = '/'

$('#event-table tr').on 'click', (e) ->
  window.location.href = this.dataset.link
