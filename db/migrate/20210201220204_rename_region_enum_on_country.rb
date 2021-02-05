class RenameRegionEnumOnCountry < ActiveRecord::Migration[6.1]
  def change
    remove_column :countries, :region
    rename_column :countries, :region_enum, :region
  end
end
