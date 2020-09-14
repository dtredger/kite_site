class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.text :name
      t.text :region

      t.references :kite_spots
      t.references :photos

      t.timestamps
    end
  end
end
