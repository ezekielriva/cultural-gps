module EventsHelper
  def get_event_time(date)
    return nil if date.nil?
    date.today? ? get_event_hour(date) : time_ago_in_words(date)
  end

  def get_hour(time)
    time.strftime('%H:%M')
  end

  def get_event_hour(time)
    "today at #{get_hour(time)}"
  end
end
