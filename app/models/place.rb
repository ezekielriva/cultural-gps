class Place < ActiveRecord::Base
  has_many :events

  scope :search_name, ->(q) { where('places.name ILIKE ?', "%#{q}%") }

  validates :name, presence: true, uniqueness: true, length: { maximum: 80 }
  validates :description, length: { maximum: 300 }
  validates :longitude, presence: true
  validates :latitude, presence: true

  reverse_geocoded_by :latitude, :longitude, :address => :location
  after_validation :reverse_geocode

end
