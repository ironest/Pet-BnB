class CreatePetsittersServices < ActiveRecord::Migration[5.2]
  def change
    create_table :petsitters_services do |t|
      t.references :petsitter, foreign_key: true
      t.references :service, foreign_key: true

      t.timestamps
    end
  end
end
