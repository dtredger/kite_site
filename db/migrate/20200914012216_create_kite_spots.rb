class CreateKiteSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :kite_spots do |t|
      t.string :name
      t.integer :monthly_conditions

      t.belongs_to :country

      t.timestamps
    end
  end
end
