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

$('#event-table tbody tr').on 'click', (e) ->
  window.location.href = this.dataset.link

# Map image
$map_image = $('#map-image')
$map_image.data('size', '340x200')
$map_image.find('img').attr('src',
  "http://maps.google.com/maps/api/staticmap?size="+$map_image.data('size')+"&sensor=false&zoom=16&markers="+ $map_image.data('latitude')+"%2C"+ $map_image.data('longitude')
  )

$('#event_place_id').select2
  placeholder: "Search event place"
  ajax:
    url: () ->
      this.data('url')
    data: (term, page) ->
      q: term
    results: (data, page) ->
      results: data.map (el) ->
        id: el.id
        text: el.name
  initSelection: (el, callback) ->
    callback
      id: el.val()
      text: el.data('value')
