class Place < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { maximum: 80 }
  validates :description, length: { maximum: 300 }
  validates :longitude, presence: true
  validates :latitude, presence: true
end
