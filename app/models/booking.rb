class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :petsitter
  belongs_to :pet
  has_one :transactions
end
