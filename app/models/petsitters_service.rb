class PetsittersService < ApplicationRecord
  belongs_to :petsitter
  belongs_to :service
end
