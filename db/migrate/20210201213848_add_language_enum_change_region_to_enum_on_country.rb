class AddLanguageEnumChangeRegionToEnumOnCountry < ActiveRecord::Migration[6.1]
  def change
    add_column :countries, :language, :integer
    add_column :countries, :region_enum, :integer
  end
end
