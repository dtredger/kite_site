class AddLatitudeLongitudeToKiteSpots < ActiveRecord::Migration[6.0]
  def change
		add_column :kite_spots, :latitude, :float
		add_column :kite_spots, :longitude, :float
  end
end
