class ChangeMonthsToStringOnKiteSpot < ActiveRecord::Migration[6.0]
  def change
		change_column :kite_spots, :monthly_conditions, :string
  end
end
