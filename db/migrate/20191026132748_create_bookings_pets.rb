class CreateBookingsPets < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings_pets do |t|
      t.references :booking, foreign_key: true
      t.references :pet, foreign_key: true

      t.timestamps
    end
  end
end
