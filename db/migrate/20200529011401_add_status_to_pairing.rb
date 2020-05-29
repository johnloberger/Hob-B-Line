class AddStatusToPairing < ActiveRecord::Migration[5.0]
  def change
    add_column :pairings, :status, :string
  end
end
