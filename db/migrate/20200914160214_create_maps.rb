class CreateMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :maps do |t|
      t.float :latitude
      t.float :longitude
      t.integer :zoom
      t.string :name
      t.references :record, null: false, polymorphic: true

      t.timestamps
    end
  end
end
