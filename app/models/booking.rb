class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :petsitter
  belongs_to :pet
  has_one :transactions
  enum status: { pending: 0, accepted: 1, rejected: 2, payed: 3 }
end
