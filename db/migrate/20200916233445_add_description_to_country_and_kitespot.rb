class AddDescriptionToCountryAndKitespot < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :description, :text
  end
end
