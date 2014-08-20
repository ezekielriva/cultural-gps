module EventsHelper
  def get_event_time(date)
    return nil if date.nil?
    return get_event_hour(date) if date.today?
    return time_ago_in_words(date) if DateTime.now + 24.hour <= date
    get_event_date(date)
  end

  def get_event_date(date)
    date.strftime('%d-%m-%Y')
  end

  def get_hour(time)
    time.strftime('%H:%M')
  end

  def get_event_hour(time)
    "today at #{get_hour(time)}"
  end

  def place_distance(bearing)
    distance = number_to_human(bearing, units: {centi: "m", unit: "km", thousand: "km"})
  end

  def place_direction(bearing)
    Geocoder::Calculations.compass_point( bearing - 180 )
  end

  def place_direction_class(bearing)
    case place_direction(bearing)
    when 'N'; 'icon-arrow-up'
    when 'S'; 'icon-arrow-down'
    when 'W'; 'icon-arrow-left'
    when 'E'; 'icon-arrow-right'
    end
  end

  def has_started_class(start_date)
    'active' if start_date <= Time.now
  end
end
