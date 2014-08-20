class Event < ActiveRecord::Base
  belongs_to :place

  validates :name, presence: true, length: { maximum: 80 }
  validates :description, presence: true, length: { maximum: 300 }

  attr_accessor :bearing, :distance

  scope :order_by_start_date, -> (order = 'ASC') { order("events.start_date #{order}") }
  scope :doesnt_end, -> () { where('events.end_date >= ?', Time.zone.now) }
  scope :until_date, -> (date = Time.zone.now.at_end_of_quarter) {
    where("events.end_date <= ?", date)
  }
  scope :get_future_events, -> () { doesnt_end.until_date.order_by_start_date }

  def self.start_until_tomorrow
    where("start_date <= ?", Date.today + 1.days)
  end

  def get_bearings(location)
    place.bearing_to(location) if place.geocoded?
  end

  def get_distance(location)
    place.distance_to(location) if place.geocoded?
  end

end
