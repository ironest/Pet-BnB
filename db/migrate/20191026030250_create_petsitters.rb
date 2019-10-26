class CreatePetsitters < ActiveRecord::Migration[5.2]
  def change
    create_table :petsitters do |t|
      t.references :user, foreign_key: true
      t.integer :price_rate

      t.timestamps
    end
  end
end
