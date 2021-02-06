class AddRegionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :region, :string
  end
end
