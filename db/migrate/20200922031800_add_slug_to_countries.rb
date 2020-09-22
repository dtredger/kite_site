class AddSlugToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :slug, :string
    add_index :countries, :slug, unique: true
  end
end
