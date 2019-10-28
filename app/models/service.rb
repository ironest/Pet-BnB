class Service < ApplicationRecord
    has_many :petsitters_services
    has_many :petsitters, through: :petsitters_services
end
