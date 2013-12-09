class Event < ActiveRecord::Base
  belongs_to :place

  validates :name, presence: true, length: { maximum: 80 }
  validates :description, presence: true, length: { maximum: 300 }

  validate :end_date_cannot_be_in_the_past,
           :start_date_cannot_be_in_the_past

  def end_date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end

  def self.get_future_events
    where("start_date >= ?", Date.today).order('start_date ASC')
  end

  def self.find_near(location)
    events = []
    places = Place.near(location)
    places.each do |place|
      events.push Event.where(place: place)
    end
    events
  end
end
