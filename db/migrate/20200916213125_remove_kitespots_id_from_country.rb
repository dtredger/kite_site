class RemoveKitespotsIdFromCountry < ActiveRecord::Migration[6.0]
  def change
		remove_column :countries, :kite_spots_id
  end
end
