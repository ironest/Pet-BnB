class Pet < ApplicationRecord
  belongs_to :user
  has_many :bookings_pets
  has_many :bookings, through: :bookings_pets
  has_one_attached :picture
end
