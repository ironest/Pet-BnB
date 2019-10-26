class AddStatusToPetsitters < ActiveRecord::Migration[5.2]
  def change
    add_column :petsitters, :status, :integer
  end
end
