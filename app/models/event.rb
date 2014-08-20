class Event < ActiveRecord::Base
  belongs_to :place

  validates :name, presence: true, length: { maximum: 80 }
  validates :description, presence: true, length: { maximum: 300 }

  validate :end_date_cannot_be_in_the_past,
           :start_date_cannot_be_in_the_past

  attr_accessor :bearing, :distance

  scope :order_by_start_date, -> (order = 'ASC') { order("events.start_date #{order}") }
  scope :doesnt_end, -> () { where('events.end_date >= ?', Time.zone.now) }
  scope :until_date, -> (date = Time.zone.now.at_end_of_quarter) {
    where("events.end_date <= ?", date)
  }
  scope :get_future_events, -> () { doesnt_end.until_date.order_by_start_date }

  def end_date_cannot_be_in_the_past
    return unless end_date.present? && end_date < Date.today
    errors.add(:end_date, "can't be in the past")
  end

  def start_date_cannot_be_in_the_past
    return unless start_date.present? && start_date < Date.today
    errors.add(:start_date, "can't be in the past")
  end

  def end_date_cannot_be_less_than_start_date
    return unless end_date.present? && end_date > start_date
    errors.add(:end_date, "can't be lower Start Date")
  end

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
