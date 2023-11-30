class AddUniqueIndexToCountries < ActiveRecord::Migration[6.0]
  def change
		add_index :countries, :name, unique: true
  end
end
