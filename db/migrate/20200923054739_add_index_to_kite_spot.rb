class AddIndexToKiteSpot < ActiveRecord::Migration[6.0]
  def change
		add_index :kite_spots, :name, unique: true
  end
end
