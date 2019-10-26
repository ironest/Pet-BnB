class RemovePetFromBookings < ActiveRecord::Migration[5.2]
  def change
    remove_reference :bookings, :pet, foreign_key: true
  end
end
