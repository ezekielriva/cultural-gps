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

  def end_date_cannot_be_less_than_start_date
    if end_date.present? && end_date > start_date
      errors.add(:end_date, "can't be lower Start Date")
    end
  end

  def self.get_future_events
    where("start_date >= ?", Date.today).order('start_date ASC')
  end

  def self.find_near(location)
    Place.near(location, 50, order: 'distance').collect do |place|
      get_future_events.where(place: place).each do |event|
        event
      end
    end.flatten
  end

end
