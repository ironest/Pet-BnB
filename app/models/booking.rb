class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :petsitter
  belongs_to :pet
end
