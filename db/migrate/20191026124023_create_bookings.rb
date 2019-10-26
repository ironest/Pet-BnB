class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :petsitter, foreign_key: true
      t.references :pet, foreign_key: true
      t.date :from_date
      t.date :to_date
      t.integer :status

      t.timestamps
    end
  end
end
