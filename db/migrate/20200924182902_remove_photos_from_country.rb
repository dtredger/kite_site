class RemovePhotosFromCountry < ActiveRecord::Migration[6.0]
  def change
    remove_column :countries, :photos_id
  end
end
