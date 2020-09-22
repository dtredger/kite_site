class AddSlugToKiteSpots < ActiveRecord::Migration[6.0]
  def change
    add_column :kite_spots, :slug, :string
    add_index :kite_spots, :slug, unique: true
  end
end
