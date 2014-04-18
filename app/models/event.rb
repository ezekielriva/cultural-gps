class Event < ActiveRecord::Base
  belongs_to :place

  validates :name, presence: true, length: { maximum: 80 }
  validates :description, presence: true, length: { maximum: 300 }

  validate :end_date_cannot_be_in_the_past,
           :start_date_cannot_be_in_the_past

  attr_accessor :bearing, :distance

  scope :by_start_date, -> { order(:start_date) }

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

  def self.get_future_events
    where("start_date >= ?", Date.today).until_date.order('start_date ASC')
  end

  def self.start_until_tomorrow
    where("start_date <= ?", Date.today + 1.days)
  end

  def self.until_date(date = Date.today.at_end_of_quarter)
    where("end_date <= ?", date)
  end

  def self.find_near(location)
    Place.near(location, 15, :units => :km, order: 'distance').collect do |place|
      get_future_events.where(place: place).start_until_tomorrow.
        by_start_date.each do |event|
          event.bearing = place.bearing
          event.distance = place.distance
          event
      end
    end.flatten
  end

end
