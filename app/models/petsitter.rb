class Petsitter < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :petsitters_services
  has_many :services, through: :petsitters_services
  enum status: { active: 0, inactive: 1 }
end
