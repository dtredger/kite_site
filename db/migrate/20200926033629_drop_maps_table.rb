class DropMapsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :maps
  end
end
