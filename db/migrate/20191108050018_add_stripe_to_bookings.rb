class AddStripeToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :stripe_id, :string
  end
end
