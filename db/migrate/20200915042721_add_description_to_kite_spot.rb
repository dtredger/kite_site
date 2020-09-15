class AddDescriptionToKiteSpot < ActiveRecord::Migration[6.0]
  def change
		add_column :kite_spots, :description, :text
  end
end
