class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :booking, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
