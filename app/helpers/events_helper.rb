module EventsHelper
  def get_event_time(date)
    return nil if date.nil?
    return get_event_hour(date) if date.today?
    return time_ago_in_words(date) if DateTime.now + 24.hour <= date
    date
  end

  def get_hour(time)
    time.strftime('%H:%M')
  end

  def get_event_hour(time)
    "today at #{get_hour(time)}"
  end

  def place_distance(event)
    distance = number_to_human(event.distance, units: {centi: "m", unit: "km", thousand: "km"})
    direction = place_direction(event.bearing)
    "#{distance} - #{direction}"
  end

  def place_direction(bearing)
    Geocoder::Calculations.compass_point( bearing )
  end
end
