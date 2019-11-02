class Pet < ApplicationRecord
  belongs_to :user
  
  has_many :bookings_pets, dependent: :destroy
  has_many :bookings, through: :bookings_pets

  has_one_attached :picture
  enum pet_type: {
    "small dog":  0,
    "medium dog": 1,
    "large dog":  2,
    "giant dog":  3,
    "puppy":      4,
    "cat":        5,
    "rabbit":     6
  }
end
