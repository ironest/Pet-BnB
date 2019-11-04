class AddTotalAmountToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :total_amount, :int
  end
end
